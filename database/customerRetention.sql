USE proyectosp2;

DROP PROCEDURE IF EXISTS CustomerRetention;

DELIMITER $$

CREATE PROCEDURE CustomerRetention(
    IN emitterID INT,
    IN requestedYear INT
)
BEGIN
    -- Declare variables to store the analysis results
    DECLARE currentMonth INT;
    DECLARE prevMonth INT;
    DECLARE maxMonth INT;
    DECLARE minMonth INT;
    DECLARE prevYear INT;
    DECLARE count INT;

    -- Get the maximum month in the requested year
    SELECT MAX(MONTH(emissionDate))
    INTO maxMonth
    FROM DTEDocument
    WHERE YEAR(emissionDate) = requestedYear;

    -- Get the minimum month in the requested year
    SELECT MIN(MONTH(emissionDate))
    INTO minMonth
    FROM DTEDocument
    WHERE YEAR(emissionDate) = requestedYear;

    -- Initialize the previous year for the first iteration    
    IF minMonth = 1 THEN
            SET prevMonth = 12;
            SET prevYear = requestedYear - 1;
    END IF;
    
    IF minMonth > 1 THEN
		SET prevMonth = minMonth - 1;
        SET prevYear = requestedYear;
	END IF;
    SET currentMonth = minMonth;
    SET count = maxMonth;
    
    -- Create temporary tables to store data for analysis
    CREATE TEMPORARY TABLE IF NOT EXISTS TempPrevMonthClients (
        idReceptor INT,
        amountGrandTotal DECIMAL(13, 2)
    );

    CREATE TEMPORARY TABLE IF NOT EXISTS TempCurrMonthClients (
        idReceptor INT,
        amountGrandTotal DECIMAL(13, 2)
    );
    
    CREATE TEMPORARY TABLE IF NOT EXISTS FinalReport (
        yearT INT,
        monthT INT,
        newClients INT,
        newAmount DECIMAL(13, 2),
        cancelledClients INT,
        cancelledAmount DECIMAL(13, 2),
        retainedClients INT,
        retainedAmount DECIMAL(13, 2),
        customerRetention DECIMAL(5, 4)
    );

    -- Display the report for the first iteration
    IF count = maxMonth THEN
    
		-- Populate temporary tables with data
		INSERT INTO TempPrevMonthClients
		SELECT idReceptor, amountGrandTotal
		FROM DTEDocument
		WHERE MONTH(emissionDate) = prevMonth AND YEAR(emissionDate) = prevYear
			AND idDteDocumentEstatus = 1
			AND idEstablishment IN (SELECT idEstablishment FROM Establishment WHERE nitEmitter = emitterID);

		INSERT INTO TempCurrMonthClients
		SELECT idReceptor, amountGrandTotal
		FROM DTEDocument
		WHERE MONTH(emissionDate) = currentMonth AND YEAR(emissionDate) = requestedYear
			AND idDteDocumentEstatus = 1
			AND idEstablishment IN (SELECT idEstablishment FROM Establishment WHERE nitEmitter = emitterID);
		
        -- Calculate cancelled, new, and retained clients and amounts
        CREATE TEMPORARY TABLE IF NOT EXISTS CancelledClients AS
            SELECT idReceptor, amountGrandTotal
            FROM TempPrevMonthClients
            WHERE idReceptor NOT IN (SELECT idReceptor FROM TempCurrMonthClients);

        CREATE TEMPORARY TABLE IF NOT EXISTS NewClients AS
            SELECT idReceptor, amountGrandTotal
            FROM TempCurrMonthClients
            WHERE idReceptor NOT IN (SELECT idReceptor FROM TempPrevMonthClients);

        CREATE TEMPORARY TABLE IF NOT EXISTS RetainedClients AS
            SELECT idReceptor, amountGrandTotal
            FROM TempPrevMonthClients
            WHERE idReceptor IN (SELECT idReceptor FROM TempCurrMonthClients);       
            
		-- Display the report for the current iteration
        INSERT INTO FinalReport
		SELECT
			requestedYear AS 'yearT',
			currentMonth AS 'monthT',
			(SELECT COUNT(DISTINCT idReceptor) FROM NewClients) AS 'newClients',
			(SELECT IFNULL(SUM(amountGrandTotal), 0) FROM NewClients) AS 'newAmount',
			(SELECT COUNT(DISTINCT idReceptor) FROM CancelledClients) AS 'cancelledClients',
			(SELECT IFNULL(SUM(amountGrandTotal), 0) FROM CancelledClients) AS 'cancelledAmount',
			(SELECT COUNT(DISTINCT idReceptor) FROM RetainedClients) AS 'retainedClients',
			(SELECT IFNULL(SUM(amountGrandTotal), 0) FROM RetainedClients) AS 'retainedAmount',
            IFNULL(
				(SELECT COUNT(DISTINCT idReceptor) FROM RetainedClients) /
				(
					(SELECT COUNT(DISTINCT idReceptor) FROM RetainedClients) +
					(SELECT COUNT(DISTINCT idReceptor) FROM CancelledClients)
				),
				0
			) AS 'customerRetention';
        
        DROP TEMPORARY TABLE IF EXISTS CancelledClients, NewClients, RetainedClients;
        TRUNCATE TempPrevMonthClients;
        TRUNCATE TempCurrMonthClients;
        
        SET count = count - 1;
        SET currentMonth = currentMonth + 1;
        IF prevMonth < 12 THEN
			SET prevMonth = prevMonth + 1;
        END IF;
        IF prevMonth = 12 THEN
            SET prevMonth = 1;
            SET prevYear = requestedYear;
        END IF;
        
    END IF;

    -- Loop through each month starting from the second iteration
    WHILE count > 0 DO

        -- Update TempPrevMonthClients and TempCurrMonthClients for the next iteration
        INSERT INTO TempPrevMonthClients
            SELECT idReceptor, amountGrandTotal
            FROM DTEDocument
            WHERE MONTH(emissionDate) = prevMonth AND YEAR(emissionDate) = prevYear
                AND idDteDocumentEstatus = 1
                AND idEstablishment IN (SELECT idEstablishment FROM Establishment WHERE nitEmitter = emitterID);

        INSERT INTO TempCurrMonthClients
            SELECT idReceptor, amountGrandTotal
            FROM DTEDocument
            WHERE MONTH(emissionDate) = currentMonth AND YEAR(emissionDate) = requestedYear
                AND idDteDocumentEstatus = 1
                AND idEstablishment IN (SELECT idEstablishment FROM Establishment WHERE nitEmitter = emitterID);
    
        -- Calculate cancelled, new, and retained clients and amounts
        CREATE TEMPORARY TABLE IF NOT EXISTS CancelledClients AS
            SELECT idReceptor, amountGrandTotal
            FROM TempPrevMonthClients
            WHERE idReceptor NOT IN (SELECT idReceptor FROM TempCurrMonthClients);

        CREATE TEMPORARY TABLE IF NOT EXISTS NewClients AS
            SELECT idReceptor, amountGrandTotal
            FROM TempCurrMonthClients
            WHERE idReceptor NOT IN (SELECT idReceptor FROM TempPrevMonthClients);

        CREATE TEMPORARY TABLE IF NOT EXISTS RetainedClients AS
            SELECT idReceptor, amountGrandTotal
            FROM TempPrevMonthClients
            WHERE idReceptor IN (SELECT idReceptor FROM TempCurrMonthClients);

        -- Display the report for the current iteration
        INSERT INTO FinalReport
		SELECT
			requestedYear AS 'yearT',
			currentMonth AS 'monthT',
			(SELECT COUNT(DISTINCT idReceptor) FROM NewClients) AS 'newClients',
			(SELECT IFNULL(SUM(amountGrandTotal), 0) FROM NewClients) AS 'newAmount',
			(SELECT COUNT(DISTINCT idReceptor) FROM CancelledClients) AS 'cancelledClients',
			(SELECT IFNULL(SUM(amountGrandTotal), 0) FROM CancelledClients) AS 'cancelledAmount',
			(SELECT COUNT(DISTINCT idReceptor) FROM RetainedClients) AS 'retainedClients',
			(SELECT IFNULL(SUM(amountGrandTotal), 0) FROM RetainedClients) AS 'retainedAmount',
            IFNULL(
				(SELECT COUNT(DISTINCT idReceptor) FROM RetainedClients) /
				(
					(SELECT COUNT(DISTINCT idReceptor) FROM RetainedClients) +
					(SELECT COUNT(DISTINCT idReceptor) FROM CancelledClients)
				),
				0
			) AS 'customerRetention';

        -- Move to the next iteration (previous month and year)
        SET count = count - 1;
        SET currentMonth = currentMonth + 1;
        IF prevMonth < 12 THEN
			SET prevMonth = prevMonth + 1;
        END IF;
        IF prevMonth = 12 THEN
            SET prevMonth = 1;
            SET prevYear = requestedYear;
        END IF;
        
        TRUNCATE TempPrevMonthClients;
        TRUNCATE TempCurrMonthClients;
        TRUNCATE CancelledClients;
        TRUNCATE NewClients;
        TRUNCATE RetainedClients;

        DROP TEMPORARY TABLE IF EXISTS CancelledClients, NewClients, RetainedClients;
    END WHILE;
    
    -- Select the final report
    SELECT * FROM FinalReport;

    -- Drop tables
    DROP TEMPORARY TABLE IF EXISTS TempPrevMonthClients, TempCurrMonthClients, CancelledClients, NewClients, RetainedClients;
    DROP TABLE IF EXISTS FinalReport;
END $$

DELIMITER ;

CALL CustomerRetention(1, 2023);