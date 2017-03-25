
DELIMITER ///
CREATE TRIGGER Check_Spazio
BEFORE INSERT ON BranoLibreria
FOR EACH ROW
BEGIN
DECLARE branosize double;
DECLARE spazioresiduo double;
SELECT Dimensione_bra INTO branosize
FROM Brano WHERE ID_bra=new.Brano_lb
LIMIT 1;
SELECT SpazioResiduo_disp INTO spazioresiduo
FROM Dispositivo WHERE Dispositivo.Libreria_disp=new.Libreria_lb
LIMIT 1;
IF (branosize>spazioresiduo) THEN
INSERT INTO Errori (Descrizione_err) VALUES ('Spazio esaurito');
END IF;
END ///

DELIMITER ///
CREATE TRIGGER Check_Libreria_Ascolto
BEFORE INSERT ON Ascolto
FOR EACH ROW
BEGIN
DECLARE n integer;
SELECT COUNT(*) INTO n
FROM Libreria JOIN BranoLibreria ON Libreria.ID_lib=BranoLibreria.Libreria_lb
WHERE BranoLibreria.Brano_lb=new.Brano_asc AND Libreria.Utente_lib=new.Utente_asc;
IF (n=0) THEN
INSERT INTO Errori (Descrizione_err) VALUES ('Ascolto di un brano non presente nella libreria');
END IF;
END ///

DELIMITER ///
CREATE TRIGGER Check_Ascolto_Valutazione
BEFORE INSERT ON Valutazione
FOR EACH ROW
BEGIN
DECLARE n integer;
SELECT COUNT(*) INTO n
FROM Ascolto 
WHERE Ascolto.Brano_asc=new.Brano_val;
IF (n=0) THEN
INSERT INTO Errori (Descrizione_err) VALUES ('Valutazione di un brano mai ascoltato');
END IF;
END ///


