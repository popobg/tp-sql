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

-- Lister les articles avec les informations fournisseur correspondantes,
-- triées par ordre alphabétique de nom de fournisseur et par prix décroissant d'articles.
SELECT art.REF AS 'référence article', art.DESIGNATION 'libellé article', art.PRIX 'prix de l''article', fou.ID AS 'ID fournisseur', fou.NOM 'fournisseur'
FROM article art
INNER JOIN fournisseur fou ON art.ID_FOU = fou.ID
ORDER BY fou.NOM, art.PRIX DESC;

-- Lister les articles de la société 'Dubois & Fils'.
SELECT * FROM article
WHERE ID_FOU = (SELECT DISTINCT ID FROM fournisseur fou WHERE fou.NOM = 'Dubois & Fils');

-- Calculer la moyenne des prix des articles de la société 'Dubois & Fils'.
SELECT fou.NOM AS 'Fournisseur', AVG(PRIX) AS 'Moyenne du prix des articles' FROM article art
INNER JOIN fournisseur fou ON art.ID_FOU = fou.ID
WHERE fou.NOM = 'Dubois & Fils'
GROUP BY fou.NOM;

-- Calculer la moyenne des prix des articles de chaque fournisseur.
SELECT fou.NOM AS 'Fournisseur', AVG(PRIX) AS 'Moyenne du prix des articles' FROM article art
INNER JOIN fournisseur fou ON art.ID_FOU = fou.ID
GROUP BY fou.NOM;

-- Lister tous les bons de commande émis entre le 01/03/19 et 05/04/19 à 12h00.
SELECT * FROM bon
WHERE date_cmde BETWEEN '2019-03-01 12:00:00' AND '2019-04-05 12:00:00';

-- Lister les bons de commande contenant des boulons.
SELECT DISTINCT bon.* FROM bon
INNER JOIN compo ON bon.ID = compo.ID_BON
WHERE compo.ID_ART IN (SELECT ID FROM article WHERE DESIGNATION LIKE '%boulon%');

-- Lister les bons de commande contenant des boulons + nom du fournisseur.
SELECT DISTINCT bon.*, fou.NOM AS 'Fournisseur' FROM bon
INNER JOIN fournisseur fou ON bon.ID_FOU = fou.ID
INNER JOIN compo ON bon.ID = compo.ID_BON
WHERE compo.ID_ART IN (SELECT ID FROM article WHERE DESIGNATION LIKE '%boulon%');

-- Calculer le prix total de chaque bon de commande.
-- Ne pas oublier de prendre en compte la quantité d'articles achetés à chaque fois.
SELECT bon.*, SUM(article.prix * compo.QTE) AS 'Total prix articles' FROM bon
INNER JOIN compo ON bon.ID = compo.ID_BON
INNER JOIN article ON compo.ID_art = article.ID
GROUP BY compo.ID_BON;

-- Compter le nombre d'articles de chaque bon de commande.
SELECT bon.*, SUM(compo.QTE) AS 'Nombre d''articles' FROM bon
INNER JOIN compo ON bon.ID = compo.ID_BON
GROUP BY compo.ID_BON;

-- Afficher le numéro des bons de commande + nombre d'articles.
-- des bons de commande contenant > 25 articles
SELECT bon.NUMERO AS 'Numéro de commande', SUM(compo.QTE) AS 'Nombre d''articles' FROM bon
INNER JOIN compo ON bon.ID = compo.ID_BON
GROUP BY compo.ID_BON
HAVING SUM(compo.QTE) > 25;

-- Calculer le coût total des commandes effectuées sur le mois d'avril.
-- On distingue le mois d'avril année par année en cas de commandes sur plusieurs années.
SELECT bon.DATE_CMDE AS 'Date de la commande', SUM(article.prix * compo.QTE) AS 'Total prix articles' FROM bon
INNER JOIN compo ON bon.ID = compo.ID_BON
INNER JOIN article ON compo.ID_art = article.ID
WHERE MONTH(bon.DATE_CMDE) = 04
GROUP BY MONTH(bon.DATE_CMDE), YEAR(bon.DATE_CMDE);

-- CONSIGNES FACULTATIVES

-- Lister les articles ayant une désignation.
-- Pas certaine que ce soit la solution la plus performante en revanche.
SELECT DISTINCT art.* FROM article art
CROSS JOIN article art_fou
WHERE art.DESIGNATION = art_fou.DESIGNATION AND art.ID_FOU <> art_fou.ID_fou;

-- Calculer les dépenses des commandes mois par mois.
SELECT MONTH(bon.DATE_CMDE) AS 'Mois', YEAR(bon.DATE_CMDE) AS 'Année', SUM(article.prix * compo.QTE) AS 'Total prix articles par mois' FROM bon
INNER JOIN compo ON bon.ID = compo.ID_BON
INNER JOIN article ON compo.ID_art = article.ID
GROUP BY MONTH(bon.DATE_CMDE), YEAR(bon.DATE_CMDE)
ORDER BY YEAR(bon.DATE_CMDE);

-- Sélectionner les bons de commandes sans article.
SELECT * FROM bon
LEFT JOIN compo ON bon.ID = compo.ID_BON
WHERE compo.ID_BON IS NULL;

-- Calculer le prix moyen des bons de commande par fournisseur.
SELECT fou.NOM, AVG(synthese.total) AS 'Total prix articles' FROM fournisseur fou
INNER JOIN bon ON bon.ID_FOU = fou.ID
INNER JOIN (
    SELECT bon.ID AS bon_ID, SUM(art.PRIX * compo.QTE) AS total FROM bon
    JOIN compo ON bon.ID = compo.ID_BON
    JOIN article art ON compo.ID_art = art.ID
    GROUP BY bon_ID
) AS synthese ON bon.ID = synthese.bon_ID
GROUP BY fou.NOM;
