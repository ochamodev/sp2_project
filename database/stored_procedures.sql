
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

CALL StandardDeviationPerMonthByYear(1, 2023);
CALL TotalSalesPerMonthByYear(1, 2022);
CALL GetSalesPerformance(1);
CALL ExistingBillingYears(1);



