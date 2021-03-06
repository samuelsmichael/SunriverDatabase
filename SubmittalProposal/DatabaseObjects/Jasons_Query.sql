
/* --------------------- Refresh SOA_ACTIVEMEMBERS ------------------------------*/
Print 'Beginning ''Refresh SOA_ACTIVEMEMBERS'''
TRUNCATE TABLE [AccessControl].[dbo].[SOA_ACTIVEMEMBERS];
INSERT INTO [AccessControl].[dbo].[SOA_ACTIVEMEMBERS]
	SELECT distinct c.[CUSTOMER_ID], cak.[ALTERNATEKEY_ID], c.[FIRSTNAME], c.[LASTNAME]
	FROM 
		[SROA14].[SunriverOwners].[dbo].[CUSTOMERS] c 
		left outer join [SROA14].[SunriverOwners].[dbo].[CUSTOMER_ALTERNATE_KEYS] cak 
			on cak.[customer_id] = c.[customer_id]
			   and cak.[ALTERNATEKEYTYPE_ID] = 1
	    left outer join [SROA14].[SunriverOwners].[dbo].[MEMBERSHIPS] m	on m.[PRIMARYMEMBERCUSTOMER_ID] = c.[CUSTOMER_ID]
	WHERE 
		cak.[ALTERNATEKEY_ID] is not null
	    AND m.[DATEEXPIRES] > getdate()
	    AND m.[DATEEFFECTIVE] <= getdate();
/* ----------------------------------------- Refresh SOA_ACTIVEMEMBERSHIPS ---------------------------------------------------------*/
PRINT 'Beginning ''Refresh SOA_ACTIVEMEMBERSHIPS''' 
TRUNCATE TABLE [AccessControl].[dbo].[SOA_ACTIVEMEMBERSHIPS];
INSERT INTO [AccessControl].[dbo].[SOA_ACTIVEMEMBERSHIPS]
  SELECT m.[MEMBERSHIP_ID], m.[PRIMARYMEMBERCUSTOMER_ID], m.[DATEEFFECTIVE],  m.[DATEEXPIRES], cak.[ALTERNATEKEY_ID], m.[PACKAGE_ID]
  FROM 
	[SROA14].[SunriverOwners].[dbo].[MEMBERSHIPS] m
	LEFT OUTER JOIN [SROA14].[SunriverOwners].[dbo].[CUSTOMER_ALTERNATE_KEYS] cak on cak.[CUSTOMER_ID] = m.[PRIMARYMEMBERCUSTOMER_ID]
  WHERE 
	m.[DATEEXPIRES] > getdate()
    AND m.[DATEEFFECTIVE] <= getdate()
    AND cak.[ALTERNATEKEYTYPE_ID] = 1
  order by cak.[ALTERNATEKEY_ID];
/* ------------------------------- Add New Members to EMP ---------------------------------------------------------------------------*/
Print 'Beginning ''Add New Members to EMP'''
DECLARE @CUSTOMER_ID INT
DECLARE @FIRSTNAME VARCHAR(40)
DECLARE @LASTNAME VARCHAR(40)

Declare MemberCursor CURSOR FAST_FORWARD FOR 

SELECT 
	am.[CUSTOMER_ID] ,am.[FIRSTNAME] ,am.[LASTNAME]
FROM 
	[AccessControl].[dbo].[SOA_ACTIVEMEMBERS] am
    left outer join [AccessControl].[dbo].[EMP] em on convert(int,left(em.[SSNO],9)) = am.[CUSTOMER_ID]
WHERE em.[ID] is null

OPEN MemberCursor
FETCH NEXT FROM MemberCursor INTO @CUSTOMER_ID, @FIRSTNAME, @LASTNAME
WHILE @@FETCH_STATUS = 0 BEGIN 
  INSERT INTO [AccessControl].[dbo].[EMP]
           ([ID]
           ,[LASTNAME]
           ,[FIRSTNAME]
           ,[MIDNAME]
           ,[SSNO]
           ,[LASTCHANGED]
           ,[VISITOR]
           ,[ALLOWEDVISITORS]
           ,[ASSET_GROUPID]
           ,[LNL_DBID]
           ,[GUARD]
           ,[SEGMENTID])
     VALUES
           ((select isnull(max(id) + 1,4000) from [AccessControl].dbo.[EMP] where id > 3999)
           ,@FIRSTNAME
           ,@LASTNAME
           ,null
           ,@CUSTOMER_ID
           ,getdate()
           ,0
           ,1
           ,0
           ,-1
           ,0
           ,-1)

   FETCH NEXT FROM MemberCursor  INTO @CUSTOMER_ID,  @FIRSTNAME, @LASTNAME
END 
CLOSE MemberCursor
DEALLOCATE MemberCursor

/* --------------------------------- Add New Members to BADGE ----------------------------------------------------------------------------------------*/
Print 'Beginning ''Add New Members to BADGE'''

DECLARE @ID INT
DECLARE @ALTERNATEKEY NVARCHAR(50)

Declare MemberCursor CURSOR FAST_FORWARD FOR 

select 
	em.[ID], am.[ALTERNATEKEY_ID] 
from  
	[AccessControl].[dbo].[EMP] em
    left outer join  [AccessControl].[dbo].[BADGE] b on b.[EMPID] = em.[ID]
    left outer join  [AccessControl].[dbo].[SOA_ACTIVEMEMBERS] am on convert(int,left(em.[SSNO],9)) = am.[CUSTOMER_ID]
where b.[ID] is null

OPEN MemberCursor
FETCH NEXT FROM MemberCursor INTO @ID, @ALTERNATEKEY
WHILE @@FETCH_STATUS = 0 
BEGIN 
  INSERT INTO [AccessControl].[dbo].[BADGE]
           ([ID]
           ,[EMPID]
           ,[TYPE]
           ,[EMBOSSED]
           ,[ACTIVATE]
           ,[DEACTIVATE]
           ,[STATUS]
           ,[PRINTS]
           ,[ISSUECODE]
           ,[APBEXEMPT]
           ,[LASTPRINT]
           ,[LASTCHANGED]
           ,[USELIMIT]
           ,[EXTEND_STRIKE_HELD]
           ,[PASSAGE_MODE]
           ,[DEADBOLT_OVERRIDE]
           ,[BADGEKEY]
           ,[SEGMENTID]
           ,[PIN]
           ,[DEST_EXEMPT]
           ,[TWO_MAN_TYPE]
           ,[DESCRIPTOR_FLAG]
           ,[DEFAULT_FLOOR]
           ,[DEFAULT_DOOR])
     VALUES
           ((select isnull(max(id) + 1,4000) from [AccessControl].dbo.[BADGE] where id > 3999)
           ,@ID
           ,1
           ,null
           ,getdate()
           ,'2055-01-01'
           ,1
           ,0
           ,0
           ,0
           ,null
           ,getdate()
           ,null
           ,0
           ,0
           ,0
           ,@ALTERNATEKEY
           ,-1
           ,0x247F8D1502326B1E1C9B24E6922137106EF214661778407ACB14E1D4A24F75D23DD1201711EB3EF0A73A57C375324AD01D74
           ,0
           ,0
           ,0
           ,0
           ,1)

   FETCH NEXT FROM MemberCursor  INTO  @ID, @ALTERNATEKEY
END 
CLOSE MemberCursor
DEALLOCATE MemberCursor

/***********************  New Members to BADGELINK  ****************************************************************/
Print 'Beginning ''New Members to BADGELINK'''
DECLARE @ALTERNATEKEY_2 NVARCHAR(50)
DECLARE @ACCESSLVID_2 INT

Declare MemberCursor CURSOR FAST_FORWARD FOR 

SELECT am.[ALTERNATEKEY_ID], al.[ACCESSLVID]
  FROM [AccessControl].[dbo].[SOA_ACTIVEMEMBERSHIPS] am
  left outer join [AccessControl].[dbo].[ACCESSLVL] al
  on al.[DESCRIPT] = convert(nvarchar(64),am.[PACKAGE_ID])
  left outer join [AccessControl].[dbo].[BADGELINK] bl
  on bl.[BADGEKEY] = am.[ALTERNATEKEY_ID]
  and al.[DESCRIPT] = convert(nvarchar(64),am.[PACKAGE_ID])
  WHERE bl.ACCLVLID is null

OPEN MemberCursor
FETCH NEXT FROM MemberCursor INTO  @ALTERNATEKEY_2, @ACCESSLVID_2
WHILE @@FETCH_STATUS = 0 BEGIN 

	INSERT INTO [AccessControl].[dbo].[BADGELINK]
           ([BADGEKEY]
           ,[ACCLVLID]
           ,[ACTIVATE]
           ,[DEACTIVATE]
           ,[INTRUSION_LEVEL]
           ,[ASSIGNMENT_TYPE])
		 VALUES
           (@ALTERNATEKEY_2
           ,@ACCESSLVID_2
           ,null
           ,null
           ,0
           ,0)

	FETCH NEXT FROM MemberCursor  INTO   @ALTERNATEKEY_2, @ACCESSLVID_2
END 
CLOSE MemberCursor
DEALLOCATE MemberCursor

/* --------------- Delete Inactive Members from EMP, BADGELINK, BADGE -------------- */
Print 'Beginning ''Delete Inactive Members from EMP, BADGELINK, BADGE'''
DECLARE @ID_2 INT
DECLARE @BADGEKEY INT


Declare MemberCursor CURSOR FAST_FORWARD FOR 

SELECT  
	em.[ID], b.[BADGEKEY] 
FROM [AccessControl].[dbo].[EMP] em
	left outer join [AccessControl].[dbo].[BADGE] b on b.[EMPID] = em.[ID]
	left outer join [AccessControl].[dbo].[SOA_ACTIVEMEMBERS] am on convert(int,left(em.[SSNO],9)) = am.[CUSTOMER_ID]
where am.[CUSTOMER_ID] is null

OPEN MemberCursor
FETCH NEXT FROM MemberCursor INTO @ID_2, @BADGEKEY
WHILE @@FETCH_STATUS = 0 BEGIN 
  
	DELETE FROM [AccessControl].[dbo].[BADGE] where EMPID = @ID_2;
	DELETE FROM [AccessControl].[dbo].[BADGELINK] where BADGEKEY = @BADGEKEY;
	DELETE FROM [AccessControl].[dbo].[EMP] where ID = @ID_2;

    FETCH NEXT FROM MemberCursor  INTO @ID_2, @BADGEKEY
END 
CLOSE MemberCursor
DEALLOCATE MemberCursor

Print 'End'