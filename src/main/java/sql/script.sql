
INSERT INTO type_abonnement (libelle, tarif, quota_livre, duree_pret_jour, quota_reservation, quota_prolongement, nb_jour_prolongement) VALUES
('enfant', 3.00, 2, 7, 1, 1, 7),
('etudiant', 5.00, 4, 14, 2, 2, 14),
('professionnel', 8.00, 5, 21, 3, 2, 21),
('professeur', 10.00, 6, 30, 3, 3, 30),
('senior', 6.00, 3, 14, 2, 1, 14);

INSERT INTO categorie (nom) VALUES
('Fiction'),
('Non-fiction'),
('Science'),
('Histoire'),
('Biographie'),
('Enfants'),
('Adolescents'),
('Romance');

-- Exemples d'insertion
insert into adherent (nom,prenom,email,id_type_abonnement,adresse,etat,date_naissance) values ('nyeja','nyeja','nyeja@gmail.com',1,'itaosy','actif','2000-01-01');
INSERT into utilisateur (username,password,role,adherent_id) values ('test','test','ADHERENT',1);
INSERT into utilisateur (username,password,role,adherent_id) values ('biblio','biblio','BIBLIOTHECAIRE',NULL);

-- Ajout de livres
INSERT INTO livre (titre, auteur, id_categorie, restriction) VALUES
('Le Petit Prince', 'Antoine de Saint-Exupery', 1, 'aucun'),
('1984', 'George Orwell', 1, 'adulte'),
('Introduction', 'Thomas H. Cormen', 3, 'aucun'),
('Harry Potter', 'J.K. Rowling', 6,'aucun'),
('L''Etranger', 'Albert Camus', 1, 'adulte');

-- Ajout d'exemplaires pour chaque livre
INSERT INTO exemplaire (reference, id_livre, statut) VALUES
('EX-PTP-001', 1, 'disponible'),
('EX-PTP-002', 1, 'disponible'),
('EX-1984-001', 2, 'disponible'),
('EX-1984-002', 2, 'emprunte'),
('EX-ALG-001', 3, 'disponible'),
('EX-HP1-001', 4, 'disponible'),
('EX-HP1-002', 4, 'reserve'),
('EX-ETR-001', 5, 'disponible');

ALTER TABLE pret ADD COLUMN nbprolongements integer DEFAULT 0;
-- -penalite tsisy resaka vola
-- prolengement
-- penalite 10j raha tsy nanatitra anlay boky a temps
-- rehefa tsy abonne tsony lay adherent dia tsy afaka manao inina fa afaka miditra systeme

-- reservation misy quota(jour)
-- prolengement na pret misy quota(jour)

-- reservation tsy pretfa ny reservation lasa rpet le jour j, fa raha tsy mbla nanatitra boky izy d na nireserver za d tsy afaka manao pret
-- mila bidirectionnel ny rehetra:

-- enregistrer lecture sur place mila tenenina kou d zao nou nalina d zao nou naverina,mbola pret fona lay izy
-- afaka manao reservation zay tina, afaka accepteny lay biblio fona 
-- duree anamerena anle boky dia miankina am profil 
-- tsy azo atao prolonger prolongement
-- -pret


-- Liste fonctionnalite atao anaty document

--- mila ampidirina anaty base ny prolongement genre hoe date taloha d date vaovao
