
DELIMITER ///
CREATE PROCEDURE MostraLibreria(IN user INT(11))
BEGIN
SELECT Brano.ID_bra, Brano.Titolo_bra
FROM Brano, BranoLibreria, Libreria, Utente
WHERE Brano.ID_bra=BranoLibreria.Brano_lb AND BranoLibreria.Libreria_lb=Libreria.ID_lib AND Libreria.Utente_lib=Utente.ID_ute AND Utente.ID_ute=user;
END ///

DELIMITER ///
CREATE PROCEDURE ScalaImporto(IN importo FLOAT,IN utente INT(11)) 
BEGIN
UPDATE Utente SET Credito_ute=Credito_ute-importo WHERE ID_ute=utente;
END ///


