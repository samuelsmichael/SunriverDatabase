USE [Renewables]
GO

/****** Object:  Table [dbo].[tblRenewables]    Script Date: 7/14/2018 7:52:07 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tblRenewables](
	[ProjectName] [nvarchar](100) NULL,
	[Buisness] [nvarchar](50) NULL,
	[BusinessAddress] [nvarchar](100) NULL,
	[BusinessPhone] [nvarchar](50) NULL,
	[BusinessContactName] [nvarchar](50) NULL,
	[TermofRenewable] [nvarchar](50) NULL,
	[RenewableReviewDate] [datetime] NULL,
	[RenewableStartDate] [datetime] NULL,
	[RenewableEndDate] [datetime] NULL,
	[RenewableTermDate] [nvarchar](50) NULL,
	[AutoRenewal] [nchar](10) NULL,
	[TermCost] [varchar](50) NULL,
	[PaymentType] [nvarchar](50) NULL,
	[SROADepartment] [nvarchar](50) NULL,
	[Notes] [nvarchar](500) NULL,
	[renewID] [int] NULL
) ON [PRIMARY]
GO

