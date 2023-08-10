CREATE DATABASE IF NOT EXISTS ProyectoSP2;

USE ProyectoSP2;

CREATE TABLE IF NOT EXISTS EmitterDTE(
    idEmitterDte INT AUTO_INCREMENT,
    nit VARCHAR(25) NOT NULL,
    nameEmitter VARCHAR(255) NOT NULL,
    PRIMARY KEY(idEmitterDte),
    UNIQUE (nit)
);

CREATE TABLE IF NOT EXISTS CertifierDTE(
    idNitCertifier INT AUTO_INCREMENT,
    fullNameCertifier TEXT,
    nitCertifier VARCHAR(25) NOT NULL,
    PRIMARY KEY (idNitCertifier)
);

CREATE TABLE IF NOT EXISTS DteDocumentEstatus(
    idDteDocumentEstatus INT AUTO_INCREMENT,
    descriptionEstatus VARCHAR (255),
    PRIMARY KEY (idDteDocumentEstatus)
);

CREATE TABLE IF NOT EXISTS DTEReceptor(
    idDteReceptor INT AUTO_INCREMENT,
    nit VARCHAR(25) NOT NULL,
    fullnameReceptor VARCHAR(255) NOT NULL,
    PRIMARY KEY (idDteReceptor),
    UNIQUE (nit)
);

CREATE TABLE IF NOT EXISTS PlatformUser(
    idUser INT AUTO_INCREMENT,
    nitEmitter INT NOT NULL,
    userName VARCHAR(255) NOT NULL,
    userLastName VARCHAR(255) NOT NULL,
    userEmail VARCHAR(255) NOT NULL,
    PRIMARY KEY (idUser),
    FOREIGN KEY (nitEmitter)
        REFERENCES EmitterDTE(idEmitterDte)
);

CREATE TABLE IF NOT EXISTS Establishment(
    idEstablishment INT AUTO_INCREMENT,
    nitEmitter INT NOT NULL,
    nameEmitter VARCHAR(255) NOT NULL,
    PRIMARY KEY (idEstablishment),
    FOREIGN KEY (nitEmitter)
        REFERENCES EmitterDTE(idEmitterDte),
    UNIQUE (nitEmitter, nameEmitter)
);

CREATE TABLE IF NOT EXISTS DTEDocument(
    idDTEDocument INT NOT NULL AUTO_INCREMENT,
    idEstablishment INT NOT NULL,
    idCertifier INT NOT NULL,
    idReceptor INT NOT NULL,
    idDteDocumentEstatus INT NOT NULL,
    authNumber TEXT,
    seriesNumber TEXT,
    emissionDate DATETIME,
    cancellationDate DATETIME,
    isMarkedCancelled TINYINT NOT NULL,
    amountGrandTotal DECIMAL(13, 4) NOT NULL,
    amountIva DECIMAL(13,4) NOT NULL,
    petroleumTax DECIMAL(13, 4) NOT NULL,
    tourismHospitalityTax DECIMAL(13, 4) NOT NULL,
    tourismPasajeTax DECIMAL(13, 4) NOT NULL,
    timbreDePrensaTax DECIMAL(13, 4) NOT NULL,
    firefightersTax DECIMAL(13, 4) NOT NULL,
    municipalTax DECIMAL(13, 4) NOT NULL,
    municipalFeeTax DECIMAL(13, 4) NOT NULL,
    alcoholicDrinksTax DECIMAL(13, 4) NOT NULL,
    tabaccoTax DECIMAL(13, 4) NOT NULL,
    cementTax DECIMAL(13, 4) NOT NULL,
    noAlcoholicDrinksTax DECIMAL(13, 4) NOT NULL,
    protuarieFeeTax DECIMAL(13, 4) NOT NULL,
    PRIMARY KEY (idDTEDocument),
    FOREIGN KEY (idEstablishment)
        REFERENCES Establishment(idEstablishment),
    FOREIGN KEY (idCertifier)
        REFERENCES CertifierDTE(idNitCertifier),
    FOREIGN KEY (idDteDocumentEstatus)
        REFERENCES DteDocumentEstatus(idDteDocumentEstatus),
    FOREIGN KEY (idReceptor)
        REFERENCES DTEReceptor(idDteReceptor)
);


