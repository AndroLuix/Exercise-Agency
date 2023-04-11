-- create database agenzia;

-- use agenzia;

create table quartieri(
codice INT auto_increment primary key,
nome varchar(30) NOT NULL,
url_mappa VARCHAR(30)

);
INSERT INTO agenzia.quartieri VALUES ( '1','Teramo Centro','www.teramocentro.it');

CREATE TABLE proprietari(
codice_fiscale CHAR(16) PRIMARY KEY,
nome VARCHAR(30) NOT NULL,
indirizzo VARCHAR(30),
telefono VARCHAR(20),
cellulare VARCHAR(20),
email VARCHAR(30),
codice_iban VARCHAR(27)
);
INSERT INTO agenzia.proprietari VALUES('DCLLSD37JH234','Luca Ambrosio','via Dante Alighieri',
'08199572395','3476394672','this@email.com','IT000384700000284');
-- MODIFICA 11/02/2023
use agenzia;
alter table proprietari
modify column email VARCHAR(40);

CREATE TABLE appartamenti(
codice INT AUTO_INCREMENT PRIMARY KEY,
indirizzo VARCHAR(40),
prezo DOUBLE, 
numero_camere INT,
posti_letto INT,
uso_cucina CHAR(1),
parcheggio CHAR(1),
note TEXT,
codice_quartiere INT,
codice_propeitario CHAR(16),
CHECK (uso_cucina = "S" OR "N" AND parcheggio = "S" OR "N"),
foreign key(codice_quartiere) references quartieri(codice),
foreign key(codice_propeitario) references proprietari(codice_fiscale)
);
 INSERT INTO agenzia.appartamenti VALUES('1','via Dante','150000.0','2','2','S','S',
 'nuova con terrazzo','1','DCLLSD37JH234');

CREATE TABLE foto(
codice INT AUTO_INCREMENT PRIMARY KEY,
didascalia VARCHAR(50),
url_foto VARCHAR(30),
codice_appartamento INT,

foreign key(codice_appartamento) references appartamenti(codice)
);

CREATE TABLE clienti (
codice_fiscale CHAR(16) NOT NULL PRIMARY KEY,
nome VARCHAR(50) NOT NULL,
indirizzo VARCHAR(60),
nome_utente VARCHAR(10),
password_utente VARCHAR(10),
telefono VARCHAR(20),
cellulare VARCHAR(20),
email VARCHAR(30)
);

CREATE TABLE prenotazioni(
codice INT AUTO_INCREMENT PRIMARY KEY,
data_prenotazione DATE,
codice_cliente 	char(16),
conferma_prenotazione CHAR(1),
CHECK (conferma_prenotazione = "S" OR "N" OR null),
foreign key(codice_cliente) references clienti(codice_fiscale)
);
-- drop table prenotazioni;

CREATE TABLE righe(
codice INT AUTO_INCREMENT PRIMARY KEY,
data_iniziale date,
costo double,
conferma_riga char(1),
codice_prenotazione INT not null,
codice_appartamento int not null,
CHECK (conferma_riga = "S" OR "N" OR null),
foreign key(codice_prenotazione) references prenotazioni(codice),
foreign key(codice_appartamento) references appartamenti(codice)
);

create table disponibilita(
codice int auto_increment primary key,
data_ date,
disponibile char(1),
codice_riga int,
codice_appartamento int,
CHECK (disponibile = "S" OR "N" OR null),
foreign key(codice_riga) references righe(codice),
foreign key(codice_appartamento) references appartamenti(codice)
);
use agenzia;
alter table disponibilita
modify column data_ datetime;
