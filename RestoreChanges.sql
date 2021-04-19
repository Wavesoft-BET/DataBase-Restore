UPDATE [EIS].[dbo].client
SET FTPLocation = 1234
WHERE clientID IN (
		SELECT [ClientID]
		FROM [EIS].[dbo].[Client]
		WHERE FK_ClientStatusID = 1
			AND FTPLocation LIKE '%10.3.2.191%'
		)

--System Settings
UPDATE [EIS].[dbo].SystemSettings
SET SystemSettingValue = '\\10.3.104.104\RaceFileOutput\\'
WHERE SystemSettingName = 'FileSource'

---Stored proc locations need to be in System Settings
--H:
-- [dbo].[XMLImport_Greyhound]
-- [dbo].[XMLImport_eOddsMaker]
-- [dbo].[ImportTXTInternationalFeeds] 

DECLARE @SearchText varchar(1000) = '10.3.2.69';

SELECT DISTINCT SPName 
FROM (
    (SELECT ROUTINE_NAME SPName
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
        AND definition LIKE '%' + @SearchText + '%')
) AS T
ORDER BY T.SPName
