------daily use command aapcashpor--[43.242.214.235].appcashpor.dbo.cds2--[43.242.214.56].cashporone.dbo.ClientLoanSubscriptionclosed

[137.59.201.177]

SELECT * FROM sys.dm_server_services;

Declare @Clientid varchar(16)='21:18:97:01:16'
SELECT Clients.ClientID, Clients.TargetID, Targets.TargetName,Targets.HusbandName, Clients.JoinDate,clients.DropOutStatus, Clients.Loancycle, Targets.status,Targets.urnid,
Clients.SusPendDate,Clients.DropOutDate, Clients.HotListRemark AS HotListRemark_NOTNULL,Clients.HotListDate,Clients.CommentedBy,Clients.RiskFund as RiskFund_3,Clients.Insurance as Insurance_16, CASE WHEN Clients.EligibleForFL = 1 THEN 'YES' ELSE 'N0' END as EligibleForFL,Eligible_Flexi_Amount,clients.Amid,clients.amgrtdate,Clients.ProposalStatus,Clients.EligibleLoanAmount,Clients.BCStatus,Clients.RecieptNo,clients.URNID,clients.DropOutDate,Targets.TargetAge
FROM Clients with(nolock) INNER JOIN Targets ON Clients.TargetID = Targets.TargetID WHERE (Clients.ClientID=@Clientid) order by Targets.TargetName
Select 'Clientadhar' as Clientadhar,targetid ,Clientid,Loanproposalid,Clien.tname,Co,Adharid,Dateofbirth,Verified,Description,CBR_Status,CBR_Remark,CBR_Enq_Date, Datestamp,Tracking_id,Trtype,TargetAge,Requestedamount,OtherOutstanding,FundingBy,Staffid,(Select StaffName From FieldStaff Where StaffID=c.Staffid)'StaffName' From Clientadhar as c with(nolock) Where Clientid=@Clientid
Select 'Husbandadhar' as Husbandadhar ,*,(Select StaffName From FieldStaff Where StaffID=b.Staffid)'StaffName' from Husbandadhar as b with(nolock) Where Clientid=@Clientid

--Recall NEFT DELETE
update ClientLoanProposal set Bankname=0,BankBranchname=0,AccountNumber=0,IFSCCode=0,BmAccountNumber=0,BmIfsccode=0,BmNeftReviewDate=null,neftconsent='1',
finalaccountnumber=0,finalifsccode=0,fundingagency=0,disbursementmode=2,LoanAmountDisbursed=0,LoanDisbursementDate=null , PrincipalOutstanding='1'
from ClientLoanProposal with (nolock)where LoanProposalID = ''

******************************** Enquirey CCIR*****************************************
Select 'Total_Pendency' ,count(*) NoOfPendency from EquifaxEnquiry..todayenquiry where sendstatus=0 
union All 
Select 'Today_Pendency' ,count(*) NoOfPendency from EquifaxEnquiry..todayenquiry where sendstatus=0 and cast(ENQUIRY_SEND_DATE as date)='2025-05-15'

                ---------------CBR_Enquiry_Pending_Status (equifaxenquiry)          
select  'Today Pending', count(clientid) as CCIR_Enquiry_Pending_Status from equifaxenquiry..todayenquiry (nolock)  where sendstatus = 0 and cast (Enquiry_send_date as date) = '2026-01-22' 
union all
Select 'Total Pending', count(*) from EquifaxEnquiry..todayenquiry where sendstatus=0 

Select *  from EquifaxEnquiry..todayenquiry where ClientID = '14:01:U7:01:11'

select f.branchid,f.staffid,f.staffname,e.serial_no,e.employee from employee_serial e
inner join fieldstaff f on e.employee_id=f.StaffID
where f.branchid like '16%' and e.Deregisterationdate='2023-16-03' --and e.employee='bm' 
order by f.branchid,f.staffid

Select MFI,Name,ACCOUNT_STATUS,ACCOUNT_NUMBER,TOTAL_AMOUNT_DISBURSED,CURRENT_BALANCE,
* From HMINQ_LOAN_DETAILS With (NoLock) Where TRACKING_ID = '54480935'

Select * From Product_category_detail with (NoLock) where ProductID = '5X' and LoanAmount = '150000' order by InstallmentAmt
Select * from Product_category_detail Where ProductCategory like '%%Bridge%%' and LoanAmount = '80000'

select Count(Distinct BranchID) from CDS1 where ActualMeetingDate = '2024-01-08' and left(BranchID,2) in ('16','16','16') 
select Distinct(BranchID) from CDS1 where ActualMeetingDate = '2024-01-08' and left(BranchID,2) in ('16','16','16')  order by branchid--Initialization
Select * From CDS1 With (NoLock) Where CenterID Like '16%'
Select * from CDS3 With (NoLock) Where ClientID Like '16%'

Select * From CDS1 With (NoLock) Where BranchID Like '10:04:E2%'--After Day Initialization
Select * From cds2 With (NoLock) Where ClientID IN ('14:11:59:01:11')
Select * from CDS3 With (NoLock) Where ClientID like '10:11:V1:01:09%' 

Select * From CDS1 With (NoLock) Where CenterID Like '10:17:ZB:01:10%'
Select * From cds2 With (NoLock) Where Clientloan1ID Like '10:17:ZB:01:10%'
Select * from CDS3 With (NoLock) Where ClientID Like '10:17:ZB:01:10%'

Select ClientLoan2UpFrontFee as Insurance_Amount,RISKFUNDDATE as Insurance_Fee_Entry_Date,ClientLoan1UpFrontFee as Processing_Fee,UPFRONTFEEDATE as Processing_Fee_Entry_Date,
ClientLoan2InstallmentNumber,ClientLoan1TotalCollected,ClientLoan1AmtDueDisbursed,ClientLoan1AmountDisbursed, *
From [43.242.214.235].appcashpor.dbo.cds2 With (NoLock) Where ClientLoan1ID Like '14:22:42:01:26%'

Select ClientLoan2UpFrontFee as Insurance_Amount,RISKFUNDDATE as Insurance_Fee_Entry_Date,ClientLoan1UpFrontFee as Processing_Fee,UPFRONTFEEDATE as Processing_Fee_Entry_Date,
ClientLoan2InstallmentNumber,ClientLoan1TotalCollected,ClientLoan1AmtDueDisbursed,ClientLoan1AmountDisbursed, * 
From [43.242.214.235].appcashpor.dbo.cds2 With (NoLock) Where ClientID IN () AND ClientLoan2UpFrontFee > 0

Select ClientLoan1ID,ClientLoan1TotalCollected,ClientLoan2InstallmentNumber,Payment_Tran_ID,Payment_Tran_Date
From [43.242.214.235].appcashpor.dbo.cds2 With (NoLock) Where ClientLoan1ID Like '05%' and ClientLoan2InstallmentNumber = 1 

Select Clientloan1id,Clientloan1amtduedisbursed,Clientloan1Amountdisbursed from [43.242.214.235].appcashpor.dbo.Cds2 with(nolock) where clientloan1id in ()

Update cds2 Set ClientLoan2InstallmentNumber = '5' Where ClientLoan1ID Like '10:12:AJ:01:20:6Y:01%'

select * from [43.242.214.235].appcashpor.dbo.paymenttrnlog where clientid='14:03:07:01:52'
select * from [43.242.214.235].appcashpor.dbo.paymenttrnlog where refid='EZY10025121820260318082741'
select * from [43.242.214.235].appcashpor.dbo.paymenttrnlog where refid in ('EZY10147892320260311123002','EZY10147892320260311123035')
select * from [43.242.214.235].appcashpor.dbo.cds2 where clientid='14:14:B9:01:74'
select  * from [43.242.214.235].appcashpor.dbo.iciciupiresponse where merchanttranid='EZY10147892320260311123002'
select  * from [43.242.214.235].appcashpor.dbo.iciciupiresponse_Adjustmnet where merchanttranid='EZY10147892320260311123002'
select  * from [43.242.214.235].appcashpor.dbo.iciciupiresponse where merchanttranid IN ('EZY10027912920260303070931','EZY10027912920260303070931')
select  * from [43.242.214.235].appcashpor.dbo.iciciupiresponse where BankRRN='935086780571'
select  * from [43.242.214.235].appcashpor.dbo.iciciupiresponse where BankRRN in ('600731273949','942749167004','414063604165')
Select * from  [43.242.214.235].appcashpor.dbo.iciciupiresponse_Adjustment With (NoLock) Where BankRRN = ''
Select * from  [43.242.214.235].appcashpor.dbo.iciciupiresponse_Adjustment With (NoLock) Where merchantTranId = ''

Select * from [43.242.214.235].appcashpor.dbo.ClientAppRegisteration Where ClientID like '05:20:55:01:29%'
Select * from [43.242.214.235].appcashpor.dbo.ClientAppRegisteration Where MobileNo = '8808960961'
select   * from [43.242.214.235].appcashpor.dbo.ICICIUPIResponse where cast(datestamp as date)='2025-07-17'
select   * from [43.242.214.235].appcashpor.dbo.ICICIUPIResponse where BankRRN  in ('569819905617')
Select  * from [43.242.214.235].appcashpor.dbo.PaymentTrnLog With (NoLock)  where clientID  = '22:16:15:01:10'

Select  * from PaymentTrnLog With (NoLock)  where clientID  = '21:28:58:01:18'

SELECT * FROM [43.242.214.235].appcashpor.dbo.Kyc_otherdetail with(nolock)where ClientID = '05:12:BB:01:79'
SELECT * FROM [43.242.214.235].appcashpor.dbo.Kyc_otherdetail with(nolock) where TrnLoanID  = '18085673'
SELECT * FROM [43.242.214.235].appcashpor.dbo.Kyc_otherdetail with(nolock) where KycTranID  = '100006158244'

Select  * from [43.242.214.235].appcashpor.dbo.KYC_review Where TrnLoanID = '17587321'
Select  * from [43.242.214.235].appcashpor.dbo.KYC_review Where KycTranID = ''
Select  * from [43.242.214.235].appcashpor.dbo.KYC_review Where ClientID = '05:23:05:01:04'

select  *  from  staffattendance  with(nolock)   where staffId = '20311' and cast(Attendancedate as Date) = '2025-09-23'
SELECT TelePhone,MobileNumber, AppVersion,StaffAppVersion,* from FieldStaff where Staffid in ('6317')
select  *  from  [43.242.214.235].appcashpor.dbo.staffattendance  with(nolock)   where staffId = '20311' and cast(AttendanceDate as Date) = '2026-01-09'

select Distinct(cast(AttendanceDate as Date)) AttendanceDate,Staffid,Imenumber,AppVersion from [43.242.214.235].appcashpor.dbo.staffattendance with(nolock) 
where staffId = '20311' order by AttendanceDate


Select  * From ICICIPennyResponse Where TranRefNO = '16827041'
Select * From Playground..pennylessdocumentation where TRNLOAN_ID = '17019161'

Select * from [43.242.214.235].appcashpor.dbo.KIScoreResponse where Customer_ID = '14:03:44:01:60'
Select * from [43.242.214.235].appcashpor.dbo.KIScoreResponse where Applied_Loan_ID = '18084912'
Select * from [43.242.214.235].appcashpor.dbo.KIScoreFailedResponse Where Applied_Loan_ID = '17523005'
Select * from [43.242.214.235].appcashpor.dbo.KIscoreBranches Where BranchID = '14:08'
Select * from [43.242.214.235].appcashpor.dbo.KIScoreConsent Where TRNLoanID = '18045380'
Select * from [43.242.214.235].appcashpor.dbo.KIScoreLoanMaster Where TRNLoanID = '16974867'
SELECT AppVersion,StaffAppVersion,* from [43.242.214.235].appcashpor.dbo.FieldStaff where Staffid in ('10607')


Select * from DIcds2 With (NoLock) Where Clientloan1ID Like '16:21:rs:01:22%'

--Region_Authorization_ForStaff
--LoginPassword

--INSURANCE
Select ClientLoan2UpFrontFee as Insurance_Amount,RISKFUNDDATE as Insurance_Fee_Entry_Date,
ClientLoan1UpFrontFee as Processing_Fee,UPFRONTFEEDATE as Processing_Fee_Entry_Date, * 
From cds2 With (NoLock) Where ClientID IN () and ClientLoan2UpFrontFee > 0


update cashporone..cds2 set LockdownNoofInstallments='1',riskfunddate=NULL where clientloan1id in ('10:01:32:01:49:2E:01')


--UPDATE cds2 Set ClientLoan2InstallmentNumber = '5'  Where ClientLoan1ID = '05:20:DN:01:18:R1:01'
--update cds2 set ClientLoan1PrincipalDue='1565',ClientLoan1PrincipalCollected='1565',ClientLoan1TotalCollected='1709' 
--Where ClientLoan1ID Like '05:14:AM:01:04:R1:01%'

update cds2 set ClientLoan1UpFrontFee='354',UPFRONTFEEDATE='2025-07-28 00:00:00',ClientLoan2UpFrontFee='300',RISKFUNDDATE=NULL,LockdownNoofInstallments='1' 
Where ClientLoan1ID Like '10:26:63:01:45:R0:01%'
update cds2 set ClientLoan1UpFrontFee='236',UPFRONTFEEDATE='2026-01-22 00:00:00',RISKFUNDDATE=NULL,LockdownNoofInstallments='1' Where ClientLoan1ID Like '14:29:95:01:57:6Y:01%'

--------AADAR MASKING
(case when k.ClientPrimaryKyctype LIKE 'Aadhar%' then ('XXXXXXXX'+right(k.ClientPrimaryKycmember,4)) else k.ClientPrimaryKycmember end) KYCNO,

Select * From DailyClosingDTL With (NoLock) Where BranchID IN ('22:22')
Select DailyProcess,* From [43.242.214.235].appcashpor.dbo.DailyClosingDTL With (NoLock) Where BranchID IN ('14:19','14:20','05:21','14:02','14:08')
update DailyClosingDTL SET Send = '0' Where BranchID IN ('14:02','14:12','14:19','14:22','14:25','05:08')
update DailyClosingDTL SET DailyProcess = '1' Where BranchID IN ('14:02','14:12','14:19','14:22','14:25','05:08')
--update DailyClosingDTL SET DailyProcess = '1' Where BranchID IN ('28:19')
--update DailyClosingDTL set DailyProcess = '1' where branchid in ('16:03','16:22','16:01','16:02','16:03','16:16','16:16','16:11','16:16','16:21','16:2','24:26','16:29')
Select * FROM DailyClosingDTL where branchid in ('10:15')

UPDATE DAILYCLOSINGDTL  SET SEND=0,DailyProcess=0  from DAILYCLOSINGDTL  with (nolock)  WHERE BRANCHID='28:30'
UPDATE BRANCH_REPORT SET SEND=0  from BRANCH_REPORT with (nolock)  WHERE BRANCHID='28:30'
UPDATE [43.242.214.56].[cashporone].[dbo].TEMPDAILYCLOSINGDTL set SEND=0,  DailyProcess=0    WHERE BRANCHID='28:30'

Select DailyProcess,* From [43.242.214.235].appcashpor.dbo.DailyClosingDTL With (NoLock) Where BranchID Like '05:21%'
Select * From TempDailyClosingDTL With (NoLock) Where BranchID Like '14:20%'
Select DailyProcess,* From tempDailyClosingDTL With (NoLock) Where BranchID Like '10:13%' and send = '0' order by Branchid
Select BranchID,BranchName,DailyProcess,* From DailyClosingDTL With (NoLock) Where BranchID Like '14:23%' and send = '0' order by Branchid
Select * From Branch_Report With (NoLock) Where Branchid Like '14:27%' and send = '0' order by Branchid
Select * From [43.242.214.235].appcashpor.dbo.FieldStaff With (NoLock) where Designation = '16' and exitdate is null And BranchID like '14:03%' order by branchid
Select * From FieldStaff With (NoLock) where Designation = '31' And exitdate is null And BranchID like '14%' order by branchid
Select * From [43.242.214.235].appcashpor.dbo.FieldStaff With (NoLock) where exitdate is null And BranchID like '05:14%'
Select * From UPICollectionLog With (NoLock) where ClientLoanID = '16:15:42:01:09:U1:01'
delete UPICollectionLog  where ClientLoanID = '16:15:42:01:09:U1:01'
select * from fieldstaff With (NoLock) where BranchID like '16%' and ExitDate is null and 
Designation in ('32','33','46','47','48','12','13','16','15','16','23','24','27','29','31')

Select count(*) from EquifaxEnquiry..todayenquiry where sendstatus=0 
select count(clientid) as CBR_Enquiry_Pending_Status from todayenquiry (nolock)  where sendstatus = 0 and cast (Enquiry_send_date as date) >= '2025-04-30'

--------------BRANCH PENDING REPORT

select Branches.CHName,DailyClosingDtl.BranchID,DailyClosingDtl.BranchName,'PENDING' as Status,
(select top 1 TelePhone from fieldstaff where exitdate is null and Designation='16' and StatusAct IN (1,0) and  Branchid=DailyClosingDtl.Branchid  ) 'BM_MOB_NUMBER',
(select top 1 Mobilenumber from fieldstaff where exitdate is null and Designation='16' and StatusAct IN(1,0) and  Branchid=DailyClosingDtl.Branchid  ) 'BM_MOB_NUMBER'
from DailyClosingDtl INNER JOIN Branches ON  Branches.BranchID=DailyClosingDtl.Branchid
where DailyClosingDtl.Branchid like '22%' and DailyClosingDtl.Send='0' 
order by Branches.CHName,DailyClosingDtl.Branchid

select Branches.CHName,DailyClosingDtl.BranchID,DailyClosingDtl.BranchName,'PENDING' as Status,
(select top 1 TelePhone from [43.242.214.235].appcashpor.dbo.fieldstaff where exitdate is null and Designation='16' and StatusAct IN (1,0) and  Branchid=DailyClosingDtl.Branchid  ) 'BM_MOB_NUMBER',
(select top 1 Mobilenumber from [43.242.214.235].appcashpor.dbo.fieldstaff where exitdate is null and Designation='16' and StatusAct IN(1,0) and  Branchid=DailyClosingDtl.Branchid  ) 'BM_MOB_NUMBER'
from [43.242.214.235].appcashpor.dbo.DailyClosingDtl INNER JOIN [43.242.214.235].appcashpor.dbo.Branches ON  Branches.BranchID=DailyClosingDtl.Branchid
where DailyClosingDtl.Branchid like '14%' and DailyClosingDtl.Send='0' 
order by Branches.CHName,DailyClosingDtl.Branchid


--Branch Pending Report Chib wise
select CHID as CHIBID,Staffname as CHIBName,branches.branchid,branches.branchname,fieldstaff.mobilenumber,
	case when  Send='1' Then 'Pending Reports'
		when send ='0' then 'Pending Reports'
	end as 'DayCloseStatus'
from [43.242.214.235].appcashpor.dbo.DailyClosingDTL
	inner join [43.242.214.235].appcashpor.dbo.branches on DailyClosingDTL.branchid=branches.branchid 
	inner join [43.242.214.235].appcashpor.dbo.fieldstaff on branches.chid=fieldstaff.staffid
where send='0'  and  
	 left(DailyClosingDTL.branchid,2)  in ('05','14','16') 
order by chid

--------------------------------------------------

	select CHID as CHIBID,Staffname as CHIBName,branches.branchid,branches.branchname,
			case when  Send='1' Then 'ReportClose'
			when send ='0' then 'Report Not Close'
		end as 'DayCloseStatus'
	from DailyClosingDTL
		inner join branches on DailyClosingDTL.branchid=branches.branchid 
		inner join fieldstaff on branches.chid=fieldstaff.staffid
	where send='0'  and 
		left(DailyClosingDTL.branchid,2) in ('10') 
	order by chid

Select ClientLoan1ID,ClientLoan1PrincipalDue,ClientLoan1PrincipalCollected,ClientLoan1InterestDue,ClientLoan1InterestCollected,ClientLoan1TotalCollected  
from cds2 Where clientID like '14:29%' and ClientLoan1Balance > '0' order by ClientLoan1ID -- Day close Check

Select ClientLoan1ID , ClientLoan1TotalCollected  
from cds2 Where clientID like '10:18%' and ClientLoan1TotalCollected   > '0' order by ClientLoan1ID


Select * From FieldStaff With (NoLock) where Designation = '27' And exitdate is null And BranchID IN ('16:22') order by branchid

----------Check after 4 PM
----Cashporone
 select CHID as CHIBID,Staffname as CHIBName,branches.branchid,branches.branchname,Cast(dtl.DateStamp as Time)as Time,Cast(dtl.DateStamp as Date)as Date,
case when  Send='1' Then 'ReportClose'
when send ='0' then 'Report Not Close'
end as 'DayCloseStatus'
  from DailyClosingDTL as dtl
  inner join branches on dtl.branchid=branches.branchid
inner join fieldstaff on branches.chid=fieldstaff.staffid
where send='1' and CONVERT(varchar,dtl.DateStamp,8) >='16:00:01'  and 
 left(dtl.branchid,2) in ('05')
 order by chid

----Appcashpor
 select CHID as CHIBID,Staffname as CHIBName,branches.branchid,branches.branchname,Cast(dtl.DateStamp as Time)as Time,Cast(dtl.DateStamp as Date)as Date,
case when  Send='1' Then 'ReportClose'
when send ='0' then 'Report Not Close'
end as 'DayCloseStatus'
  from [43.242.214.235].appcashpor.dbo.DailyClosingDTL as dtl
  inner join [43.242.214.235].appcashpor.dbo.branches on dtl.branchid=branches.branchid
inner join [43.242.214.235].appcashpor.dbo.fieldstaff on branches.chid=fieldstaff.staffid
where send='1' and CONVERT(varchar,dtl.DateStamp,8) >='15:30:01'  and 
 left(dtl.branchid,2) in ('14')
 order by chid


 Select * From cds2 With (Nolock) where ClientID in ('16:27:S1:01:47') 
And ClientLoan1AmtDueDisbursed> '0' And ClientLoan1Balance = '0' And  ClientLoan1AmountDisbursed='0'

Select * From FieldStaff With (NoLock) where Designation In ('16','27') And exitdate is null And BranchID like '16:11%' order by branchid

Select * From FieldStaff With (NoLock) where  exitdate is null And BranchID like '16:22%' order by branchid
Select * From BMABMStaffDetails With (NoLock) where BranchID like '16:02%'

Select Sum(ClientLoan1AmountDisbursed) as TotalCollection from cds2 where ClientID Like '14:29%' and ClientLoan1AmtDueDisbursed > '0' And  
ClientLoan1AmountDisbursed>'0' And ClientLoan1Balance='0'

Select ClientLoan2UpFrontFee,ClientLoan1UpFrontFee,ClientLoan2InstallmentNumber,ClientLoan1TotalCollected,* 
From cds2 With (NoLock) Where ClientID in ()

Select * from CDS2 Where DeathPerson<> 0 and ClientID Like '16:04%' --Check Arear

Select Sum(ClientLoan1TotalCollected) As Collection From [43.242.214.235].appcashpor.dbo.cds2 With (NoLock) Where ClientID Like '05%' and ClientLoan2InstallmentNumber in ('7','5','1','6')
Select ClientLoan1ID, ClientLoan1TotalCollected as Cashless From [43.242.214.235].appcashpor.dbo.cds2 With (NoLock) Where ClientID Like '22:31%' and ClientLoan2InstallmentNumber in ('7','5','1','6')
Select Sum(ClientLoan2UpFrontFee) As Insurance From [43.242.214.235].appcashpor.dbo.cds2 With (NoLock) Where ClientID Like '22:11%' And RiskFundDate = '2025-07-08'
Select Sum(ClientLoan1UpFrontFee) As Processing From [43.242.214.235].appcashpor.dbo.cds2 With (NoLock) Where ClientID Like '28:27%'And UpFrontFeeDate = '2025-06-24'
Select Sum(ClientLoan1AmountDisbursed) As Collection From [43.242.214.235].appcashpor.dbo.cds2 With (NoLock) Where ClientID Like '05:02%'

Select ClientLoan1ID,ClientLoan2UpFrontFee As Insurance,Riskfunddate as Insurancedate From prevcds2 With (NoLock) Where ClientID Like '14:22%' And RiskFundDate = '2024-05-21'

--------Insurance ClientWise
select ClientLoan1ID,RiskFundDate as InsuranceEntryDate,ClientLoan2UpFrontFee as InsuranceFee from cds2 
where cast(RiskFundDate as date) = '2025-08-26' and ClientID like '10:09%'
--------Processing ClientWise
select ClientLoan1ID,UpFrontFeeDate as ProccessingEntryDate,ClientLoan1UpFrontFee as ProcesiingFee from cds2 
where cast(UpFrontFeeDate as date) = '2025-08-26' and ClientID like '10:09%'


Select *  From cds2 With (NoLock) Where ClientID in ('16:28:24:01:18')

Select LEFT(ClientLoan1ID,8) As CenterID,Sum(ClientLoan1TotalCollected) As Collection
From cds2 With (NoLock) Where ClientID Like '10:13:92%' and ClientLoan1Balance > '0'
Group By LEFT(ClientLoan1ID,8)
order by LEFT(ClientLoan1ID,8)

----Branch_Wise_Collection

Select b.BranchID,b.BranchName,Sum(cds2.ClientLoan1PrincipalCollected+cds2.ClientLoan1InterestCollected) As UPICollection
From [43.242.214.235].appcashpor.dbo.cds2 With (NoLock) 
Inner join [43.242.214.235].appcashpor.dbo.Branches as b on b. BranchId=cds2.BranchID
Where ClientID Like '05%' and ClientLoan2InstallmentNumber in ('7','5','1','6')
Group By b.BranchID,b.BranchName
order by b.BranchID,b.BranchName

----Center_Wise_Collection

Select b.BranchID,b.BranchName,c.CenterID,c.CenterName,Sum(cds2.ClientLoan1PrincipalCollected+cds2.ClientLoan1InterestCollected) As UPICollection
From [43.242.214.235].appcashpor.dbo.cds2 With (NoLock) 
Inner join [43.242.214.235].appcashpor.dbo.Branches as b on b. BranchId=cds2.BranchID
Inner Join [43.242.214.235].appcashpor.dbo.Centers as c on c.CenterID=cds2.CenterID
Where ClientID Like '05:27%' and ClientLoan2InstallmentNumber in ('7','5','1','6')
Group By b.BranchID,b.BranchName,c.CenterID,c.CenterName
order by b.BranchID,b.BranchName,c.CenterID,c.CenterName

----Client_Wise_Collection

Select b.BranchID,b.BranchName,c.CenterID,c.CenterName,cds2.ClientLoan1ID,Sum(cds2.ClientLoan1PrincipalCollected+cds2.ClientLoan1InterestCollected) As UPICollection,cds2.ClientLoan2InstallmentNumber
From [43.242.214.235].appcashpor.dbo.cds2 With (NoLock) 
Inner join [43.242.214.235].appcashpor.dbo.Branches as b on b. BranchId=cds2.BranchID
Inner Join [43.242.214.235].appcashpor.dbo.Centers as c on c.CenterID=cds2.CenterID
Where ClientID Like '14:03:82%' and ClientLoan2InstallmentNumber in ('7','5','1','6')
Group By b.BranchID,b.BranchName,c.CenterID,c.CenterName,cds2.ClientLoan1ID,cds2.ClientLoan2InstallmentNumber
order by b.BranchID,b.BranchName,c.CenterID,c.CenterName,cds2.ClientLoan1ID,cds2.ClientLoan2InstallmentNumber

select LEFT(ClientLoan1ID,8) As CenterID,SUM(ClientLoan1PrincipalDue+ClientLoan1InterestDue) Due,SUM(ClientLoan1PrincipalCollected+ClientLoan1InterestCollected) 
Collection From cds2 where clientloan1id like '10:24%' and ClientLoan1TotalCollected > 0
group by LEFT(ClientLoan1ID,8)

--Settlement Check
Select LEFT(ClientLoan1ID,16) As ClientID,Sum(ClientLoan1PrincipalCollected+ClientLoan1InterestCollected) As Collection
From cds2 With (NoLock) Where ClientID Like '05:27%' and ClientLoan1TotalCollected > (ClientLoan1PrincipalDue+ClientLoan1InterestDue)
Group By LEFT(ClientLoan1ID,16)
order by LEFT(ClientLoan1ID,16)

Select ClientLoan1AmtDueDisbursed,ClientLoan1AmountDisbursed,* From cds2 With (NoLock) 
Where Clientid Like '05:27%' and ClientLoan1AmountDisbursed>'0'--disbursement check

Select * From [43.242.214.235].appcashpor.dbo.Product_Category With (NoLock) Where RID like '14:13%' and ProductCategory like '%Flexi%' and LoanAmount = '50000' order by LoanAmount 

Select DueAmount,DueDate,CollAmount,CollDate,ServiceExpiryDate,* from MInsureSurvey With (NoLock) Where clientID Like '14:19:ZR:01:52%'
Select DueAmount,DueDate,CollAmount,CollDate,ServiceExpiryDate,* from MInsureSurvey With (NoLock) Where clientID in ('05:18:59:01:12','05:18:59:01:13','05:18:59:01:14','05:18:59:01:15')

Select BranchBC,* from branches With (NoLock) Where BranchID = '14:19'-- Check For Branch BC OR OWN

Select * From cds2 Where ClientID in ()
Select * From CDS1 With (NoLock) Where CenterID Like '22:16:10%'

Select * From IndusInddocument Where ClientID = '16:22:16:01:38'--BM Final Submit

Select * From ClientLoanProposal_FormFlow Where ClientID = '14:01:AT:01:85'--BM Final Submit
select * from Nominee_Relation_Master

select DueDate,CollAmount,CollDate,ServiceExpiryDate,* From [43.242.214.235].appcashpor.dbo.MInsureSurvey with (Nolock) where clientID in ('05:14:22:02:08')
select DueDate,CollAmount,CollDate,ServiceExpiryDate,* From [43.242.214.235].appcashpor.dbo.MInsureSurvey with (Nolock) where clientID liKe '05:05%'
AND CollDate = '2025-12-29'

select BranchID,ClientID,ClientName,CollAmount,collDate,PaymentMode , * from [43.242.214.235].appcashpor.dbo.MInsureSurvey
with(nolock) where ClientID like '07:06%'  and collDate between '2022-10-01' and '2022-06-30' and WriteoffDate is null 

select mis.BranchID,b.branchname,mis.clientid,mis.clientname,mis.DueDate,mis.CollAmount,mis.CollDate,mis.ServiceExpiryDate
From [43.242.214.235].appcashpor.dbo.MInsureSurvey as mis with (Nolock)
inner join [43.242.214.235].appcashpor.dbo.branches as b on b.branchid=mis.branchid
where mis.clientID lIKe '05:05%' 
AND mis.CollDate between '2025-12-29' and '2025-12-29' order by mis.BranchID 

--update Branches set downloading = '1' Where BranchID Like '14:19%' 
Select CHID,CHName,BranchBC,pincode,downloading,* From [43.242.214.235].appcashpor.dbo.Branches Where BranchID Like '14%' and DissolvedDate is null
Select BranchBC,* From Branches Where AMID = ''
Select FCID,* From Branches Where FCID = ''
Select CHID,CHName,* From Branches Where CHID = '0532'
Select Amid,CHID,CHName,* From Branches Where BranchID in ('10:09','10:10','10:11','10:26') and DissolvedDate is null

Select * from NGSQCheck where Clientloanid like '16:04:62:01:84%'

Select * From DesignationMaster With (NoLock) Where DesignationID IN ('25','26')
Select * From Insurance_Master1 Where RID = '05' and LoanAmount = '100000'
Select * From Product_category with (NoLock) where RID Like '11:07%' and ProductCategory like '%%bc%%'
Select * From Loanpurposes with (NoLock) where Description Like '%General%'
Select * From Loanpurposes with (NoLock) where PurposeID IN ('4747') 
Select * From Village_Master with (NoLock) where BranchID Like '24:30%' and VillageName Like '%%manjhariya%%'
Select * from IFSCODE where IFSC = 'SBIN0064663'

------select * from Branch_Report where branchid = '16:24'
Select Eligible_Flexi_Amount,EligibleForFL,Loancycle,EligibleLoanAmount,Comments,HotListRemark,HotListDate,CommentedBy,* From [43.242.214.235].appcashpor.dbo.Clients with (NoLock) 
where ClientID in ('14:28:Ao:01:26')
Select Eligible_Flexi_Amount,EligibleForFL,Loancycle,EligibleLoanAmount,Comments,HotListRemark,HotListDate,CommentedBy,* From [43.242.214.235].appcashpor.dbo.Clients with (NoLock) 
where ClientID in ()
SELECT  HotListRemark,* FROM [43.242.214.235].appcashpor.dbo.Clientsdropout WITH(NOLOCK) WHERE CLIENTID in ('14:07:IA:01:55')
SELECT  HotListRemark,* FROM [43.242.214.235].appcashpor.dbo.Clientsdropout WITH(NOLOCK) WHERE CLIENTID like '14:15:11:01:53%'
Select maritialstatus,* from [43.242.214.235].appcashpor.dbo.Targets Where TargetID = '14:21:12448'
Select Eligible_Flexi_Amount,EligibleForFL,Loancycle,EligibleLoanAmount,Comments,SuspendDate,HotListRemark,HotListDate,
* from Clients with (NoLock) where ClientID ='28:15:38:01:43'
Select * From Clients with (NoLock) where ClientID ='16:11:33:01:16'
Select HotListRemark,* From Clientsdropout where ClientID = '16:12:RY:01:42'
Select HotListRemark,* From Clientsdropout where ClientID IN ()
Select * From ATClients where ClientID in ('10:18:A5:01:43')
Select ActivateDate,* From ATClients where ClientID = '14:28:AO:01:26'
SELECT  * FROM centers WITH(NOLOCK) WHERE CenterID like '16:01:su%'
SELECT ActivateDate, * FROM [43.242.214.235].appcashpor.dbo.ATClients WITH(NOLOCK) WHERE CLIENTID like '05:21:ZV:01:84:R1:01%'
Select * From [43.242.214.235].appcashpor.dbo.ClientLoanProposal With (NoLock) Where ClientID Like '14:09:A3:02:04:%'
SELECT * FROM [43.242.214.235].appcashpor.dbo.ClientLoanProposal WITH(NOLOCK) WHERE LoanProposalID like '14:12:48996%'  
select  * from RejectedProposal with (nolock) where clientid like '16:13:67:01:60%'
Select * from RejectedProposal where clientId like '16:16:35:01:17%'
Select * from [43.242.214.235].appcashpor.dbo.Loan_Utilisation With (NoLock) Where ClientLoanID Like '14:07:AI:01:55:4X:01%'
Select * from Loan_Utilisation With (NoLock) Where Aro_StaffId = '16020' and Aro_ReviewDate = '2023-04-16'
SELECT * FROM Clientadhar with(nolock)where CLIENTID like '14:12:82:01:94%'
SELECT * FROM Husbandadhar with(nolock)where CLIENTID like '10:20:ZG:01:54%'
SELECT Centerid,* FROM ClientaAdhar with(nolock)where Adharid ='511413017019'
SELECT * FROM Husbandadhar with(nolock)where Adharid ='616250635459'
Select * from KYC Where trnloanid = '1BA03462'
Select * from [43.242.214.235].appcashpor.dbo.KYC Where ClientID = '14:12:82:01:94'
SELECT * FROM Husbandadhar with(nolock) where CLIENTID like '14:01:EN:01:60%'
select * from [43.242.214.235].appcashpor.dbo.ATDataEntryBC with(nolock) where clientid like '05:27:O7:01:46%'
select * from mobileverification Where clientID = '21:16:93:01:28'
select  * from [43.242.214.235].appcashpor.dbo.ClientLoanProposalHelp with(nolock)where clientid like '14:02:E1:01:73%'
Select * from [43.242.214.235].appcashpor.dbo.Second_KYC_Verification_TRN Where Client_ID = '05:12:P1:01:35'
Select * from [43.242.214.235].appcashpor.dbo.KycVerificationTRN Where ClientID = '05:22:XW:01:59'
Select * from [43.242.214.235].appcashpor.dbo.MobileVerification where ClientId liKE '14:11:42:01:47%'
Select * from [43.242.214.235].appcashpor.dbo.MobileVerification where OldMobileNumber='8840566068'
Select * from [43.242.214.235].appcashpor.dbo.MobileVerification where NewMobileNumber='9565718531'
select * from Center_Switching with(nolock) where CurrentCenterID like '10:02:ZS%'
Select * from [43.242.214.235].appcashpor.dbo.ProposalDeactivation Where ClientID like '14:08:10:01:44%'


SELECT FCID,* from Branches where BranchID IN ('')--16874
SELECT FCID,* from Branches where BranchID Like '34:04%'

Select * From EKYCICICI With (NoLock) Where ClientID = '31:12:13:01:24'--ekyc print
Select * From IFSCODE With (NoLock) Where IFSC = 'CBIN0285146'-- Check For IFSC Code

Select * from RegionShortName where rId = '16'
 
select * from [43.242.214.235].appcashpor.dbo.Clients where ClientID Like '14:21:L1%' and DropOutStatus = '0' order by ClientID DESC
select NumMembers,* from [43.242.214.235].appcashpor.dbo.centers where centerid like '05:14:vs%' and DissolvedDate is Null
select ReportingDay,CenterMeetingDay, * from centers where centerid IN ('05:30:S4') and DissolvedDate is Null
select ReportingDay , CenterMeetingDay , * from [43.242.214.235].appcashpor.dbo.centers where centerid like '14%' and DissolvedDate is Null and CenterMeetingDay = '1' and ReportingDay = '3'
select distinct left(branchid , 2) from [43.242.214.235].appcashpor.dbo.centers with(nolock) where reportingday <> centermeetingday and dissolveddate is null
select * from [43.242.214.235].appcashpor.dbo.Centers where staffid = 'BA27' and DissolvedDate is Null
select  * from center_Switching where CurrentCenterID = '28:12:45'
Select * From [43.242.214.235].appcashpor.dbo.FieldStaff With (NoLock) where exitdate is null And BranchID like '14:19%'
Select appversion,staffappversion,* From [43.242.214.235].appcashpor.dbo.FieldStaff With (NoLock) where exitdate is null And BranchID like '14:11%'
select * from centers where centerid IN () and DissolvedDate is Null and StaffID = '4579'
select * from fieldstaff where BranchID = ''
Select * From [43.242.214.235].appcashpor.dbo.FieldStaff With (NoLock) where Designation in ('16') And exitdate is null And BranchID like '14%' order by BranchID
SELECT Trtype,Datestamp ,* FROM ClientAdhar with(nolock)where Adharid like '256336960916%'
SELECT AppVersion,StaffAppVersion,* from [43.242.214.235].appcashpor.dbo.FieldStaff where Staffid in ('28808','28811','14906 ')
select * from ATfieldstaff where  Staffid in ('14764') order by DateofUpdation Desc
Select * From DesignationMaster With (NoLock) Where DesignationID IN ('32')
Select * From StaffOTP With (NoLock) Where StaffID = '13352'
Select * From TrackVisit With (NoLock) Where Staffid = '2171' And Location_id = '28:27:70'
Select * From Employee_Serial With (NoLock) Where Employee_id = '15424'
Select * From CDS1 WITH (NoLock) Where centerid = '31:16:71'
Select BranchBC,pincode,* From Branches Where BranchID Like '06%'
Select * from Nomineerelation

--update Employee_Serial set Branch_id = '16:21' Where Employee_id = '' --sugam login msg 3
update FieldStaff set appversion = '1.6',staffappversion = '1.3' where Staffid in ('19837')

--- login problem
Select * From [43.242.214.235].appcashpor.dbo.FieldStaff With (NoLock) where Designation = '31' And exitdate is null And BranchID like '05%'order by branchid
Select * From [43.242.214.235].appcashpor.dbo.FieldStaff With (NoLock) where exitdate is null And BranchID like '10:09%'order by branchid
select * from [43.242.214.235].appcashpor.dbo.fieldstaff where staffid= 'BA03'
select * from [43.242.214.235].appcashpor.dbo.Login_Master1 where Employee_id = 'BA03'
select * from [43.242.214.235].appcashpor.dbo.Employee_Serial where Employee_id = 'BA03'
Select * From [43.242.214.235].appcashpor.dbo.StaffOTP With (NoLock) Where StaffID = 'BA03'
select * from [43.242.214.235].appcashpor.dbo.centers where staffid = 'BA03' order by centerID
Select * From [43.242.214.235].appcashpor.dbo.UserRegion With (NoLock) Where StaffID = 'BA03'
--select * from centers where CenterID = '21:21:16'--


--update UserRegion set RegionID= '16' Where StaffID = '16020'

--delete Employee_Serial where Employee_id = '16020'--(for new staff before active app
--delete Login_Master1 where Employee_id = '16020'

--Delete FieldStaff where StaffID = 'DBA24'

--where clientid like  '35:12:17:01:16%'Adharid ='478951646'
--select * from Targets where TargetID ='17:25:16216' 
--select * from centers with (nolock) where centerid like '16:06:jl%'

Select * From WIR Where ProductID = '6x' and LoanAmount = '50000'

 ---- branch due  (check both local and upper too)
  SELECT * from cds2 with (nolock) where clientid like '16:02%' and ClientLoan1AmtDueDisbursed > 0 order by clientloan1Id

select * from CreditNeedAccessment where Clientid = '16:06:bw:01:53'

select * from CDS3 with ( nolock) where clientid = '16:12:43:01:60' 

select * from CDS1 where branchid like '35:01%' 

select * from Loan_Utilisation with (nolock) where ClientLoanID like '22:25:a6:01:16%'

-- Targeting Adding Problem --    
-- 1st Step --

select Max(clientID) from Clients WITH(NOLOCK) where ClientID like '16:16:24%'
select Max(clientID) from Targetwithadhar with(NOLOCK) where ClientID like '16:16:24%'

-- 2nd Step --

select Max(TargetID) from Targets with(nolock) where CenterID like '16:16:24%'
select max(TargetID) from ClientAdhar with (nolock) where clientid like '16:16:24%'
select max(TargetID) from Clients with(NOLock) where ClientID like '16:16:24%'

-- Last Step --

Select RiskFund, * from Clients where ClientID like '10:24:90%' and DropOutStatus='0' order by ClientID

---not digitized  

select * from clientpassbookimages with (nolock) WHERE Clientid LIKE '16:02:N7:01:22%' 
select * from clientpassbookimages with (nolock) WHERE Clientid IN ('16:03:CU:01:68')
SELECT * FROM ClientLoanProposal WITH(NOLOCK) WHERE CLIENTID LIKE '16:15:FI:01:65%' 

---longitude and latitude of branch
select BranchID,BranchName,latitude,longitude,address from Branches with ( nolock ) where BranchID like '16%' 
and latitude is null and longitude is null
and DissolvedDate is null

--- worthiness problrm
SELECT  Verified,CBR_Date, CBR_Status,CBR_REMARK, * FROM Clientadhar with(nolock)where clientid like  '16:09:r8:01:29%'

Select * From MInsureSurvey where ClientID like '35:15:80:01:04%'

-- adding ,targeting problem (enrollmant service currently
SELECT   Clientid,Clientname,targetid,Trtype,Centerid,* FROM Clientadhar with(nolock)where Adharid ='416216572743'


-----disbursment problem( nahi ho pa raha)
SELECT LoanDisbursementDate,LoanAmountDisbursed,ProposalDate, * FROM ClientLoanProposal
 WITH(NOLOCK) WHERE CLIENTID LIKE '21:25:AC:01:13%'

 --- nominee name
SELECT   nominee ,NomineeRelation,* FROM ClientLoanProposal
WITH(NOLOCK) WHERE CLIENTID LIKE '16:18:m4:01:01%'  

-- Eligible amount less and Other Outstanding and Mfi
SELECT ClientID, Loancycle, EligibleLoanAmount,Dropoutstatus FROM Clients
 WITH(NOLOCK) WHERE CLIENTID LIKE '16:22:58:01:25%'

SELECT Proposaldate,OtherOutstanding,TRACKING_ID FROM ClientAdhar
WITH(NOLOCK) WHERE clientid like  '16:22:58:01:25%'

--select * from ClientLoanSubscription with(nolock) where ClientLoanID like '16:12:ZK:01:12%'

select MFI , ACCOUNT_STATUS,* from HMINQ_LOAN_DETAILS
WITH(NOLOCK) WHERE TRACKING_ID = '2516302' 
and ACCOUNT_STATUS <> 'Closed Account'

--WORTHINESS not show  

SELECT Clientid , Verified , CBR_Status , CBR_Date,CBR_REMARK , CBR_Enq_Date,* FROM Clientadhar
with(nolock)where clientid like  '16:21:11:03:37%'

select TargetID,TargetName,TargettingDate ,StaffID,* from Targets
 with (nolock)where BranchID  like'16:22%' and TargettingDate >= '2021-12-01'

----bm review and bm neft

select FinalReviewDate,BmNeftReviewDate,BmAccountNumber,BmIfsccode,* from Clientloanproposal
 with(nolock)where clientid like '16:16:12:01:01%' and BmNeftReviewDate is null and LoanDisbursementDate is null
 
   --18:q3:01:66

--upi not  show

select ClientLoan1TotalCollected,ClientLoan2InstallmentNumber ,*from cds2 
with (nolock) where clientid like  '16:15:35:01:21%'

select ClientLoan1TotalCollected,ClientLoan2InstallmentNumber ,*from cds2 
with (nolock) where clientid like  '16:21%'  and ClientLoan2InstallmentNumber = 2 

select * from branch_report where branchid like '16:16%'

---hospicash
select clientid, HealthInsurance as client_HealthInsurance,HealthInsuranceSpouse as husband_HealthInsurance, * from cds2
 with (nolock) where clientid like  '16%' and (HealthInsurance>0 or HealthInsuranceSpouse>0)

--client eligibility

SELECT Proposaldate,Adharid, Verified,CBR_Status,CBR_Date,CBR_Enq_Date,OtherOutstanding,TRACKING_ID FROM ClientAdhar with(nolock)where clientid like  '16:09:v1:01:53%'

select * from Targets with(nolock)where targetid like '16:21:13402%'
select * from Targets with(nolock)where targetid like '16:%'


---not show in bm review
select FinalReviewDate,BmNeftReviewDate, * from Clientloanproposal
with(nolock)where clientid like '10:16:79:01:24%'

select LoanProposalID,ProposalDate, Bmrecommenddate ,* from Clientloanproposal 
with(nolock)where clientid like '16:24:11:01:43%'

---M-Insurance 

select BranchID,ClientID,ClientName,CollAmount,collDate,PaymentMode , * from MInsureSurvey
with(nolock) where ClientID like '16:13%'  and collDate = '2022-16-13' and WriteoffDate is null 

select BranchID,ClientID,ClientName,CollAmount,collDate,
PaymentMode,ServiceExpiryDate , * from MInsureSurvey
with(nolock) where ClientID like '16:21:w4:01:22%'  and WriteoffDate is null AND RejectedBy IS NULL 

 AND collDate = ('2022-01-22') AND RejectedBy IS NULL and WriteoffDate is null 

select ClientID,ClientName,CollAmount,CollDate  from MInsureSurvey with(nolock) where BranchID like '05:01%' and collDate >= '2024-05-01' order by CollDate,ClientID
select ClientID,ClientName,CollAmount,CollDate,*  from MInsureSurvey with(nolock)where ClientID like '35:09:16:01:16%'

---other outstanding and mfi 

SELECT * FROM Clientadhar with(nolock)where clientid like  '16:15:59:01:16%'
select * from HMINQ_LOAN_DETAILS where traCking_id = '	2201791'
select MFI , ACCOUNT_STATUS , MFI,* from HMINQ_LOAN_DETAILS where traCking_id = '2221677' 
----collection not show
select * from cds1 where CenterID like '16:01:54%' and ActualMeetingDate = '2022-02-10' 


-- due not show or not come

select ClientLoan1ProductName, * from cds2 with (nolock)where
 clientid like  '16:18:o8:01:70%' 

select ClientLoan1ProductName ,ClientLoan1TotalCollected,ClientLoan2InstallmentNumber,* from cds2
with(nolock) where clientid like  '16:18:o8:01:70%'

select ClientLoan1ProductName ,ClientLoan1TotalCollected,ClientLoan2InstallmentNumber,* from cds2
with(nolock) where clientid like  '16:16:z9:01:25%' and ClientLoan1TotalCollected = '0' and ClientLoan1ProductName <> '0' order by clientid

---- PENDING DAY END REPORT
SELECT CHName,* FROM Branches WHERE BranchID LIKE '16%'

select Branches.CHName,Branch_Report.Branchid,Branch_Report.BranchName,Branch_Report.send from
Branch_Report INNER JOIN Branches ON  Branches.BranchID=Branch_Report.Branchid
where Branch_Report.Branchid like '16%' and Branch_Report.Send='0'
order by Branches.CHName,Branch_Report.Branchid --Branch_Report.Branchid , 

select * from Branch_Report with (nolock)where branchid like '16%' and send ='1'

select count(*) from Branch_Report with (nolock)where branchid like '16%' and send ='0'

select  Branchid,BranchName,send from Branch_Report
with (nolock)where branchid like '16%' and send ='0' order by Branchid

---exec proc_eligibleamount '16:04'

---search table with name include in table

select * from sys.tables with(nolock) where name like '%passbook%'

----for field staff

select * from FieldStaff where   StaffID = '27139' 
and ExitDate is NULL


SELECT * FROM Centers  where centerid ='16:11:ZB' 
select * from RptFieldStaff where   StaffID = '16793'    and ExitDate is NULL
SELECT * FROM DesignationMaster

---- no of client in center

SELECT count(*)  FROM Clients WITH(NOLOCK) WHERE CLIENTID LIKE '16:10:ZL%' and dropoutstatus = 0 

---m insurance with service expiry and due

select ClientID,ClientName,CollAmount,CollDate,PaymentMode,EntryDate,* from MInsureSurvey
 WHERE ClientID LIKE '16:21:z3:01:17%' and WriteoffDate is null
  
select ClientID,ClientName,CollAmount,CollDate,PaymentMode,EntryDate,* from MInsureSurvey
 WHERE ClientID LIKE '16:21:z3:01:17%'

select ClientID,ClientName,CollAmount,CollDate,PaymentMode,EntryDate,* from MInsureSurvey
 with(nolock) where BranchID like '16:15%' and collDate like '2022-01-29' and WriteoffDate IS NULL order by CollDate,clientid

select * from cds2 with(nolock) where clientID like '16:06:z8:01:43%'
select * from cds3  where ClientID like '16:16:u5:01:51%'

--- airtel prsent day upi

select * from ClientAirtelUPI with(nolock) where clientid like '16:25:al:01:47%'

select * from AirtelUPIResponse with(nolock) where hdnOrderID like '16:09:z5:01:25%'
select * from AirtelUPIResponse with(nolock) where hdnOrderID like '16:21:11:01:27%'

select * from ATClientAirtelUPI

---hospi cash

Select HealthInsurance,HealthInsuranceSpouse, *from cds2 with (nolock) where clientid like  '16:09:g9%' 

--half full bima
Select *from CDS3 with (nolock) where clientid like  '16:13:x2:01:86%' AND RiskFundDate >='2021-12-30'

SELECT Clientid,Adharid,clientname,cbr_remark,* FROM Clientadhar
with(nolock)where clientid like  '16:13:x2:01:86%'

select clientid,husbandname,adharid,Datestamp,husbandage,* from Husbandadhar
with(nolock)where clientid like  '16:13:x2:01:86%'

select Nominee,NomineeRelation,* from ClientLoanProposal
with(nolock)where clientid like  '16:12:a4:01:53%'

--branch hospi

Select ClientID , HealthInsurance,HealthInsuranceSpouse from cds2
with (nolock) where clientid like  '16:16%' and (HealthInsurance>0 or HealthInsuranceSpouse>0) 

--select * from ClientAdhar
--Select cds2.ClientID ,ClientAdhar.Clientname, cds2.HealthInsurance,cds2.HealthInsuranceSpouse, *from cds2
 -- inner join ClientAdhar on 
 --cds2.ClientID=ClientAdhar.clientid 
 ---with (nolock) where cds2.ClientID like  '16:%' and (HealthInsurance>0 or HealthInsuranceSpouse>0)

 select TargetID,TargetName,TargettingDate ,StaffID from Targets with (nolock)where BranchID  like'16:22%' and TargettingDate >= '2021-12-01' and order by TargettingDate

 select TargetID, 
  (Select clientid from Clientadhar Where targetid=b.targetid)'ClientID',
  TargetName as ClientName,TargettingDate ,StaffID from Targets as b with (nolock)where BranchID  like'16:22%' and TargettingDate >= '2021-12-01'
  
  ---CoborrowerAdhar
select * from  CoborrowerAdhar with(nolock) where adharid like '764001789379%' --clientid like '16:04:n2:01:65%'

---client suspend bt not show for active
--riskfund =0 and insurance =16 hona chahiye for active 

SELECT  DropOutStatus,RiskFund,Insurance,* FROM Clients WITH(NOLOCK) WHERE CLIENTID LIKE '16:04:16:01:26%' 

select * from tmpStaff where branchid like '16%'
---search column by name

select sys.columns.name AS columnName,
tables.name AS TableName
from 
sys.columns 
join sys.tables ON
sys.columns.object_id=tables.object_id
where sys.columns.name LIKE '%risk%'

---search table with name include in table

select * from sys.tables with(nolock) where name like '%number%'

select ClientLoan1ProductName ,ClientLoan1TotalCollected,ClientLoan2InstallmentNumber,* from cds2
with(nolock) where clientid like  '16:16:ZD:01:18%'

select * from LoanLedger where ClientLoanID='16:16:ZD:01:18:U4:01'

select * from CreditNeedAccessment with (nolock) where clientid like '16:09:zq:01:13%'

Select * from Branch_Report Where Branchid like'16:16%' 

order by BranchID 

-- check target allocation by branchid 

Select * from tmptargetallocation Where Branchid like'16:18%'
-- client not show in cedit need

select * from CreditNeedAccessment with (nolock) where Clientid like '16:22:c7:01:54%'

select staffid, staffname,branchid,designation from FieldStaff with (nolock) where branchid like '16%'  and ExitDate is NULL 
order by StaffID,BranchID
and TelePhone='0'and Designation like'16'

1681
select *from cds2 with (nolock) where clientid like  '16:04:16:01:56%'

select * from FieldStaff where StaffID='4033'

select * from DesignationMaster

select * from FieldStaff where  StaffID = '21610'

select * from CDS1 where meetingdate='2022-02-02'and branchid like '16%'

select * from LoanLedger
 ------targeting adding problem 
--select * from sys.tables with(nolock) where name like '%with%'
---1st step
SELECT Max(clientId) FROM Clients WITH(NOLOCK)WHERE CLIENTID LIKE '16:16:79%' 
SELECT  Max(clientId) from Targetwithadhar WITH(NOLOCK)WHERE CLIENTID LIKE '16:16:79%' 
----2nd step
SELECT Max(TargetID) FROM Targets with(nolock)where CenterID like '16:16:79%'
SELECT Max(TargetID) FROM Clientadhar with(nolock)where clientid like '16:16:79%'
SELECT Max(TargetID) FROM Clients WITH(NOLOCK)WHERE CLIENTID LIKE '16:16:79%' 

select * from Centers with(nolock) WHERE CenterID= '16:16:79' 
select * from clients where clientid like '16:16:79%' and dropoutstatus = '0'
--- login problem
select * from fieldstaff where staffid= '16020'
select * from login_master1 where Employee_id = '16020'
select * from centers where CenterID = '10:12:D7'
select * from centers where staffid = '16020' order by centerID--and dissolveddate is null  order by centerid
select * from Login_Master1 where Employee_id = '16020'
select * from Employee_Serial where Employee_id = '16020'--(for new staff before active app


---hospicash not show
select clientid, HealthInsurance,HealthInsuranceSpouse, * from cds2
 with (nolock) where clientid like  '16:15%' and (HealthInsurance>0 or HealthInsuranceSpouse>0)
SELECT TargetAge, Co,trtype, * FROM Clientadhar with(nolock)where clientid like  '16:15:04%' 
SELECT trtype,* FROM Husbandadhar with(nolock) where clientid like  '16:15%' 

---death entry

select deathperson, * from cds2 with (nolock) where clientid like  '16:10:58:01:28%'

select * from FieldStaff where Designation ='16' and BranchID like '16%'  and exitdate is null and  StatusAct = '1'

-----credit help upi update logfile

select * from  UPICollectionLog where rrn='206816735091'

--Details of BC proposal entry by CM.
select left(Clientid,5) as BranchID, ClientID, TargetName, ClientRequestedAmount, ProductCategory, FinalReviewDate from ClientLoanProposal 
where Clientid like '31%' and Proposaldate>='2022-16-23' and left(ClientID,5) in (select branchid from branches where Branchbc like 'BC%') 
and productid not in ('r1','r0','8r','7r')

--Proposal detail from 2022-16-01 to 2022-16-18
Select left(ClientID,5) as BranchID,b.BranchName,clp.entryby,fs.StaffName,clp.ClientID, clp.Targetname, clp.ProposalDate,clp.productID,clp.ClientRequestedAmount,
clp.FinalReviewDate
From ClientLoanProposal as clp 
inner Join Branches as b on b.BranchID=left(clp.ClientID,5)
inner Join FieldStaff as fs on fs.StaffID=clp.EntryBy where  ProposalDate >= '2022-16-01'  and ClientID like '16:02%' order by ProposalDate

--Drm Above staff Mobile number
Select b.Zone,left(b.branchId,2) as RegionId,b.DistrictName as RegionName,fs.branchid,b.BranchName,fs.staffid,fs.staffname,dm.DesignationName,fs.TelePhone from FieldStaff as fs With (NoLock)
inner join DesignationMaster as dm on dm.DesignationID=fs.Designation
inner join branches as b on b.BranchID = fs.BranchID
Where DesignationID in ('23','24','21','22','43') and exitdate is null order by Zone


Select b.BranchID,b.BranchName,c.ClientID,clp.Targetname as Clientname,* from ClientLoanSubscription as cls With (NoLock) 
inner join clients as c on c.clientId=left(cls.clientloanId,16)
inner join kyc as k on cast(c.ClientAdharid as varchar)=cast(k.trnloanid as varchar)
inner join ClientLoanProposal as clp on clp.LoanProposalID=cls.LoanProposalID
inner join branches as b on b. branchId = left(cls.clientloanId,5)
where cls.ActualPaidUpDate IS NULL and c.AMGRTDate between '2023-16-01' and '2023-16-26' and c.DropOutStatus = '0' Order By cls.clientloanId

Select b.zone,b.BranchID,b.BranchName,c.ClientID,t.TargetName as ClientName,c.JoinDate,t.HusbandName,k.ClientPrimaryKycmember,k.ClientPrimaryKyctype,k.ClientPrimaryNameasperkyc,
k.ClientPrimaryKycDateofbirth,k.ClientPrimaryFathername,k.ClientSecondaryKyctype,k.ClientSecondaryKycid,k.ClientSecondaryNameasperkyc,k.ClientSecondaryKycDateofbirth,
k.ClientSecondaryFathername From Clients c with (NoLock) 
inner join ClientLoanSubscription cls on c.clientId=left(cls.clientloanId,16)
inner join kyc as k on k. clientId=c.ClientID
Inner join branches as b on b.BranchID = Left(c.ClientID,5)
inner join Targets as t on t.TargetID=c.TargetID
where c.AMGRTDate between '2023-16-01' and '2023-16-26' and c.DropOutStatus = '0' and cls.ActualPaidUpDate IS NULL

--Proposal Entry Report
Select b.branchID,B.branchName,clp.clientID,Clp.Targetname as ClientName,clp.ProposalDate,clp.LoanProposalID,clp.ClientRequestedAmount,clp.EntryBy as CMID,f.StaffName as CMName,
clp.LoanAmountApproved,
clp.NumberOfInstallments,clp.ProductID,clp.ProductCategory,clp.FinalReviewDate,clp.LoanDisbursementDate
from ClientLoanProposal as clp With (NoLock) 
inner join branches as b on b.BranchID = left(clp.clientid,5)
inner join FieldStaff as f on f.StaffID = clp.entryBY
where Clientid like '28%' and clp.proposaldate between '2025-05-15' and '2025-06-10'

--Client wise Due details
Select b.branchid,b.branchname,cds2.clientid,cds2.ClientLoan1ID,clp.targetname as Clientname,clp.LoanProposalID,clp.ProposalDate,clp.ProductID,clp.ProductCategory,clp.FinalReviewDate,clp.LoanDisbursementDate,
clp.LoanAmountApproved,cds2.ClientLoan1AmtDueDisbursed as DueAmount,cds2.ClientLoan1AmountDisbursed as DisbursedAmount
from cds2 With (NoLock) 
Inner join clientloanProposal as clp on clp.LoanProposalID=cds2.LoanProposalID
inner join branches as b on b.BranchID=left(cds2.clientid,5)
Where cds2.ClientId Like '14%' and cds2.ClientLoan1AmtDueDisbursed > '0'
order by b.branchid,b.branchname,cds2.clientid,cds2.ClientLoan1ID,clp.targetname

--Cash Carry More than 30000
select left(clp.clientid,5) BID, b.BranchName, left(clp.clientid,8) CenterID, c.CenterName, ClientID, TargetName, LoanAmountDisbursed from clientloanproposal clp
inner join branches b on b.branchid=left(clp.clientid,5)
inner join centers c on c.centerid=left(clp.clientid,8)
where loanamountdisbursed>30000 and 
left(clientid,8) in (select centerid from centercashcarry where centerid like '16%') and 
proposaldate>='2023-04-01' and  clientid like '16%'

--Bridge Disbursed Loan With Kyc Number Local
Select b.BranchID,b.Branchname,clp.ClientID,clp.KYCNo,clp.Targetname as ClientName,clp.ProposalDate,clp.LoanProposalID,clp.LoanAmountApproved,clp.ProductId,clp.ProductCategory,
clp.NumberOfInstallments,clp.FinalReviewDate,clp.LoanDisbursementDate,clp.PrincipalOutstanding,clp.EntryBy as CMID,f.StaffName,clp.BMID,fs.staffname
from ClientLoanProposal as clp With (NoLock) 
inner join branches as b on b.branchID=left(clp.clientId,5)
inner join FieldStaff as f on f.StaffID=clp.EntryBy
inner join FieldStaff as fs on fs.StaffID=clp.BMID
where clp.ClientID like '16%' and clp.PrincipalOutstanding > '1' and clp.ProductCategory like '%%Bridge%%'
order by b.BranchID

----MINSURANCE Collection details
select LEFT(mis.ClientID,5) as BranchID,b.BranchName,count(mis.ClientID) as NoOFMINS,SuM(mis.CollAmount) as MINSAmount From MInsureSurvey as mis with (Nolock) 
Inner Join Branches as b on b.BranchID=LEFT(ClientID,5)
where clientID lIKe '14%' 
AND CollDate between '2024-01-01' and '2024-01-31'
group by LEFT(ClientID,5),b.BranchName
order by LEFT(ClientID,5)

--proposal not disbursed with neft status and center meeting day(ClientID IN)
Select b.branchID,b.BranchName,clp.clientid,Kycname,Case When KYCName='Aadhar' Then '********'+Right(KYCNo,4) 
Else  KYCNo End KYCNumber,clp.Targetname as ClientName,clp.ProposalDate,clp.LoanProposalID,clp.productid,clp.ProductCategory,clp.NumberOfInstallments,
clp.LoanAmountApproved,clp.FinalReviewDate,Case when C.ReportingDay=1 then 'Monday'
when C.ReportingDay=2 then 'Tuesday'
when C.ReportingDay=3 then 'Wednesday'
when C.ReportingDay=4 then 'Thursday'
when C.ReportingDay=5 then 'Friday'
when C.ReportingDay=6 then 'Saturday' end as CenterMeetingDay,
case when clp.bankname = ('0') then 'CMNeftPending' else 'CmNeftDone' end as CmNeftPendency,
case when clp.BmAccountNumber = ('0') then 'BMNeftPending' else 'BMNeftDone' end as BMNeftPendency
from clientLoanProposal as clp With (nolock) 
inner join centers as c on c.CenterID=left(clp.clientid,8)
inner join Branches as b on b.BranchID=left(clp.clientid,5)
where clp.ClientId in () and clp.LoanDisbursementDate is null and clp.PrincipalOutstanding = '1'

--proposal entry staffid and date wise
Select clp.EntryBy as Staff_ID,f.StaffName as CM_Name, count(clp.ClientRequestedAmount) as Proposal_Entry_Count,Sum(clp.ClientRequestedAmount) as Entry_Amount,clp.ProposalDate
from clientloanproposal as clp
inner join FieldStaff as f on f.StaffID=clp.EntryBy
where clp.Clientid like '10%' and clp.ProposalDate between '2025-03-06' and '2025-06-30' and clp.BmID = '13696'
group by clp.EntryBy,f.StaffName,clp.ProposalDate
order By clp.EntryBy,f.StaffName,clp.ProposalDate

---Deletion Format
SELECT B.Zone,B.DistrictName AS Region,B.BranchName,CLP.ClientID,CLP.Targetname AS ClientName,CLP.ClientRequestedAmount,CLP.LoanAmountApproved,CLP.ProposalDate,
CLP.FinalReviewDate,CLP.ProductCategory
FROM CLIENTLOANPROPOSAL AS CLP 
INNER JOIN BRANCHES AS B ON B.BRANCHID=LEFT(CLP.CLIENTID,5)
WHERE CLP.CLIENTID IN () AND CLP.PrincipalOutstanding = '1'


---Worthiness Format
select b.Zone,b.DistrictName as RegionName,b.branchName,cw.Clientid,cw.Loanamount,cw.DateStamp as WorthinessDate,cw.ProductCategory,cw.ReviewedDate 
from CreditWorthinesstrn as cw with (NoLock) 
inner join branches as b on b.BranchID=left(cw.clientid,5)
where clientid in () and Trnloanid not in (select Trnloanid from clientloanproposal where TRNLoanID is not null)

------Today Collection and DUE
select b.Branchid,BranchName,sum(ClientLoan1AmtDueDisbursed) TodayDue,
SUM(ClientLoan1PrincipalDue+ClientLoan1InterestDue) TodayCollection from CDS2 c inner join Branches b 
on left(c.clientid,5)=b.branchid where b.DissolvedDate  is null and branchid like'14%'
group by b.branchid,branchname
order by b.BranchID

-----Client Repayment Capacity should not be below then proposed loan Repayment amount...
Select b.DistrictName,B.BranchID,b.BranchName,c.ClientID,Clp.TargetName as ClientName,c.ClientLoan1ProductName,clp.ProposalDate,clp.LoanProposalID,clp.NumberOfInstallments,clp.LoanAmountApproved,clp.FinalReviewDate from CDS2 as c 
Inner Join ClientloanProposal as clp on clp.LoanProposalId=c.LoanProposalId 
Inner Join Branches as b on b. BranchID=Left(C.ClientID,5)
Where c.ClientId like '14%'  and c.ClientLoan1ProductName like '%Client%'
order by BranchID


-------KYC detail Center Wise 
-----------------------------------------------------------------------------------------
Select ClientID,c.CenterID,C.CenterName,ClientPrimaryNameasperKYC as ClientName,ClientPrimaryKycType AS KYCType,
(case when k.ClientPrimaryKycType IN ('Aadhar') then ('XXXXXXXX'+right(k.ClientPrimaryKycmember,4)) else k.ClientPrimaryKycmember end) KYCNO From Kyc k With (NoLock)
Inner Join Centers as c on c.centerID=k.CenterID
Where k.CenterID in ('36:24:47','36:24:48')

------LUC-------
select LEFT(lu.ClientLoanID,5)as BID,
(select branchname from Branches b where b.branchid=LEFT(lu.ClientLoanID,5))as BranchName
,lu.ClientLoanID, lu.LoanAmountDisbursed,
                                (case when cm_reviewDate is not null then cm_reviewDate  end )as CMRreview,
                                (case when bm_reviewDate  is not null then bm_reviewDate  end )as BMReview,
                                (case when Am_reviewDate  is not null then Am_reviewDate  end )as CHIBReview,
                                (case when aro_reviewdate  is not null then aro_reviewdate  end )as AROReview
from Loan_Utilisation as lu where 
lu.ClientLoanID in ( select ClientLoanID  from ClientLoanProposal where PrincipalOutstanding >1)
and lu.loandisbursementdate between '2024-04-01' and '2024-08-28'
and lu.clientloanid like '14%'

----App install details

SELECT b.BRANCHID,CHID,CHName,STAFFID , STAFFNAME,
(SELECT DesignationName  FROM [43.242.214.235].Appcashpor.dbo.DESIGNATIONMASTER WHERE DesignationID=FIELDSTAFF.DESIGNATION) AS POSITION
,appversion ,staffappversion FROM [43.242.214.235].Appcashpor.dbo.FIELDSTAFF 
Inner Join [43.242.214.235].Appcashpor.dbo.Branches b on b.BranchID=FIELDSTAFF.BranchID
WHERE 
b.BRANCHID LIKE '14%'
AND  EXITDATE IS NULL   
AND appversion='1.26' 
AND staffappversion not like '1.26%' 
and DESIGNATION not  IN ('48','99','17','1','2','20')  and staffname not like '%dummy%'
order by CHID,b.branchid ,STAFFID

------or

SELECT b.BRANCHID,CHID,CHName,STAFFID , STAFFNAME,
(SELECT DesignationName  FROM DESIGNATIONMASTER WHERE DesignationID=FIELDSTAFF.DESIGNATION) AS POSITION
,appversion ,staffappversion FROM FIELDSTAFF 
Inner Join Branches b on b.BranchID=FIELDSTAFF.BranchID
WHERE 
b.BRANCHID LIKE '22%'
AND  EXITDATE IS NULL   AND staffappversion not like '1.17%'
AND appversion like '1.17%' and DESIGNATION not  IN ('48','99','17','1' )  and staffname not like '%dummy%'
order by CHID,b.branchid ,STAFFID

---OR

SELECT AppVersion,StaffAppVersion,* from [43.242.214.235].appcashpor.dbo.FieldStaff where Staffid in ('BA03 ')

SELECT b.BRANCHID,CHID,CHName,STAFFID , STAFFNAME,
(SELECT DesignationName  FROM [43.242.214.235].Appcashpor.dbo.DESIGNATIONMASTER WHERE DesignationID=FIELDSTAFF.DESIGNATION) AS POSITION
,appversion ,staffappversion FROM [43.242.214.235].Appcashpor.dbo.FIELDSTAFF 
Inner Join [43.242.214.235].Appcashpor.dbo.Branches b on b.BranchID=FIELDSTAFF.BranchID
WHERE 
b.BRANCHID LIKE '05%'
AND  EXITDATE IS NULL   
AND appversion='1.22' 
AND (staffappversion not like '%1.21%' or staffappversion like '%1.21%')
and DESIGNATION not  IN ('48','99','17','1','2','20')  and staffname not like '%dummy%'
order by CHID,b.branchid ,STAFFID

----Today KYC Detail StaffWise

Select  b.BranchID,b.BranchName,fs.StaffID,fs.StaffName,Count(ClientPrimaryKycmember) as TotalKYC from Kyc with (NoLock) 
inner join Branches as b on b.BranchID=left(kyc.CenterId,5)
Inner Join Fieldstaff as fs on fs.staffID=kyc.StaffId
Where Left(ClientId,2) IN ('05') and cast(kyc.DateStamp as date) = '2025-11-11'
Group BY fs.StaffID,fs.StaffName,b.BranchID,b.BranchName
order by b.BranchID,b.BranchName,fs.StaffID,fs.StaffName

--OR

Select  left(clientid,2)RID,k.TrnLoanid,(select distinct(upper(districtname)) from Branches where left(Branchid,2)=left(clientid,2)) RegionName, 
left(k.ClientID,5) BranchID,(select Branchname from Branches where Branchid=left(k.clientid,5)) BranchName,
(select CHID from Branches where Branchid=left(k.clientid,5)) CHIBID,
(select CHNAME from Branches where Branchid=left(k.clientid,5)) CHNAME,
Clientid ,
(case when ClientPrimaryKyctype='Aadhar' then ('********'+right(ClientPrimaryKycmember,4)) else ClientPrimaryKycmember end)KYCNO
,ClientPrimaryKyctype,ClientPrimaryNameasperkyc,k.Datestamp

from KYC k(nolock) where  cast(datestamp AS date) = cast(getdate() - 1 AS date) and left(clientid,2) in ('31' , '35' , '36')
group by clientid,ClientPrimaryKycmember ,ClientPrimaryKyctype,ClientPrimaryNameasperkyc,k.TrnLoanid,k.Datestamp
order by left(clientid,2) 



---HR attendance Lofin pendency
select  b.CHID,b.CHName,b.BranchId,b.BranchName,StaffID,StaffName,DesignationName from fieldstaff  with(nolock) 
Inner Join Branches as b on b.BranchId=fieldstaff.BranchId
Inner Join DesignationMaster as d on d.DesignationID=fieldstaff.Designation
where staffid Not in (select  staffid  from  staffattendance  with(nolock)   where appversion = '1.4' ) 
and left(fieldstaff.branchid,2) in ('28')  and exitdate is null  and 
staffname not like '%dummy%' and DesignationID Not IN ('1')
and statusact <>0
