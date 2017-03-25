
CREATE VIEW Ascolti AS
SELECT Brano.ID_bra, Brano.Titolo_bra, COUNT(*) AS Numero_Ascolti
FROM Brano, Ascolto, Utente
WHERE Brano.ID_bra=Ascolto.Brano_asc AND Ascolto.Utente_asc=Utente.ID_ute AND Utente.Nazione_ute='Italia'
GROUP BY Brano.ID_bra, Brano.Titolo_bra;

CREATE VIEW top5_ascolti_italia AS
SELECT Ascolti.ID_Bra AS ID, Ascolti.Titolo_bra AS Titolo, GROUP_CONCAT(Artista.Nome_art SEPARATOR ', ') AS Artista, Ascolti.Numero_Ascolti
FROM Ascolti, Esecuzione, Artista
WHERE Ascolti.ID_bra=Esecuzione.Brano_ese and Esecuzione.Artista_ese=Artista.ID_art
GROUP BY Ascolti.ID_Bra, Ascolti.Titolo_bra
ORDER BY Numero_ascolti DESC
LIMIT 5;

CREATE VIEW totale_speso_utente AS
SELECT Utente.ID_ute AS ID, Utente.Nome_ute AS Nome, Utente.Cognome_ute AS Cognome, Utente.Nazione_ute AS Nazione, round(Sum(Importo_acq),2) AS Totale_Speso
FROM Acquisto JOIN Utente ON Acquisto.Utente_acq=Utente.ID_ute
GROUP BY Utente.ID_ute, Utente.Nome_ute, Utente.Cognome_ute, Utente.Nazione_ute;

CREATE VIEW Acquisti_2016 AS
SELECT Brano.ID_bra, Brano.Titolo_bra, COUNT(*) AS Numero_Acquisti
FROM Acquisto JOIN Brano ON Acquisto.Brano_acq=Brano.ID_bra
WHERE Acquisto.Data_acq BETWEEN '2016-01-01' AND '2016-12-31'
GROUP BY Brano.ID_bra, Brano.Titolo_bra;

CREATE VIEW top5_vendite_2016 AS
SELECT Acquisti_2016.ID_Bra AS ID, Acquisti_2016.Titolo_bra AS Titolo, GROUP_CONCAT(Artista.Nome_art SEPARATOR ', ') AS Artista, Acquisti_2016.Numero_Acquisti
FROM Acquisti_2016, Esecuzione, Artista
WHERE Acquisti_2016.ID_bra=Esecuzione.Brano_ese and Esecuzione.Artista_ese=Artista.ID_art
GROUP BY Acquisti_2016.ID_bra, Acquisti_2016.Titolo_bra
ORDER BY Numero_Acquisti DESC
LIMIT 5;

CREATE VIEW artista_più_in_attività AS
SELECT Artista.Nome_art AS Nome_Artista, Brano.Data_bra AS Data
FROM Artista, Esecuzione, Brano
WHERE Artista.ID_art=Esecuzione.Artista_ese AND Esecuzione.Brano_ese=Brano.ID_bra
ORDER BY Brano.Data_bra ASC
LIMIT 1;

CREATE VIEW artisti_band AS
SELECT ID_art AS ID, Nome_art AS Nome_Artista
FROM Artista
WHERE NumComp_ban IS NOT NULL;

CREATE VIEW genere_album AS
SELECT Album.ID_alb AS ID, Album.Nome_alb AS Nome_Album, GROUP_CONCAT(DISTINCT Genere.Nome_gen SEPARATOR ', ') AS Genere_Album
FROM Genere, Brano, BranoAlbum, Album
WHERE Genere.ID_gen=Brano.Genere_bra AND Brano.ID_bra=BranoAlbum.Brano_ba AND BranoAlbum.Album_ba=Album.ID_alb
GROUP BY Album.ID_alb, Album.Nome_alb;

CREATE VIEW brani_sigle AS
SELECT ID_bra AS ID, Titolo_bra AS Titolo
FROM Brano
WHERE Brano.ID_bra NOT IN (SELECT Brano.Id_bra AS Brano
FROM Brano JOIN BranoAlbum ON Brano.ID_bra=BranoAlbum.Brano_ba);


