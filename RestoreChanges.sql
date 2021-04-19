UPDATE [EIS].[dbo].client
SET FTPLocation = 1234
WHERE clientID IN (
		SELECT [ClientID]
		FROM [EIS].[dbo].[Client]
		WHERE FK_ClientStatusID = 1
			AND FTPLocation LIKE '%10.3.2.69%'
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