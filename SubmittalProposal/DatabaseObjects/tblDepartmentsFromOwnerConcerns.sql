USE [OwnerConcerns]
GO

/****** Object:  Table [dbo].[tblDepartment{LU}]    Script Date: 7/14/2018 7:23:00 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tblDepartment{LU}](
	[DeptSelector] [nvarchar](30) NULL,
	[Department] [nvarchar](30) NOT NULL,
	[isInOwnerConcernList] [bit] NULL,
	[EmailContactName1] [nvarchar](30) NULL,
	[EmailContactAddr1] [nvarchar](30) NULL,
	[EmailContactName2] [nvarchar](30) NULL,
	[EmailContactAddr2] [nvarchar](30) NULL
) ON [PRIMARY]
GO

