SET FOREIGN_KEY_CHECKS=0;

CREATE TABLE IF NOT EXISTS Utente(
    ID_ute int(11) auto_increment primary key,
    Nome_ute varchar(50) not null,
    Cognome_ute varchar(50) not null,
    DataN_ute date not null,
    Email_ute varchar(50) not null,
    Password_ute varchar(50) not null,
    Nazione_ute varchar(50) not null,
    Credito_ute float not null
);

CREATE TABLE IF NOT EXISTS Genere(
    ID_gen int(11) auto_increment primary key,
    Nome_gen varchar(50) not null
);

CREATE TABLE IF NOT EXISTS Brano(
    ID_bra int(11) auto_increment primary key,
    Titolo_bra varchar(50) not null,
    Durata_bra time not null,
    Data_bra date not null,
    Dimensione_bra int(11) not null,
    Prezzo_bra float not null,
    Genere_bra int(11) not null,
    FOREIGN KEY(Genere_bra) REFERENCES Genere(ID_gen)
);

CREATE TABLE IF NOT EXISTS Libreria(
    ID_lib int(11) auto_increment primary key,
    Utente_lib int(11) not null,
    FOREIGN KEY(Utente_lib) REFERENCES Utente(ID_ute)
   	 ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Dispositivo(
    ID_disp int(11) auto_increment primary key,
    Nome_disp varchar(50),
    SpazioResiduo_disp bigint(12) not null,
    Libreria_disp int(11) not null,
    FOREIGN KEY(Libreria_disp) REFERENCES Libreria(ID_lib)
);

CREATE TABLE IF NOT EXISTS Album(
    ID_alb int(11) auto_increment primary key,
    Nome_alb varchar(50) not null,
    Data_alb date not null
);

CREATE TABLE IF NOT EXISTS Artista(
    ID_art int(11) auto_increment primary key,
    Nome_art varchar(50) not null,
    Nazione_art varchar(50) not null,
    NumComp_ban int(11)
);

CREATE TABLE IF NOT EXISTS Esecuzione(
    Brano_ese int(11),
    Artista_ese int(11),
    PRIMARY KEY(Brano_ese,Artista_ese),
    FOREIGN KEY(Brano_ese) REFERENCES Brano(ID_bra)
   	 ON DELETE CASCADE,
    FOREIGN KEY(Artista_ese) REFERENCES Artista(ID_art)
   	 ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS BranoAlbum(
    Brano_ba int(11),
    Album_ba int(11),
    PRIMARY KEY(Brano_ba,Album_ba),
    FOREIGN KEY(Brano_ba) REFERENCES Brano(ID_bra)
   	 ON DELETE CASCADE,
    FOREIGN KEY(Album_ba) REFERENCES Album(ID_alb)
   	 ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS BranoLibreria(
    Brano_lb int(11),
    Libreria_lb int(11),
    PRIMARY KEY(Brano_lb,Libreria_lb),
    FOREIGN KEY(Brano_lb) REFERENCES Brano(ID_bra)
   	 ON DELETE CASCADE,
    FOREIGN KEY(Libreria_lb) REFERENCES Libreria(ID_lib)
   	 ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Acquisto(
    Data_acq date not null,
    Importo_acq float not null,
    Utente_acq int(11),
    Brano_acq int(11),
    PRIMARY KEY(Utente_acq,Brano_acq),
    FOREIGN KEY(Utente_acq) REFERENCES Utente(ID_ute),
    FOREIGN KEY(Brano_acq) references Brano(ID_bra)
);

CREATE TABLE IF NOT EXISTS Valutazione(
    Voto_val int(1),
    Utente_val int(11),
    Brano_val int(11),
    PRIMARY KEY(Utente_val,Brano_val),
    FOREIGN KEY(Utente_val) REFERENCES Utente(ID_ute),
    FOREIGN KEY(Brano_val) REFERENCES Brano(ID_bra)
);

CREATE TABLE IF NOT EXISTS Ascolto(
    Data_asc datetime,
    Utente_asc int(11),
    Brano_asc int(11),
    PRIMARY KEY(Data_asc,Utente_asc,Brano_asc),
    FOREIGN KEY(Utente_asc) REFERENCES Utente(ID_ute),
    FOREIGN KEY(Brano_asc) REFERENCES Brano(ID_bra)
);

CREATE TABLE IF NOT EXISTS Errori(
    ID_err int(11) auto_increment primary key,
    Descrizione_err varchar(50) not null
);

SET FOREIGN_KEY_CHECKS=1;


