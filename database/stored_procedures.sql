
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
    LIMIT 1;
END $$
DELIMITER ;

DROP PROCEDURE GetSalesPerformance;

