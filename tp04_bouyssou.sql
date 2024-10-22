USE compta2;

-- lister tous les enregistrements de la table article.
SELECT * FROM article;

-- lister les ref et désignation pour des articles dont le prix est strictement supérieur à 2€.
-- Tri arbitraire par ordre alphabétique à partir de la colonne 'désignation'
SELECT ref, designation FROM article
WHERE prix > 2
ORDER BY designation;

-- lister les articles dont le prix est compris entre 2 et 6.25€ (inclus), avec les opérateurs de comparaison.
SELECT * FROM article
WHERE prix >= 2 AND prix <= 6.25;

-- lister les articles dont le prix est compris entre 2 et 6.25€ (inclus), avec BETWEEN.
SELECT * FROM article
WHERE prix BETWEEN 2 AND 6.25;

-- lister les articles dont le prix N'EST PAS COMPRIS entre 2 et 6.25€
-- et dont le fournisseur est 'Française d'Imports' (ID = 1).
SELECT * FROM article
WHERE !(prix >= 2 AND prix <= 6.25)
AND ID_fou = 1;

-- lister les articles dont le fournisseur est 'Française d'Imports' ou 'Dubois & fils' (ID 1 et 3).
-- avec un opérateur logique
SELECT * FROM article
WHERE ID_fou = 1 OR ID_fou = 3;

-- lister les articles dont le fournisseur est 'Française d'Imports' ou 'Dubois & fils' (ID 1 et 3).
-- avec l'opérateur IN
SELECT * FROM article
WHERE ID_fou IN (1, 3);

-- lister les articles dont le fournisseur n'est ni 'Française d'Imports', ni 'Dubois & fils'.
SELECT * FROM article
WHERE ID_fou NOT IN (1, 3);

-- lister tous les bons de commande dont la date de commande est entre le 01/02/19 et le 30/04/19.
SELECT * FROM bon
WHERE DATE_CMDE BETWEEN '2019-02-01 00:00:00' AND '2019-04-30';