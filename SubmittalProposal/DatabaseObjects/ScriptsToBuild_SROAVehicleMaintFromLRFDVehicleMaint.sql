USE [master]
GO
/****** Object:  Database [SROAVehicleMaintenance]    Script Date: 11/27/2016 3:09:45 PM ******/
/*CREATE DATABASE [SROAVehicleMaintenance] ON  PRIMARY 
( NAME = N'SROAVehicleMaintenance', FILENAME = N'c:\Program Files (x86)\Microsoft SQL Server\MSSQL.1\MSSQL\DATA\SROAVehicleMaintenance.mdf' , SIZE = 7168KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'SROAVehicleMaintenance_log', FILENAME = N'c:\Program Files (x86)\Microsoft SQL Server\MSSQL.1\MSSQL\DATA\SROAVehicleMaintenance_log.ldf' , SIZE = 1792KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
*/
--------- Not working: "Incorrect syntax near '90'" ALTER DATABASE [SROAVehicleMaintenance] SET COMPATIBILITY_LEVEL = 90
--GO
/*
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SROAVehicleMaintenance].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
*/
/*
ALTER DATABASE [SROAVehicleMaintenance] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SROAVehicleMaintenance] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SROAVehicleMaintenance] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SROAVehicleMaintenance] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SROAVehicleMaintenance] SET ARITHABORT OFF 
GO
ALTER DATABASE [SROAVehicleMaintenance] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [SROAVehicleMaintenance] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SROAVehicleMaintenance] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SROAVehicleMaintenance] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SROAVehicleMaintenance] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SROAVehicleMaintenance] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SROAVehicleMaintenance] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SROAVehicleMaintenance] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SROAVehicleMaintenance] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SROAVehicleMaintenance] SET  DISABLE_BROKER 
GO
ALTER DATABASE [SROAVehicleMaintenance] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SROAVehicleMaintenance] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SROAVehicleMaintenance] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SROAVehicleMaintenance] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SROAVehicleMaintenance] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SROAVehicleMaintenance] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SROAVehicleMaintenance] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [SROAVehicleMaintenance] SET  MULTI_USER 
GO
ALTER DATABASE [SROAVehicleMaintenance] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SROAVehicleMaintenance] SET DB_CHAINING OFF 
GO
*/
USE [SROAVehicleMaintenance]
GO
/****** Object:  Table [dbo].[tblDepartment{LU}]    Script Date: 11/27/2016 3:09:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblDepartment{LU}](
	[VWOSelector] [nvarchar](30) NOT NULL,
	[Department] [nvarchar](30) NOT NULL,
	[DepartmentID] [smallint] NOT NULL,
	[Address] [nvarchar](50) NULL,
	[City] [nvarchar](50) NULL,
	[State] [nvarchar](50) NULL,
	[Zip] [nvarchar](50) NULL,
	[PartMarkUpRate] [real] NULL,
	[AdministrationRate] [real] NULL,
 CONSTRAINT [PK_tblDepartment{LU}] PRIMARY KEY CLUSTERED 
(
	[DepartmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblMechanicInfo{LU}]    Script Date: 11/27/2016 3:09:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblMechanicInfo{LU}](
	[MechRate] [money] NULL,
	[MechName] [nvarchar](25) NULL,
	[MechID] [int] NOT NULL,
 CONSTRAINT [PK_tblMechanicInfo{LU}] PRIMARY KEY CLUSTERED 
(
	[MechID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblVehicleList{LU}]    Script Date: 11/27/2016 3:09:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblVehicleList{LU}](
	[Number] [nvarchar](12) NOT NULL,
	[fkDeptID] [smallint] NULL,
	[Department] [nvarchar](20) NULL,
	[Description] [nvarchar](40) NULL,
	[UnitID] [nvarchar](10) NULL,
	[Engine] [nvarchar](20) NULL,
	[Decommissioned] [bit] NOT NULL,
 CONSTRAINT [PK_tblVehicleList{LU}] PRIMARY KEY CLUSTERED 
(
	[Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblVWOData]    Script Date: 11/27/2016 3:09:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblVWOData](
	[VWOID] [nvarchar](10) NOT NULL,
	[fkNumber] [nvarchar](12) NULL,
	[Estimate] [bit] NOT NULL,
	[Request By] [nvarchar](20) NULL,
	[Request Nature] [nvarchar](max) NULL,
	[Date In] [datetime] NOT NULL,
	[Date Out] [datetime] NULL,
	[Data Entry Date] [datetime] NULL,
	[Data Entry By] [nvarchar](20) NULL,
	[Odometer] [real] NULL,
	[Hour Meter] [real] NULL,
	[Proceedure 1] [nvarchar](max) NULL,
	[Comments] [nvarchar](max) NULL,
	[AdminRate] [real] NULL,
 CONSTRAINT [PK_tblVWOData] PRIMARY KEY CLUSTERED 
(
	[VWOID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblVWOLabor]    Script Date: 11/27/2016 3:09:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblVWOLabor](
	[VWOLaborID] [int] IDENTITY(1,1) NOT NULL,
	[fkVWOL_ID] [nvarchar](10) NOT NULL,
	[MechName] [nvarchar](25) NULL,
	[MechHours] [real] NULL,
	[MechRate] [money] NULL,
 CONSTRAINT [PK_tblVWOLabor] PRIMARY KEY CLUSTERED 
(
	[VWOLaborID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblVWOParts]    Script Date: 11/27/2016 3:09:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblVWOParts](
	[VWOPartID] [int] IDENTITY(1,1) NOT NULL,
	[fkVWOP_ID] [nvarchar](10) NOT NULL,
	[PtDescription] [nvarchar](30) NULL,
	[PtNumber] [nvarchar](15) NULL,
	[PtRate] [money] NOT NULL,
	[PtQuan] [real] NOT NULL,
	[PtMkUpRate] [real] NULL,
 CONSTRAINT [PK_tblVWOParts] PRIMARY KEY CLUSTERED 
(
	[VWOPartID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblVWOServices]    Script Date: 11/27/2016 3:09:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblVWOServices](
	[VWOCtrServID] [int] IDENTITY(1,1) NOT NULL,
	[fkVWOS_ID] [nvarchar](10) NOT NULL,
	[CSDescription] [nvarchar](50) NULL,
	[CSVendor] [nvarchar](20) NULL,
	[CSCost] [money] NULL,
 CONSTRAINT [PK_tblVWOServices] PRIMARY KEY CLUSTERED 
(
	[VWOCtrServID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  View [dbo].[qry_VWO_Labor]    Script Date: 11/27/2016 3:09:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[qry_VWO_Labor]
AS
SELECT        VWOLaborID, fkVWOL_ID, MechName, MechHours, MechRate, ROUND(MechHours * MechRate, 2) AS TotalLabor
FROM            dbo.tblVWOLabor AS l

GO
/****** Object:  View [dbo].[qry_VWO_Parts]    Script Date: 11/27/2016 3:09:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[qry_VWO_Parts]
AS
SELECT        v.fkDeptID, p.fkVWOP_ID, p.PtDescription, p.PtNumber, p.PtQuan, p.PtRate, p.PtMkUpRate, ROUND((p.PtQuan * p.PtRate) * (1 + p.PtMkUpRate), 2) AS TotalParts
FROM            dbo.[tblDepartment{LU}] AS d INNER JOIN
                         dbo.[tblVehicleList{LU}] AS v ON d.DepartmentID = v.fkDeptID INNER JOIN
                         dbo.tblVWOParts AS p RIGHT OUTER JOIN
                         dbo.tblVWOData ON p.fkVWOP_ID = dbo.tblVWOData.VWOID ON v.Number = dbo.tblVWOData.fkNumber

GO
/****** Object:  View [dbo].[qry_VWO_Services]    Script Date: 11/27/2016 3:09:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[qry_VWO_Services]
AS
SELECT        fkVWOS_ID, CSDescription, CSVendor, CSCost, CSCost AS TotalService
FROM            dbo.tblVWOServices AS s

GO
/****** Object:  View [dbo].[qry_VehicleMaintenanceHistory]    Script Date: 11/27/2016 3:09:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[qry_VehicleMaintenanceHistory]
AS
SELECT        VWOID, fkNumber, Estimate, [Request By], [Request Nature], [Date In], [Date Out], [Data Entry Date], [Data Entry By], Odometer, [Hour Meter], [Proceedure 1], 
                         Comments, AdminRate, Description, Department, Address, City, State, Zip, fkDeptID, DepartmentID, TotLabor, TotParts, TotServices, totLaborHrs, 
                         TotLabor + TotParts + TotServices AS TotalInvoice
FROM            (SELECT        wo.VWOID, wo.fkNumber, wo.Estimate, wo.[Request By], wo.[Request Nature], wo.[Date In], wo.[Date Out], wo.[Data Entry Date], wo.[Data Entry By], 
                                                    wo.Odometer, wo.[Hour Meter], wo.[Proceedure 1], wo.Comments, wo.AdminRate, v.Description, d.Department, d.Address, d.City, d.State, d.Zip, 
                                                    v.fkDeptID, d.DepartmentID,
                                                        (SELECT        ISNULL(SUM(ISNULL(TotalLabor, 0)), 0) AS Expr1
                                                          FROM            dbo.qry_VWO_Labor
                                                          WHERE        (fkVWOL_ID = wo.VWOID)) AS TotLabor,
                                                        (SELECT        ISNULL(SUM(ISNULL(TotalParts, 0)), 0) AS Expr1
                                                          FROM            dbo.qry_VWO_Parts
                                                          WHERE        (fkVWOP_ID = wo.VWOID)) AS TotParts,
                                                        (SELECT        ISNULL(SUM(ISNULL(TotalService, 0)), 0) AS Expr1
                                                          FROM            dbo.qry_VWO_Services
                                                          WHERE        (fkVWOS_ID = wo.VWOID)) AS TotServices,
                                                        (SELECT        ROUND(ISNULL(SUM(ISNULL(MechHours, 0)), 0), 2) AS Expr1
                                                          FROM            dbo.qry_VWO_Labor AS qry_VWO_Labor_1
                                                          WHERE        (fkVWOL_ID = wo.VWOID)) AS totLaborHrs
                          FROM            dbo.[tblDepartment{LU}] AS d INNER JOIN
                                                    dbo.[tblVehicleList{LU}] AS v ON d.DepartmentID = v.fkDeptID INNER JOIN
                                                    dbo.tblVWOData AS wo ON v.Number = wo.fkNumber) AS q1

GO
/****** Object:  StoredProcedure [dbo].[uspLRFDFindHighestWordOrderNumber]    Script Date: 11/27/2016 3:09:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 11/11/2015
-- Description:	Finds the highest-most key in tblVWOData, and returns its integer component
/*
	declare @HighestInt int
	exec uspLRFDFindHighestWordOrderNumber @HighestInt out
	print cast(@HighestInt as varchar)
*/
-- =============================================
CREATE PROCEDURE [dbo].[uspLRFDFindHighestWordOrderNumber] 
	@HighestWorkOrderIntergerComponent int out
AS
BEGIN
	declare @HighestVWOID nvarchar(10),
			@LocationOfDash int
	select top 1 @HighestVWOID=VWOID from tblVWOData order by VWOID desc
	set @LocationOfDash=CHARINDEX('-',@hIGHESTvwoid)
	SELECT @HighestWorkOrderIntergerComponent=CAST(SUBSTRING(@HighestVWOID,@LocationOfDash+1,9999) as int)
END

GO
/****** Object:  StoredProcedure [dbo].[uspLRFDLaborDelete]    Script Date: 11/27/2016 3:09:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 11/11/2015
-- Description:	Deletes Labor
/*
	exec uspLRFDLaborDelete
*/
-- =============================================
create PROCEDURE [dbo].[uspLRFDLaborDelete] 
	@VWOLaborID int
AS
BEGIN
	delete from tblVWOLabor where VWOLaborID=@VWOLaborID
END

GO
/****** Object:  StoredProcedure [dbo].[uspLRFDLaborUpdate]    Script Date: 11/27/2016 3:09:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 11/11/2015
-- Description:	Updates Labor
/*
	exec uspLRFDLaborUpdate
*/
-- =============================================
CREATE PROCEDURE [dbo].[uspLRFDLaborUpdate] 
	@VWOLaborID int = null,
	@fkVWOL_ID nvarchar(10),
	@MechName nvarchar(25)=null,
	@MechHours real=null,
	@MechRate money=null,
	@VWOLaborIDOut int out
AS
BEGIN
	if(@VWOLaborID is not null) begin
		set @VWOLaborIDOut=@VWOLaborID
		update tblVWOLabor
		set
			MechName=@MechName,
			MechHours=@MechHours,
			MechRate=@MechRate
		where VWOLaborID=@VWOLaborID 
	end else begin
		INSERT INTO [dbo].tblVWOLabor
           (fkVWOL_ID
           ,MechName
           ,MechHours
		   ,MechRate)
		VALUES
           (@fkVWOL_ID
           ,@MechName
           ,@MechHours
		   ,@MechRate)
		set @VWOLaborIDOut=scope_identity()
	end
END

GO
/****** Object:  StoredProcedure [dbo].[uspLRFDPartsDelete]    Script Date: 11/27/2016 3:09:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 11/11/2015
-- Description:	Deletes Parts
/*
	exec uspLRFDPartsDelete
*/
-- =============================================
create PROCEDURE [dbo].[uspLRFDPartsDelete] 
	@VWOPartID int
AS
BEGIN
	delete from tblVWOParts where VWOPartID=@VWOPartID
END

GO
/****** Object:  StoredProcedure [dbo].[uspLRFDPartsUpdate]    Script Date: 11/27/2016 3:09:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 11/11/2015
-- Description:	Updates Parts
/*
	exec uspLRFDPartsUpdate
*/
-- =============================================
CREATE PROCEDURE [dbo].[uspLRFDPartsUpdate] 
	@VWOPartID int = null,
	@fkVWOP_ID nvarchar(10),
	@ptDescription nvarchar(30)=null,
	@ptNumber nvarchar(15)=null,
	@ptRate money=null,
	@ptQuan real=null,
	@NewVWOPartID int out
AS
BEGIN
	DECLARE @PartMarkUpRate real
	SET NOCOUNT ON;
	SELECT @PartMarkUpRate=PartMarkUpRate from [tblDepartment{LU}] where DepartmentID = (SELECT fkDeptID from [tblVehicleList{LU}] where Number = (SELECT fkNumber FROM tblVWOData WHERE VWOID=@fkVWOP_ID))
	if(@VWOPartID is not null) begin
		set @NewVWOPartID=@VWOPartID
		update tblVWOParts
		set
			PtDescription=@ptDescription,
			PtNumber=@ptNumber,
			PtRate=@ptRate,
			PtQuan=@ptQuan,
			PtMkUpRate = @PartMarkUpRate
		where VWOPartID=@VWOPartID 
	end else begin
		INSERT INTO [dbo].tblVWOParts
           ([fkVWOP_Id]
           ,[PtDescription]
           ,[PtNumber]
		   ,[PtRate]
		   ,[PtQuan]
		   ,PtMkUpRate)
		VALUES
           (@fkVWOP_ID
           ,@ptDescription
           ,@ptNumber
		   ,@ptRate
		   ,@PtQuan
		   ,@PartMarkUpRate)
		set @NewVWOPartID=scope_identity()
	end
END

GO
/****** Object:  StoredProcedure [dbo].[uspLRFDServiceDelete]    Script Date: 11/27/2016 3:09:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 11/11/2015
-- Description:	Deletes Service
/*
	exec uspLRFDServiceDelete
*/
-- =============================================
CREATE PROCEDURE [dbo].[uspLRFDServiceDelete] 
	@VWOServiceID int
AS
BEGIN
	delete from tblVWOServices where VWOCtrServID=@VWOServiceID
END

GO
/****** Object:  StoredProcedure [dbo].[uspLRFDServiceUpdate]    Script Date: 11/27/2016 3:09:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 11/11/2015
-- Description:	Updates LRFD Service
/*
	exec uspLRFDServiceUpdate
*/
-- =============================================
create PROCEDURE [dbo].[uspLRFDServiceUpdate] 
	@VWOCtrServID int = null,
	@fkVWOS_ID nvarchar(10),
	@CSDescription nvarchar(50)=null,
	@CSVendor nvarchar(20)=null,
	@CSCost money=null,
	@VWOCtrServIDOut int out
AS
BEGIN
	if(@VWOCtrServID is not null) begin
		set @VWOCtrServIDOut=@VWOCtrServID
		update tblVWOServices
		set
			CSDescription=@CSDescription,
			CSVendor=@CSVendor,
			CSCost=@CSCost
		where VWOCtrServID=@VWOCtrServID 
	end else begin
		INSERT INTO [dbo].tblVWOServices
           (fkVWOS_ID
           ,CSDescription
           ,CSVendor
		   ,CSCost)
		VALUES
           (@fkVWOS_ID
           ,@CSDescription
           ,@CSVendor
		   ,@CSCost)
		set @VWOCtrServIDOut=scope_identity()
	end
END

GO
/****** Object:  StoredProcedure [dbo].[uspLRFDVehicleMaintenanceTablesGet]    Script Date: 11/27/2016 3:09:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 3/11/2015
-- Description:	Gets the tables of LRFDVehicleMaintenance
-- =============================================
CREATE PROCEDURE [dbo].[uspLRFDVehicleMaintenanceTablesGet] 
AS
BEGIN
	SET NOCOUNT ON;
	Select * from tblVWOData;
	select * from tblVWOLabor;
	select * from tblVWOParts;
	select * from tblVWOServices
	select * from [tblDepartment{LU}]
	select * from [tblMechanicInfo{LU}]
	select * from [tblVehicleList{LU}]
END

GO
/****** Object:  StoredProcedure [dbo].[uspLRFDVehicleMaintenanceUpdate]    Script Date: 11/27/2016 3:09:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 11/11/2015
-- Description:	Updates Parts
/*
	exec uspLRFDVehicleMaintenanceUpdate
*/
-- =============================================
create PROCEDURE [dbo].[uspLRFDVehicleMaintenanceUpdate] 
    @VWOID nvarchar(10) = null,
    @fkNumber nvarchar(12),
    @Estimate bit =null,
    @RequestBy nvarchar(20) =null,
    @RequestNature  nvarchar(max) =null,
    @DateIn datetime = null,
    @DateOut datetime = null,
    @DataEntryDate datetime = null,
    @DataEntryBy nvarchar(20) = null,
    @Odometer  real = null,
    @HourMeter real = null,
    @Proceedure1 nvarchar(max) = null,
    @Comments nvarchar(max) = null,
    @AdminRate real = null,
	@VWOID_new nvarchar(10) = null
AS
BEGIN
	SET NOCOUNT ON;
	if(@VWOID is not null) begin
		update tblVWOData
	    SET [VWOID] = @VWOID
		  ,[fkNumber] = @fkNumber
		  ,[Estimate] = @Estimate
		  ,[Request By] = @RequestBy
		  ,[Request Nature] = @RequestNature
		  ,[Date In] = @DateIn
		  ,[Date Out] = @DateOut
		  ,[Data Entry Date] = @DataEntryDate
		  ,[Data Entry By] = @DataEntryBy
		  ,[Odometer] = @Odometer
		  ,[Hour Meter] = @HourMeter
		  ,[Proceedure 1] = @Proceedure1
		  ,[Comments] = @Comments
		  ,[AdminRate] = @AdminRate
		where VWOID=@VWOID 
	end else begin
		INSERT INTO [dbo].[tblVWOData]
				   ([VWOID]
				   ,[fkNumber]
				   ,[Estimate]
				   ,[Request By]
				   ,[Request Nature]
				   ,[Date In]
				   ,[Date Out]
				   ,[Data Entry Date]
				   ,[Data Entry By]
				   ,[Odometer]
				   ,[Hour Meter]
				   ,[Proceedure 1]
				   ,[Comments]
				   ,[AdminRate])
			 VALUES
				   (@VWOID_new
				   ,@fkNumber
				   ,@Estimate
				   ,@RequestBy
				   ,@RequestNature
				   ,@DateIn
				   ,@DateOut
				   ,@DataEntryDate
				   ,@DataEntryBy
				   ,@Odometer
				   ,@HourMeter
				   ,@Proceedure1
				   ,@Comments
				   ,@AdminRate)
		end
END

GO
/****** Object:  StoredProcedure [dbo].[uspRptLapineRFDVehicles]    Script Date: 11/27/2016 3:09:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 11/20/2015
-- Description:	Get Data for Report: Lapine RFD Vehicles 
/*
	EXEC uspRptLapineRFDVehicles 
*/
-- =============================================
create PROCEDURE [dbo].[uspRptLapineRFDVehicles]

AS
BEGIN
SELECT v.Number, v.fkDeptID, v.Department, v.[Description], v.UnitID, v.Engine, v.Decommissioned
FROM [tblVehicleList{LU}] v

END

GO
/****** Object:  StoredProcedure [dbo].[uspRptLRFDInvoices]    Script Date: 11/27/2016 3:09:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 11/20/2015
-- Description:	Get Data for Report: Lapine RFD Invoices 
/*
	EXEC uspRptLRFDInvoices @StartDate='1/1/2014', @EndDate='12/31/2015'
*/
-- =============================================
create PROCEDURE [dbo].[uspRptLRFDInvoices]
	@StartDate datetime,
	@EndDate datetime

AS
BEGIN
set @Enddate=dateadd(ss,55,@EndDate)
SELECT v.*
FROM qry_VehicleMaintenanceHistory v
WHERE v.[Date Out] Between @StartDate And @Enddate
ORDER BY v.fkNumber;

END

GO
/****** Object:  StoredProcedure [dbo].[uspRptMechanicActivity]    Script Date: 11/27/2016 3:09:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 11/20/2015
-- Description:	Get Data for Report: Mechanic Activity 
/*
	EXEC uspRptMechanicActivity @FromDate='1/1/2014', @ToDate='12/31/2015'
*/
-- =============================================
CREATE PROCEDURE [dbo].[uspRptMechanicActivity] 
	@FromDate datetime,
	@ToDate datetime
AS
BEGIN
set @ToDate=DateAdd(ss,60,@ToDate)
SELECT v.*,l.*,vl.[Description] as VehicleName
FROM qry_VehicleMaintenanceHistory v inner join tblVWOLabor l on l.fkVWOL_ID=VWOID
	inner join [tblVehicleList{LU}] vl on vl.Number = v.fkNumber
WHERE v.[Date Out] Between @FromDate And @ToDate
ORDER BY l.MechName,v.fkNumber;
END

GO
/****** Object:  StoredProcedure [dbo].[uspRptVehicleMaintenanceHistory]    Script Date: 11/27/2016 3:09:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 11/20/2015
-- Description:	Get Data for Report: Vehicle Maintenance History 
/*
	EXEC uspRptVehicleMaintenanceHistory @Number='1002', @FromDate='1/1/2014', @ToDate='12/31/2015'
*/
-- =============================================
CREATE PROCEDURE [dbo].[uspRptVehicleMaintenanceHistory] 
	@Number nvarchar(12),
	@FromDate datetime,
	@ToDate datetime,
	@VehicleName nvarchar(40)=null
AS
BEGIN
	SET NOCOUNT ON;
	set @ToDate=dateadd(ss,60,@Todate)
	print cast(@todate as varchar)
	SELECT q.*
	FROM qry_VehicleMaintenanceHistory q
	WHERE q.fkNumber=@Number AND q.[Date Out] Between @FromDate And @ToDate
	ORDER BY q.fkNumber;
END

GO
/****** Object:  StoredProcedure [dbo].[uspRptVehicleShopActivity]    Script Date: 11/27/2016 3:09:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 11/20/2015
-- Description:	Get Data for Report: Vehicle Shop Activity 
/*
	EXEC uspRptVehicleShopActivity @FromDate='1/1/2014', @ToDate='12/31/2015'
*/
-- =============================================
create PROCEDURE [dbo].[uspRptVehicleShopActivity] 
	@FromDate datetime,
	@ToDate datetime
AS
BEGIN
set @ToDate=DateAdd(ss,60,@ToDate)
SELECT v.*
FROM qry_VehicleMaintenanceHistory v
WHERE v.[Date Out] Between @FromDate And @ToDate
ORDER BY v.fkNumber;
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "q1"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'qry_VehicleMaintenanceHistory'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'qry_VehicleMaintenanceHistory'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "l"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'qry_VWO_Labor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'qry_VWO_Labor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "p"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "d"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 135
               Right = 437
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "v"
            Begin Extent = 
               Top = 6
               Left = 475
               Bottom = 135
               Right = 656
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tblVWOData"
            Begin Extent = 
               Top = 6
               Left = 694
               Bottom = 135
               Right = 864
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'qry_VWO_Parts'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'qry_VWO_Parts'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "s"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'qry_VWO_Services'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'qry_VWO_Services'
GO
USE [master]
GO
ALTER DATABASE [LRFDVehicleMaintenance] SET  READ_WRITE 
GO
