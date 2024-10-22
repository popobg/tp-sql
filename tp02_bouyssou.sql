--  mariadb -h localhost -u root -p (connexion en CLI)
CREATE DATABASE compta CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';
USE compta;

CREATE TABLE article (
    ID INT(6) AUTO_INCREMENT PRIMARY KEY,
    ref VARCHAR(50) UNIQUE,
    designation VARCHAR(30),
    prix DECIMAL(8,2),
    ID_fou INT(6)
);

CREATE TABLE fournisseur (
    ID INT(6) AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(30)
);

CREATE TABLE bon_commande (
    ID INT(6) AUTO_INCREMENT PRIMARY KEY,
    numero INT(6),
    date_cmde DATE,
    delai INT(3),
    ID_fou INT(6)
);

CREATE TABLE compo (
    ID INT(6) AUTO_INCREMENT PRIMARY KEY,
    qte INT(6),
    ID_art INT(6),
    ID_bon INT(6)
);