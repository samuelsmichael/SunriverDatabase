USE [ID-Card_Split_FE]
go
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
	SELECT dbo.udfPadString(null,'left','0',6)
	SELECT dbo.udfPadString('','left','0',6)
	SELECT dbo.udfPadString('1','left','0',6)
	SELECT dbo.udfPadString('12','left','0',6)
	SELECT dbo.udfPadString('123','left','0',6)
	SELECT dbo.udfPadString('1234','left','0',6)
	SELECT dbo.udfPadString('12345','left','0',6)
	SELECT dbo.udfPadString('123456','left','0',6)
	SELECT dbo.udfPadString('1234567','left','0',6)
*/
ALTER FUNCTION dbo.udfPadString
(
	@Input nvarchar(max),
	@Side nvarchar(5),
	@FillChar nvarchar(1),
	@Length int
)
RETURNS nvarchar(max)
AS
BEGIN
	Declare @Output nvarchar(max),
			@len int
	if @Input is null begin
		set @Input=''
	end
	set @len=@Length-len(@Input) 
	set @Output=@Input
	if @len > 0 begin
		while @len > 0 begin
			if @Side='left' begin
				set @Output=@FillChar+@Output
			end else begin
				set @Output=@Output+@FillChar
			end
			set @len=@len-1
		end
	end
	RETURN @Output

END
GO

