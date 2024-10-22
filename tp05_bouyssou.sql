USE compta2;

-- Lister tous les enregistrements de la table article, par ordre alphabétique (ascendant).
SELECT * FROM article
ORDER BY DESIGNATION;

-- Lister les articles dans l'ordre des prix du plus élevé au moins élevé.
SELECT * FROM article
ORDER BY PRIX DESC;

-- Lister tous les articles qui sont des 'boulon'; tri par ordre de prix ascendant.
-- Notre DB n'est pas sensible à la casse (configuration à la création de la DB).
SELECT * FROM article
WHERE DESIGNATION LIKE '%boulon%'
ORDER BY PRIX;

-- Lister tous les articles dont la 'désignation' contient le mot 'sachet', en étant sensible à la casse.
SELECT * FROM article
WHERE DESIGNATION LIKE '%sachet%' COLLATE utf8mb4_bin;

-- Lister tous les articles dont la 'désignation' contient le mot 'sachet',
-- la DB ayant déjà la collation insensible à la casse, pas besoin d'ajouter quoi que ce soit.
SELECT * FROM article
WHERE DESIGNATION LIKE '%sachet%';

-- Lister les articles avec les informations fournisseur correspondantes, triés par ordre alphabétique
-- de fournisseur et par prix décroissant d'articles.
SELECT art.REF AS 'référence article', art.DESIGNATION 'libellé article', art.PRIX 'prix de l''article', fou.NOM 'fournisseur'
FROM article AS art
INNER JOIN fournisseur AS fou ON art.ID_FOU = fou.ID
ORDER BY fou.NOM, art.PRIX DESC;

-- Lister les articles de la société 'Dubois & Fils'.
SELECT * FROM article AS art
INNER JOIN fournisseur AS fou ON art.ID_FOU = fou.ID
WHERE fou.NOM = 'Dubois & Fils';

-- Calculer la moyenne des prix des articles de la société 'Dubois & Fils'.
SELECT fou.NOM AS 'Fournisseur', AVG(PRIX) AS 'Moyenne du prix des articles' FROM article AS art
INNER JOIN fournisseur AS fou ON art.ID_FOU = fou.ID
WHERE fou.NOM = 'Dubois & Fils'
GROUP BY fou.NOM;

-- Calculer la moyenne des prix des articles de chaque fournisseur.
SELECT fou.NOM AS 'Fournisseur', AVG(PRIX) AS 'Moyenne du prix des articles' FROM article AS art
INNER JOIN fournisseur AS fou ON art.ID_FOU = fou.ID
GROUP BY fou.NOM;

-- Lister tous les bons de commande émis entre le 01/03/19 et 05/04/19 à 12h00.
SELECT * FROM bon
WHERE date_cmde BETWEEN '2019-03-01 12:00:00' AND '2019-04-05 12:00:00';

-- Lister les bons de commande contenant des boulons
SELECT DISTINCT bon.* FROM bon
INNER JOIN compo ON bon.ID = compo.ID_BON
WHERE compo.ID_ART IN (SELECT ID FROM article WHERE DESIGNATION LIKE '%boulon%');

-- Lister les bons de commande contenant des boulons + nom du fournisseur.
SELECT DISTINCT bon.*, fou.NOM AS 'Fournisseur' FROM bon
INNER JOIN fournisseur AS fou ON bon.ID_FOU = fou.ID
INNER JOIN compo ON bon.ID = compo.ID_BON
WHERE compo.ID_ART IN (SELECT ID FROM article WHERE DESIGNATION LIKE '%boulon%');

-- Calculer le prix total de chaque bon de commande.
SELECT bon.*, SUM(article.prix) AS 'Total prix articles' FROM bon
INNER JOIN compo ON bon.ID = compo.ID_BON
INNER JOIN article ON compo.ID_art = article.ID
GROUP BY compo.ID_BON;

-- Compter le nombre d'articles de chaque bon de commande
SELECT bon.*, SUM(compo.QTE) AS 'Nombre d''articles' FROM bon
INNER JOIN compo ON bon.ID = compo.ID_BON
GROUP BY compo.ID_BON;

-- Afficher le numéro des bons de commande + nombre d'articles
-- des bons de commande contenant > 25 articles
SELECT bon.NUMERO AS 'Numéro de commande', SUM(compo.QTE) AS 'Nombre d''articles' FROM bon
INNER JOIN compo ON bon.ID = compo.ID_BON
GROUP BY compo.ID_BON
HAVING SUM(compo.QTE) > 25;

-- Calculer le coût total des commandes effectuées sur le mois d'avril
SELECT bon.NUMERO AS 'Numéro de la commande', bon.DATE_CMDE AS 'Date de la commande', SUM(article.prix) AS 'Total prix articles' FROM bon
INNER JOIN compo ON bon.ID = compo.ID_BON
INNER JOIN article ON compo.ID_art = article.ID
WHERE MONTH(bon.DATE_CMDE) = 04
GROUP BY compo.ID_BON;