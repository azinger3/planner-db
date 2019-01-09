
USE `planner`;
-- MySQL dump 10.13  Distrib 5.7.17, for macos10.12 (x86_64)
--
-- Host:     Database: planner
-- ------------------------------------------------------
-- Server version	5.7.22-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Dumping routines for database 'planner'
--
/*!50003 DROP FUNCTION IF EXISTS `DateMask` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE FUNCTION `DateMask`(SourceDT DATETIME) RETURNS varchar(10) CHARSET latin1
BEGIN
	DECLARE MaskDT VARCHAR(10);
    
    SET MaskDT = DATE_FORMAT(SourceDT,'%m/%d/%YY');
    
RETURN MaskDT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `MonthNumberGet` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE FUNCTION `MonthNumberGet`(BudgetMonth DATETIME) RETURNS int(11)
BEGIN
	DECLARE MonthNumber INT(2);
    
	SET MonthNumber = MONTH(BudgetMonth) + 9;
    
    IF MonthNumber > 12 THEN
		SET MonthNumber = MonthNumber - 12;
    END IF;
		
	RETURN MonthNumber;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ApplicationLogInsert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `ApplicationLogInsert`(
	ApplicationID				INT
	,RemoteAddress				VARCHAR(100)
	,RemoteHost					VARCHAR(100)
	,RemotePort					VARCHAR(100)
	,RemoteUser					VARCHAR(100)
	,RemoteUserRedirect			VARCHAR(100)
	,RequestMethod				VARCHAR(100)
	,RequestTime				VARCHAR(100)
	,HTTPAcceptCharacterSet		VARCHAR(100)
	,HTTPAcceptEncoding			VARCHAR(100)
	,HTTPAcceptHeader			VARCHAR(100)
	,HTTPAcceptLanguage			VARCHAR(100)
	,HTTPConnection				VARCHAR(100)
	,HTTPHost					VARCHAR(100)
	,HTTPReferer				VARCHAR(100)
	,HTTPSecure					VARCHAR(100)
	,HTTPUserAgent				VARCHAR(100)
	,AuthenticationPassword		VARCHAR(100)
	,AuthenticationType			VARCHAR(100)
	,AuthenticationUser			VARCHAR(100)
	,ServerAddress				VARCHAR(100)
	,ServerAdministrator		VARCHAR(100)
	,ServerName					VARCHAR(100)
	,ServerPort					VARCHAR(100)
	,ServerProtocol				VARCHAR(100)
	,ServerSignature			VARCHAR(100)
	,ServerSoftware				VARCHAR(100)
	,ScriptFileName				VARCHAR(100)
	,ScriptName					VARCHAR(100)
	,ScriptPathTranslated		VARCHAR(100)
	,ScriptURI					VARCHAR(100)
	,PathInformation			VARCHAR(100)
	,PathInformationOriginal	VARCHAR(100)
	,DocumentRoot				VARCHAR(100)
	,GatewayInterface			VARCHAR(100)
	,PHPSelf					VARCHAR(100)
	,QueryString				VARCHAR(100)
)
BEGIN
	INSERT INTO ApplicationLog
    (
		ApplicationID
		,RemoteAddress
		,RemoteHost
		,RemotePort
		,RemoteUser
		,RemoteUserRedirect
		,RequestMethod
		,RequestTime
		,HTTPAcceptCharacterSet
		,HTTPAcceptEncoding
		,HTTPAcceptHeader
		,HTTPAcceptLanguage
		,HTTPConnection
		,HTTPHost
		,HTTPReferer
		,HTTPSecure
		,HTTPUserAgent
		,AuthenticationPassword
		,AuthenticationType
		,AuthenticationUser
		,ServerAddress
		,ServerAdministrator
		,ServerName
		,ServerPort
		,ServerProtocol
		,ServerSignature
		,ServerSoftware
		,ScriptFileName
		,ScriptName
		,ScriptPathTranslated
		,ScriptURI
		,PathInformation
		,PathInformationOriginal
		,DocumentRoot
		,GatewayInterface
		,PHPSelf
		,QueryString
        ,CreateDT
        ,CreateBy
    )
	SELECT	ApplicationID
			,RemoteAddress
			,RemoteHost
			,RemotePort
			,RemoteUser
			,RemoteUserRedirect
			,RequestMethod
			,RequestTime
			,HTTPAcceptCharacterSet
			,HTTPAcceptEncoding
			,HTTPAcceptHeader
			,HTTPAcceptLanguage
			,HTTPConnection
			,HTTPHost
			,HTTPReferer
			,HTTPSecure
			,HTTPUserAgent
			,AuthenticationPassword
			,AuthenticationType
			,AuthenticationUser
			,ServerAddress
			,ServerAdministrator
			,ServerName
			,ServerPort
			,ServerProtocol
			,ServerSignature
			,ServerSoftware
			,ScriptFileName
			,ScriptName
			,ScriptPathTranslated
			,ScriptURI
			,PathInformation
			,PathInformationOriginal
			,DocumentRoot
			,GatewayInterface
			,PHPSelf
			,QueryString
			,CONVERT_TZ(NOW(),'+00:00','+03:00') 	AS CreateDT
			,'System' 								AS CreateBy
            ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `BudgetAverageGet` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE PROCEDURE `BudgetAverageGet`(StartDT DATETIME, EndDT DATETIME)
BEGIN
	DECLARE SessionID VARCHAR(100);
	DECLARE TimeSpanMonth INT;
    
    SET SessionID = UUID();
    SET TimeSpanMonth = TIMESTAMPDIFF(MONTH, StartDT, EndDT);

    INSERT INTO tmpBudgetAverage
    (
		SessionID
        ,TransactionID
		,TransactionDT
		,TransactionTypeID
		,TransactionType
		,TransactionNumber
		,Description
		,Amount
		,Note
        ,BudgetNumber
		,BudgetGroupID
		,BudgetGroup
		,BudgetCategoryID
		,BudgetCategory
		,Sort
    )
    SELECT		SessionID							AS SessionID
				,Transaction.TransactionID			AS TransactionID
				,Transaction.TransactionDT			AS TransactionDT
				,TransactionType.TransactionTypeID	AS TransactionTypeID
				,TransactionType.TransactionType	AS TransactionType
				,Transaction.TransactionNumber		AS TransactionNumber
				,Transaction.Description			AS Description
				,Transaction.Amount					AS Amount
				,Transaction.Note					AS Note
                ,Transaction.BudgetNumber			AS BudgetNumber
				,BudgetGroup.BudgetGroupID			AS BudgetGroupID
				,BudgetGroup.BudgetGroup			AS BudgetGroup
				,BudgetCategory.BudgetCategoryID	AS BudgetCategoryID
				,BudgetCategory.BudgetCategory		AS BudgetCategory
				,BudgetCategory.Sort				AS Sort
	FROM		Transaction Transaction
    INNER JOIN	TransactionType TransactionType
    ON			TransactionType.TransactionTypeID = Transaction.TransactionTypeID
	INNER JOIN	BudgetCategory BudgetCategory
    ON			BudgetCategory.BudgetCategoryID = Transaction.BudgetCategoryID
    INNER JOIN	BudgetGroup BudgetGroup
    ON			BudgetGroup.BudgetGroupID = BudgetCategory.BudgetGroupID
    WHERE		Transaction.TransactionDT BETWEEN StartDT AND EndDT
    AND			Transaction.TransactionTypeID IN (1, 2)
	;
    
	UPDATE		tmpBudgetAverage
    INNER JOIN	(
					SELECT 		BudgetItem.BudgetTypeID			AS BudgetTypeID	
								,BudgetItem.BudgetCategoryID	AS BudgetCategoryID
					FROM 		BudgetItem BudgetItem
                    INNER JOIN	tmpBudgetAverage tmpBudgetAverage	
                    ON			tmpBudgetAverage.BudgetCategoryID = BudgetItem.BudgetCategoryID
					AND			tmpBudgetAverage.BudgetNumber = BudgetItem.BudgetNumber
                    WHERE		tmpBudgetAverage.SessionID = SessionID
					GROUP BY	BudgetItem.BudgetCategoryID
				) RS
	ON			tmpBudgetAverage.BudgetCategoryID = RS.BudgetCategoryID
	SET			tmpBudgetAverage.BudgetTypeID = RS.BudgetTypeID
	WHERE 		tmpBudgetAverage.SessionID = SessionID
    ;
    
    UPDATE		tmpBudgetAverage
    INNER JOIN	(
					SELECT 		tmpBudgetAverage.BudgetCategoryID	AS BudgetCategoryID
								,SUM(tmpBudgetAverage.Amount)		AS CategoryActual 
					FROM 		tmpBudgetAverage tmpBudgetAverage	
                    WHERE 		tmpBudgetAverage.SessionID = SessionID
					AND			tmpBudgetAverage.BudgetTypeID = 1
                    AND			tmpBudgetAverage.TransactionTypeID = 1
					GROUP BY	tmpBudgetAverage.BudgetCategoryID
				) RS
	ON			tmpBudgetAverage.BudgetCategoryID = RS.BudgetCategoryID
	SET			tmpBudgetAverage.CategoryActual = RS.CategoryActual
    WHERE 		tmpBudgetAverage.SessionID = SessionID
    ;
    
	UPDATE		tmpBudgetAverage
    INNER JOIN	(
					SELECT 		tmpBudgetAverage.BudgetCategoryID	AS BudgetCategoryID
								,SUM(tmpBudgetAverage.Amount)		AS CategoryActual 
					FROM 		tmpBudgetAverage tmpBudgetAverage	
                    WHERE 		tmpBudgetAverage.SessionID = SessionID
					AND			tmpBudgetAverage.BudgetTypeID = 2
                    AND			tmpBudgetAverage.TransactionTypeID = 2
					GROUP BY	tmpBudgetAverage.BudgetCategoryID
				) RS
	ON			tmpBudgetAverage.BudgetCategoryID = RS.BudgetCategoryID
	SET			tmpBudgetAverage.CategoryActual = RS.CategoryActual
    WHERE 		tmpBudgetAverage.SessionID = SessionID
    ;
    
    UPDATE		tmpBudgetAverage
    SET			tmpBudgetAverage.CategoryAverage = IFNULL(tmpBudgetAverage.CategoryActual, 1) / TimeSpanMonth
    WHERE		tmpBudgetAverage.SessionID = SessionID
    ;
    
    UPDATE		tmpBudgetAverage
    INNER JOIN	(
					SELECT 		SUM(tmpBudgetAverage.Amount)	AS IncomeActual 
					FROM 		tmpBudgetAverage tmpBudgetAverage	
                    WHERE 		tmpBudgetAverage.SessionID = SessionID
                    AND			tmpBudgetAverage.BudgetTypeID = 1
					GROUP BY	tmpBudgetAverage.BudgetTypeID
				) RS
	SET			tmpBudgetAverage.IncomeActual = RS.IncomeActual
    WHERE 		tmpBudgetAverage.SessionID = SessionID
    ;
    
	UPDATE		tmpBudgetAverage
    SET			tmpBudgetAverage.IncomeAverage = IFNULL(tmpBudgetAverage.IncomeActual, 1) / TimeSpanMonth
    WHERE		tmpBudgetAverage.SessionID = SessionID
    ;
    
    UPDATE		tmpBudgetAverage
    INNER JOIN	(
					SELECT 		SUM(tmpBudgetAverage.Amount)	AS ExpenseActual 
					FROM 		tmpBudgetAverage tmpBudgetAverage	
                    WHERE 		tmpBudgetAverage.SessionID = SessionID
                    AND			tmpBudgetAverage.BudgetTypeID = 2
					GROUP BY	tmpBudgetAverage.BudgetTypeID
				) RS
	SET			tmpBudgetAverage.ExpenseActual = RS.ExpenseActual
    WHERE 		tmpBudgetAverage.SessionID = SessionID
    ;
    
	UPDATE		tmpBudgetAverage
    SET			tmpBudgetAverage.ExpenseAverage = IFNULL(tmpBudgetAverage.ExpenseActual, 1) / TimeSpanMonth
    WHERE		tmpBudgetAverage.SessionID = SessionID
	;
    
	UPDATE		tmpBudgetAverage
    SET			tmpBudgetAverage.TotalIncomeVsExpenseActual = IFNULL(tmpBudgetAverage.IncomeActual, 0) - IFNULL(tmpBudgetAverage.ExpenseActual, 0)
    WHERE		tmpBudgetAverage.SessionID = SessionID
    ;
    
	UPDATE		tmpBudgetAverage
    SET			tmpBudgetAverage.TotalIncomeVsExpenseAverage = IFNULL(tmpBudgetAverage.IncomeAverage, 0)  - IFNULL(tmpBudgetAverage.ExpenseAverage, 0) 
    WHERE		tmpBudgetAverage.SessionID = SessionID
    ;
    
	UPDATE		tmpBudgetAverage
    SET			tmpBudgetAverage.IsTotalIncomeVsExpenseActualNegative = 1
    WHERE		tmpBudgetAverage.TotalIncomeVsExpenseActual < 0
    ;
    
	UPDATE		tmpBudgetAverage
    SET			tmpBudgetAverage.IsTotalIncomeVsExpenseAverageNegative = 1
    WHERE		tmpBudgetAverage.TotalIncomeVsExpenseAverage < 0
    ;
    
    -- Flags
	UPDATE		tmpBudgetAverage
    SET			tmpBudgetAverage.IsExpenseFlg = 1
    WHERE		tmpBudgetAverage.BudgetTypeID = 2
    ;
    
	SELECT 		tmpBudgetAverage.KeyID 										AS KeyID
				,tmpBudgetAverage.SessionID 								AS SessionID
				,tmpBudgetAverage.TransactionID 							AS TransactionID
				,DateMask(tmpBudgetAverage.TransactionDT) 					AS TransactionDT
				,tmpBudgetAverage.TransactionTypeID 						AS TransactionTypeID
				,tmpBudgetAverage.TransactionType 							AS TransactionType
				,tmpBudgetAverage.TransactionNumber 						AS TransactionNumber
				,tmpBudgetAverage.Description 								AS Description
				,tmpBudgetAverage.Amount 									AS Amount
				,tmpBudgetAverage.Note 										AS Note
				,tmpBudgetAverage.BudgetNumber 								AS BudgetNumber
                ,tmpBudgetAverage.BudgetTypeID 								AS BudgetTypeID
				,tmpBudgetAverage.BudgetGroupID 							AS BudgetGroupID
				,tmpBudgetAverage.BudgetGroup 								AS BudgetGroup
				,tmpBudgetAverage.BudgetCategoryID 							AS BudgetCategoryID
				,tmpBudgetAverage.BudgetCategory 							AS BudgetCategory
				,tmpBudgetAverage.Sort 										AS Sort
				,IFNULL(tmpBudgetAverage.CategoryActual, 0) 				AS CategoryActual
				,IFNULL(tmpBudgetAverage.CategoryAverage, 0) 				AS CategoryAverage
				,IFNULL(tmpBudgetAverage.IncomeActual, 0) 					AS IncomeActual
				,IFNULL(tmpBudgetAverage.IncomeAverage, 0) 					AS IncomeAverage
				,IFNULL(tmpBudgetAverage.ExpenseActual, 0) 					AS ExpenseActual
				,IFNULL(tmpBudgetAverage.ExpenseAverage, 0) 				AS ExpenseAverage
				,IFNULL(tmpBudgetAverage.TotalIncomeVsExpenseActual, 0) 	AS TotalIncomeVsExpenseActual
				,IFNULL(tmpBudgetAverage.TotalIncomeVsExpenseAverage, 0)	AS TotalIncomeVsExpenseAverage
                ,tmpBudgetAverage.IsTotalIncomeVsExpenseActualNegative		AS IsTotalIncomeVsExpenseActualNegative
                ,tmpBudgetAverage.IsTotalIncomeVsExpenseAverageNegative		AS IsTotalIncomeVsExpenseAverageNegative
                ,tmpBudgetAverage.IsExpenseFlg								AS IsExpenseFlg
	FROM 		tmpBudgetAverage tmpBudgetAverage
    WHERE		tmpBudgetAverage.SessionID = SessionID
    ORDER BY	tmpBudgetAverage.BudgetTypeID ASC
                ,tmpBudgetAverage.BudgetCategory ASC
                ,tmpBudgetAverage.TransactionDT ASC;

	DELETE FROM	tmpBudgetAverage 
    WHERE		tmpBudgetAverage.SessionID = SessionID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `BudgetBreakdownGet` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `BudgetBreakdownGet`(StartDT DATETIME, EndDT DATETIME)
BEGIN
	DECLARE SessionID VARCHAR(100);
    
    SET SessionID = UUID();

    INSERT INTO tmpBudgetBreakdown
    (
		SessionID
		,BudgetGroupID
		,BudgetGroup
		,BudgetCategoryID
		,BudgetCategory
		,ColorHighlight
    )
    SELECT		DISTINCT
				SessionID							AS SessionID
				,BudgetGroup.BudgetGroupID			AS BudgetGroupID
				,BudgetGroup.BudgetGroup			AS BudgetGroup
				,BudgetCategory.BudgetCategoryID	AS BudgetCategoryID
				,BudgetCategory.BudgetCategory		AS BudgetCategory
				,BudgetCategory.ColorHighlight		AS ColorHighlight
	FROM		Transaction Transaction
    INNER JOIN	TransactionType TransactionType
    ON			TransactionType.TransactionTypeID = Transaction.TransactionTypeID
	INNER JOIN	BudgetCategory BudgetCategory
    ON			BudgetCategory.BudgetCategoryID = Transaction.BudgetCategoryID
    INNER JOIN	BudgetGroup BudgetGroup
    ON			BudgetGroup.BudgetGroupID = BudgetCategory.BudgetGroupID
    WHERE		Transaction.TransactionDT BETWEEN StartDT AND EndDT
    AND			Transaction.TransactionTypeID = 2
	;
    
	UPDATE		tmpBudgetBreakdown
    INNER JOIN	(
					SELECT		BudgetCategory.BudgetCategoryID		AS BudgetCategoryID
								,SUM(Transaction.Amount)			AS CategoryTotal
					FROM		Transaction Transaction
					INNER JOIN	TransactionType TransactionType
					ON			TransactionType.TransactionTypeID = Transaction.TransactionTypeID
					INNER JOIN	BudgetCategory BudgetCategory
					ON			BudgetCategory.BudgetCategoryID = Transaction.BudgetCategoryID
					INNER JOIN	BudgetGroup BudgetGroup
					ON			BudgetGroup.BudgetGroupID = BudgetCategory.BudgetGroupID
					WHERE		Transaction.TransactionDT BETWEEN StartDT AND EndDT
					AND			Transaction.TransactionTypeID = 2
					GROUP BY	BudgetCategory.BudgetCategoryID
								,BudgetCategory.BudgetCategory
				) RS
	ON			tmpBudgetBreakdown.BudgetCategoryID = RS.BudgetCategoryID
	SET			tmpBudgetBreakdown.CategoryTotal = RS.CategoryTotal
	WHERE 		tmpBudgetBreakdown.SessionID = SessionID
    ;
              
    UPDATE		tmpBudgetBreakdown
    JOIN		(
					SELECT		SUM(tmpBudgetBreakdown.CategoryTotal)	AS CategoryExpenseTotal 
					FROM 		tmpBudgetBreakdown tmpBudgetBreakdown	
				) RS
	SET			tmpBudgetBreakdown.CategoryExpenseTotal = RS.CategoryExpenseTotal	
    WHERE 		tmpBudgetBreakdown.SessionID = SessionID
    ;

	UPDATE      tmpBudgetBreakdown
	SET         CategoryPercentage = (CategoryTotal / CategoryExpenseTotal) * 100
    ;
    
	SELECT		tmpBudgetBreakdown.KeyID					AS KeyID
				,tmpBudgetBreakdown.SessionID				AS SessionID
				,tmpBudgetBreakdown.BudgetGroupID			AS BudgetGroupID
				,tmpBudgetBreakdown.BudgetGroup				AS BudgetGroup
				,tmpBudgetBreakdown.BudgetCategoryID 		AS BudgetCategoryID
				,tmpBudgetBreakdown.BudgetCategory			AS BudgetCategory
                ,CONCAT(tmpBudgetBreakdown.BudgetCategory, ' (', tmpBudgetBreakdown.CategoryPercentage,'%)')	AS CategoryLabel
                ,tmpBudgetBreakdown.ColorHighlight			AS ColorHighlight
                ,tmpBudgetBreakdown.CategoryTotal			AS CategoryTotal
                ,tmpBudgetBreakdown.CategoryExpenseTotal	AS CategoryExpenseTotal
				,tmpBudgetBreakdown.CategoryPercentage		AS CategoryPercentage
	FROM 		tmpBudgetBreakdown tmpBudgetBreakdown
    WHERE		tmpBudgetBreakdown.SessionID = SessionID
    ORDER BY	tmpBudgetBreakdown.CategoryTotal DESC
	LIMIT 		15
	;

	DELETE FROM	tmpBudgetBreakdown 
    WHERE		tmpBudgetBreakdown.SessionID = SessionID
    ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `BudgetByMonthDelete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `BudgetByMonthDelete`(BudgetNumber INT)
BEGIN
	DELETE FROM	Budget 
    WHERE		Budget.BudgetNumber = BudgetNumber
    ;
    
    DELETE FROM BudgetItem
    WHERE		BudgetItem.BudgetNumber = BudgetNumber
    ;
    
    DELETE FROM	BudgetIncome
    WHERE		BudgetIncome.BudgetNumber = BudgetNumber
    ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `BudgetByMonthInsert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `BudgetByMonthInsert`(BudgetMonth DATETIME)
BEGIN
	DECLARE BudgetNumberPrevious INT;
    DECLARE BudgetIDNew INT;
    DECLARE BudgetNumber INT(10);
    
    SET BudgetNumberPrevious = (SELECT Budget.BudgetNumber FROM Budget Budget WHERE TIMESTAMPDIFF(MONTH, Budget.BudgetMonth, DATE_ADD(BudgetMonth, INTERVAL -1 MONTH)) = 0);
    SET BudgetNumber =  EXTRACT(YEAR_MONTH FROM BudgetMonth);
    
    
    INSERT INTO Budget
    (
		BudgetNumber
        ,BudgetMonth
        ,CreateDT
        ,CreateBy
    )
    SELECT	BudgetNumber
			,BudgetMonth
            ,NOW()
            ,'User'
	FROM DUAL
	WHERE NOT EXISTS (SELECT Budget.BudgetNumber FROM Budget Budget WHERE Budget.BudgetNumber = BudgetNumber)
    ;

    SET BudgetIDNew = LAST_INSERT_ID();
    
    
	INSERT INTO BudgetItem
    (
		BudgetNumber
        ,BudgetCategoryID
        ,BudgetTypeID
        ,Amount
        ,Sort
        ,CreateDT
        ,CreateBy
    )
    SELECT	BudgetNumber					AS BudgetNumber
            ,BudgetItem.BudgetCategoryID	AS BudgetCategoryID
            ,BudgetItem.BudgetTypeID		AS BudgetTypeID
            ,BudgetItem.Amount				AS Amount
            ,BudgetItem.Sort				AS Sort
            ,NOW()							AS CreateDT
            ,'User'							AS CreateBy
    FROM 	BudgetItem BudgetItem
    WHERE	BudgetItem.BudgetNumber = BudgetNumberPrevious 
    AND 	BudgetNumberPrevious IS NOT NULL
    AND		BudgetIDNew <> 0;
    
    
    INSERT INTO BudgetIncome
    (
		BudgetNumber
        ,IncomeName
        ,IncomeTypeID
        ,IncomeType
        ,PayCycleID
        ,PayCycle
        ,TakeHomePay
        ,HourlyRate
        ,PlannedHours
        ,Salary
        ,YearDeduct
        ,Sort
        ,CreateDT
        ,CreateBy
    )
    SELECT	BudgetNumber					AS BudgetNumber
            ,BudgetIncome.IncomeName		AS IncomeName
            ,BudgetIncome.IncomeTypeID		AS IncomeTypeID
            ,BudgetIncome.IncomeType		AS IncomeType
            ,BudgetIncome.PayCycleID		AS PayCycleID
            ,BudgetIncome.PayCycle			AS PayCycle
            ,BudgetIncome.TakeHomePay		AS TakeHomePay
            ,BudgetIncome.HourlyRate		AS HourlyRate
            ,BudgetIncome.PlannedHours		AS PlannedHours
            ,BudgetIncome.Salary			AS Salary
            ,BudgetIncome.YearDeduct		AS YearDeduct
            ,BudgetIncome.Sort				AS Sort
            ,NOW()							AS CreateDT
            ,'User'							AS CreateBy
    FROM 	BudgetIncome BudgetIncome
    WHERE	BudgetIncome.BudgetNumber = BudgetNumberPrevious 
    AND 	BudgetNumberPrevious IS NOT NULL
    AND		BudgetIDNew <> 0;
    
    
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `BudgetByMonthValidate` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE PROCEDURE `BudgetByMonthValidate`(BudgetMonth DATETIME)
BEGIN
	DECLARE BudgetNumber INT(10);
    DECLARE HasBudgetFlg INT(1);

	SET BudgetNumber = EXTRACT(YEAR_MONTH FROM BudgetMonth); 
	SET HasBudgetFlg = 0;

	SET	HasBudgetFlg = (SELECT COUNT(Budget.BudgetID) FROM Budget Budget WHERE Budget.BudgetNumber = BudgetNumber);

	SELECT HasBudgetFlg AS HasBudgetFlg;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `BudgetCategoryByKeywordGet` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `BudgetCategoryByKeywordGet`(Keyword VARCHAR(100))
BEGIN
	SELECT		BudgetGroup.BudgetGroupID
				,BudgetGroup.BudgetGroup
				,BudgetCategory.BudgetCategoryID
				,BudgetCategory.BudgetCategory
				,BudgetCategory.Description
				,BudgetCategory.Note
				,BudgetCategory.HasSpotlight
				,BudgetCategory.IsEssential
				,Fund.FundID
				,Fund.FundName
                ,CAST(Fund.StartingBalance AS DECIMAL(10, 2)) AS StartingBalance
				,CASE WHEN Fund.FundID > 0 THEN 1 ELSE 0 END AS HasFundFlg
	FROM		BudgetCategory BudgetCategory
	INNER JOIN	BudgetGroup BudgetGroup
	ON			BudgetGroup.BudgetGroupID = BudgetCategory.BudgetGroupID
	LEFT JOIN	Fund Fund
	ON			Fund.FundID = BudgetCategory.FundID
    WHERE		BudgetGroup.ActiveFlg = 1
    AND			BudgetCategory.ActiveFlg = 1
    AND			BudgetCategory.BudgetCategoryID <> 29 -- Income
    AND			(BudgetCategory.BudgetCategory LIKE CONCAT('%', Keyword, '%') OR Keyword IS NULL)
    ORDER BY	BudgetCategory.BudgetCategory ASC
    ;
    

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `BudgetCategoryGet` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `BudgetCategoryGet`()
BEGIN
	SELECT		BudgetGroup.BudgetGroupID
				,BudgetGroup.BudgetGroup
				,BudgetCategory.BudgetCategoryID
				,BudgetCategory.BudgetCategory
	FROM		BudgetGroup BudgetGroup
    INNER JOIN	BudgetCategory BudgetCategory
    ON			BudgetCategory.BudgetGroupID = BudgetGroup.BudgetGroupID
    WHERE		BudgetGroup.ActiveFlg = 1
    AND			BudgetCategory.ActiveFlg = 1
    AND			BudgetCategory.BudgetCategoryID <> 29 -- Income
    ORDER BY	BudgetCategory.BudgetCategory ASC
    ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `BudgetCategoryInsert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `BudgetCategoryInsert`(IN BudgetGroupID INT, IN FundID INT, BudgetCategory VARCHAR(100), IN Description VARCHAR(1000), IN Note VARCHAR(1000), IN IsEssential INT, IN HasSpotlight INT, OUT BudgetCategoryID INT)
BEGIN
	INSERT INTO	BudgetCategory
    (
		BudgetGroupID
		,FundID
		,BudgetCategory
		,Description
		,Note
		,IsEssential
		,HasSpotlight
		,CreateDT
		,CreateBy
    )
    SELECT	BudgetGroupID
			,FundID
			,BudgetCategory
			,Description
			,Note
			,IsEssential
			,HasSpotlight
			,NOW()
			,'User'
    ;
    
    
    SET BudgetCategoryID = LAST_INSERT_ID();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `BudgetCategorySpotlightGet` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `BudgetCategorySpotlightGet`()
BEGIN
	DECLARE SessionID VARCHAR(100);
	DECLARE StartDT DATETIME;
	DECLARE EndDT DATETIME;
    DECLARE BudgetNumber INT(10);

	SET SessionID = UUID();
	SET StartDT = CAST(DATE_FORMAT(NOW() ,'%Y-%m-01') AS DATE);
	SET EndDT = LAST_DAY(NOW());
    SET BudgetNumber = EXTRACT(YEAR_MONTH FROM StartDT);

	INSERT INTO tmpBudgetCategorySpotlight
	(
		SessionID
		,BudgetCategoryID
		,BudgetCategory
		,Sort
	)
	SELECT 		SessionID							AS SessionID
				,BudgetCategory.BudgetCategoryID	AS BudgetCategoryID
				,BudgetCategory.BudgetCategory		AS BudgetCategory
				,BudgetCategory.Sort				AS Sort
	FROM 		BudgetCategory BudgetCategory
    INNER JOIN	BudgetItem	BudgetItem
    ON			BudgetItem.BudgetCategoryID = BudgetCategory.BudgetCategoryID
	WHERE 		BudgetCategory.HasSpotlight = 1 
	AND 		BudgetCategory.FundID IS NULL
    AND			BudgetItem.BudgetNumber = BudgetNumber
	;
	
	UPDATE		tmpBudgetCategorySpotlight
    INNER JOIN	(
					SELECT 		Budget.BudgetNumber	AS BudgetNumber
								,Budget.BudgetMonth	AS BudgetMonth
					FROM 		Budget Budget
                    WHERE		Budget.BudgetNumber = BudgetNumber
				) RS
	SET			tmpBudgetCategorySpotlight.BudgetNumber = RS.BudgetNumber
				,tmpBudgetCategorySpotlight.BudgetMonth = RS.BudgetMonth
	WHERE 		tmpBudgetCategorySpotlight.SessionID = SessionID
    ;
    
    -- Category
	UPDATE		tmpBudgetCategorySpotlight
    INNER JOIN	(
					SELECT 		BudgetItem.BudgetCategoryID	AS BudgetCategoryID
								,SUM(BudgetItem.Amount)		AS CategoryBudget 
					FROM 		BudgetItem BudgetItem
                    INNER JOIN	tmpBudgetCategorySpotlight tmpBudgetCategorySpotlight
                    ON			tmpBudgetCategorySpotlight.BudgetCategoryID = BudgetItem.BudgetCategoryID
					AND			tmpBudgetCategorySpotlight.BudgetNumber = BudgetItem.BudgetNumber
                    WHERE		tmpBudgetCategorySpotlight.SessionID = SessionID
					GROUP BY	BudgetItem.BudgetCategoryID
				) RS
	ON			tmpBudgetCategorySpotlight.BudgetCategoryID = RS.BudgetCategoryID
	SET			tmpBudgetCategorySpotlight.CategoryBudget = RS.CategoryBudget
	WHERE 		tmpBudgetCategorySpotlight.SessionID = SessionID
    ;
    
	UPDATE		tmpBudgetCategorySpotlight
    INNER JOIN	(
					SELECT 		Transaction.BudgetCategoryID	AS BudgetCategoryID
								,SUM(Transaction.Amount)		AS CategoryActual 
					FROM 		Transaction Transaction	
                    WHERE		Transaction.TransactionDT BETWEEN StartDT AND EndDT
					GROUP BY	Transaction.BudgetCategoryID
				) RS
	ON			tmpBudgetCategorySpotlight.BudgetCategoryID = RS.BudgetCategoryID
	SET			tmpBudgetCategorySpotlight.CategoryActual = RS.CategoryActual
    WHERE 		tmpBudgetCategorySpotlight.SessionID = SessionID
    ;
    
	UPDATE		tmpBudgetCategorySpotlight
	SET			tmpBudgetCategorySpotlight.CategoryActualVsBudget = IFNULL(CategoryBudget, 0) - IFNULL(CategoryActual, 0)
    WHERE 		tmpBudgetCategorySpotlight.SessionID = SessionID
    ;
    
	UPDATE		tmpBudgetCategorySpotlight
	SET			tmpBudgetCategorySpotlight.CategoryPercentageSpent = (CategoryActual / IFNULL(CategoryBudget, 1)) * 100
    WHERE 		tmpBudgetCategorySpotlight.SessionID = SessionID
    ;
    
	UPDATE		tmpBudgetCategorySpotlight
	SET			tmpBudgetCategorySpotlight.CategoryProgressBarStyle = 'success'
    WHERE 		tmpBudgetCategorySpotlight.CategoryPercentageSpent <= 25
    AND			tmpBudgetCategorySpotlight.SessionID = SessionID
    ;	
    
	UPDATE		tmpBudgetCategorySpotlight
	SET			tmpBudgetCategorySpotlight.CategoryProgressBarStyle = 'info'
    WHERE 		tmpBudgetCategorySpotlight.CategoryPercentageSpent >= 26
    AND			tmpBudgetCategorySpotlight.CategoryPercentageSpent <= 50
    AND			tmpBudgetCategorySpotlight.SessionID = SessionID
    ;
    
	UPDATE		tmpBudgetCategorySpotlight
	SET			tmpBudgetCategorySpotlight.CategoryProgressBarStyle = 'warning'
    WHERE 		tmpBudgetCategorySpotlight.CategoryPercentageSpent >= 51
    AND			tmpBudgetCategorySpotlight.CategoryPercentageSpent <= 75
    AND			tmpBudgetCategorySpotlight.SessionID = SessionID
    ;
    
	UPDATE		tmpBudgetCategorySpotlight
	SET			tmpBudgetCategorySpotlight.CategoryProgressBarStyle = 'danger'
    WHERE 		tmpBudgetCategorySpotlight.CategoryPercentageSpent >= 76
    AND			tmpBudgetCategorySpotlight.SessionID = SessionID
    ;
    
	UPDATE		tmpBudgetCategorySpotlight
	SET			tmpBudgetCategorySpotlight.IsCategoryNegativeFlg = 1
    WHERE 		tmpBudgetCategorySpotlight.CategoryActualVsBudget < 0
    AND			tmpBudgetCategorySpotlight.SessionID = SessionID
    ;
    
    -- Total
	UPDATE		tmpBudgetCategorySpotlight
    INNER JOIN	(
					SELECT 		SUM(tmpBudgetCategorySpotlight.CategoryActual)	AS TotalCategoryActual 
					FROM 		tmpBudgetCategorySpotlight tmpBudgetCategorySpotlight	
				) RS
	SET			tmpBudgetCategorySpotlight.TotalCategoryActual = RS.TotalCategoryActual
    WHERE 		tmpBudgetCategorySpotlight.SessionID = SessionID
    ;
    
	UPDATE		tmpBudgetCategorySpotlight
    INNER JOIN	(
					SELECT 		SUM(tmpBudgetCategorySpotlight.CategoryBudget)	AS TotalCategoryBudget 
					FROM 		tmpBudgetCategorySpotlight tmpBudgetCategorySpotlight	
				) RS
	SET			tmpBudgetCategorySpotlight.TotalCategoryBudget = RS.TotalCategoryBudget
    WHERE 		tmpBudgetCategorySpotlight.SessionID = SessionID
    ;
    
	UPDATE		tmpBudgetCategorySpotlight
    INNER JOIN	(
					SELECT 		SUM(tmpBudgetCategorySpotlight.CategoryActualVsBudget)	AS TotalCategoryActualVsBudget 
					FROM 		tmpBudgetCategorySpotlight tmpBudgetCategorySpotlight	
				) RS
	SET			tmpBudgetCategorySpotlight.TotalCategoryActualVsBudget = RS.TotalCategoryActualVsBudget
    WHERE 		tmpBudgetCategorySpotlight.SessionID = SessionID
    ;
    
	UPDATE		tmpBudgetCategorySpotlight
	SET			tmpBudgetCategorySpotlight.TotalCategoryPercentageSpent = (TotalCategoryActual / IFNULL(TotalCategoryBudget, 1)) * 100
    WHERE 		tmpBudgetCategorySpotlight.SessionID = SessionID
    ;
    
	UPDATE		tmpBudgetCategorySpotlight
	SET			tmpBudgetCategorySpotlight.TotalCategoryProgressBarStyle = 'success'
    WHERE 		tmpBudgetCategorySpotlight.TotalCategoryPercentageSpent <= 25
    AND			tmpBudgetCategorySpotlight.SessionID = SessionID
    ;	
    
	UPDATE		tmpBudgetCategorySpotlight
	SET			tmpBudgetCategorySpotlight.TotalCategoryProgressBarStyle = 'info'
    WHERE 		tmpBudgetCategorySpotlight.TotalCategoryPercentageSpent >= 26
    AND			tmpBudgetCategorySpotlight.TotalCategoryPercentageSpent <= 50
    AND			tmpBudgetCategorySpotlight.SessionID = SessionID
    ;
    
	UPDATE		tmpBudgetCategorySpotlight
	SET			tmpBudgetCategorySpotlight.TotalCategoryProgressBarStyle = 'warning'
    WHERE 		tmpBudgetCategorySpotlight.TotalCategoryPercentageSpent >= 51
    AND			tmpBudgetCategorySpotlight.TotalCategoryPercentageSpent <= 75
    AND			tmpBudgetCategorySpotlight.SessionID = SessionID
    ;
    
	UPDATE		tmpBudgetCategorySpotlight
	SET			tmpBudgetCategorySpotlight.TotalCategoryProgressBarStyle = 'danger'
    WHERE 		tmpBudgetCategorySpotlight.TotalCategoryPercentageSpent >= 76
    AND			tmpBudgetCategorySpotlight.SessionID = SessionID
    ;
    
	UPDATE		tmpBudgetCategorySpotlight
	SET			tmpBudgetCategorySpotlight.IsTotalCategoryNegativeFlg = 1
    WHERE 		tmpBudgetCategorySpotlight.TotalCategoryActualVsBudget < 0
    AND			tmpBudgetCategorySpotlight.SessionID = SessionID
    ;
    
	SELECT		KeyID										AS KeyID
				,SessionID									AS SessionID
				,DATE_FORMAT(NOW(),'%M %e, %Y')				AS BudgetMonth
				,tmpBudgetCategorySpotlight.BudgetNumber	AS BudgetNumber
				,BudgetCategoryID							AS BudgetCategoryID
				,BudgetCategory								AS BudgetCategory
				,Sort										AS Sort
				,IFNULL(CategoryActual, 0)					AS CategoryActual
				,IFNULL(CategoryBudget, 0)					AS CategoryBudget
				,IFNULL(CategoryActualVsBudget, 0)			AS CategoryActualVsBudget
				,IFNULL(CategoryPercentageSpent, 0)			AS CategoryPercentageSpent
                ,CategoryProgressBarStyle					AS CategoryProgressBarStyle
                ,IsCategoryNegativeFlg						AS IsCategoryNegativeFlg
				,IFNULL(TotalCategoryActual, 0)				AS TotalCategoryActual
				,IFNULL(TotalCategoryBudget, 0)				AS TotalCategoryBudget
				,IFNULL(TotalCategoryActualVsBudget, 0)		AS TotalCategoryActualVsBudget
				,IFNULL(TotalCategoryPercentageSpent, 0)	AS TotalCategoryPercentageSpent
                ,TotalCategoryProgressBarStyle				AS TotalCategoryProgressBarStyle
                ,IsTotalCategoryNegativeFlg					AS IsTotalCategoryNegativeFlg
	FROM		tmpBudgetCategorySpotlight tmpBudgetCategorySpotlight
    WHERE		tmpBudgetCategorySpotlight.SessionID = SessionID
    ORDER BY	tmpBudgetCategorySpotlight.BudgetCategory ASC
	;
    
	DELETE FROM	tmpBudgetCategorySpotlight 
	WHERE		tmpBudgetCategorySpotlight.SessionID = SessionID
    ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `BudgetCategoryUpdate` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `BudgetCategoryUpdate`(IN BudgetCategoryID INT, IN BudgetGroupID INT, IN FundID INT, BudgetCategory VARCHAR(100), IN Description VARCHAR(1000), IN Note VARCHAR(1000), IN IsEssential INT, IN HasSpotlight INT)
BEGIN
	UPDATE 	BudgetCategory
	SET		BudgetCategory.BudgetGroupID 	= BudgetGroupID
			,BudgetCategory.FundID 			= FundID
			,BudgetCategory.BudgetCategory 	= BudgetCategory
			,BudgetCategory.Description 	= Description
			,BudgetCategory.Note 			= Note
			,BudgetCategory.IsEssential 	= IsEssential
			,BudgetCategory.HasSpotlight 	= HasSpotlight
			,BudgetCategory.ModifyDT 		= NOW()
			,BudgetCategory.ModifyBy 		= 'User'
	WHERE	BudgetCategory.BudgetCategoryID = BudgetCategoryID
    ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `BudgetExpenseByMonthGet` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `BudgetExpenseByMonthGet`(BudgetMonth DATETIME)
BEGIN    

	DECLARE BudgetNumber	INT(10);
    DECLARE MonthNumber		INT(10);
    DECLARE MonthInterval	INT(10);
    DECLARE StartDT			DATETIME;
    DECLARE EndDT			DATETIME;

	SET BudgetNumber = EXTRACT(YEAR_MONTH FROM BudgetMonth);
    
	SET MonthNumber = MonthNumberGet(NOW());
	SET MonthInterval = (MonthNumber * -1) + 1;
    
	SET StartDT = DATE_ADD(CAST(DATE_FORMAT(NOW() ,'%Y-%m-01') AS DATE), INTERVAL MonthInterval MONTH);
	SET EndDT = LAST_DAY(NOW());


    DROP TEMPORARY TABLE IF EXISTS tmpBudget;

	CREATE TEMPORARY TABLE tmpBudget
	(
		KeyID                   	INT(10) NOT NULL AUTO_INCREMENT
		,BudgetItemID           	INT(10)
		,BudgetID               	INT(10)
		,BudgetNumber           	INT(10)
		,BudgetMonth            	DATETIME
		,BudgetGroupID          	INT(10)
		,BudgetGroup            	VARCHAR(100)
		,BudgetCategoryID       	INT(10)
		,BudgetCategory         	VARCHAR(100)
		,BudgetTypeID           	INT(10)
		,BudgetType             	VARCHAR(100)
		,Note                   	VARCHAR(1000)
		,Description            	VARCHAR(1000)
		,IsEssential            	INT(1)
		,HasSpotlight           	INT(1)
		,ColorHighlight         	VARCHAR(1000)
		,FundID                 	INT(10)
		,Percentage             	DECIMAL(10, 2)
		,AmountMonthly          	DECIMAL(10, 0)
		,AmountBiWeekly         	DECIMAL(10, 0)
		,AmountWeekly           	DECIMAL(10, 0)
		,AmountBiYearly         	DECIMAL(10, 0)
		,AmountYearly           	DECIMAL(10, 0)        
		,TotalIncomeMonthly     	DECIMAL(10, 0)
		,TotalIncomeBiWeekly    	DECIMAL(10, 0)
		,TotalIncomeWeekly      	DECIMAL(10, 0)
		,TotalIncomeBiYearly    	DECIMAL(10, 0)
		,TotalIncomeYearly      	DECIMAL(10, 0)
		,TotalExpenseMonthly    	DECIMAL(10, 0)
		,TotalExpenseBiWeekly   	DECIMAL(10, 0)
		,TotalExpenseWeekly     	DECIMAL(10, 0)
		,TotalExpenseBiYearly   	DECIMAL(10, 0)
		,TotalExpenseYearly     	DECIMAL(10, 0)
		,BalanceMonthly         	DECIMAL(10, 0)
		,BalanceBiWeekly        	DECIMAL(10, 0)
		,BalanceWeekly          	DECIMAL(10, 0)
		,BalanceBiYearly        	DECIMAL(10, 0)
		,BalanceYearly          	DECIMAL(10, 0)
        ,TransactionActual			DECIMAL(10, 2)
		,TransactionAverage			DECIMAL(10, 2)
        ,RANK						INT(10)
        ,IsBalanceMonthlyNegative	INT(1)
		,PRIMARY KEY (`KeyID`)
	);

	INSERT INTO tmpBudget
	(
		BudgetItemID
		,BudgetID
		,BudgetNumber
		,BudgetMonth
		,BudgetGroupID
		,BudgetGroup
		,BudgetCategoryID
		,BudgetCategory
		,BudgetTypeID
		,BudgetType
		,Note
		,Description
		,IsEssential
		,HasSpotlight
		,ColorHighlight
		,FundID
		,AmountMonthly
	)
	SELECT      BudgetItem.BudgetItemID
				,Budget.BudgetID
				,Budget.BudgetNumber
				,Budget.BudgetMonth
				,BudgetGroup.BudgetGroupID
				,BudgetGroup.BudgetGroup
				,BudgetCategory.BudgetCategoryID
				,BudgetCategory.BudgetCategory
				,BudgetType.BudgetTypeID
				,BudgetType.BudgetType
				,BudgetCategory.Note
				,BudgetCategory.Description
				,BudgetCategory.IsEssential
				,BudgetCategory.HasSpotlight
				,BudgetCategory.ColorHighlight
				,BudgetCategory.FundID
				,BudgetItem.Amount AS AmountMonthly
	FROM        Budget Budget
	INNER JOIN  BudgetItem BudgetItem
	ON          Budget.BudgetNumber = BudgetItem.BudgetNumber
	INNER JOIN  BudgetType BudgetType
	ON          BudgetType.BudgetTypeID = BudgetItem.BudgetTypeID
	INNER JOIN  BudgetCategory BudgetCategory
	ON          BudgetCategory.BudgetCategoryID = BudgetItem.BudgetCategoryID
	INNER JOIN  BudgetGroup BudgetGroup
	ON          BudgetGroup.BudgetGroupID = BudgetCategory.BudgetGroupID
	WHERE       Budget.BudgetNumber = BudgetNumber
    AND			Budget.ActiveFlg = 1
    ORDER BY	BudgetItem.Amount DESC
	;



	UPDATE      tmpBudget
	INNER JOIN  (
				  SELECT      BudgetItem.BudgetItemID
							  ,BudgetItem.Amount * 12 AS AmountYearly
				  FROM        Budget Budget
				  INNER JOIN  BudgetItem BudgetItem
				  ON          Budget.BudgetNumber = BudgetItem.BudgetNumber
				  WHERE       Budget.BudgetNumber = BudgetNumber
				) RS
	ON          tmpBudget.BudgetItemID = RS.BudgetItemID
	SET         tmpBudget.AmountYearly = RS.AmountYearly
	;



	UPDATE      tmpBudget
	SET         AmountBiWeekly = AmountYearly / 26
				,AmountWeekly = AmountYearly / 52
				,AmountBiYearly = AmountYearly / 2
	;



	UPDATE      tmpBudget
	SET         TotalIncomeMonthly = (
										SELECT      SUM(Amount) AS IncomeTotal
										FROM        Budget Budget
										INNER JOIN  BudgetItem BudgetItem ON Budget.BudgetNumber = BudgetItem.BudgetNumber
										WHERE       BudgetTypeID = 1
										AND         Budget.BudgetNumber = BudgetNumber
										)
	;



	UPDATE      tmpBudget
	SET         TotalIncomeYearly = TotalIncomeMonthly * 12
    ;



	UPDATE      tmpBudget
	SET         TotalIncomeBiWeekly = TotalIncomeYearly / 26
				,TotalIncomeWeekly = TotalIncomeYearly / 52
				,TotalIncomeBiYearly = TotalIncomeYearly / 2
	;



	UPDATE      tmpBudget
	SET         TotalExpenseMonthly = (
										SELECT      SUM(Amount) AS ExpenseTotal
										FROM        Budget Budget
										INNER JOIN  BudgetItem BudgetItem ON Budget.BudgetNumber = BudgetItem.BudgetNumber
										WHERE       BudgetTypeID = 2
										AND         Budget.BudgetNumber = BudgetNumber
										)
	;



	UPDATE      tmpBudget
	SET         TotalExpenseYearly = TotalExpenseMonthly * 12
    ;



	UPDATE      tmpBudget
	SET         TotalExpenseBiWeekly = TotalExpenseYearly / 26
				,TotalExpenseWeekly = TotalExpenseYearly / 52
				,TotalExpenseBiYearly = TotalExpenseYearly / 2
	;



	UPDATE      tmpBudget
	SET         BalanceMonthly = TotalIncomeMonthly - TotalExpenseMonthly
				,BalanceBiWeekly = TotalIncomeBiWeekly - TotalExpenseBiWeekly
				,BalanceWeekly = TotalIncomeWeekly - TotalExpenseWeekly
				,BalanceBiYearly = TotalIncomeBiYearly - TotalExpenseBiYearly
				,BalanceYearly = TotalIncomeYearly - TotalExpenseYearly
	;



	UPDATE      tmpBudget
	SET         Percentage = (AmountYearly / TotalIncomeYearly) * 100
    ;
    
    
    
    SET @i = 0;
    UPDATE		tmpBudget
    INNER JOIN	(	
					SELECT  RSRank.Amount
							,RSRank.BudgetItemID
							,RSRank.BudgetCategory
							,RSRank.RANK
					FROM
					(
						SELECT  RSBudgetItem.Amount
								,RSBudgetItem.BudgetItemID
								,RSBudgetItem.BudgetCategory
								,@i :=  @i + 1 AS RANK
						FROM
						(
							SELECT  	BudgetItem.Amount
										,BudgetItem.BudgetItemID
										,BudgetCategory.BudgetCategory
							FROM    	BudgetItem BudgetItem
							INNER JOIN	BudgetCategory BudgetCategory
							ON			BudgetCategory.BudgetCategoryID = BudgetItem.BudgetCategoryID
							WHERE		BudgetItem.BudgetNumber = BudgetNumber
							AND			BudgetTypeID = 2
							ORDER BY	BudgetItem.Amount 			DESC
										,BudgetItem.BudgetItemID 	ASC
						) RSBudgetItem
					) RSRank
				) RS
    ON			tmpBudget.BudgetItemID = RS.BudgetItemID
    SET			tmpBudget.RANK = RS.RANK
	;
    
    
    
	UPDATE		tmpBudget
    INNER JOIN	(	
					SELECT		Transaction.BudgetCategoryID
								,IFNULL(SUM(Transaction.Amount), 0) AS TransactionActual
					FROM		Transaction Transaction
					WHERE		Transaction.TransactionDT BETWEEN StartDT AND EndDT
					AND			Transaction.TransactionTypeID IN (2)
					GROUP BY	Transaction.BudgetCategoryID
				) RS
    ON			tmpBudget.BudgetCategoryID = RS.BudgetCategoryID
    SET			tmpBudget.TransactionActual = RS.TransactionActual
	;
    
    
    
    UPDATE		tmpBudget
    SET			TransactionAverage = tmpBudget.TransactionActual / MonthNumber
    ;
    
	UPDATE		tmpBudget
    SET			tmpBudget.IsBalanceMonthlyNegative = 1
    WHERE		tmpBudget.BalanceMonthly < 0
    ;
    

	DELETE FROM	tmpBudget
    WHERE		tmpBudget.BudgetCategoryID = 29
    ;
    
	SELECT 		tmpBudget.KeyID
				,tmpBudget.BudgetItemID
				,tmpBudget.BudgetID
				,tmpBudget.BudgetNumber
				,tmpBudget.BudgetMonth
				,tmpBudget.BudgetGroupID
				,tmpBudget.BudgetGroup
				,tmpBudget.BudgetCategoryID
				,tmpBudget.BudgetCategory
				,tmpBudget.BudgetTypeID
				,tmpBudget.BudgetType
				,tmpBudget.Note
				,tmpBudget.Description
				,tmpBudget.IsEssential
				,tmpBudget.HasSpotlight
				,tmpBudget.ColorHighlight
				,tmpBudget.FundID
				,tmpBudget.Percentage
                ,IFNULL(tmpBudget.AmountMonthly, 0) 	AS AmountMonthly
                ,IFNULL(tmpBudget.AmountBiWeekly, 0) 	AS AmountBiWeekly
                ,IFNULL(tmpBudget.AmountWeekly, 0) 		AS AmountWeekly
                ,IFNULL(tmpBudget.AmountBiYearly, 0) 	AS AmountBiYearly
                ,IFNULL(tmpBudget.AmountYearly, 0) 		AS AmountYearly
				,tmpBudget.TotalIncomeMonthly
				,tmpBudget.TotalIncomeBiWeekly
				,tmpBudget.TotalIncomeWeekly
				,tmpBudget.TotalIncomeBiYearly
				,tmpBudget.TotalIncomeYearly
				,tmpBudget.TotalExpenseMonthly
				,tmpBudget.TotalExpenseBiWeekly
				,tmpBudget.TotalExpenseWeekly
				,tmpBudget.TotalExpenseBiYearly
				,tmpBudget.TotalExpenseYearly
				,tmpBudget.BalanceMonthly
				,tmpBudget.BalanceBiWeekly
				,tmpBudget.BalanceWeekly
				,tmpBudget.BalanceBiYearly
				,tmpBudget.BalanceYearly
                ,tmpBudget.TransactionActual
                ,IFNULL(tmpBudget.TransactionAverage, 0) AS TransactionAverage
                ,tmpBudget.RANK
                ,tmpBudget.IsBalanceMonthlyNegative
	FROM 		tmpBudget tmpBudget				
	ORDER BY 	tmpBudget.BudgetGroup
				,tmpBudget.BudgetCategory
	;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `BudgetExpenseDelete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `BudgetExpenseDelete`(BudgetItemID INT)
BEGIN
	DELETE FROM	BudgetItem
    WHERE		BudgetItem.BudgetItemID = BudgetItemID
    ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `BudgetExpenseDetailGet` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `BudgetExpenseDetailGet`(BudgetItemID INT)
BEGIN
	SELECT		BudgetItem.BudgetItemID
				,BudgetItem.BudgetNumber
				,BudgetGroup.BudgetGroupID
				,BudgetGroup.BudgetGroup
				,BudgetCategory.BudgetCategoryID
				,BudgetCategory.BudgetCategory
				,CAST(BudgetItem.Amount AS DECIMAL(10, 0)) AS Amount
				,BudgetCategory.Description
				,BudgetCategory.Note
				,BudgetCategory.HasSpotlight
				,BudgetCategory.IsEssential
				,Fund.FundID
				,Fund.FundName
                ,CAST(Fund.StartingBalance AS DECIMAL(10, 2)) AS StartingBalance
				,CASE WHEN Fund.FundID > 0 THEN 1 ELSE 0 END AS HasFundFlg
	FROM		BudgetItem BudgetItem
	INNER JOIN	BudgetCategory BudgetCategory
	ON			BudgetCategory.BudgetCategoryID = BudgetItem.BudgetCategoryID
	INNER JOIN	BudgetGroup BudgetGroup
	ON			BudgetGroup.BudgetGroupID = BudgetCategory.BudgetGroupID
	LEFT JOIN	Fund Fund
	ON			Fund.FundID = BudgetCategory.FundID
	WHERE		BudgetItem.BudgetItemID = BudgetItemID
	;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `BudgetExpenseUpdate` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `BudgetExpenseUpdate`(BudgetItemID INT, BudgetNumber INT, Amount DECIMAL(10, 4), BudgetGroupID INT, BudgetGroup VARCHAR(100), BudgetCategoryID INT, BudgetCategory VARCHAR(100), Description VARCHAR(1000), Note VARCHAR(1000), IsEssential INT, HasSpotlight INT, HasFundFlg INT, FundID INT, FundName VARCHAR(100), StartingBalance DECIMAL(10, 4))
BEGIN 
	IF BudgetGroupID > 0 THEN
        CALL BudgetGroupUpdate(BudgetGroupID, BudgetGroup);
	ELSE
        CALL BudgetGroupInsert(BudgetGroup, @BudgetGroupID);
        
        SET BudgetGroupID = @BudgetGroupID;
	END IF;
    

	IF HasFundFlg = 1 AND FundID > 0 THEN
        CALL BudgetFundUpdate(FundName, StartingBalance, FundID);
        
	ELSEIF HasFundFlg = 1 AND FundID = 0 THEN
        CALL BudgetFundInsert(FundName, StartingBalance, @FundID);
        
        SET FundID = @FundID;
        
	ELSEIF HasFundFlg = 0 THEN
		SET FundID = NULL;
        
    END IF;
    
    
    IF BudgetCategoryID > 0 THEN        
        CALL BudgetCategoryUpdate(BudgetCategoryID, BudgetGroupID, FundID, BudgetCategory, Description, Note, IsEssential, HasSpotlight);
	ELSE
        CALL BudgetCategoryInsert(BudgetGroupID, FundID, BudgetCategory, Description, Note, IsEssential, HasSpotlight, @BudgetCategoryID);
        
        SET BudgetCategoryID = @BudgetCategoryID;
	END IF;


	IF BudgetItemID > 0 THEN        
        CALL BudgetItemUpdate(BudgetItemID, BudgetNumber, BudgetCategoryID, 2, Amount);
	ELSE
        CALL BudgetItemInsert(BudgetNumber, BudgetCategoryID, 2, Amount);
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `BudgetFundByKeywordGet` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `BudgetFundByKeywordGet`(Keyword VARCHAR(100))
BEGIN
	SELECT		FundID
				,FundName
				,CAST(StartingBalance AS DECIMAL(10, 2)) AS StartingBalance
                ,Note
                ,Sort
                ,CreateDT
                ,CreateBy
                ,ModifyDT
                ,ModifyBy
                ,ActiveFlg
	FROM		Fund Fund
    WHERE		(Fund.FundName LIKE CONCAT('%', Keyword, '%') OR Keyword IS NULL)
    ORDER BY	Fund.FundName
    ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `BudgetFundGet` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `BudgetFundGet`()
BEGIN
	SELECT		FundID
				,FundName
				,StartingBalance
                ,Note
                ,Sort
                ,CreateDT
                ,CreateBy
                ,ModifyDT
                ,ModifyBy
                ,ActiveFlg
	FROM		Fund Fund
    ORDER BY	Fund.FundName
    ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `BudgetFundInsert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `BudgetFundInsert`(IN FundName VARCHAR(100), IN StartingBalance DECIMAL(10, 4), OUT FundID INT)
BEGIN
	INSERT INTO Fund
    (
		FundTypeID
        ,FundName
        ,StartingBalance
        ,CreateDT
        ,CreateBy
    )
    SELECT	1					AS FundTypeID
			,FundName			AS FundName
			,StartingBalance	AS StartingBalance
            ,NOW()				AS CreateDT
            ,'User'				AS CreateBy
	;
    
    
    SET FundID = LAST_INSERT_ID();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `BudgetFundSpotlightGet` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE PROCEDURE `BudgetFundSpotlightGet`()
BEGIN
	DECLARE SessionID VARCHAR(100);

	SET SessionID = UUID();

	INSERT INTO tmpBudgetFundSpotlight
	(
		SessionID
		,BudgetCategoryID
		,BudgetCategory
		,Sort
        ,FundID
        ,FundName
        ,StartingBalance
	)
	SELECT 		SessionID							AS SessionID
				,BudgetCategory.BudgetCategoryID	AS BudgetCategoryID
				,BudgetCategory.BudgetCategory		AS BudgetCategory
				,BudgetCategory.Sort				AS Sort
				,Fund.FundID 						AS FundID
				,Fund.FundName 						AS FundName
				,Fund.StartingBalance 				AS StartingBalance
	FROM 		BudgetCategory BudgetCategory
    INNER JOIN	Fund Fund
    ON			Fund.FundID = BudgetCategory.FundID
	WHERE 		BudgetCategory.HasSpotlight = 1
	;
    
	UPDATE		tmpBudgetFundSpotlight
    INNER JOIN	(
					SELECT 		Transaction.BudgetCategoryID	AS BudgetCategoryID
								,SUM(ABS(Transaction.Amount))		AS FundSpent 
					FROM 		Transaction Transaction	
                    INNER JOIN	tmpBudgetFundSpotlight tmpBudgetFundSpotlight
                    ON			tmpBudgetFundSpotlight.BudgetCategoryID = Transaction.BudgetCategoryID
                    WHERE		tmpBudgetFundSpotlight.SessionID = SessionID 
                    AND			Transaction.TransactionTypeID = 4
					GROUP BY	Transaction.BudgetCategoryID
				) RS
	ON			tmpBudgetFundSpotlight.BudgetCategoryID = RS.BudgetCategoryID
	SET			tmpBudgetFundSpotlight.FundSpent = RS.FundSpent
    WHERE 		tmpBudgetFundSpotlight.SessionID = SessionID
    ;
    
	UPDATE		tmpBudgetFundSpotlight
    INNER JOIN	(
					SELECT 		Transaction.BudgetCategoryID	AS BudgetCategoryID
								,SUM(Transaction.Amount)		AS FundReceived 
					FROM 		Transaction Transaction	
                    INNER JOIN	tmpBudgetFundSpotlight tmpBudgetFundSpotlight
                    ON			tmpBudgetFundSpotlight.BudgetCategoryID = Transaction.BudgetCategoryID
                    WHERE		tmpBudgetFundSpotlight.SessionID = SessionID 
                    AND			Transaction.TransactionTypeID = 3
					GROUP BY	Transaction.BudgetCategoryID
				) RS
	ON			tmpBudgetFundSpotlight.BudgetCategoryID = RS.BudgetCategoryID
	SET			tmpBudgetFundSpotlight.FundReceived = RS.FundReceived
    WHERE 		tmpBudgetFundSpotlight.SessionID = SessionID
    ;
    
	UPDATE		tmpBudgetFundSpotlight
	SET			tmpBudgetFundSpotlight.FundReceivedPlusStartingBalance = IFNULL(tmpBudgetFundSpotlight.FundReceived, 0) + IFNULL(tmpBudgetFundSpotlight.StartingBalance, 0)
    WHERE 		tmpBudgetFundSpotlight.SessionID = SessionID
    ;
    
	UPDATE		tmpBudgetFundSpotlight
	SET			tmpBudgetFundSpotlight.FundSpentVsReceived = IFNULL(tmpBudgetFundSpotlight.FundReceivedPlusStartingBalance, 0) - IFNULL(tmpBudgetFundSpotlight.FundSpent, 0)
    WHERE 		tmpBudgetFundSpotlight.SessionID = SessionID
    ;
    
	UPDATE		tmpBudgetFundSpotlight
    INNER JOIN	(
					SELECT 		SUM(tmpBudgetFundSpotlight.FundSpentVsReceived)	AS TotalFundSpentVsReceived 
					FROM 		tmpBudgetFundSpotlight tmpBudgetFundSpotlight	
				) RS
	SET			tmpBudgetFundSpotlight.TotalFundSpentVsReceived = RS.TotalFundSpentVsReceived
    WHERE 		tmpBudgetFundSpotlight.SessionID = SessionID
    ;
    
    SELECT 		tmpBudgetFundSpotlight.KeyID 										AS KeyID
				,tmpBudgetFundSpotlight.SessionID 									AS SessionID
				,tmpBudgetFundSpotlight.BudgetCategoryID 							AS BudgetCategoryID
				,tmpBudgetFundSpotlight.BudgetCategory 								AS BudgetCategory
				,tmpBudgetFundSpotlight.Sort 										AS Sort
				,tmpBudgetFundSpotlight.FundID 										AS FundID
				,tmpBudgetFundSpotlight.FundName 									AS FundName
				,tmpBudgetFundSpotlight.StartingBalance 							AS StartingBalance
				,IFNULL(tmpBudgetFundSpotlight.FundSpent, 0)						AS FundSpent
				,IFNULL(tmpBudgetFundSpotlight.FundReceived, 0)						AS FundReceived
				,IFNULL(tmpBudgetFundSpotlight.FundReceivedPlusStartingBalance, 0)	AS FundReceivedPlusStartingBalance
				,IFNULL(tmpBudgetFundSpotlight.FundSpentVsReceived, 0)				AS FundSpentVsReceived
				,IFNULL(tmpBudgetFundSpotlight.TotalFundSpentVsReceived, 0)			AS TotalFundSpentVsReceived
	FROM 		tmpBudgetFundSpotlight tmpBudgetFundSpotlight
    WHERE		tmpBudgetFundSpotlight.SessionID = SessionID
    ORDER BY	tmpBudgetFundSpotlight.FundName ASC
    ;

	DELETE FROM	tmpBudgetFundSpotlight 
	WHERE		tmpBudgetFundSpotlight.SessionID = SessionID
    ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `BudgetFundSummaryGet` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `BudgetFundSummaryGet`(FundID INT)
BEGIN
	DECLARE SessionID VARCHAR(100);

	SET SessionID = UUID();

	INSERT INTO	tmpBudgetFundSummary
	(
		SessionID
		,FundID
		,FundName
		,BudgetCategoryID
		,BudgetCategory
		,TransactionID
		,TransactionTypeID
		,TransactionNumber
		,TransactionDT
		,Amount
		,Description
		,Note
		,StartingBalance
	)
	SELECT		SessionID							AS SessionID
				,Fund.FundID						AS FundID
				,Fund.FundName						AS FundName
				,BudgetCategory.BudgetCategoryID	AS BudgetCategoryID
				,BudgetCategory.BudgetCategory		AS BudgetCategory
				,Transaction.TransactionID			AS TransactionID
				,Transaction.TransactionTypeID		AS TransactionTypeID
				,Transaction.TransactionNumber		AS TransactionNumber
				,Transaction.TransactionDT			AS TransactionDT
				,Transaction.Amount					AS Amount
				,Transaction.Description			AS Description
				,Transaction.Note					AS Note
				,Fund.StartingBalance				AS StartingBalance
	FROM		Transaction Transaction
	INNER JOIN	BudgetCategory BudgetCategory
	ON			BudgetCategory.BudgetCategoryID = Transaction.BudgetCategoryID
	INNER JOIN	Fund Fund
	ON			Fund.FundID = BudgetCategory.FundID
	WHERE		Transaction.TransactionTypeID IN (3, 4)
	AND			Fund.FundID = FundID
	;

	UPDATE		tmpBudgetFundSummary
	INNER JOIN	(
					SELECT 		SUM(ABS(tmpBudgetFundSummary.Amount))	AS FundReceived 
					FROM 		tmpBudgetFundSummary tmpBudgetFundSummary	
					WHERE		tmpBudgetFundSummary.TransactionTypeID = 3
				) RS
	SET			tmpBudgetFundSummary.FundReceived = IFNULL(RS.FundReceived, 0)
	WHERE 		tmpBudgetFundSummary.SessionID = SessionID
	;
    
	UPDATE		tmpBudgetFundSummary
	INNER JOIN	(
					SELECT 		SUM(ABS(tmpBudgetFundSummary.Amount))	AS FundSpent 
					FROM 		tmpBudgetFundSummary tmpBudgetFundSummary	
					WHERE		tmpBudgetFundSummary.TransactionTypeID = 4
				) RS
	SET			tmpBudgetFundSummary.FundSpent = IFNULL(RS.FundSpent, 0)
	WHERE 		tmpBudgetFundSummary.SessionID = SessionID
	;

	UPDATE		tmpBudgetFundSummary
	SET			tmpBudgetFundSummary.FundReceivedPlusStartingBalance = IFNULL(tmpBudgetFundSummary.FundReceived, 0) + IFNULL(tmpBudgetFundSummary.StartingBalance, 0)
	WHERE 		tmpBudgetFundSummary.SessionID = SessionID
	;

	UPDATE		tmpBudgetFundSummary
	SET			tmpBudgetFundSummary.FundSpentVsReceived = IFNULL(tmpBudgetFundSummary.FundReceivedPlusStartingBalance, 0) - IFNULL(tmpBudgetFundSummary.FundSpent, 0)
	WHERE 		tmpBudgetFundSummary.SessionID = SessionID
	;
    
    INSERT INTO tmpBudgetFundSummary
    (
		SessionID
        ,FundID
        ,FundName
        ,StartingBalance
        ,FundSpent
        ,FundReceived
        ,FundSpentVsReceived
    )
	SELECT	SessionID				AS SessionID
			,Fund.FundID			AS FundID
			,Fund.FundName			AS FundName
			,Fund.StartingBalance	AS StartingBalance
            ,0						AS FundSpent
            ,0						AS FundReceived
            ,0						AS FundSpentVsReceived
    FROM	Fund Fund
    WHERE	Fund.FundID = FundID
    AND		(SELECT COUNT(1) FROM tmpBudgetFundSummary) = 0
    ;
    
	SELECT		tmpBudgetFundSummary.KeyID								AS KeyID
				,SessionID												AS SessionID
				,tmpBudgetFundSummary.FundID							AS FundID
				,tmpBudgetFundSummary.FundName							AS FundName
				,tmpBudgetFundSummary.BudgetCategoryID					AS BudgetCategoryID
				,tmpBudgetFundSummary.BudgetCategory					AS BudgetCategory
				,tmpBudgetFundSummary.TransactionID						AS TransactionID
				,tmpBudgetFundSummary.TransactionTypeID					AS TransactionTypeID
				,tmpBudgetFundSummary.TransactionNumber					AS TransactionNumber
				,DateMask(tmpBudgetFundSummary.TransactionDT)			AS TransactionDT
				,tmpBudgetFundSummary.Amount							AS Amount
				,tmpBudgetFundSummary.Description						AS Description
				,tmpBudgetFundSummary.Note								AS Note
				,tmpBudgetFundSummary.StartingBalance					AS StartingBalance
				,tmpBudgetFundSummary.FundSpent							AS FundSpent
				,tmpBudgetFundSummary.FundReceived						AS FundReceived
				,tmpBudgetFundSummary.FundReceivedPlusStartingBalance	AS FundReceivedPlusStartingBalance
				,tmpBudgetFundSummary.FundSpentVsReceived				AS FundSpentVsReceived
	FROM		tmpBudgetFundSummary
    WHERE		tmpBudgetFundSummary.SessionID = SessionID
    ORDER BY	tmpBudgetFundSummary.TransactionDT DESC
	;

	DELETE FROM	tmpBudgetFundSummary 
	WHERE		tmpBudgetFundSummary.SessionID = SessionID
	;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `BudgetFundUpdate` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `BudgetFundUpdate`(IN FundName VARCHAR(100), IN StartingBalance DECIMAL(10, 4), IN FundID INT)
BEGIN
	UPDATE 	Fund
    SET		Fund.FundName = FundName
			,Fund.StartingBalance = StartingBalance
            ,Fund.ModifyDT = NOW()
            ,Fund.ModifyBy = 'User'
    WHERE	Fund.FundID = FundID
    ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `BudgetGet` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `BudgetGet`()
BEGIN
	SELECT 		Budget.BudgetID
				,Budget.BudgetNumber
				,Budget.BudgetMonth
				,DATE_FORMAT(Budget.BudgetMonth,'%M %Y') AS BudgetMonthSummary
                ,DATE_FORMAT(Budget.BudgetMonth,'%Y-%m-%d') AS BudgetMonthSummaryUrl
				,Budget.CreateDT
				,Budget.CreateBy
				,Budget.ModifyDT
				,Budget.ModifyBy
				,Budget.ActiveFlg
	FROM 		Budget Budget
    WHERE		TIMESTAMPDIFF(MONTH, Budget.BudgetMonth, NOW()) <= 12
	ORDER BY	Budget.BudgetMonth DESC
	;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `BudgetGroupByKeywordGet` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `BudgetGroupByKeywordGet`(Keyword VARCHAR(100))
BEGIN
	SELECT		BudgetGroupID
				,BudgetGroup
                ,Sort
                ,CreateBy
                ,CreateDT
                ,ActiveFlg
    FROM		BudgetGroup BudgetGroup
     WHERE		(BudgetGroup.BudgetGroup LIKE CONCAT('%', Keyword, '%') OR Keyword IS NULL)
    ORDER BY	BudgetGroup.BudgetGroup
	;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `BudgetGroupGet` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `BudgetGroupGet`()
BEGIN
	SELECT		BudgetGroupID
				,BudgetGroup
                ,Sort
                ,CreateBy
                ,CreateDT
                ,ActiveFlg
    FROM		BudgetGroup BudgetGroup
    ORDER BY	BudgetGroup.BudgetGroup
	;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `BudgetGroupInsert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `BudgetGroupInsert`(IN BudgetGroup VARCHAR(100), OUT BudgetGroupID INT)
BEGIN
	INSERT INTO BudgetGroup
	(
		BudgetGroup
		,CreateDT
		,CreateBy
	)
	SELECT	BudgetGroup
			,NOW()
			,'User'
	;


	SET BudgetGroupID = LAST_INSERT_ID();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `BudgetGroupUpdate` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `BudgetGroupUpdate`(BudgetGroupID INT, BudgetGroup VARCHAR(100))
BEGIN
	UPDATE	BudgetGroup
    SET		BudgetGroup.BudgetGroup 	= BudgetGroup
			,BudgetGroup.ModifyDT		= NOW()
            ,BudgetGroup.ModifyBy		= 'User'
	WHERE	BudgetGroup.BudgetGroupID = BudgetGroupID
    ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `BudgetIncomeByMonthGet` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `BudgetIncomeByMonthGet`(BudgetMonth DATETIME)
BEGIN
    DECLARE BudgetNumber	INT(10);

	SET BudgetNumber = EXTRACT(YEAR_MONTH FROM BudgetMonth);
       

    DROP TEMPORARY TABLE IF EXISTS tmpBudgetIncome;

	CREATE TEMPORARY TABLE tmpBudgetIncome
	(
		KeyID                   INT(10) NOT NULL AUTO_INCREMENT
        ,BudgetIncomeID			INT(10)
        ,IncomeName				VARCHAR(100)
		,IncomeTypeID			INT(10)
		,IncomeType				VARCHAR(100)
        ,PayCycleID				INT(10)
        ,PayCycle				VARCHAR(100)
        ,TakeHomePay			DECIMAL(10, 0)
        ,HourlyRate				DECIMAL(10, 2)
        ,PlannedHours			INT(10)
		,Salary					DECIMAL(10, 0)
		,YearDeduct				DECIMAL(10, 2)
        ,Sort					INT(3)
		,BudgetID               INT(10)
        ,BudgetItemID			INT(10)
		,BudgetNumber           INT(10)
		,BudgetMonth            DATETIME
		,BudgetGroupID          INT(10)
		,BudgetGroup            VARCHAR(100)
		,BudgetCategoryID       INT(10)
		,BudgetCategory         VARCHAR(100)
		,BudgetTypeID           INT(10)
		,BudgetType             VARCHAR(100)
		,ColorHighlight         VARCHAR(1000)
		,IncomeMonthly     		DECIMAL(10, 0)
		,IncomeBiWeekly    		DECIMAL(10, 0)
		,IncomeWeekly      		DECIMAL(10, 0)
		,IncomeBiYearly    		DECIMAL(10, 0)
		,IncomeYearly      		DECIMAL(10, 0)
		,TotalIncomeMonthly     DECIMAL(10, 0)
		,TotalIncomeBiWeekly    DECIMAL(10, 0)
		,TotalIncomeWeekly      DECIMAL(10, 0)
		,TotalIncomeBiYearly    DECIMAL(10, 0)
		,TotalIncomeYearly      DECIMAL(10, 0)
        ,TotalIncomeYearlyGross	DECIMAL(10, 0)
		,PRIMARY KEY (`KeyID`)
	);
    
    INSERT INTO tmpBudgetIncome
	(
		BudgetIncomeID
        ,IncomeName
		,IncomeTypeID
		,IncomeType
        ,PayCycleID
        ,PayCycle
        ,TakeHomePay
        ,HourlyRate
        ,PlannedHours
		,Salary
		,YearDeduct
        ,Sort
		,BudgetID
		,BudgetNumber
		,BudgetMonth
	)
	SELECT		BudgetIncome.BudgetIncomeID
				,BudgetIncome.IncomeName
				,BudgetIncome.IncomeTypeID
				,BudgetIncome.IncomeType
				,BudgetIncome.PayCycleID
				,BudgetIncome.PayCycle
                ,BudgetIncome.TakeHomePay
                ,BudgetIncome.HourlyRate
                ,BudgetIncome.PlannedHours
				,BudgetIncome.Salary
				,BudgetIncome.YearDeduct
                ,BudgetIncome.Sort
				,Budget.BudgetID
				,Budget.BudgetNumber
				,Budget.BudgetMonth
    FROM		Budget Budget
    INNER JOIN	BudgetIncome BudgetIncome
    ON			BudgetIncome.BudgetNumber = Budget.BudgetNumber
    WHERE		Budget.BudgetNumber = BudgetNumber
	;
    
    
	UPDATE      tmpBudgetIncome
	INNER JOIN  (
					SELECT  	Budget.BudgetNumber
								,BudgetItem.BudgetItemID
								,BudgetGroup.BudgetGroupID
								,BudgetGroup.BudgetGroup
								,BudgetCategory.BudgetCategoryID
								,BudgetCategory.BudgetCategory
								,BudgetType.BudgetTypeID
								,BudgetType.BudgetType
								,BudgetCategory.ColorHighlight   
								,BudgetItem.Amount AS TotalIncomeMonthly
					FROM        Budget Budget
					INNER JOIN  BudgetItem BudgetItem
					ON          Budget.BudgetNumber = BudgetItem.BudgetNumber
					INNER JOIN  BudgetType BudgetType
					ON          BudgetType.BudgetTypeID = BudgetItem.BudgetTypeID
					INNER JOIN  BudgetCategory BudgetCategory
					ON          BudgetCategory.BudgetCategoryID = BudgetItem.BudgetCategoryID
					INNER JOIN  BudgetGroup BudgetGroup
					ON          BudgetGroup.BudgetGroupID = BudgetCategory.BudgetGroupID
					WHERE       Budget.BudgetNumber = BudgetNumber
					AND			BudgetCategory.BudgetCategoryID = 29
				) RS
	ON          tmpBudgetIncome.BudgetNumber = RS.BudgetNumber
	SET         tmpBudgetIncome.BudgetItemID = RS.BudgetItemID
				,tmpBudgetIncome.BudgetGroupID = RS.BudgetGroupID
                ,tmpBudgetIncome.BudgetGroup = RS.BudgetGroup
                ,tmpBudgetIncome.BudgetCategoryID = RS.BudgetCategoryID
                ,tmpBudgetIncome.BudgetCategory = RS.BudgetCategory
                ,tmpBudgetIncome.BudgetTypeID = RS.BudgetTypeID
                ,tmpBudgetIncome.BudgetType = RS.BudgetType
                ,tmpBudgetIncome.ColorHighlight = RS.ColorHighlight
                ,tmpBudgetIncome.TotalIncomeMonthly = RS.TotalIncomeMonthly
    ;
    
	
	UPDATE      tmpBudgetIncome
	SET         TotalIncomeYearly = TotalIncomeMonthly * 12;


	UPDATE      tmpBudgetIncome
	SET         TotalIncomeBiWeekly = TotalIncomeYearly / 26
				,TotalIncomeWeekly = TotalIncomeYearly / 52
				,TotalIncomeBiYearly = TotalIncomeYearly / 2;
       
       
	UPDATE		tmpBudgetIncome
    INNER JOIN	(
					SELECT 	BudgetIncomeID				AS BudgetIncomeID
							,(TakeHomePay * 26) / 12 	AS IncomeMonthly
							,TakeHomePay 				AS IncomeBiWeekly
							,(TakeHomePay * 26) / 52 	AS IncomeWeekly
							,(TakeHomePay * 26) / 2 	AS IncomeBiYearly
							,(TakeHomePay * 26) 		AS IncomeYearly
					FROM	BudgetIncome
					WHERE 	BudgetIncome.BudgetNumber = BudgetNumber
				) RS
	ON			tmpBudgetIncome.BudgetIncomeID = RS.BudgetIncomeID
    SET			tmpBudgetIncome.IncomeMonthly = RS.IncomeMonthly
				,tmpBudgetIncome.IncomeBiWeekly = RS.IncomeBiWeekly
                ,tmpBudgetIncome.IncomeWeekly = RS.IncomeWeekly
                ,tmpBudgetIncome.IncomeBiYearly = RS.IncomeBiYearly
                ,tmpBudgetIncome.IncomeYearly = RS.IncomeYearly;
                
	UPDATE		tmpBudgetIncome
    SET			TotalIncomeYearlyGross = (SELECT SUM(BudgetIncome.Salary) FROM BudgetIncome BudgetIncome WHERE BudgetIncome.BudgetNumber = BudgetNumber);
                

	SELECT 		tmpBudgetIncome.KeyID                  
				,tmpBudgetIncome.BudgetIncomeID
                ,tmpBudgetIncome.IncomeName
				,tmpBudgetIncome.IncomeTypeID			
				,tmpBudgetIncome.IncomeType				
				,tmpBudgetIncome.PayCycleID				
				,tmpBudgetIncome.PayCycle				
				,tmpBudgetIncome.TakeHomePay			
				,tmpBudgetIncome.HourlyRate				
				,tmpBudgetIncome.PlannedHours			
				,tmpBudgetIncome.Salary					
				,tmpBudgetIncome.YearDeduct				
				,tmpBudgetIncome.BudgetID              
				,tmpBudgetIncome.BudgetItemID			
				,tmpBudgetIncome.BudgetNumber          
				,tmpBudgetIncome.BudgetMonth           
				,tmpBudgetIncome.BudgetGroupID
				,tmpBudgetIncome.BudgetGroup
				,tmpBudgetIncome.BudgetCategoryID
				,tmpBudgetIncome.BudgetCategory
				,tmpBudgetIncome.BudgetTypeID
				,tmpBudgetIncome.BudgetType
				,tmpBudgetIncome.ColorHighlight
				,tmpBudgetIncome.IncomeMonthly
				,tmpBudgetIncome.IncomeBiWeekly
				,tmpBudgetIncome.IncomeWeekly
				,tmpBudgetIncome.IncomeBiYearly
				,tmpBudgetIncome.IncomeYearly	
				,tmpBudgetIncome.TotalIncomeMonthly
				,tmpBudgetIncome.TotalIncomeBiWeekly
				,tmpBudgetIncome.TotalIncomeWeekly
				,tmpBudgetIncome.TotalIncomeBiYearly
				,tmpBudgetIncome.TotalIncomeYearly
                ,tmpBudgetIncome.TotalIncomeYearlyGross
	FROM 		tmpBudgetIncome tmpBudgetIncome				
	ORDER BY 	tmpBudgetIncome.Sort
				,tmpBudgetIncome.IncomeMonthly
	;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `BudgetIncomeCalculate` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `BudgetIncomeCalculate`(BudgetNumber INT)
BEGIN
	UPDATE	BudgetItem
	SET		Amount = 	(
							SELECT	(SUM(TakeHomePay) * 26) / 12 AS Amount
							FROM	BudgetIncome BudgetIncome
							WHERE	BudgetIncome.BudgetNumber = BudgetNumber
						)
	WHERE	BudgetItem.BudgetCategoryID = 29
	AND		BudgetItem.BudgetNumber = BudgetNumber
    ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `BudgetIncomeDelete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `BudgetIncomeDelete`(BudgetIncomeID INT)
BEGIN
	DECLARE BudgetNumber INT(10);
    
    SET BudgetNumber = (SELECT BudgetIncome.BudgetNumber FROM BudgetIncome BudgetIncome WHERE BudgetIncome.BudgetIncomeID = BudgetIncomeID);
	
    
	DELETE FROM	BudgetIncome
    WHERE		BudgetIncome.BudgetIncomeID = BudgetIncomeID;
    
        
    
    CALL BudgetIncomeCalculate(BudgetNumber);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `BudgetIncomeDetailGet` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `BudgetIncomeDetailGet`(BudgetIncomeID INT)
BEGIN
	SELECT	BudgetIncome.BudgetIncomeID
			,BudgetIncome.BudgetNumber
            ,BudgetIncome.IncomeName
			,BudgetIncome.IncomeTypeID
			,BudgetIncome.IncomeType
			,BudgetIncome.PayCycleID
			,BudgetIncome.PayCycle
            ,CASE BudgetIncome.PayCycleID 
				WHEN 1 THEN 'Every 2 Weeks' 
                WHEN 2 THEN 'Every Week' 
			END AS PayCycleDescription
			,CAST(BudgetIncome.TakeHomePay AS DECIMAL(10, 0)) AS TakeHomePay
			,CAST(BudgetIncome.HourlyRate AS DECIMAL(10, 2)) AS HourlyRate
			,BudgetIncome.PlannedHours
			,CAST(BudgetIncome.Salary AS DECIMAL(10, 0)) AS Salary
			,CAST(BudgetIncome.YearDeduct AS DECIMAL(10, 2)) AS YearDeduct
			,BudgetIncome.Sort
			,BudgetIncome.CreateDT
			,BudgetIncome.CreateBy
			,BudgetIncome.ModifyDT
			,BudgetIncome.ModifyBy
			,BudgetIncome.ActiveFlg
	FROM 	BudgetIncome BudgetIncome
    WHERE	BudgetIncome.BudgetIncomeID = BudgetIncomeID
    ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `BudgetIncomeInsert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `BudgetIncomeInsert`(BudgetNumber INT, IncomeName VARCHAR(100), IncomeTypeID INT, IncomeType VARCHAR(100), PayCycleID INT, PayCycle VARCHAR(100), TakeHomePay DECIMAL(10, 4), HourlyRate DECIMAL(10, 4), PlannedHours INT, Salary DECIMAL(10, 4), YearDeduct DECIMAL(10, 4))
BEGIN
	INSERT INTO BudgetIncome
	(
		BudgetNumber
        ,IncomeName
		,IncomeTypeID
		,IncomeType
		,PayCycleID
		,PayCycle
		,TakeHomePay
		,HourlyRate
		,PlannedHours
		,Salary
		,YearDeduct
		,CreateDT
		,CreateBy
	)
	SELECT	BudgetNumber
			,IncomeName
			,IncomeTypeID
			,IncomeType
			,PayCycleID
			,PayCycle
			,TakeHomePay
			,HourlyRate
			,PlannedHours
			,Salary
			,YearDeduct
			,NOW()
			,'User'
	;
    
    
    CALL BudgetIncomeCalculate(BudgetNumber);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `BudgetIncomeUpdate` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `BudgetIncomeUpdate`(BudgetIncomeID INT, BudgetNumber INT, IncomeName VARCHAR(100), IncomeTypeID INT, IncomeType VARCHAR(100), PayCycleID INT, PayCycle VARCHAR(100), TakeHomePay DECIMAL(10, 4), HourlyRate DECIMAL(10, 4), PlannedHours INT, Salary DECIMAL(10, 4), YearDeduct DECIMAL(10, 4))
BEGIN
	UPDATE 	BudgetIncome
	SET		BudgetIncome.BudgetNumber 	= BudgetNumber
			,BudgetIncome.IncomeName 	= IncomeName
			,BudgetIncome.IncomeTypeID 	= IncomeTypeID
			,BudgetIncome.IncomeType 	= IncomeType
			,BudgetIncome.PayCycleID 	= PayCycleID
			,BudgetIncome.PayCycle 		= PayCycle
			,BudgetIncome.TakeHomePay 	= TakeHomePay
			,BudgetIncome.HourlyRate 	= HourlyRate
			,BudgetIncome.PlannedHours 	= PlannedHours
			,BudgetIncome.Salary 		= Salary
			,BudgetIncome.YearDeduct 	= YearDeduct
			,BudgetIncome.ModifyDT 		= NOW()
			,BudgetIncome.ModifyBy 		= 'User'
	WHERE	BudgetIncome.BudgetIncomeID = BudgetIncomeID
    ;
    
    
    CALL BudgetIncomeCalculate(BudgetNumber);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `BudgetInsert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE PROCEDURE `BudgetInsert`(BudgetMonth DATETIME)
BEGIN
	DECLARE BudgetIDPrevious INT;
    DECLARE BudgetIDNew INT;
    DECLARE BudgetNumber VARCHAR(100);
    
    SET BudgetIDPrevious = (SELECT Budget.BudgetID FROM Budget Budget WHERE TIMESTAMPDIFF(MONTH, Budget.BudgetMonth, DATE_ADD(BudgetMonth, INTERVAL -1 MONTH)) = 0);
    SET BudgetNumber =  EXTRACT(YEAR_MONTH FROM BudgetMonth);
    
    
    INSERT INTO Budget
    (
		BudgetNumber
        ,BudgetMonth
        ,CreateDT
        ,CreateBy
    )
    SELECT	BudgetNumber
			,BudgetMonth
            ,NOW()
            ,'User'
	FROM DUAL
	WHERE NOT EXISTS (SELECT Budget.BudgetMonth FROM Budget Budget WHERE TIMESTAMPDIFF(MONTH, Budget.BudgetMonth, BudgetMonth) = 0)
    ;

    SET BudgetIDNew = LAST_INSERT_ID();
    
    
	INSERT INTO BudgetItem
    (
		BudgetID
        ,BudgetCategoryID
        ,BudgetTypeID
        ,Amount
        ,Sort
        ,CreateDT
        ,CreateBy
    )
    SELECT	BudgetIDNew
            ,BudgetItem.BudgetCategoryID
            ,BudgetItem.BudgetTypeID
            ,BudgetItem.Amount
            ,BudgetItem.Sort
            ,NOW()
            ,'User'
    FROM 	BudgetItem BudgetItem
    WHERE	BudgetItem.BudgetID = BudgetIDPrevious 
    AND 	BudgetIDPrevious IS NOT NULL
    AND		BudgetIDNew <> 0;
    
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `BudgetItemDelete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `BudgetItemDelete`(BudgetItemID INT)
BEGIN
	DELETE FROM	BudgetItem
    WHERE		BudgetItem.BudgetItemID = BudgetItemID
    ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `BudgetItemInsert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `BudgetItemInsert`(BudgetNumber INT, BudgetCategoryID INT, BudgetTypeID INT, Amount DECIMAL(10, 4))
BEGIN
	INSERT INTO BudgetItem
    (
		BudgetNumber
        ,BudgetCategoryID
        ,BudgetTypeID
        ,Amount
        ,CreateDT
        ,CreateBy
    )
    SELECT	BudgetNumber
			,BudgetCategoryID
            ,BudgetTypeID
            ,Amount
            ,NOW()
            ,'User'
	;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `BudgetItemUpdate` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `BudgetItemUpdate`(BudgetItemID INT, BudgetNumber INT, BudgetCategoryID INT, BudgetTypeID INT, Amount DECIMAL(10, 4))
BEGIN
	UPDATE	BudgetItem
	SET		BudgetItem.BudgetNumber			= BudgetNumber
			,BudgetItem.BudgetCategoryID	= BudgetCategoryID
			,BudgetItem.BudgetTypeID 		= BudgetTypeID
	       	,BudgetItem.Amount 				= Amount
	       	,BudgetItem.ModifyDT			= NOW()
			,BudgetItem.ModifyBy			= 'User'
	WHERE	BudgetItem.BudgetItemID = BudgetItemID
    ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `BudgetSummaryGet` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE PROCEDURE `BudgetSummaryGet`(BudgetMonth DATETIME)
BEGIN

    DECLARE SessionID VARCHAR(100);
    DECLARE StartDT DATETIME;
    DECLARE EndDT DATETIME;
    DECLARE BudgetNumber INT(10);
    
    SET SessionID = UUID();
	SET StartDT = CAST(DATE_FORMAT(BudgetMonth ,'%Y-%m-01') AS DATE);
	SET EndDT = LAST_DAY(BudgetMonth);
    SET BudgetNumber = EXTRACT(YEAR_MONTH FROM BudgetMonth);    

	INSERT INTO tmpBudgetSummary
	(
		SessionID
		,TransactionID
		,TransactionDT
		,TransactionTypeID
		,TransactionType
		,TransactionNumber
		,Description
		,Amount
		,Note
		,BudgetNumber
		,BudgetGroupID
		,BudgetGroup
		,BudgetCategoryID
		,BudgetCategory
		,Sort
	)
    SELECT		SessionID							AS SessionID
				,Transaction.TransactionID			AS TransactionID
				,Transaction.TransactionDT			AS TransactionDT
				,TransactionType.TransactionTypeID	AS TransactionTypeID
				,TransactionType.TransactionType	AS TransactionType
				,Transaction.TransactionNumber		AS TransactionNumber
				,Transaction.Description			AS Description
				,Transaction.Amount					AS Amount
				,Transaction.Note					AS Note
                ,Transaction.BudgetNumber			AS BudgetNumber
				,BudgetGroup.BudgetGroupID			AS BudgetGroupID
				,BudgetGroup.BudgetGroup			AS BudgetGroup
				,BudgetCategory.BudgetCategoryID	AS BudgetCategoryID
				,BudgetCategory.BudgetCategory		AS BudgetCategory
				,BudgetCategory.Sort				AS Sort
	FROM		Transaction Transaction
    INNER JOIN	TransactionType TransactionType
    ON			TransactionType.TransactionTypeID = Transaction.TransactionTypeID
	INNER JOIN	BudgetCategory BudgetCategory
    ON			BudgetCategory.BudgetCategoryID = Transaction.BudgetCategoryID
    INNER JOIN	BudgetGroup BudgetGroup
    ON			BudgetGroup.BudgetGroupID = BudgetCategory.BudgetGroupID
    WHERE		Transaction.TransactionDT BETWEEN StartDT AND EndDT
    AND			Transaction.TransactionTypeID IN (1, 2)
	;
   
    INSERT INTO tmpBudgetSummary
	(
		SessionID
		,BudgetNumber
        ,CategoryActual
		,BudgetGroupID
		,BudgetGroup
		,BudgetCategoryID
		,BudgetCategory
		,Sort
	)
	SELECT		SessionID							AS SessionID
				,BudgetItem.BudgetNumber			AS BudgetNumber
                ,0									AS CategoryActual
				,BudgetGroup.BudgetGroupID			AS BudgetGroupID
				,BudgetGroup.BudgetGroup			AS BudgetGroup
				,BudgetCategory.BudgetCategoryID	AS BudgetCategoryID
				,BudgetCategory.BudgetCategory		AS BudgetCategory
				,BudgetCategory.Sort				AS Sort
    FROM 		BudgetItem BudgetItem
	INNER JOIN	BudgetCategory BudgetCategory
    ON			BudgetCategory.BudgetCategoryID = BudgetItem.BudgetCategoryID
    INNER JOIN	BudgetGroup BudgetGroup
    ON			BudgetGroup.BudgetGroupID = BudgetCategory.BudgetGroupID
    WHERE		BudgetItem.BudgetNumber = BudgetNumber
    AND			BudgetItem.Amount > 0
    AND			BudgetItem.BudgetCategoryID NOT IN 	(
														SELECT 	tmpBudgetSummary.BudgetCategoryID 
                                                        FROM 	tmpBudgetSummary tmpBudgetSummary
													)
	;
	    
	UPDATE		tmpBudgetSummary
    INNER JOIN	(
					SELECT 		BudgetItem.BudgetTypeID			AS BudgetTypeID	
								,BudgetItem.BudgetCategoryID	AS BudgetCategoryID
								,BudgetItem.Amount				AS CategoryBudget 
					FROM 		BudgetItem BudgetItem
                    INNER JOIN	tmpBudgetSummary tmpBudgetSummary	
                    ON			tmpBudgetSummary.BudgetCategoryID = BudgetItem.BudgetCategoryID
					AND			tmpBudgetSummary.BudgetNumber = BudgetItem.BudgetNumber
                    WHERE		tmpBudgetSummary.SessionID = SessionID
					GROUP BY	BudgetItem.BudgetCategoryID
				) RS
	ON			tmpBudgetSummary.BudgetCategoryID = RS.BudgetCategoryID
	SET			tmpBudgetSummary.CategoryBudget = RS.CategoryBudget
				,tmpBudgetSummary.BudgetTypeID = RS.BudgetTypeID
	WHERE 		tmpBudgetSummary.SessionID = SessionID
    ;
    
	UPDATE		tmpBudgetSummary
    INNER JOIN	(
					SELECT 		tmpBudgetSummary.BudgetCategoryID	AS BudgetCategoryID
								,SUM(tmpBudgetSummary.Amount)		AS CategoryActual 
					FROM 		tmpBudgetSummary tmpBudgetSummary	
                    WHERE 		tmpBudgetSummary.SessionID = SessionID
					AND			tmpBudgetSummary.BudgetTypeID = 1
                    AND			tmpBudgetSummary.TransactionTypeID = 1
					GROUP BY	tmpBudgetSummary.BudgetCategoryID
				) RS
	ON			tmpBudgetSummary.BudgetCategoryID = RS.BudgetCategoryID
	SET			tmpBudgetSummary.CategoryActual = RS.CategoryActual
    WHERE 		tmpBudgetSummary.SessionID = SessionID
    ;
    
	UPDATE		tmpBudgetSummary
    INNER JOIN	(
					SELECT 		tmpBudgetSummary.BudgetCategoryID	AS BudgetCategoryID
								,SUM(tmpBudgetSummary.Amount)		AS CategoryActual 
					FROM 		tmpBudgetSummary tmpBudgetSummary	
                    WHERE 		tmpBudgetSummary.SessionID = SessionID
					AND			tmpBudgetSummary.BudgetTypeID = 2
                    AND			tmpBudgetSummary.TransactionTypeID = 2
					GROUP BY	tmpBudgetSummary.BudgetCategoryID
				) RS
	ON			tmpBudgetSummary.BudgetCategoryID = RS.BudgetCategoryID
	SET			tmpBudgetSummary.CategoryActual = RS.CategoryActual
    WHERE 		tmpBudgetSummary.SessionID = SessionID
    ;
    
    UPDATE		tmpBudgetSummary
    SET			tmpBudgetSummary.CategoryActualVsBudget = IFNULL(tmpBudgetSummary.CategoryActual, 0) - IFNULL(tmpBudgetSummary.CategoryBudget, 0)
    WHERE		tmpBudgetSummary.BudgetTypeID = 1
    AND			tmpBudgetSummary.SessionID = SessionID
    ;
    
    UPDATE		tmpBudgetSummary
    SET			tmpBudgetSummary.CategoryActualVsBudget = IFNULL(tmpBudgetSummary.CategoryBudget, 0) - IFNULL(tmpBudgetSummary.CategoryActual, 0)
    WHERE		tmpBudgetSummary.BudgetTypeID = 2
    AND			tmpBudgetSummary.SessionID = SessionID
    ;
    
    UPDATE		tmpBudgetSummary
    INNER JOIN	(
					SELECT 		SUM(tmpBudgetSummary.Amount)	AS IncomeActual 
					FROM 		tmpBudgetSummary tmpBudgetSummary	
                    WHERE 		tmpBudgetSummary.SessionID = SessionID
                    AND			tmpBudgetSummary.BudgetTypeID = 1
                    AND			tmpBudgetSummary.TransactionTypeID = 1
					GROUP BY	tmpBudgetSummary.BudgetTypeID
				) RS
	SET			tmpBudgetSummary.IncomeActual = RS.IncomeActual
    WHERE 		tmpBudgetSummary.SessionID = SessionID
    ;
    
	UPDATE		tmpBudgetSummary
    INNER JOIN	(
					SELECT 		SUM(rsBudgetSummary.CategoryBudget)	AS IncomeBudget 
					FROM 		(
									SELECT	DISTINCT
											tmpBudgetSummary.CategoryBudget	AS CategoryBudget
									FROM	tmpBudgetSummary tmpBudgetSummary
                                    WHERE 	tmpBudgetSummary.SessionID = SessionID
                                    AND 	tmpBudgetSummary.BudgetTypeID = 1
								) rsBudgetSummary
				) RS
	SET			tmpBudgetSummary.IncomeBudget = RS.IncomeBudget
    WHERE 		tmpBudgetSummary.SessionID = SessionID
    ;
    
	UPDATE		tmpBudgetSummary
    SET			tmpBudgetSummary.IncomeActualVsBudget = IFNULL(tmpBudgetSummary.IncomeActual, 0) - IFNULL(tmpBudgetSummary.IncomeBudget, 0)
    WHERE		tmpBudgetSummary.SessionID = SessionID
    ;
    
    UPDATE		tmpBudgetSummary
    INNER JOIN	(
					SELECT 		SUM(tmpBudgetSummary.Amount)	AS ExpenseActual 
					FROM 		tmpBudgetSummary tmpBudgetSummary	
                    WHERE 		tmpBudgetSummary.SessionID = SessionID
                    AND			tmpBudgetSummary.BudgetTypeID = 2
                    AND			tmpBudgetSummary.TransactionTypeID = 2
					GROUP BY	tmpBudgetSummary.BudgetTypeID
				) RS
	SET			tmpBudgetSummary.ExpenseActual = RS.ExpenseActual
    WHERE 		tmpBudgetSummary.SessionID = SessionID
    ;
    
	UPDATE		tmpBudgetSummary
    INNER JOIN	(
					SELECT 		SUM(rsBudgetSummary.CategoryBudget)	AS ExpenseBudget 
					FROM 		(
									SELECT	DISTINCT
											tmpBudgetSummary.CategoryBudget	AS CategoryBudget
                                            ,tmpBudgetSummary.BudgetCategoryID AS BudgetCategoryID
									FROM	tmpBudgetSummary tmpBudgetSummary
                                    WHERE 	tmpBudgetSummary.SessionID = SessionID
                                    AND 	tmpBudgetSummary.BudgetTypeID = 2
								) rsBudgetSummary
				) RS
	SET			tmpBudgetSummary.ExpenseBudget = RS.ExpenseBudget
    WHERE 		tmpBudgetSummary.SessionID = SessionID
    ;

	UPDATE		tmpBudgetSummary
    SET			tmpBudgetSummary.ExpenseActualVsBudget = IFNULL(tmpBudgetSummary.ExpenseBudget, 0) - IFNULL(tmpBudgetSummary.ExpenseActual, 0)
    WHERE		tmpBudgetSummary.SessionID = SessionID
    ;
    
    -- Final totals
	UPDATE		tmpBudgetSummary
    SET			tmpBudgetSummary.TotalIncomeVsExpenseActual = IFNULL(tmpBudgetSummary.IncomeActual, 0) - IFNULL(tmpBudgetSummary.ExpenseActual, 0)
    WHERE		tmpBudgetSummary.SessionID = SessionID
    ;
    
	UPDATE		tmpBudgetSummary
    SET			tmpBudgetSummary.TotalIncomeVsExpenseBudget = IFNULL(tmpBudgetSummary.IncomeBudget, 0) - IFNULL(tmpBudgetSummary.ExpenseBudget, 0)
    WHERE		tmpBudgetSummary.SessionID = SessionID
    ;
    
	UPDATE		tmpBudgetSummary
    SET			tmpBudgetSummary.TotalIncomeVsExpenseActualVsBudget = IFNULL(tmpBudgetSummary.IncomeActualVsBudget, 0) + IFNULL(tmpBudgetSummary.ExpenseActualVsBudget ,0)
    WHERE		tmpBudgetSummary.SessionID = SessionID
    ;
    
    -- Negative flags
    UPDATE		tmpBudgetSummary
    SET			tmpBudgetSummary.IsCategoryActualVsBudgetNegative = 1
    WHERE		tmpBudgetSummary.CategoryActualVsBudget < 0
    ;
    
    UPDATE		tmpBudgetSummary
    SET			tmpBudgetSummary.IsTotalIncomeVsExpenseActualNegative = 1
    WHERE		tmpBudgetSummary.TotalIncomeVsExpenseActual < 0
    ;
    
	UPDATE		tmpBudgetSummary
    SET			tmpBudgetSummary.IsTotalIncomeVsExpenseBudgetNegative = 1
    WHERE		tmpBudgetSummary.TotalIncomeVsExpenseBudget < 0
    ;
    
	UPDATE		tmpBudgetSummary
    SET			tmpBudgetSummary.IsTotalIncomeVsExpenseActualVsBudgetNegative = 1
    WHERE		tmpBudgetSummary.TotalIncomeVsExpenseActualVsBudget < 0
    ;
    
    -- Flags
	UPDATE		tmpBudgetSummary
    SET			tmpBudgetSummary.IsExpenseFlg = 1
    WHERE		tmpBudgetSummary.BudgetTypeID = 2
    ;
    
	SELECT 		tmpBudgetSummary.KeyID 											AS KeyID
				,tmpBudgetSummary.SessionID 									AS SessionID
				,tmpBudgetSummary.TransactionID 								AS TransactionID
				,DateMask(tmpBudgetSummary.TransactionDT) 						AS TransactionDT
				,tmpBudgetSummary.TransactionTypeID 							AS TransactionTypeID
				,tmpBudgetSummary.TransactionType 								AS TransactionType
				,tmpBudgetSummary.TransactionNumber 							AS TransactionNumber
				,tmpBudgetSummary.Description 									AS Description
				,tmpBudgetSummary.Amount 										AS Amount
				,tmpBudgetSummary.Note 											AS Note
                ,DATE_FORMAT(BudgetMonth,'%M %Y') 								AS BudgetMonth
				,tmpBudgetSummary.BudgetNumber 									AS BudgetNumber
                ,tmpBudgetSummary.BudgetTypeID 									AS BudgetTypeID
				,tmpBudgetSummary.BudgetGroupID 								AS BudgetGroupID
				,tmpBudgetSummary.BudgetGroup 									AS BudgetGroup
				,tmpBudgetSummary.BudgetCategoryID 								AS BudgetCategoryID
				,tmpBudgetSummary.BudgetCategory 								AS BudgetCategory
				,tmpBudgetSummary.Sort 											AS Sort
				,IFNULL(tmpBudgetSummary.CategoryActual, 0) 					AS CategoryActual
				,IFNULL(tmpBudgetSummary.CategoryBudget, 0) 					AS CategoryBudget
				,IFNULL(tmpBudgetSummary.CategoryActualVsBudget, 0) 			AS CategoryActualVsBudget
				,IFNULL(tmpBudgetSummary.IncomeActual, 0) 						AS IncomeActual
				,IFNULL(tmpBudgetSummary.IncomeBudget, 0) 						AS IncomeBudget
				,IFNULL(tmpBudgetSummary.IncomeActualVsBudget, 0) 				AS IncomeActualVsBudget
				,IFNULL(tmpBudgetSummary.ExpenseActual, 0) 						AS ExpenseActual
				,IFNULL(tmpBudgetSummary.ExpenseBudget, 0) 						AS ExpenseBudget
				,IFNULL(tmpBudgetSummary.ExpenseActualVsBudget, 0) 				AS ExpenseActualVsBudget
				,IFNULL(tmpBudgetSummary.TotalIncomeVsExpenseActual, 0) 		AS TotalIncomeVsExpenseActual
				,IFNULL(tmpBudgetSummary.TotalIncomeVsExpenseBudget, 0) 		AS TotalIncomeVsExpenseBudget
				,IFNULL(tmpBudgetSummary.TotalIncomeVsExpenseActualVsBudget, 0)	AS TotalIncomeVsExpenseActualVsBudget
                ,tmpBudgetSummary.IsCategoryActualVsBudgetNegative				AS IsCategoryActualVsBudgetNegative
                ,tmpBudgetSummary.IsTotalIncomeVsExpenseActualNegative			AS IsTotalIncomeVsExpenseActualNegative
                ,tmpBudgetSummary.IsTotalIncomeVsExpenseBudgetNegative			AS IsTotalIncomeVsExpenseBudgetNegative
                ,tmpBudgetSummary.IsTotalIncomeVsExpenseActualVsBudgetNegative	AS IsTotalIncomeVsExpenseActualVsBudgetNegative
                ,tmpBudgetSummary.IsExpenseFlg									AS IsExpenseFlg
	FROM 		tmpBudgetSummary tmpBudgetSummary
    WHERE		tmpBudgetSummary.SessionID = SessionID
    ORDER BY	tmpBudgetSummary.BudgetTypeID ASC
                ,tmpBudgetSummary.BudgetCategory ASC
                ,tmpBudgetSummary.TransactionDT ASC
	;

	DELETE FROM	tmpBudgetSummary 
    WHERE		tmpBudgetSummary.SessionID = SessionID
    ;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `BudgetSummarySpotlightGet` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `BudgetSummarySpotlightGet`()
BEGIN
	SELECT 		Budget.BudgetID
				,Budget.BudgetNumber
				,Budget.BudgetMonth
				,DATE_FORMAT(Budget.BudgetMonth,'%M %Y') AS BudgetMonthSummary
                ,DATE_FORMAT(Budget.BudgetMonth,'%Y-%m-%d') AS BudgetMonthSummaryUrl
				,Budget.CreateDT
				,Budget.CreateBy
				,Budget.ModifyDT
				,Budget.ModifyBy
				,Budget.ActiveFlg
	FROM 		Budget Budget
	WHERE		TIMESTAMPDIFF(MONTH, Budget.BudgetMonth, NOW()) <= 12
	ORDER BY	Budget.BudgetMonth DESC
    LIMIT 		13
	;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `BudgetYearGet` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `BudgetYearGet`()
BEGIN
	DECLARE MaxDT DATETIME;
	DECLARE StartDT DATETIME;
	DECLARE EndDT DATETIME;
	DECLARE i INT; 
    DECLARE counter INT;
    
	SET MaxDT = NOW();
	SET StartDT = '2016-04-01';
	SET EndDT = DATE_ADD(StartDT, INTERVAL 12 MONTH);
	SET i = 1; 
    SET counter = 3;
    
    DROP TEMPORARY TABLE IF EXISTS tmpBudgetYear;

	CREATE TEMPORARY TABLE tmpBudgetYear
	(
		KeyID		INT(10) NOT NULL AUTO_INCREMENT
        ,StartDT	DATETIME
        ,EndDT		DATETIME
        ,YearName	VARCHAR(100)
        ,YearValue	VARCHAR(100)
        ,PRIMARY KEY (`KeyID`)
	);

	WHILE i = 1 DO
        IF EndDT > MaxDT THEN 
			SET EndDT = DATE_FORMAT(DATE_ADD(LAST_DAY(MaxDT), INTERVAL 1 DAY) ,'%Y-%m-%d');
			SET i = 0;
		END IF;
        
		INSERT INTO tmpBudgetYear
		(
			StartDT
			,EndDT
			,YearName
            ,YearValue
		)
		SELECT	StartDT						AS StartDT
				,EndDT						AS EndDT
				,CONCAT('Year ', counter)	AS YearName
                ,CONCAT(DATE_FORMAT(StartDT ,'%Y-%m-%d'), '|', DATE_FORMAT(EndDT ,'%Y-%m-%d')) AS YearValue
		;
        
		SET StartDT = DATE_ADD(StartDT, INTERVAL 12 MONTH);
		SET EndDT = DATE_ADD(StartDT, INTERVAL 12 MONTH);
        SET counter = counter + 1;
	END WHILE;

    
    SELECT		tmpBudgetYear.KeyID 		AS KeyID
				,tmpBudgetYear.StartDT 		AS StartDT
				,tmpBudgetYear.EndDT 		AS EndDT
				,CONCAT(DATE_FORMAT(tmpBudgetYear.StartDT,'%b %Y'), ' - ', DATE_FORMAT(tmpBudgetYear.EndDT,'%b %Y')) AS YearName
                ,tmpBudgetYear.YearValue	AS YearValue
    FROM 		tmpBudgetYear tmpBudgetYear
    ORDER BY	tmpBudgetYear.YearName DESC
    ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `TransactionDelete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE PROCEDURE `TransactionDelete`(TransactionID INT)
BEGIN
	DELETE FROM Transaction
    WHERE Transaction.TransactionID = TransactionID
    ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `TransactionDescriptionGet` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE PROCEDURE `TransactionDescriptionGet`(Keyword VARCHAR(100))
BEGIN
	SET @Description = '';			
	SET @TransactionDT = '';
	SET @TransactionID = '';
	SET @i = 1;

	SELECT 	RS.Description
			,RS.TransactionDT
			,RS.TransactionID
			,CAST(RS.Amount AS DECIMAL(10, 2)) AS Amount
            ,RS.BudgetCategoryID
	FROM	(
				SELECT  RSRank.Description
						,RSRank.TransactionDT
						,RSRank.TransactionID
						,RSRank.Amount
                        ,RSRank.BudgetCategoryID
						,RSRank.RANK
				FROM
				(
					SELECT  RSTransaction.Description
							,RSTransaction.TransactionDT
							,RSTransaction.TransactionID
							,RSTransaction.Amount
                            ,RSTransaction.BudgetCategoryID
							,@i := IF	(
											@Description = RSTransaction.Description, 
												IF	(
														@TransactionDT = RSTransaction.TransactionDT, 
															IF	(
																	@TransactionID = RSTransaction.TransactionID, 
																		@i, 
																	@i + 1 -- ELSE TransactionID
																), 
														@i + 1 -- ELSE TransactionDT
													),
											1 -- ELSE Description
										) AS RANK
							,@Description := RSTransaction.Description    
							,@TransactionDT := RSTransaction.TransactionDT
							,@TransactionID := RSTransaction.TransactionID
					FROM
					(
						SELECT  	Transaction.Description
									,Transaction.TransactionDT
									,Transaction.TransactionID
									,Transaction.Amount
                                    ,Transaction.BudgetCategoryID
						FROM    	Transaction Transaction
						ORDER BY	Transaction.Description
									,Transaction.TransactionDT DESC
									,Transaction.TransactionID DESC
					) RSTransaction
				) RSRank
			) RS
	WHERE	(RS.Description LIKE CONCAT('%', Keyword, '%') OR Keyword IS NULL)
    AND		RS.RANK = 1
    
	;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `TransactionInsert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE PROCEDURE `TransactionInsert`(TransactionTypeID INT, TransactionNumber VARCHAR(100), TransactionDT DATETIME, BudgetCategoryID INT, Amount DECIMAL(10 ,4), Description VARCHAR(1000), Note VARCHAR(1000))
BEGIN
	DECLARE BudgetNumber INT(10);
    DECLARE FundID INT(1);
    DECLARE IsNegativeFlg INT(1);
    
    SET BudgetNumber = EXTRACT(YEAR_MONTH FROM TransactionDT);
    SET FundID = (SELECT BudgetCategory.FundID FROM BudgetCategory WHERE BudgetCategory.BudgetCategoryID = BudgetCategoryID);
    SET IsNegativeFlg = (IFNULL((SELECT '1' FROM DUAL WHERE Amount < 0), 0));

	INSERT INTO Transaction
    (
		TransactionTypeID
        ,TransactionNumber
        ,TransactionDT
        ,BudgetNumber
        ,BudgetCategoryID
        ,Amount
        ,Description
        ,Note
        ,CreateDT
        ,CreateBy
    )
    SELECT	TransactionTypeID
			,TransactionNumber
			,TransactionDT
			,BudgetNumber
			,BudgetCategoryID
			,Amount
			,Description
            ,Note
            ,NOW()
            ,'User'
	FROM 	DUAL 
	WHERE	IsNegativeFlg = 0
    ;
    
    -- Fund Saved
	INSERT INTO Transaction
    (
		TransactionTypeID
        ,TransactionNumber
        ,TransactionDT
        ,BudgetNumber
        ,BudgetCategoryID
        ,Amount
        ,Description
        ,Note
        ,CreateDT
        ,CreateBy
    )
    SELECT	'3' -- Saved
			,TransactionNumber
			,TransactionDT
			,BudgetNumber
			,BudgetCategoryID
			,Amount
			,Description
            ,'Added to fund'
            ,NOW()
            ,'User'
	FROM 	DUAL 
	WHERE	TransactionTypeID = 2
	AND 	FundID IS NOT NULL
	AND		IsNegativeFlg = 0
    ;
    
    -- Fund Spent
	INSERT INTO Transaction
    (
		TransactionTypeID
        ,TransactionNumber
        ,TransactionDT
        ,BudgetNumber
        ,BudgetCategoryID
        ,Amount
        ,Description
        ,Note
        ,CreateDT
        ,CreateBy
    )
    SELECT	'4' -- Spent
			,TransactionNumber
			,TransactionDT
			,BudgetNumber
			,BudgetCategoryID
			,Amount
			,Description
            ,'Spent from fund'
            ,NOW()
            ,'User'
	FROM 	DUAL 
	WHERE	TransactionTypeID = 2
	AND 	FundID IS NOT NULL
	AND		IsNegativeFlg = 1
    ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `TransactionRecentGet` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE PROCEDURE `TransactionRecentGet`()
BEGIN
	SELECT		Transaction.TransactionID					AS TransactionID
				,Transaction.TransactionTypeID				AS TransactionTypeID
				,DateMask(Transaction.TransactionDT)		AS TransactionDT
				,Transaction.TransactionNumber				AS TransactionNumber
				,Transaction.Description					AS Description
				,CAST(Transaction.Amount AS DECIMAL(10,2)) 	AS Amount
				,Transaction.Note							AS Note
				,BudgetCategory.BudgetCategoryID			AS BudgetCategoryID
				,BudgetCategory.BudgetCategory				AS BudgetCategory
                ,Transaction.CreateBy						AS CreateBy
                ,Transaction.CreateDT						AS CreateDT
                ,Transaction.ModifyBy						AS ModifyBy
                ,Transaction.ModifyDT						AS ModifyDT
                ,Transaction.ActiveFlg						AS ActiveFlg
                ,CASE 
					WHEN Transaction.TransactionTypeID = 2 
						THEN 1
					ELSE NULL
				END 										AS IsExpenseFlg
				,CASE 
					WHEN Transaction.TransactionTypeID = 3 
						THEN 1
					ELSE NULL
				END 										AS IsSavedFlg
				,CASE 
					WHEN Transaction.TransactionTypeID = 4 
						THEN 1
					ELSE NULL
				END 										AS IsSpentFlg
	FROM		Transaction Transaction
	INNER JOIN	BudgetCategory BudgetCategory
    ON			BudgetCategory.BudgetCategoryID = Transaction.BudgetCategoryID
    WHERE		Transaction.TransactionDT > DATE_SUB(NOW(), INTERVAL 1 MONTH)
    ORDER BY	Transaction.TransactionDT DESC
				,Transaction.CreateDT DESC
                ,Transaction.TransactionID DESC
				,Transaction.Description ASC
	;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `TransactionUpdate` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE PROCEDURE `TransactionUpdate`(TransactionID INT, TransactionNumber VARCHAR(100), TransactionDT DATETIME, BudgetID INT, BudgetCategoryID INT, Amount DECIMAL(10 ,4), Description VARCHAR(1000), Note VARCHAR(1000))
BEGIN
	UPDATE	Transaction
    SET		Transaction.TransactionDT 		= TransactionDT
			,Transaction.BudgetNumber		= EXTRACT(YEAR_MONTH FROM TransactionDT)
            ,Transaction.BudgetCategoryID 	= BudgetCategoryID
            ,Transaction.Amount 			= Amount
            ,Transaction.TransactionNumber 	= TransactionNumber
            ,Transaction.Note 				= Note
            ,Transaction.Description 		= Description
            ,Transaction.ModifyDT			= NOW()
            ,Transaction.ModifyBy			= 'User'
	WHERE	Transaction.TransactionID = TransactionID
    ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-01-08 20:48:36
