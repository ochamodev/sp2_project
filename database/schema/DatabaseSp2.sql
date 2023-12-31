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
    userPassword VARCHAR(255) NOT NULL,
    PRIMARY KEY (idUser),
    FOREIGN KEY (nitEmitter)
        REFERENCES EmitterDTE(idEmitterDte)
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Establishment(
    idEstablishment INT AUTO_INCREMENT,
    establishmentCode INT NOT NULL,
    nitEmitter INT NOT NULL,
    nameEmitter VARCHAR(255) NOT NULL,
    PRIMARY KEY (idEstablishment),
    FOREIGN KEY (nitEmitter)
        REFERENCES EmitterDTE(idEmitterDte)
        ON DELETE CASCADE,
    UNIQUE (nitEmitter, nameEmitter, establishmentCode)
);

CREATE TABLE IF NOT EXISTS DTEDocument(
    idDTEDocument INT NOT NULL AUTO_INCREMENT,
    idEstablishment INT NOT NULL,
    idCertifier INT NOT NULL,
    idReceptor INT NOT NULL,
    idDteDocumentEstatus INT NOT NULL,
    authNumber TEXT,
    seriesNumber TEXT,
    emissionDate DATE,
    cancellationDate DATETIME,
    isMarkedCancelled TINYINT NOT NULL,
    amountGrandTotal DECIMAL(13, 2) NOT NULL,
    amountIva DECIMAL(13,2) NOT NULL,
    petroleumTax DECIMAL(13, 2) NOT NULL,
    tourismHospitalityTax DECIMAL(13, 2) NOT NULL,
    tourismPasajeTax DECIMAL(13, 2) NOT NULL,
    timbreDePrensaTax DECIMAL(13, 2) NOT NULL,
    firefightersTax DECIMAL(13, 2) NOT NULL,
    municipalFeeTax DECIMAL(13, 2) NOT NULL,
    alcoholicDrinksTax DECIMAL(13, 2) NOT NULL,
    tabaccoTax DECIMAL(13, 2) NOT NULL,
    cementTax DECIMAL(13, 2) NOT NULL,
    noAlcoholicDrinksTax DECIMAL(13, 2) NOT NULL,
    protuarieFeeTax DECIMAL(13, 2) NOT NULL,
    PRIMARY KEY (idDTEDocument),
    FOREIGN KEY (idEstablishment)
        REFERENCES Establishment(idEstablishment)
        ON DELETE CASCADE,
    FOREIGN KEY (idCertifier)
        REFERENCES CertifierDTE(idNitCertifier)
        ON DELETE CASCADE,
    FOREIGN KEY (idDteDocumentEstatus)
        REFERENCES DteDocumentEstatus(idDteDocumentEstatus)
        ON DELETE CASCADE,
    FOREIGN KEY (idReceptor)
        REFERENCES DTEReceptor(idDteReceptor)
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS ResponseCodes(
    idResponse INT NOT NULL AUTO_INCREMENT,
    respCode VARCHAR(255) NOT NULL,
    respDescription VARCHAR(255) NOT NULL,
    PRIMARY KEY (idResponse),
    UNIQUE(respCode)
)
