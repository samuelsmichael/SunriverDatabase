-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 06/11/2015
-- Description:	Gets the CardClass values
/*
	exec uspCardClassGet
*/
-- =============================================
alter PROCEDURE uspCardClassGet
AS
BEGIN
	SET NOCOUNT ON;
	select * from [tblCardClass{LU}] order by cdClass
end
GO
