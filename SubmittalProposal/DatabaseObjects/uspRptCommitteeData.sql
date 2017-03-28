SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* =============================================
	exec uspRptCommitteeData
   ============================================= */
Use ComRoster;
go
create PROCEDURE uspRptCommitteeData
AS
BEGIN
	select * from tblCommitteeData
END
GO
