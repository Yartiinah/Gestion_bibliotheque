-- Script d'insertion des données pour la base biblio
\c biblio;

-- Insertion des types d'abonnement
INSERT INTO type_abonnement (libelle, tarif, quota_livre, duree_pret_jour, quota_reservation, quota_prolongement, nb_jour_prolongement) VALUES
('enfant', 5.00, 3, 14, 2, 1, 7),
('etudiant', 10.00, 5, 21, 3, 2, 7),
('adulte', 20.00, 5, 14, 2, 1, 7),
('senior', 15.00, 4, 21, 3, 2, 7),
('professionnel', 35.00, 10, 28, 5, 3, 7),
('professeur', 25.00, 8, 28, 4, 2, 7);

-- Insertion des adhérents
INSERT INTO adherent (nom, prenom, email, id_type_abonnement, adresse, etat, date_naissance) VALUES
('jean', 'Jean', 'jean.dupont@email.com', 3, 'Tana', 'actif', '1985-03-15');


-- Insertion des catégories
INSERT INTO categorie (nom) VALUES
('Roman'),
('Science-Fiction'),
('Histoire'),
('Biographie'),
('Jeunesse'),
('Bande Dessinée'),
('Poésie'),
('Théâtre'),
('Philosophie'),
('Sciences'),
('Informatique'),
('Cuisine'),
('Art'),
('Musique'),
('Sport');

-- Insertion des livres
INSERT INTO livre (titre, auteur, id_categorie, restriction) VALUES
('Le Petit Prince', 'Antoine de Saint-Exupéry', 5, 'aucun'),
('1984', 'George Orwell', 2, 'adulte'),
('L''Étranger', 'Albert Camus', 1, 'adulte'),
('Harry Potter à l''école des sorciers', 'J.K. Rowling', 5, 'aucun'),
('Dune', 'Frank Herbert', 2, 'aucun'),
('L''Histoire de France', 'Jules Michelet', 3, 'aucun'),
('Steve Jobs', 'Walter Isaacson', 4, 'aucun'),
('Astérix et Obélix', 'René Goscinny', 6, 'aucun'),
('Les Fleurs du Mal', 'Charles Baudelaire', 7, 'adulte'),
('Hamlet', 'William Shakespeare', 8, 'aucun'),
('Ainsi parlait Zarathoustra', 'Friedrich Nietzsche', 9, 'adulte'),
('Une brève histoire du temps', 'Stephen Hawking', 10, 'aucun'),
('Clean Code', 'Robert C. Martin', 11, 'aucun'),
('Le Grand Livre de Cuisine', 'Alain Ducasse', 12, 'aucun'),
('Histoire de l''Art', 'Ernst Gombrich', 13, 'aucun'),
('Traité d''harmonie', 'Arnold Schoenberg', 14, 'aucun'),
('L''Équipe', 'Collectif', 15, 'aucun'),
('Madame Bovary', 'Gustave Flaubert', 1, 'adulte'),
('Le Seigneur des Anneaux', 'J.R.R. Tolkien', 2, 'aucun'),
('Tintin au Tibet', 'Hergé', 6, 'aucun');

-- Insertion des exemplaires
INSERT INTO exemplaire (reference, id_livre, statut) VALUES
('EX001', 1, 'disponible'),
('EX002', 1, 'emprunte'),
('EX003', 2, 'disponible'),
('EX004', 2, 'reserve'),
('EX005', 3, 'disponible'),
('EX006', 4, 'emprunte'),
('EX007', 4, 'disponible'),
('EX008', 5, 'disponible'),
('EX009', 6, 'emprunte'),
('EX010', 7, 'disponible'),
('EX011', 8, 'disponible'),
('EX012', 9, 'disponible'),
('EX013', 10, 'disponible'),
('EX014', 11, 'disponible'),
('EX015', 12, 'emprunte'),
('EX016', 13, 'disponible'),
('EX017', 14, 'disponible'),
('EX018', 15, 'disponible'),
('EX019', 16, 'disponible'),
('EX020', 17, 'disponible'),
('EX021', 18, 'emprunte'),
('EX022', 19, 'disponible'),
('EX023', 20, 'disponible');

-- Insertion des prêts
INSERT INTO pret (id_exemplaire, id_adherent, date_emprunt, date_retour_prevue, date_retour_effective, type_pret, statut) VALUES
(2, 1, '2024-07-01', '2024-07-15', NULL, 'emporte', 'en_cours'),
(6, 2, '2024-06-15', '2024-07-06', NULL, 'emporte', 'en_retard'),
(9, 3, '2024-07-05', '2024-08-02', NULL, 'emporte', 'en_cours'),
(15, 4, '2024-06-20', '2024-07-18', NULL, 'emporte', 'en_cours'),
(21, 5, '2024-07-10', '2024-07-24', NULL, 'emporte', 'en_cours'),
(1, 6, '2024-06-01', '2024-06-15', '2024-06-14', 'emporte', 'termine'),
(3, 7, '2024-05-15', '2024-05-29', '2024-06-05', 'emporte', 'termine'),
(8, 8, '2024-07-08', '2024-07-22', NULL, 'sur_place', 'en_cours');

-- Insertion des réservations
INSERT INTO reservation (id_adherent, id_livre, date_reservation, date_expiration, statut) VALUES
(1, 2, '2024-07-01', '2024-07-08', 'active'),
(3, 4, '2024-06-25', '2024-07-02', 'active'),
(5, 18, '2024-07-05', '2024-07-12', 'active'),
(2, 1, '2024-06-10', '2024-06-17', 'expiree'),
(4, 5, '2024-05-20', '2024-05-27', 'honoree');

-- Insertion des pénalités

-- Insertion des jours fériés
INSERT INTO jourferie (date_ferie, description) VALUES
('2024-01-01', 'Nouvel An'),
('2024-05-01', 'Fête du Travail'),
('2024-05-08', 'Victoire 1945'),
('2024-07-14', 'Fête Nationale'),
('2024-08-15', 'Assomption'),
('2024-11-01', 'Toussaint'),
('2024-11-11', 'Armistice 1918'),
('2024-12-25', 'Noël'),
('2025-01-01', 'Nouvel An'),
('2025-05-01', 'Fête du Travail'),
('2025-05-08', 'Victoire 1945'),
('2025-07-14', 'Fête Nationale');

-- Insertion des utilisateurs
INSERT INTO utilisateur (username, password, role, adherent_id) VALUES
('admin', 'admin', 'BIBLIOTHECAIRE', NULL);

-- Vérification des données insérées
SELECT 'Types d''abonnement' as table_name, COUNT(*) as nb_records FROM type_abonnement
UNION ALL
SELECT 'Adhérents', COUNT(*) FROM adherent
UNION ALL
SELECT 'Inscriptions', COUNT(*) FROM inscription
UNION ALL
SELECT 'Catégories', COUNT(*) FROM categorie
UNION ALL
SELECT 'Livres', COUNT(*) FROM livre
UNION ALL
SELECT 'Exemplaires', COUNT(*) FROM exemplaire
UNION ALL
SELECT 'Prêts', COUNT(*) FROM pret
UNION ALL
SELECT 'Réservations', COUNT(*) FROM reservation
UNION ALL
SELECT 'Pénalités', COUNT(*) FROM penalite
UNION ALL
SELECT 'Jours fériés', COUNT(*) FROM jourferie
UNION ALL
SELECT 'Utilisateurs', COUNT(*) FROM utilisateur;

-- Affichage de quelques statistiques
SELECT 
    'Adhérents actifs' as statistique,
    COUNT(*) as valeur
FROM adherent 
WHERE etat = 'actif'
UNION ALL
SELECT 
    'Livres disponibles',
    COUNT(*)
FROM exemplaire 
WHERE statut = 'disponible'
UNION ALL
SELECT 
    'Prêts en cours',
    COUNT(*)
FROM pret 
WHERE statut = 'en_cours'
UNION ALL
SELECT 
    'Réservations actives',
    COUNT(*)
FROM reservation 
WHERE statut = 'active';

RAISE NOTICE 'Toutes les données ont été insérées avec succès!';