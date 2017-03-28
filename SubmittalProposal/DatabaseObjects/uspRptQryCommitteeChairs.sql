SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* =============================================
	exec uspRptQryCommitteeChairs
   ============================================= */
Use ComRoster;
go
create PROCEDURE uspRptQryCommitteeChairs
AS
BEGIN
	select * from qryCommitteeChairs
END
GO
