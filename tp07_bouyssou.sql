USE compta2;

-- Désactiver le mode "safe update"
SET SQL_SAFE_UPDATES = 0;

-- Supprimer de la table 'compo' les enregistrements concernant
-- les bons de commande d'avril 2019.
DELETE compo
FROM compo
JOIN bon ON compo.ID_BON = bon.ID
WHERE MONTH(bon.DATE_CMDE) = '04' AND YEAR(bon.DATE_CMDE) = '2019';

-- Supprimer dans la table 'bon' tous les bons de commande d'avril 2019.
DELETE FROM bon
WHERE MONTH(DATE_CMDE) = '04' AND YEAR(DATE_CMDE) = '2019';