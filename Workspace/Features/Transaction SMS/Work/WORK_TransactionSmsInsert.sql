USE `planner`;

DROP PROCEDURE IF EXISTS `TransactionSmsInsert`;

DELIMITER ;;
CREATE PROCEDURE `TransactionSmsInsert` 
(
    prmSender						VARCHAR(100)
    ,prmReceiver 					VARCHAR(100)
    ,prmBody							VARCHAR(1000)
    ,prmSmsSid 					VARCHAR(1000)
	,prmSmsMessageSid 		VARCHAR(1000)
    ,prmSmsStatus 				VARCHAR(100)
    ,prmAccountSid 				VARCHAR(1000)
    ,prmMessageSid 			VARCHAR(1000)
    ,prmFromCity 					VARCHAR(100)
	,prmFromState 				VARCHAR(100)
	,prmFromZip 					VARCHAR(100)
	,prmFromCountry 			VARCHAR(100)
	,prmToState 					VARCHAR(100)
    ,prmToCity 						VARCHAR(100)
    ,prmToZip 						VARCHAR(100)
    ,prmToCountry 				VARCHAR(100)
	,prmNumMedia 				VARCHAR(100)
    ,prmNumSegments 		VARCHAR(100)
	,prmApiVersion 				VARCHAR(100)
)
BEGIN

SET @varSender = prmSender;
SET @varReceiver = prmReceiver;
SET @varBody = prmBody;
SET @varSmsSid = prmSmsSid;
SET @varSmsMessageSid = prmSmsMessageSid;
SET @varSmsStatus = prmSmsStatus;
SET @varAccountSid = prmAccountSid;
SET @varMessageSid = prmMessageSid;
SET @varFromCity = prmFromCity;
SET @varFromState = prmFromState;
SET @varFromZip = prmFromZip;
SET @varFromCountry = prmFromCountry;
SET @varToState = prmToState;
SET @varToCity = prmToCity;
SET @varToZip = prmToZip;
SET @varToCountry = prmToCountry;
SET @varNumMedia = prmNumMedia;
SET @varNumSegments = prmNumSegments;
SET @varApiVersion = prmApiVersion;

INSERT INTO TransactionSms
(
	Sender		
    ,Receiver
	,Body
	,SmsSid
	,SmsMessageSid
	,SmsStatus
	,AccountSid
	,MessageSid
	,FromCity
	,FromState
	,FromZip
	,FromCountry
	,ToState
	,ToCity
	,ToZip
	,ToCountry
	,NumMedia
	,NumSegments
	,ApiVersion
	,CreateBy
)
SELECT  @varSender					AS Sender
				,@varReceiver				AS Receiver						
				,@varBody						AS Body
				,@varSmsSid 					AS SmsSid
				,@varSmsMessageSid 	AS SmsMessageSid
				,@varSmsStatus 			AS SmsStatus
				,@varAccountSid 			AS AccountSid
				,@varMessageSid 			AS MessageSid
				,@varFromCity 				AS FromCity
				,@varFromState 			AS FromState
				,@varFromZip 				AS FromZip
				,@varFromCountry 		AS FromCountry
				,@varToState 					AS ToState
				,@varToCity 					AS ToCity
				,@varToZip 					AS ToZip
				,@varToCountry 				AS ToCountry
				,@varNumMedia 			AS NumMedia
				,@varNumSegments 		AS NumSegments
				,@varApiVersion 			AS ApiVersion
				,'Bot'								AS CreateBy
;

END;;
DELIMITER ;