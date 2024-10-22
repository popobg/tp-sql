USE compta2;

-- lister tous les enregistrements de la table article.
SELECT * FROM ARTICLE;

-- lister les ref et désignation pour des articles dont le prix est strictement supérieur à 2€.
-- Tri arbitraire par ordre alphabétique à partir de la colonne 'désignation'
SELECT REF, DESIGNATION FROM ARTICLE
WHERE PRIX > 2
ORDER BY DESIGNATION;

-- lister les articles dont le prix est compris entre 2 et 6.25€ (inclus), avec les opérateurs de comparaison.
SELECT * FROM ARTICLE
WHERE PRIX >= 2 AND PRIX <= 6.25;

-- lister les articles dont le prix est compris entre 2 et 6.25€ (inclus), avec BETWEEN.
SELECT * FROM ARTICLE
WHERE PRIX BETWEEN 2 AND 6.25;

-- lister les articles dont le prix N'EST PAS COMPRIS entre 2 et 6.25€
-- et dont le fournisseur est 'Française d'Imports' (ID = 1).
SELECT * FROM ARTICLE
WHERE !(PRIX >= 2 AND PRIX <= 6.25)
AND ID_FOU = 1;

-- lister les articles dont le fournisseur est 'Française d'Imports' ou 'Dubois & fils' (ID 1 et 3).
-- avec un opérateur logique
SELECT * FROM ARTICLE
WHERE ID_FOU = 1 OR ID_FOU = 3;

-- lister les articles dont le fournisseur est 'Française d'Imports' ou 'Dubois & fils' (ID 1 et 3).
-- avec l'opérateur IN
SELECT * FROM ARTICLE
WHERE ID_FOU IN (1, 3);

-- lister les articles dont le fournisseur n'est ni 'Française d'Imports', ni 'Dubois & fils'.
SELECT * FROM ARTICLE
WHERE ID_FOU NOT IN (1, 3);

-- lister tous les bons de commande dont la date de commande est entre le 01/02/19 et le 30/04/19.
SELECT * FROM bon
WHERE DATE_CMDE BETWEEN '2019-02-01 00:00:00' AND '2019-04-30';