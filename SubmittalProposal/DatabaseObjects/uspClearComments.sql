-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 02/22/2016
-- Description:	Clears all of the comments fields in tblInput-IDCard
-- =============================================
create PROCEDURE uspClearComments
AS
BEGIN
	update [tblInput-IDCard]
	set cdComments=''
end
GO
