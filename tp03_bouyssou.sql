--  mariadb -h localhost -u root -p (connexion en CLI)
USE compta;

ALTER TABLE article ADD CONSTRAINT FOREIGN KEY(ID_fou) REFERENCES fournisseur(ID);
ALTER TABLE bon_commande ADD CONSTRAINT FOREIGN KEY(ID_fou) REFERENCES fournisseur(ID);
ALTER TABLE compo ADD CONSTRAINT FOREIGN KEY(ID_art) REFERENCES article(ID);
ALTER TABLE compo ADD CONSTRAINT FOREIGN KEY(ID_bon) REFERENCES bon_commande(ID);

INSERT INTO fournisseur (nom)
values ('Française d''Imports'), ('FDM SA'), ('Dubois & Fils');

INSERT INTO article (ref, designation, prix, ID_fou)
values ('A01', 'Perceuse P1', 74.99, 1),
('F01', 'Boulon laiton 4 x 40 mm (sachet de 10)', 2.25, 2),
('F02', 'Boulon laiton 5 x 40 mm (sachet de 10)', 4.45, 2),
('D01', 'Boulon laiton 5 x 40 mm (sachet de 10)', 4.40, 3),
('A02', 'Meuleuse 125mm', 37.85, 1),
('D03', 'Boulon acier zingué 4 x 40mm (sachet de 10)', 1.8, 3),
('A03', 'Perceuse à colonnes', 185.25, 1),
('D04', 'Coffret mêches à bois', 12.25, 3),
('F03', 'Coffret mêches plates', 6.25, 2),
('F04', 'Fraises d''encastrement', 8.14, 2);

INSERT INTO bon_commande (date_cmde, delai, ID_fou)
values ('2024-10-22', 3, 1);

INSERT INTO compo (qte, ID_art, ID_bon)
values (3, 1, 1), (4, 5, 1), (1, 7, 1);