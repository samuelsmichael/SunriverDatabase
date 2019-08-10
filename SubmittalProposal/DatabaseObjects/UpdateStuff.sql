DECLARE	
	@bcstring nvarchar(2000),
	@FileSpec varchar(300)
set @FileSpec='\\fc-sql01.holden.local\c$\temp\NCOADeliveryPoint.txt'

/*
truncate table tmpNCOADeliveryPoint

drop table tmpNCOADeliveryPoint
create table tmpNCOADeliveryPoint (
	CarrerRount varchar(20),
	DeliveryPoint varchar(15),
	TypeOfID int,
	OrderID varchar(20)
)
*/
/*


*/	
/*  -- tab delimiter */
SET @bcString = 'BULK INSERT ' + db_name() + '.dbo.[tmpNCOADeliveryPoint]
           FROM '+CHAR(39)+ @Filespec +CHAR(39)+'
		  		WITH
		    	(
		      	DATAFILETYPE    = '+CHAR(39)+'char'+CHAR(39)+',
		      	ROWTERMINATOR   = '+CHAR(39)+char(13)+char(10)+CHAR(39)+',
			FIELDTERMINATOR = '+CHAR(39)+char(9)+CHAR(39)+',
			FIRSTROW = 1	     
		      )'

/* Comma delimiter 
SET @bcString = 'BULK INSERT ' + db_name() + '.dbo.[tmpCKsaa3]
           FROM '+CHAR(39)+ @Filespec +CHAR(39)+'
		  		WITH
		    	(
		      	DATAFILETYPE    = '+CHAR(39)+'char'+CHAR(39)+',
		      	ROWTERMINATOR   = '+CHAR(39)+char(13)+char(10)+CHAR(39)+',
			FIELDTERMINATOR = '+CHAR(39)+','+CHAR(39)+',
			FIRSTROW = 2	     
		      )'
*/			  
    EXEC master..sp_executesql @bcString
	select * from tmpNCOADeliveryPoint
select dp.*,o.CarrierRoute_DeliveryPoint from tmpNCOADeliveryPoint dp inner join [order] o on cast(dp.OrderID as int) = o.Orderid and TypeOfID=3
where CarrerRount is not null and (right(CarrierRoute_DeliveryPoint,3) != DeliveryPoint or left(CarrierRoute_DeliveryPoint,4) != CarrerRount)

select dp.*,c.CarrierRoute_DeliveryPoint from tmpNCOADeliveryPoint dp inner join customer c on cast(dp.OrderID as int) = c.Customerid and TypeOfID=0
where CarrerRount is not null and (right(CarrierRoute_DeliveryPoint,3) != DeliveryPoint or left(CarrierRoute_DeliveryPoint,4) != CarrerRount)

  
/*

/*
with reships as (
	select distinct o.orderid from [order] o inner join ordercontacthistory och on och.orderid=o.orderid and orderstatusid = 8 and contacttext like '%SENT INVOICE%' 
	and isnull(IsResetForReshipment,0)=1 ) 
*/
select * from [order] o inner join continuities_2018_12_1 c on c.OrderID=o.OrderId
where 
	c.Address2!=o.shiptoAddress1
	or c.Address2!=o.shiptoaddress3
	or 


update continuities_2018_12_1 set OrderID=cast(RIGHT(left(ACCOUNT,16),7) as int)
select * from tmpOFAWolff t where sku='03OF19CEV'
select * from tmpofawolff t inner join [order] o on t.orderid=o.orderid inner join OrderLineItem oli on oli.orderid=o.OrderID inner join lineitem li on li.LineItemID=oli.LineItemID inner join lineitemcomponent lic on lic.LineItemID=oli.LineItemID inner join inventoryitem ii on ii.InventoryItemID=lic.InventoryItemID where oli.IsVoid=0 and t.qty=oli.quantityOrdered and (li.ClientLineItemNbr=t.sku or ii.[name]=t.sku)
--inner join lineitem li on oli.LineItemID=li.lineitemid
-- and t.SKU=li.ClientLineItemNbr
and oli.QuantityOrdered!=qty-- or t.descr != li.DisplayName
select sum(qty) [Count], SKU, descr [Description] from tmpofawolff group by sku,descr order by SKU
*/


/*update o
set shiptoFirstname=t.[First], shiptoMiddleName=t.mi, shiptolastname=t.[last], shiptocompanyname=t.[company],
shiptoaddress1=t.[address], shiptoaddress2=t.address2, shiptocity=t.city, shiptostateorprovince=t.st, shiptopostalcode=t.zip, shiptocountrycode='us'
FROM tmpEBAddressChanges t inner join [order] o ON t.ordnum=o.ClientOrderNbr and programid=30
*/

/*

update CustomerServiceStaffTimeCard set Manager=Replace(Manager,'"','')

select o.* from tmpbbtfns t inner join [Order] o on o.ClientOrderNbr=t.ClientOrderNbr


update o 
set o.AmountTaxOther=o.AmountTax, AmountTaxFederal=0, AmountTaxState=0, AmountTaxCounty=0, AmountTaxCity=0, AmountTaxLocal=0
--select * 
from tmpbbtfns t inner join [Order] o on o.ClientOrderNbr=t.ClientOrderNbr

select * from tmpbbtfns t inner join [Order] o on o.ClientOrderNbr=t.ClientOrderNbr inner join OrderLineItem oli on oli.OrderID=o.Orderid
where ((
	(AmountFreight + AmountTax + oli.UnitPrice) != AmountTotal
	) or 
	(  (o.AmountTaxOther+ AmountTaxFederal+ AmountTaxState+ AmountTaxCounty+ AmountTaxCity+ AmountTaxLocal)  != o.AmountTax  ))




SELECT PD.* from PhoneDetail pd inner join tmpbbtfns f on pd.tfn=f.tfn where isactive=0 AND updateddate < '1/13/2016'

	update pd
	set IsActive=1 from PhoneDetail pd inner join tmpbbtfns f on pd.tfn=f.tfn where isactive=1 and ProgramID=37
*/


/*  BBoy update addresses
update o
set ShipToAddress1=Address1, ShipToCity=City, ShipToStateOrProvince=[State], ShipToPostalCode=ZipPlus4
FROM [Order] o 
Inner join tmpbbtfns t on o.ClientOrderNbr=t.ClientOrderNbr

update c
set BillToAddress1=Address1, BillToCity=City, BillToStateOrProvince=[State], BillToPostalCode=ZipPlus4
FROM Customer c
Inner join tmpbbtfns t on c.ClientCustomerNbr=t.ClientCustomerNbr
Inner join [Order] o on o.ClientOrderNbr=t.ClientOrderNbr
where c.ClientID=13
*/

/*
select t.lastname tlastname, s.lastname slastname,t.FirstName tfirstname,s.firstname sfirstname,
	t.city tcity, s.city scity,
	t.[state] tstate, s.[state] sstate,
	t.zip tzip, s.zip szip,
	t.grade tgrade,s.gradeno sgradeno,
	t.homeroom thomeroom, s.homeroom shomeroom,
	t.studentId tstudentid, s.studentid sstudentid,
	t.phonenumber tphonenumber,s.phone sphone
	from tmpCKsaa3 t inner join Student s 
	on 
		t.ck=s.ck

select t.lastname tlastname, s.lastname slastname,t.FirstName tfirstname,s.firstname sfirstname,
	t.city tcity, s.city scity,
	t.[state] tstate, s.[state] sstate,
	t.zip tzip, s.zip szip,
	t.grade tgrade,s.gradeno sgradeno,
	t.homeroom thomeroom, s.homeroom shomeroom,
	t.studentId tstudentid, s.studentid sstudentid,
	t.phonenumber tphonenumber,s.phone sphone
	from tmpCKsaa3 t inner join Student s 
	on 
		t.ck=s.ck
where
	t.lastname!=isnull(s.lastname,'') or
	t.firstname!=isnull(s.firstname,'') or
	t.city!=isnull(s.city,'') or
	t.[state]!=isnull(s.[state],'') or
	t.zip!=isnull(s.zip,'') or
	t.grade!=isnull(s.gradeno,'') or
	t.homeroom!=isnull(s.homeroom,'') or
	t.studentid!=isnull(s.studentid,'') or
	t.phonenumber!=isnull(s.phone,'') 
*/
/*
update s
	set 
		s.lastname=t.lastname,
		s.firstname=t.firstname,
		s.city=t.city,
		s.[state]=t.[state],
		s.zip=t.zip,
		s.gradeno=t.grade,
		s.homeroom=t.homeroom,
		s.studentid=t.studentid,
		s.phone=t.phonenumber,
		s.parentcity=t.city,
		s.parentstate=t.[state],
		s.parentzip=t.zip,
		s.parentphone=t.phonenumber,
		lastchangeddate=getdate()
from
	tmpCKsaa3 t inner join Student s 
	on 
		t.ck=s.ck
*/
/*

update u
	set
		u.parentcity=t.city,
		u.parentstate=t.[state],
		u.parentzip=t.zip,
		u.parentphone=t.phonenumber

from 
	tmpCKsaa3 t
		INNER JOIN Student s ON t.ck=s.ck
		INNER JOIN UserStudentJoin usj ON s.ck=usj.ck
		INNER JOIN [User] u on usj.UserId=u.userId

*/
/*


select *
from 
	tmpCKsaa3 t
		INNER JOIN Student s ON t.ck=s.ck
		LEFT OUTER JOIN UserStudentJoin usj ON s.ck=usj.ck
		where usj.ck is null


update student set lastchangeddate=getdate() where jobno=17933 and campno=1014

select * from student where jobno=37631 and campno=1014 order by lastname,firstname
select s.InitialResponseCode,s.OrderTotal,ReceivedDate,* 
from tmpCKsaa3 t inner join 
	 student s on t.firstname=s.firstname and t.lastname=s.lastname and t.jobno=s.jobno and s.campno=1014 
where InitialResponseCode='Y' and Ordertotal>0 and StmtCnt=0
--where s.ck is null
order by t.lastname,t.FirstName
*/
/*
select * from tmpCKsaa3Cancel t order by t.lastname,t.FirstName
select t.*,s.StudentStatus,s.OrderTotal,s.OrderAmountPaid from tmpcksaa3Cancel t inner join student s on t.ck=s.ck order by t.lastname,t.firstname

select * from tmpCKsaa3Change order by lastname,firstname
select t.*,s.LastName,s.FirstName,s.GradeNo,s.HomeRoom from tmpcksaa3Change t inner join student s on t.ck=s.ck where t.lastname!=s.LastName or t.firstname != s.firstname or t.grade!=s.gradeno or t.homeroom!=s.HomeRoom order by t.lastname,t.firstname

select * from tmpCksaa3Cancel tc inner join tmpcksaa3change tcg on tc.ck=tcg.ck
*/
/*
select * from tmpcksaa3add ta inner join tmpcksaa3cancel tc on tc.firstname=ta.firstname and tc.lastname=ta.lastname
select * from tmpcksaa3add ta inner join tmpCksaa3Change tc on tc.firstname=ta.firstname and tc.lastname=ta.lastname
select * from tmpcksaa3add t  order by lastname,firstname

select * from school

select /*tc.ck as ck_cancel, tchg.ck as ck_chg,*/s.firstname, s.lastname, s.studentstatus,s.homeroom as s_homeroom,ta.homeroom ta_homeroom,s.gradeno as s_gradeno,ta.grade ta_gradeno,s.studentid as s_studentid,ta.studentid as ta_studentId, s.address1 as s_address1, ta.address1 as t_address1,s.ordertotal,s.OrderAmountPaid,s.ck 
from tmpcksaa3add ta inner join student s on s.firstname=ta.firstname and s.lastname=ta.lastname and s.campno=1014 and jobno=34376 

left outer join tmpCksaa3Cancel tc on tc.ck=s.ck left outer join tmpCksaa3Change tchg on tchg.ck=s.ck
where jobno=34376 and campno=1014 and (ta.Grade!=s.gradeno or ta.HomeRoom!=s.HomeRoom or ta.Address1!=s.Address1) order by ta.lastname,ta.firstname

update tmpcksaa3cancel set didit=0
exec uspstudentinformationview '53437651658' 
select * from student where campno=1014 and jobno=34376  order by right(ck,4)

select * from studentstatuscode

delete from schoolcontact where skey in (
select skey from schoolcontact sc inner join schoolstatuscode ssc on sc.schoolstatus=ssc.schoolstatus where jobno=34376 and campno=1014 and sc.schoolstatus in (21,26)
)

select * from core.dbo.[user] where username like '%tram%'

delete from studentcontact where skey in (
select skey from  studentcontact sc inner join student s on sc.ck=s.ck where s.jobno=34376 and s.campno=1014 and sc.studentstatus in (21,26)
)
*/
/*
declare @ck varchar(11)
while exists (select * from tmpCksaa3Cancel where didit=0) begin
	select top 1 @ck=ck from tmpcksaa3cancel where didit=0
	print 'doing '+@ck
	exec [uspCancelOrderJBL]
		@ck =@ck,
		@ArchiveEmpID=1344,
		@DoJBL = 1,
		@DoLegacy =1
	update tmpcksaa3cancel set didit=1 where ck=@ck	
	
end
*/

/*
update s
	set Email=t.Email,
		ParentEmail=t.Email,
		LastChangedDate=getdate()
from tmpCksaa3 t inner join student s on t.ck=s.ck

update u
	set ParentEmail=s.Email
	
	from tmpCksaa3 t inner join Student s on t.ck=s.ck inner join userstudentjoin usj on s.ck=usj.ck inner join [user] u on u.userid=usj.userid
*/

