-- DROP DATABASE IF EXISTS digital_twin_ponte;
CREATE DATABASE IF NOT EXISTS digital_twin_ponte;
USE digital_twin_ponte;

CREATE TABLE IF NOT EXISTS Sensore (
    id_sensore INT AUTO_INCREMENT PRIMARY KEY,
    tipo VARCHAR(50) NOT NULL,              
    posizione VARCHAR(100) NOT NULL,        
    unita_misura VARCHAR(20) NOT NULL,      
    data_installazione DATE NOT NULL        
);


CREATE TABLE IF NOT EXISTS Rilevazione (
    id_rilevazione INT AUTO_INCREMENT PRIMARY KEY,
    id_sensore INT NOT NULL,
    timestamp DATETIME NOT NULL,            
    valore DECIMAL(10, 4) NOT NULL,         
    qualita VARCHAR(30) DEFAULT 'Valida',   
    
    CONSTRAINT fk_rilevazione_sensore 
        FOREIGN KEY (id_sensore) REFERENCES Sensore(id_sensore)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Allarme (
    id_allarme INT AUTO_INCREMENT PRIMARY KEY,
    id_sensore INT NOT NULL,
    timestamp_inizio DATETIME NOT NULL,
    timestamp_fine DATETIME NULL,           
    livello VARCHAR(20) NOT NULL,          
    descrizione TEXT,                      
    
    CONSTRAINT fk_allarme_sensore 
        FOREIGN KEY (id_sensore) REFERENCES Sensore(id_sensore)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Manutenzione (
    id_manutenzione INT AUTO_INCREMENT PRIMARY KEY,
    id_allarme INT NOT NULL,
    tecnico VARCHAR(100) NOT NULL,          
    data_intervento DATE NOT NULL,          
    esito VARCHAR(100) NOT NULL,            
    
    CONSTRAINT fk_manutenzione_allarme 
        FOREIGN KEY (id_allarme) REFERENCES Allarme(id_allarme)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

INSERT INTO Sensore (tipo, posizione, unita_misura, data_installazione)
VALUES 
    ('Accelerometro', 'Campata centrale', 'm/s2', '2025-03-10'),
    ('Estensimetro', 'Pilone Nord', 'microstrain', '2025-03-10'),
    ('Sensore di temperatura', 'Arcata Sud', '°C', '2025-03-12');

INSERT INTO Rilevazione (id_sensore, timestamp, valore, qualita)
VALUES 
    (1, '2026-11-20 08:30:00', 0.1450, 'Valida'),
    (1, '2026-11-20 08:35:00', 1.8900, 'Anomala'),
    (2, '2026-11-20 08:30:00', 120.5000, 'Valida'),
    (3, '2026-11-20 08:30:00', 14.2000, 'Valida');

INSERT INTO Allarme (id_sensore, timestamp_inizio, timestamp_fine, livello, descrizione)
VALUES 
    (1, '2026-11-20 08:35:10', '2026-11-20 11:15:00', 'Critico', 'Vibrazione eccessiva rilevata sulla campata centrale'),
    (2, '2026-11-21 14:00:00', NULL, 'Medio', 'Deformazione superiore alla soglia sul pilone Nord');

INSERT INTO Manutenzione (id_allarme, tecnico, data_intervento, esito)
VALUES 
    (1, '[Tuo Nome e Cognome]', '2026-11-20', 'Risolto - Taratura supporto sensore'),
    (2, 'Ing. Laura Bianchi', '2026-11-22', 'In verifica - Monitoraggio in corso');


SHOW TABLES;

DESCRIBE Sensore;
DESCRIBE Rilevazione;
DESCRIBE Allarme;
DESCRIBE Manutenzione;

SELECT * FROM Sensore;
SELECT * FROM Rilevazione;
SELECT * FROM Allarme;
SELECT * FROM Manutenzione;
