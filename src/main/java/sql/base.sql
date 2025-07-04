\c postgres
DROP DATABASE IF EXISTS biblio;
CREATE DATABASE biblio;
\c biblio;

-- Table des types d'abonnement
CREATE TABLE type_abonnement (
    id SERIAL PRIMARY KEY,
    libelle VARCHAR(20) UNIQUE NOT NULL CHECK (libelle IN ('enfant', 'etudiant', 'adulte', 'senior', 'professionnel', 'professeur')),
    tarif NUMERIC(6,2) NOT NULL,
    quota_livre INT NOT NULL CHECK (quota_livre >= 0),
    duree_pret_jour INT NOT NULL DEFAULT 14, -- durée max du prêt en jours
    quota_reservation INT NOT NULL DEFAULT 2, -- nombre max de réservations
    quota_prolongement INT NOT NULL DEFAULT 1, -- nombre max de prolongements
    nb_jour_prolongement INT NOT NULL DEFAULT 7 -- nombre de jours pour un prolongement
);

CREATE TABLE adherent (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    prenom VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    id_type_abonnement INT NOT NULL REFERENCES type_abonnement(id),
    adresse VARCHAR(255) NOT NULL,
    etat VARCHAR(20) NOT NULL CHECK (etat IN ('actif', 'bloque')),
    date_naissance TIMESTAMP
);

CREATE TABLE inscription (
    id SERIAL PRIMARY KEY,
    id_adherent INT NOT NULL REFERENCES adherent(id),
    date_inscription TIMESTAMP NOT NULL,
    date_expiration TIMESTAMP NOT NULL,
    statut VARCHAR(20) NOT NULL CHECK (statut IN ('valide', 'expiree'))
);

-- Table des catégories de livre
CREATE TABLE categorie (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE livre (
    id SERIAL PRIMARY KEY,
    titre VARCHAR(200) NOT NULL,
    auteur VARCHAR(150) NOT NULL,
    id_categorie INT REFERENCES categorie(id),
    restriction VARCHAR(20) CHECK (restriction IN ('aucun', 'adulte'))
);

-- Table des exemplaires
CREATE TABLE exemplaire (
    id SERIAL PRIMARY KEY,
    reference VARCHAR(30) UNIQUE NOT NULL,
    id_livre INT NOT NULL REFERENCES livre(id),
    statut VARCHAR(20) NOT NULL CHECK (statut IN ('disponible', 'emprunte', 'reserve'))
);

CREATE TABLE pret (
    id SERIAL PRIMARY KEY,
    id_exemplaire INT NOT NULL REFERENCES exemplaire(id),
    id_adherent INT NOT NULL REFERENCES adherent(id),
    date_emprunt TIMESTAMP NOT NULL,
    date_retour_prevue TIMESTAMP NOT NULL,
    date_retour_effective TIMESTAMP,
    type_pret VARCHAR(20) NOT NULL CHECK (type_pret IN ('sur_place', 'emporte')),
    statut VARCHAR(20) NOT NULL CHECK (statut IN ('en_cours', 'termine', 'en_retard'))
);

-- Table des réservations
CREATE TABLE reservation (
    id SERIAL PRIMARY KEY,
    id_adherent INT NOT NULL REFERENCES adherent(id),
    id_livre INT NOT NULL REFERENCES livre(id),
    date_reservation TIMESTAMP NOT NULL,
    date_expiration TIMESTAMP NOT NULL,
    statut VARCHAR(20) NOT NULL CHECK (statut IN ('active', 'expiree', 'honoree'))
);

CREATE TABLE penalite (
    id SERIAL PRIMARY KEY,
    id_adherent INT NOT NULL REFERENCES adherent(id),
    id_pret INT NOT NULL REFERENCES pret(id),
    reglee BOOLEAN NOT NULL,
    sanction NUMERIC(6,2) DEFAULT 0 -- montant de la pénalité (ex: 10j de retard = pénalité)
);

-- Table des jours fériés
CREATE TABLE jourferie (
    id SERIAL PRIMARY KEY,
    date_ferie TIMESTAMP UNIQUE NOT NULL,
    description VARCHAR(100)
);


-- Table des utilisateurs
CREATE TABLE utilisateur (
    id SERIAL PRIMARY KEY,
    username VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(20) NOT NULL CHECK (role IN ('ADHERENT', 'BIBLIOTHECAIRE')),
    adherent_id INT REFERENCES adherent(id)
);