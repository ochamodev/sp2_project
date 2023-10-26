USE proyectosp2;

DROP PROCEDURE IF EXISTS GetAvgActiveMonth;
DELIMITER $$

CREATE PROCEDURE GetAvgActiveMonth(
	IN emitterNit INT
)
BEGIN
	SELECT AVG(subquery.monthT) AS 'avgActiveMonth'
    FROM (
		SELECT DISTINCT idReceptor AS 'idReceptor',
		COUNT(DISTINCT MONTH(emissionDate)) AS 'monthT',
		dtedocument.idDteDocumentEstatus,
		Establishment.nitEmitter
		FROM dtedocument
		INNER JOIN Establishment
		ON Establishment.idEstablishment = DteDocument.idEstablishment
		GROUP BY dtedocument.idReceptor, dtedocument.idDteDocumentEstatus, Establishment.nitEmitter
		HAVING dtedocument.idDteDocumentEstatus = 1 AND Establishment.nitEmitter = emitterNit
    ) AS subquery;
END $$

DELIMITER ;

CALL GetAvgActiveMonth(1);

DROP PROCEDURE IF EXISTS GetAvgFrequencyPurchase;
DELIMITER $$

CREATE PROCEDURE GetAvgFrequencyPurchase(
	IN emitterNit INT
)
BEGIN
	SELECT (subquery.idDTEDocument / subquery.monthT) AS 'avgFrequencyMonth'
    FROM (
		SELECT COUNT(idDTEDocument) AS 'idDteDocument',
		COUNT(DISTINCT MONTH(emissionDate)) AS 'monthT',
		dtedocument.idDteDocumentEstatus,
		Establishment.nitEmitter
		FROM dtedocument
		INNER JOIN Establishment
		ON Establishment.idEstablishment = DteDocument.idEstablishment
		GROUP BY dtedocument.idDteDocumentEstatus, Establishment.nitEmitter
		HAVING dtedocument.idDteDocumentEstatus = 1 AND Establishment.nitEmitter = emitterNit
    ) AS subquery;
END $$

DELIMITER ;

CALL GetAvgFrequencyPurchase(1);

DROP PROCEDURE IF EXISTS GetAvgPurchase;

DELIMITER $$
CREATE PROCEDURE GetAvgPurchase(
	IN emitterNit INT
)
BEGIN
	SELECT avg(amountGrandTotal) AS 'avgPurchase', 
    dtedocument.idDteDocumentEstatus,
    Establishment.nitEmitter FROM DteDocument
	INNER JOIN Establishment
    ON Establishment.idEstablishment = DteDocument.idEstablishment
	GROUP BY Establishment.nitEmitter, dtedocument.idDteDocumentEstatus
    HAVING dtedocument.idDteDocumentEstatus = 1 AND Establishment.nitEmitter = emitterNit;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS GetTotalClients;

CALL GetAvgPurchase(1);

DELIMITER $$
CREATE PROCEDURE GetTotalClients(
	IN emitterNit INT
)
BEGIN
	SELECT COUNT(DISTINCT dtedocument.idReceptor) AS 'totalClients',
    dtedocument.idDteDocumentEstatus,
    Establishment.nitEmitter FROM DteDocument
	INNER JOIN Establishment
    ON Establishment.idEstablishment = DteDocument.idEstablishment
	GROUP BY Establishment.nitEmitter, dtedocument.idDteDocumentEstatus
    HAVING dtedocument.idDteDocumentEstatus = 1 AND Establishment.nitEmitter = emitterNit;
END $$
DELIMITER ;

CALL GetTotalClients(1);

DROP PROCEDURE IF EXISTS CustomerValue;
DELIMITER $$
CREATE PROCEDURE CustomerValue(
    IN emitterNit INT,
    IN yearToRequest INT
)
BEGIN
    SELECT subquery.yearT,
    subquery.monthT,
    subquery.amount,
    subquery.clientCount, 
    subquery.quantity, 
    (subquery.amount/subquery.clientCount) AS 'customerValue',
    (subquery.quantity/subquery.clientCount) AS 'purchaseRate', 
    (subquery.amount/subquery.quantity) AS 'purchaseValue'
    FROM(
        SELECT SUM(amountGrandTotal) AS 'amount', 
        COUNT(dtedocument.idDTEDocument) AS 'quantity',
        YEAR(emissionDate) 'yearT',
        MONTH(emissionDate) 'monthT',
        COUNT(DISTINCT idReceptor) 'clientCount' FROM DteDocument
        INNER JOIN Establishment
        ON Establishment.idEstablishment = DteDocument.idEstablishment
        GROUP BY yearT, dtedocument.idDteDocumentEstatus, Establishment.nitEmitter,
        monthT
        HAVING dtedocument.idDteDocumentEstatus = 1 AND Establishment.nitEmitter = emitterNit
        AND yearT = yearToRequest
    ) AS subquery;
END $$

DELIMITER ;
CALL CustomerValue(1, 2023)


    
