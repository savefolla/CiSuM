
DELIMITER ///
CREATE FUNCTION prezzoAlbum(IDalbum INT(11)) RETURNS DECIMAL(5,2)
BEGIN
DECLARE totale DECIMAL(5,2);
SELECT SUM(Brano.Prezzo_bra) INTO totale
FROM BranoAlbum JOIN Brano ON BranoAlbum.Brano_ba=Brano.ID_bra
WHERE BranoAlbum.Album_ba=IDalbum;
RETURN totale;
END ///

DELIMITER ///
CREATE FUNCTION spesaUtenteData(IDute INT(11), dataMin DATE, dataMax DATE) RETURNS DECIMAL(11,2)
BEGIN
DECLARE tot DECIMAL(11,2);
SELECT SUM(Brano.Prezzo_bra) INTO tot
FROM Acquisto JOIN Brano ON Acquisto.Brano_acq=Brano.ID_bra
WHERE Acquisto.Utente_acq=IDute AND Acquisto.Data_acq BETWEEN dataMin AND dataMax;
RETURN tot;
END ///


