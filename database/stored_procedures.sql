
USE ProyectoSP2;


DELIMITER $$
CREATE PROCEDURE GetSalesPerformance(
	IN emitterNit INT
)
BEGIN
	SELECT SUM(amountGrandTotal) AS 'amount', 
    COUNT(dtedocument.idDTEDocument) AS 'quantity',
    YEAR(emissionDate) 'yearT',
    dtedocument.idDteDocumentEstatus,
    Establishment.nitEmitter FROM DteDocument
	INNER JOIN Establishment
    ON Establishment.idEstablishment = DteDocument.idEstablishment
	GROUP BY yearT, dtedocument.idDteDocumentEstatus, Establishment.nitEmitter
    HAVING dtedocument.idDteDocumentEstatus = 1 AND Establishment.nitEmitter = emitterNit
    LIMIT 5;
END $$

DELIMITER ;

DELIMITER $$
CREATE PROCEDURE TotalSalesPerMonthByYear(
	IN emitterNit INT,
    IN yearRequested INT
)
BEGIN
	SELECT SUM(amountGrandTotal) AS 'amount', 
		COUNT(dtedocument.idDTEDocument) AS 'quantity',
		YEAR(emissionDate) 'yearT',
        MONTH(emissionDAte) 'monthT',
		dtedocument.idDteDocumentEstatus,
		Establishment.nitEmitter FROM DteDocument
		INNER JOIN Establishment
		ON Establishment.idEstablishment = DteDocument.idEstablishment
		GROUP BY yearT, monthT, dtedocument.idDteDocumentEstatus, Establishment.nitEmitter
		HAVING dtedocument.idDteDocumentEstatus = 1 AND Establishment.nitEmitter = emitterNit
        AND yearT = yearRequested;
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE ExistingBillingYears(
	IN nitEmitterId INT
)
BEGIN
	START TRANSACTION;
	SELECT DISTINCT YEAR(emissionDate) 'yearT'
		FROM DteDocument
		INNER JOIN Establishment
		ON Establishment.idEstablishment = DteDocument.idEstablishment
		WHERE Establishment.nitEmitter = nitEmitterId
        LIMIT 5;
	COMMIT;
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE StandardDeviationPerMonthByYear(
	IN emitterNit INT,
    IN yearRequested INT
)
BEGIN
	SELECT STDDEV(amountGrandTotal) AS 'amount', 
		YEAR(emissionDate) 'yearT',
        MONTH(emissionDAte) 'monthT',
		dtedocument.idDteDocumentEstatus,
		Establishment.nitEmitter FROM DteDocument
		INNER JOIN Establishment
		ON Establishment.idEstablishment = DteDocument.idEstablishment
		GROUP BY yearT, monthT, Establishment.nitEmitter
		HAVING dtedocument.idDteDocumentEstatus = 1 AND Establishment.nitEmitter = emitterNit
        AND yearT = yearRequested;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS GetUsersInCompany;
DELIMITER $$
CREATE PROCEDURE GetUsersInCompany(
    IN emitterId INT
)
BEGIN
    SELECT p.* FROM platformuser AS p
        INNER JOIN emitterplatformuser AS epu
        ON epu.idUser = p.idUser
        WHERE epu.nitEmitter = emitterId;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS DeleteUserFromCompany;
DELIMITER $$
CREATE PROCEDURE DeleteUserFromCompany(
    IN emitterId INT,
    IN userId INT
)
BEGIN
    START TRANSACTION;
    DELETE FROM emitterplatformuser
        WHERE idUser = userId AND nitEmitter = emitterId;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS AddUserToCompany;
DELIMITER $$
CREATE PROCEDURE AddUserToCompany(
    IN emitterId INT,
    IN _userName VARCHAR(255),
    IN _lastName VARCHAR(255),
    IN _userEmail VARCHAR(255),
    IN _userPassword VARCHAR(255)
)
BEGIN
    INSERT INTO platformuser (userName, userLastName, userEmail, userPassword)
        VALUES(_userName, _lastName, _userEmail, _userPassword);
    INSERT INTO emitterplatformuser(idUser, nitEmitter)
        VALUES (LAST_INSERT_ID(), emitterId);
END $$


DELIMITER ;

CALL AddUserToCompany(1, 'HELLO', 'WORL', 'FffF', 'DA');


CALL StandardDeviationPerMonthByYear(1, 2023);
CALL TotalSalesPerMonthByYear(1, 2022);
CALL GetSalesPerformance(1);
CALL ExistingBillingYears(1);

CALL DeleteUserFromCompany(2, 2);

