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
END