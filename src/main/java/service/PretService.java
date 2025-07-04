package service;

import model.Pret;
import model.Exemplaire;
import model.Adherent;
import model.Livre;
import model.TypeAbonnement;
import model.HistoriquePret;
import service.HistoriquePretService;
import repository.PretRepository;
import repository.ExemplaireRepository;
import repository.AdherentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.time.LocalDateTime;
import java.util.Optional;
import java.util.List;
import model.Penalite;
import repository.PenaliteRepository;

@Service
public class PretService {
    @Autowired
    public PretRepository pretRepository;
    @Autowired
    private ExemplaireRepository exemplaireRepository;
    @Autowired
    private AdherentRepository adherentRepository;
    @Autowired
    private HistoriquePretService historiquePretService;
    @Autowired
    private AdherentService adherentService;

    @Autowired
    private PenaliteRepository penaliteRepository;

    public String creerPret(Integer adherentId, String referenceExemplaire, String typePret) {
        Optional<Adherent> adherentOpt = adherentRepository.findById(adherentId);
        if (adherentOpt.isEmpty()) return "Adhérent introuvable";
        Adherent adherent = adherentOpt.get();
        if (!adherentService.isInscriptionValide(adherent)) {
            return "Votre abonnement n'est plus valide. Veuillez le renouveler.";
        }
        if (!"actif".equals(adherent.getEtat())) return "Veuillez renouveler votre abonnement";

        if (penaliteRepository.existsByAdherentAndDateFinAfter(adherent, LocalDateTime.now())) {
                return "Cet adherent est pénalisé jusqu'à la date " +
                penaliteRepository.findFirstByAdherentAndDateFinAfterOrderByDateFinDesc(adherent, LocalDateTime.now()).getDateFin();
        }

        Exemplaire exemplaires = exemplaireRepository.findByReference(referenceExemplaire).orElse(null);
        Livre livre = exemplaires.getLivre();
        if(livre.getRestriction().equals("adulte")){
            if(adherent.getTypeAbonnement().getLibelle().equals("enfant")){
                return "Ce livre est reserve au plus de 18 ans";
            }
        }
        
        // Vérifier pénalités impayées (à implémenter selon ta logique)
        // Vérifier quota d'emprunt
        int quota = adherent.getTypeAbonnement().getQuotaLivre();
        long nbPretsEnCours = pretRepository.findAll().stream()
            .filter(p -> p.getAdherent().getId() == adherentId && "en_cours".equals(p.getStatut()))
            .count();
        if (nbPretsEnCours >= quota) {
            return "Limite d'emprunts atteinte (" + nbPretsEnCours + "/" + quota + " livres)";
        }

        Optional<Exemplaire> exemplaireOpt = exemplaireRepository.findByReference(referenceExemplaire);
        if (exemplaireOpt.isEmpty()) return "Exemplaire introuvable";
        Exemplaire exemplaire = exemplaireOpt.get();
        if (!"disponible".equals(exemplaire.getStatut())) return "Cet exemplaire n'est pas empruntable";

        // Vérifier restriction livre (ex: adulte seulement)
        // TODO: à compléter selon ta logique

        // Calculer la durée selon le type d'abonnement
        TypeAbonnement abo = adherent.getTypeAbonnement();
        int duree = abo.getDureePretJour();
        LocalDateTime now = LocalDateTime.now();
        LocalDateTime retour = now.plusDays(duree);
        Pret pret = new Pret();
        pret.setAdherent(adherent);
        pret.setExemplaire(exemplaire);
        pret.setDateEmprunt(now);
        pret.setDateRetourPrevue(retour);
        pret.setTypePret(typePret);
        pret.setStatut("en_cours");
        pretRepository.save(pret);
        exemplaire.setStatut("emprunte");
        exemplaireRepository.save(exemplaire);
        // Historique : création de prêt
        HistoriquePret hist = new HistoriquePret();
        hist.setPret(pret);
        hist.setAction("emprunt");
        hist.setDateAction(now);
        hist.setCommentaire("Prêt créé");
        historiquePretService.save(hist);
        // TODO: envoyer email de confirmation
        return "Prêt enregistré avec succès. Date de retour : " + retour;
    }

    public String prolongerPret(Integer pretId, Integer adherentId) {
        Pret pret = pretRepository.findById(pretId).orElse(null);
        if (pret == null || pret.getAdherent().getId() != adherentId || !"en_cours".equals(pret.getStatut())) {
            return "Prêt introuvable ou non prolongeable";
        }
        Adherent adherent = pret.getAdherent();
        if (!adherentService.isInscriptionValide(adherent)) {
            return "Votre abonnement n'est plus valide. Veuillez le renouveler.";
        }
        if (!"actif".equals(adherent.getEtat())) {
            return "Vous êtes pénalisé, prolongement impossible";
        }

        TypeAbonnement abo = adherent.getTypeAbonnement();
        if (pret.getNbProlongements() >= abo.getQuotaProlongement()) {
            return "Quota de prolongements atteint";
        }

        // if (pret.getDateRetourPrevue().minusDays(2).isBefore(LocalDateTime.now())) {
        //     return "Prolongement possible uniquement 2 jours avant la date de retour";
        // }
        // Vérifier si le livre est réservé par un autre adhérent (à implémenter)
        // if (reservationRepository.existsByExemplaireAndNotAdherent(pret.getExemplaire(), adherent)) { ... }

        pret.setNbProlongements(pret.getNbProlongements() + 1);
        pret.setDateRetourPrevue(pret.getDateRetourPrevue().plusDays(abo.getNbJourProlongement()));
        pretRepository.save(pret);
        // Historique : prolongement
        HistoriquePret hist = new HistoriquePret();
        hist.setPret(pret);
        hist.setAction("prolongement");
        hist.setDateAction(LocalDateTime.now());
        hist.setCommentaire("Prolongement effectué");
        historiquePretService.save(hist);
        return "Prolongement effectué avec succès";
    }
    public String retourPret(Integer pretId){
        Pret pret = pretRepository.findById(pretId).orElse(null);
        if(pret==null) return "Prêt introuvable";
        Adherent adherent = pret.getAdherent();
        // if (!adherentService.isInscriptionValide(adherent)) {
        //     return "Votre abonnement n'est plus valide. Veuillez le renouveler.";
        // }
        Exemplaire exemplaire = pret.getExemplaire();
        exemplaire.setStatut("disponible");
        pret.setDateRetourEffective(LocalDateTime.now());
        pret.setStatut("termine");
        pretRepository.save(pret);
        exemplaireRepository.save(exemplaire);
        // Historique : retour
        HistoriquePret hist = new HistoriquePret();
        hist.setPret(pret);
        hist.setAction("retour");
        hist.setDateAction(LocalDateTime.now());
        hist.setCommentaire("Retour effectué");
        historiquePretService.save(hist);

        if (pret.getDateRetourPrevue() != null && LocalDateTime.now().isAfter(pret.getDateRetourPrevue())) {
            Penalite penalite = new Penalite();
            penalite.setAdherent(adherent);
            penalite.setPret(pret);
            penalite.setDateDebut(LocalDateTime.now());
            penalite.setDateFin(LocalDateTime.now().plusDays(10));
            penalite.setReglee(false);
            penaliteRepository.save(penalite);
        }

        

        return "Retour enregistré avec succès pour le prêt ID " + pretId;
    }

    public List<Pret> getPretsByAdherent(Integer adherentId) {
        return pretRepository.findAll().stream()
            .filter(p -> p.getAdherent().getId() == adherentId)
            .toList();
    }

    public List<Pret> getPretsByAdherentId(Integer adherentId) {
        return pretRepository.findByAdherentId(adherentId);
    }
}