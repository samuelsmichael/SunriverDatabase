USE [ID-Card_Split_FE]
GO
/*
	exec dbo.uspMasterTableConversion
*/

alter procedure [dbo].uspMasterTableConversion
as begin

	if not exists (SELECT 'a' a 
		FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
		WHERE CONSTRAINT_NAME='PK_Member' 
	) begin
		
		ALTER TABLE [dbo].[Member] ALTER COLUMN [Member Code] nvarchar(255) NOT NULL;
		ALTER TABLE [dbo].[Member] ADD  CONSTRAINT [PK_Member] PRIMARY KEY CLUSTERED 
		(
			[Member Code] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	end

	IF not EXISTS(SELECT 1 FROM sys.columns 
	    WHERE Name = N'State'
        AND Object_ID = Object_ID(N'Member')) begin

			ALTER TABLE Member
				ADD [State]  AS (right([AddressLine3],(2)))
		end
	
	IF not EXISTS(SELECT 1 FROM sys.columns 
	    WHERE Name = N'City'
        AND Object_ID = Object_ID(N'Member')) begin
			ALTER TABLE Member
				ADD City  AS (left([AddressLine3],charindex(',',[AddressLine3])-(1)))
		end

	IF not EXISTS(SELECT 1 FROM sys.columns 
	    WHERE Name = N'Voted'
        AND Object_ID = Object_ID(N'Member')) begin

			ALTER TABLE Member
				ADD [Voted]  nvarchar(50)
		end
	delete from member where [Member Code]	like '%[a-z]%';
	update member
		set [Member Code]=dbo.udfPadString([Member Code],'left','0',6)
end

