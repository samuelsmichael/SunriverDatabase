-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 06/11/2015
-- Description:	Gets the CardStatus values
/*
	exec uspCardStatusGet
*/
-- =============================================
alter PROCEDURE uspCardStatusGet
AS
BEGIN
	SET NOCOUNT ON;
	select * from [tblCardStatus{LU}] order by cdStatus
end
GO
