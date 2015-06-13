-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 06/11/2015
-- Description:	Gets the Cards associated with a PropertyId
/*
	exec uspCardGet @PropId='01001'
*/
-- =============================================
alter PROCEDURE uspCardGet (
	@PropId nvarchar(10)
)
AS
BEGIN
	SET NOCOUNT ON;
	select id.* from [tblInput-IDCard] id where fkISPropID=@PropId
end
GO
