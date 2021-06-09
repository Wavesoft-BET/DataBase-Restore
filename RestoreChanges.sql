UPDATE [EIS].[dbo].client
SET FTPLocation = 1234
WHERE clientID IN (
SELECT [ClientID]
FROM [EIS].[dbo].[Client]
WHere FTPLocation LIKE '%10.3.2.191%'
)
--------------------------------------------------------------------------------------
---Stored proc locations need to be in System Settings
--H:
-- [dbo].[XMLImport_Greyhound]
-- [dbo].[XMLImport_eOddsMaker]
-- [dbo].[ImportTXTInternationalFeeds] 
-- [dbo].[XMLImport_SISHorseRacing]
----------------------------------------------------------------------------------------- 
UPDATE [EIS].[dbo].SystemSettings
SET SystemSettingValue = '\\10.3.104.104\RaceFileOutput\\'
WHERE SystemSettingName = 'FileSource'

UPDATE [EISImport].[dbo].SystemSettings
SET SystemSettingValue = '\\10.3.104.104\\eOddsMaker\\'
WHERE SystemSettingName = 'eOddsMakerFileLocation'
 
UPDATE [EISImport].[dbo].SystemSettings
SET SystemSettingValue = '\\10.3.104.104\\Incoming\\TurfSport\\'
WHERE SystemSettingName = 'FileOutputLocation'  

UPDATE [EISImport].[dbo].SystemSettings
SET SystemSettingValue = '\\10.3.104.104\\Incoming\\TurfSport\\'
WHERE SystemSettingName = 'FileSource'  

UPDATE [EISImport].[dbo].SystemSettings
SET SystemSettingValue = 'http://10.3.104.104/ReportServer'
WHERE SystemSettingName = 'ReportServerURL'  

UPDATE [EISImport].[dbo].SystemSettings
SET SystemSettingValue = 'H:\Incoming\SAHorseRacing'
WHERE SystemSettingName = 'SAHorseRacingFileLocation'  

UPDATE [EISImport].[dbo].SystemSettings
SET SystemSettingValue = 'H:\Incoming\TattsBetsHorseRacing'
WHERE SystemSettingName = 'TatsBetFiles'  

UPDATE [EISImport].[dbo].SystemSettings
SET SystemSettingValue = 'H:\Incoming\TSXMLOutputFiles'
WHERE SystemSettingName = 'TurfsportOutputXML'  

--------------------------------------------------------------------
 ---Stored proc locations need to be in System Settings
-- 10.3.2.69 -> 10.3.104.104
-- 10.3.2.65 -> 10.3.104.103
-- moz-syx-sql1 - >10.3.105.101
---------------------------------------------------------------------

DECLARE @SearchText varchar(1000) = '10.3.2.69';

SELECT DISTINCT SPName
FROM ((SELECT ROUTINE_NAME SPName
FROM INFORMATION_SCHEMA.ROUTINES
WHERE ROUTINE_DEFINITION LIKE '%' + @SearchText + '%'
AND ROUTINE_TYPE='PROCEDURE')
UNION ALL
(SELECT OBJECT_NAME(id) SPName
FROM SYSCOMMENTS
WHERE [text] LIKE '%' + @SearchText + '%'
AND OBJECTPROPERTY(id, 'IsProcedure') = 1
GROUP BY OBJECT_NAME(id))
UNION ALL
(SELECT OBJECT_NAME(object_id) SPName
FROM sys.sql_modules
WHERE OBJECTPROPERTY(object_id, 'IsProcedure') = 1
AND definition LIKE '%' + @SearchText + '%')) AS T
ORDER BY T.SPName


DECLARE @SearchPush varchar(1000) = '10.3.2.65';

SELECT DISTINCT SPName
FROM ((SELECT ROUTINE_NAME SPName
FROM INFORMATION_SCHEMA.ROUTINES
WHERE ROUTINE_DEFINITION LIKE '%' + @SearchText + '%'
AND ROUTINE_TYPE='PROCEDURE')
UNION ALL
(SELECT OBJECT_NAME(id) SPName
FROM SYSCOMMENTS
WHERE [text] LIKE '%' + @SearchPush + '%'
AND OBJECTPROPERTY(id, 'IsProcedure') = 1
GROUP BY OBJECT_NAME(id))
UNION ALL
(SELECT OBJECT_NAME(object_id) SPName
FROM sys.sql_modules
WHERE OBJECTPROPERTY(object_id, 'IsProcedure') = 1
AND definition LIKE '%' + @SearchText + '%')) AS T
ORDER BY T.SPName

DECLARE @SearchMoz varchar(1000) = 'moz-syx-sql1';

SELECT DISTINCT SPName
FROM ((SELECT ROUTINE_NAME SPName
FROM INFORMATION_SCHEMA.ROUTINES
WHERE ROUTINE_DEFINITION LIKE '%' + @SearchText + '%'
AND ROUTINE_TYPE='PROCEDURE')
UNION ALL
(SELECT OBJECT_NAME(id) SPName
FROM SYSCOMMENTS
WHERE [text] LIKE '%' + @SearchMoz + '%'
AND OBJECTPROPERTY(id, 'IsProcedure') = 1
GROUP BY OBJECT_NAME(id))
UNION ALL
(SELECT OBJECT_NAME(object_id) SPName
FROM sys.sql_modules
WHERE OBJECTPROPERTY(object_id, 'IsProcedure') = 1
AND definition LIKE '%' + @SearchText + '%')) AS T
ORDER BY T.SPName
