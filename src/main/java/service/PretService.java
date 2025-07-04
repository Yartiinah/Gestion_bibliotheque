package service;

import model.Pret;
import model.Exemplaire;
import model.Adherent;
import model.TypeAbonnement;
import repository.PretRepository;
import repository.ExemplaireRepository;
import repository.AdherentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.time.LocalDateTime;
import java.util.Optional;
import java.util.List;

@Service
public class PretService {
    @Autowired
    public PretRepository pretRepository;
    @Autowired
    private ExemplaireRepository exemplaireRepository;
    @Autowired
    private AdherentRepository adherentRepository;

    public String creerPret(Integer adherentId, String referenceExemplaire, String typePret) {
        Optional<Adherent> adherentOpt = adherentRepository.findById(adherentId);
        if (adherentOpt.isEmpty()) return "Adhérent introuvable";
        Adherent adherent = adherentOpt.get();
        if (!"actif".equals(adherent.getEtat())) return "Veuillez renouveler votre abonnement";

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
        // TODO: envoyer email de confirmation
        return "Prêt enregistré avec succès. Date de retour : " + retour;
    }

    public String prolongerPret(Integer pretId, Integer adherentId) {
        Pret pret = pretRepository.findById(pretId).orElse(null);
        if (pret == null || pret.getAdherent().getId() != adherentId || !"en_cours".equals(pret.getStatut())) {
            return "Prêt introuvable ou non prolongeable";
        }
        Adherent adherent = pret.getAdherent();
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
        return "Prolongement effectué avec succès";
    }
    public String retourPret(Integer pretId){
        Pret pret = pretRepository.findById(pretId).orElse(null);
        if(pret==null) return "Prêt introuvable";
        Exemplaire exemplaire = pret.getExemplaire();
        exemplaire.setStatut("disponible");
        pret.setDateRetourEffective(LocalDateTime.now());
        pret.setStatut("termine");
        pretRepository.save(pret);
        exemplaireRepository.save(exemplaire);
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