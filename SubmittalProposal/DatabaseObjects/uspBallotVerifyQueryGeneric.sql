SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 7/07/2015
-- Description:	Gets the tables of Ballot Verify
/*
  gd
 */
/*
	select * from t where tblArshipTo_Addr1!=tblArCust_Addr1
*/
-- =============================================
ALTER PROCEDURE	 uspBallotVerifyQueryGeneric
	@Type varchar(12),
	@Voted varchar(10) -- Yes, No, Either
as
BEGIN
Declare @SQL varchar(1024),
		@and VARCHAR(5)
SET @AND = ''
set @SQL='
	SELECT t.CustId, t.PropID, t.tblArShipTo_Addr1, t.Voted, t.PostalCode, t.GroupCode, OwnerName, Contact, tblArCust_addr1, Addr2
FROM tblBallotVerify t
WHERE '
if @Type='SRResort' begin
	SET @SQL = @SQL + @and +  ' ((t.PropID Between ''61401'' And ''61433'') or (t.PropId=''60031'')) '
	set @and=' AND '
END
if @Type='Pines' begin
	SET @SQL = @SQL + @and +  ' ((t.PropID Between ''66001'' And ''66065'') or (t.PropID Between ''43020'' And ''43022'')) '
	set @and=' AND '
END
if @Type='Ridge' begin
	SET @SQL = @SQL + @and +  ' (t.PropID Between ''53001'' And ''53046'') '
	set @and=' AND '
END

if @Type='CA' begin
	SET @SQL = @SQL + @and +  ' (left(t.PostalCode,5) Between ''90001'' And ''96699'') '
	set @and=' AND '
end
if @Type='OR' begin
	SET @SQL = @SQL + @and +  ' (left(t.PostalCode,5) Between ''97001'' And ''97999'') '
	set @and=' AND '
end
if @Type='WA' begin
	SET @SQL = @SQL + @and +  ' (left(t.PostalCode,5) Between ''98001'' And ''99499'') '
	set @and=' AND '
end
if @Type='USA' begin
	SET @SQL = @SQL + @and +  ' ((left(t.PostalCode,5) Between ''00000'' And ''89999'') OR (left(t.PostalCode,5) Between ''96701'' And ''96999'')  OR (left(t.PostalCode,5) Between ''99501'' And ''99999'')) '
	set @and=' AND '
end
if @Type='SUNRIVER' BEGIN
	SET @SQL = @SQL + @and +  ' (left(t.PostalCode,5) LIKE ''97707%'') '
	set @and=' AND '
END
if @Type='NOZIP' BEGIN
	SET @SQL = @SQL + @and +  ' (ltrim(rtrim(isnull(t.PostalCode,'''')))='''') '
	set @and=' AND '
END
IF @Voted = 'yes' begin
	set @sql=@sql + @AND + ' t.Voted is not null AND t.Voted=''X'''
	SET @AND = ' AND '
end
if @Voted = 'no' begin
	set @sql=@sql + @AND + '(t.Voted is null or t.Voted!=''X'')'
	SET @AND = ' AND '
end

set @SQL = @SQL + ' ORDER BY t.PropID'
PRINT @SQL
EXEC (@SQL)

END
GO
