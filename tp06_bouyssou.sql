USE compta2;

-- Désactiver le mode "safe update"
SET SQL_SAFE_UPDATES = 0;

-- Mettre en majuscule la valeur de la colonne 'désignation'
-- de tous les articles dont le prix > 10€.
UPDATE article
SET designation = UPPER(designation)
WHERE prix > 10;

-- Mettre en minuscule la valeur de la colonne 'designation' dont l'ID est 2.
UPDATE article
SET designation = LOWER(designation)
WHERE ID = 2;

-- Augmenter de 10% les prix de tous les articles du fournisseurs 'FDM SA'
UPDATE article
SET prix = prix * 1.1
WHERE ID_FOU = (SELECT DISTINCT ID FROM fournisseur WHERE NOM = 'FDM SA');