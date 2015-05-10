SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 5/10/2015
-- Description:	Updates Contractor
/*
	declare @SRContrRegIDOut int
	exec uspContractorUpdate
		@Company='Diamond Software',
		@Contact='Mike Samuels',
		@MailAddr1='',
		@MailAddr2='',
		@City='',
		@State='',
		@ZIP='',
		@Phone_1='',
		@Phone_2='',
		@Fax='',
		@Email='',
		@Active='',
		@Lic_Number='',
		@CAT_1='',
		@CAT_2 ='',
		@CAT_3='',
		@CAT_4='',
		@Comment='',
		@SRContrRegIDOut = @SRContrRegIDOut out
*/
-- =============================================
alter PROCEDURE uspContractorUpdate 
	@SRContrRegID int=null,
	@Reg_Date datetime=null,
    @Company nvarchar(70),
    @Contact nvarchar(50),
    @MailAddr1 nvarchar(40),
    @MailAddr2 nvarchar(40),
    @City nvarchar(20),
    @State nvarchar(2),
    @ZIP nvarchar(10),
    @Phone_1 nvarchar(14),
    @Phone_2 nvarchar(14),
    @Fax nvarchar(14),
    @Email nvarchar(40),
    @Active nvarchar(14),
    @Lic_Number nvarchar(8),
    @Lic_X_Date datetime=null,
    @CAT_1 nvarchar(35),
    @CAT_2 nvarchar(35),
    @CAT_3 nvarchar(35),
    @CAT_4 nvarchar(30),
    @Comment ntext,
	@SRContrRegIDOut int out
AS
BEGIN
	SET NOCOUNT ON;
	if(@SRContrRegID is not null) begin
		set @SRContrRegIDOut=@SRContrRegID
		UPDATE [dbo].[tblContractors]
		   SET [Reg_Date] = @Reg_Date
			  ,[Company] = @Company
			  ,[Contact] = @Contact
			  ,[MailAddr1] = @MailAddr1
			  ,[MailAddr2] = @MailAddr2
			  ,[City] = @City
			  ,[State] = @State
			  ,[ZIP] = @ZIP
			  ,[Phone_1] = @Phone_1
			  ,[Phone_2] = @Phone_2
			  ,[Fax] = @Fax
			  ,[Email] = @Email
			  ,[Active] = @Active
			  ,[Lic_Number] = @Lic_Number
			  ,[Lic_X_Date] = @Lic_X_Date
			  ,[CAT_1] = @CAT_1
			  ,[CAT_2] = @CAT_2
			  ,[CAT_3] = @CAT_3
			  ,[CAT_4] = @CAT_4
			  ,[Comment] = @Comment
		WHERE SRContrRegID=@SRContrRegID
 	end else begin
		INSERT INTO [dbo].[tblContractors]
				   ([Reg_Date]
				   ,[Company]
				   ,[Contact]
				   ,[MailAddr1]
				   ,[MailAddr2]
				   ,[City]
				   ,[State]
				   ,[ZIP]
				   ,[Phone_1]
				   ,[Phone_2]
				   ,[Fax]
				   ,[Email]
				   ,[Active]
				   ,[Lic_Number]
				   ,[Lic_X_Date]
				   ,[CAT_1]
				   ,[CAT_2]
				   ,[CAT_3]
				   ,[CAT_4]
				   ,[Comment])
			 VALUES
				   (@Reg_Date
				   ,@Company
				   ,@Contact
				   ,@MailAddr1
				   ,@MailAddr2
				   ,@City
				   ,@State
				   ,@ZIP
				   ,@Phone_1
				   ,@Phone_2
				   ,@Fax
				   ,@Email
				   ,@Active
				   ,@Lic_Number
				   ,@Lic_X_Date
				   ,@CAT_1
				   ,@CAT_2
				   ,@CAT_3
				   ,@CAT_4
				   ,@Comment
				)
		set @SRContrRegIDOut=scope_identity()
	end
END
GO
