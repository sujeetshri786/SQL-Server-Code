select * from ClientLoanSubscription with(nolock) where ClientLoanID like '10%'  And LoanDurationInWeeks='20' And LoanAmountDisbursed='30000'
And Substring(ClientLoanID,14,2) = '2R'
--daily use command cmc local
---use Muzaffarpur
---use Kushinagar
---use Kushinagar
---use ambedkarnagar
---use jaunpur
--exec uspnewactivityproc '2023-09-09','2023-09-09','14'
--exec uspnewactivityproc '2023-09-09','2023-09-09','14'
--exec dayclose '14:24','2023-14-21'

select * from logfile with(nolock) where BranchID like '14%' and EndProcDate = '2023-12-15' and EndProcDate is null order by branchid

Select * From Report..DataBaseName Where DayIniStatus = '1'
Select * From Report..DataBaseName Where DayCloseStatus = '1'
select * from logfile with(nolock) where BranchID like '05%' and iniprocdate = '2025-11-28' and EndProcDate is null order by branchid
select Distinct(BranchID) from DICDS1 where regionid = '10' and ActualMeetingDate = '2025-10-09' order by branchid--Initialization
select Distinct(BranchID) from DICDS1 where regionid in ('10','21','22') and ActualMeetingDate = '2025-10-09' order by branchid--Initialization
select * from logfile with(nolock) where BranchID like '05%' and EndProcDate = '2024-05-27' order by branchid
select * from logfile with(nolock) where left(BranchID,2) in ('10','21','22') and EndProcDate = '2024-10-08' order by branchid
select * from logfile with(nolock) where left(BranchID,2) in ('10','21','22') and iniprocdate = '2025-10-08' and EndProcDate is null order by branchid
--exec uspnewactivityproc '2023-09-09','2023-09-09','14'
select * from branches With (NoLock) where DissolvedDate IS NULL and BranchID Not IN 
(Select BranchId from logfile with (Nolock) where IniProcDate = '2025-05-06' and Endprocdate is null) order by BranchID

Select * From Report..DataBaseName Where DayCloseStatus = '1'
select * from DICDS1
select * from Subsription_Update_Status where BranchID like '14:10'

----Ban Status
select * from [equifaxenquiry].[dbo].CCRMFILOANDETAILS  where clientid ='14:13:J4:01:68' and accountstatus like '%active%'
select * from [equifaxenquiry].[dbo].CCRMFILOANDETAILS  where clientid ='05:23:15:01:73' and Outstanding > 0
select * from equifaxenquiry..CCRMFILOANDETAILS  where clientid ='10:03:G4:03:60'  and accountstatus like '%active%'
select * from [equifaxenquiry].[dbo].CCRMFILOANDETAILS  where clientid ='10:20:05:01:41' and accountstatus like '%active%'  and EnquiryDate >= '2025-09-20'
select * from [equifaxenquiry].[dbo].CCRMFILOANDETAILS  where CustRefField ='100005261958' and accountstatus like '%active%'
select * from [equifaxenquiry].[dbo].CCRMFILOANDETAILS  where CustRefField LIKE '18026604%' and Outstanding > 0


----CCIR
Select Count (*) from EquiFaxEnquiry..TodayEnquiry Where SendStatus = 0
Select Count (*) from EquiFaxEnquiry..TodayEnquiry Where SendStatus = 0 and cast (Enquiry_Send_date as date) = '2025-05-05'
Select * from EquiFaxEnquiry..TodayEnquiry where clientid ='22:24:35:01:29'

--Recall Reprocess
Select * from DueCreationStop where LoanProposalId = '10:26:09509'

--Ashwani
declare @date date='2023-11-30'
select sum(cast(PrincipalOutstanding as bigint)) as AmountOutstanding  from clientloansubscription (nolock)where ActualPaidUpDate is null
select sum(riskfund) as InsuranceFee from clientloansubscription (nolock)where riskfunddate=@date
select sum(riskfund_2) as InsuranceFee2 from clientloansubscription (nolock)where riskfunddate_2=@date
select sum(upfrontfee) as ProcessingFee from clientloansubscription (nolock)where upfrontfeedate=@date
select sum(LoanAmountDisbursed) as DisbursementAmount from clientloansubscription (nolock)where DisbursementDate=@date
select sum(PrincipalCollected)as PrincipalCollected,sum(InterestCollected)as InterestCollected from loanledger (nolock)where WeeklyTransactionDate=@date


declare @date date = '2025-09-16'
declare @RID int = '10'
select sum(cast(PrincipalOutstanding as bigint)) as AmountOutstanding  from clientloansubscription (nolock)where ActualPaidUpDate is null and RegionID = @RID
select sum(riskfund) as InsuranceFee from clientloansubscription (nolock)where riskfunddate=@date and RegionID = @RID
select sum(riskfund_2) as InsuranceFee2 from clientloansubscription (nolock)where riskfunddate_2=@date and RegionID = @RID
select sum(upfrontfee) as ProcessingFee from clientloansubscription (nolock)where upfrontfeedate=@date and RegionID = @RID
select sum(LoanAmountDisbursed) as DisbursementAmount from clientloansubscription (nolock)where DisbursementDate=@date and RegionID = @RID
select sum(PrincipalCollected)as PrincipalCollected,sum(InterestCollected)as InterestCollected from loanledger (nolock)where WeeklyTransactionDate=@date and RegionID = @RID

declare @RID varchar (2) ='10'
declare @date date=(convert(nvarchar(10),getdate()-1,23)) -------(convert(nvarchar(10),getdate()-2,23))
select  (select sum(CAST(PrincipalOutstanding AS FLOAT)) from clientloansubscription with (nolock) where ActualPaidUpDate is null and regionid=@RID) AmountOutstanding, 
(select sum(riskfund) from clientloansubscription with (nolock) where riskfunddate=@date and regionid=@RID) InsuranceFee, 
(select sum(riskfund_2) from clientloansubscription with (nolock) where riskfunddate_2=@date and regionid=@RID) InsuranceFee2,
(select sum(upfrontfee) from clientloansubscription with (nolock) where upfrontfeedate=@date and regionid=@RID) ProcessingFee, 
(select sum(LoanAmountDisbursed)  from clientloansubscription with (nolock) where DisbursementDate=@date and regionid=@RID)DisbursementAmount ,
sum(PrincipalCollected)as PrincipalCollected,sum(InterestCollected)as InterestCollected from loanledger with (nolock) where WeeklyTransactionDate=@date and regionid=@RID

select sum(cast(PrincipalOutstanding as bigint)) as AmountOutstanding  from clientloansubscription (nolock)where ActualPaidUpDate is null and RegionID = '10'
select sum(riskfund) as InsuranceFee from clientloansubscription (nolock)where riskfunddate='2025-12-12' and RegionID = '05'
select sum(riskfund_2) as InsuranceFee2 from clientloansubscription (nolock)where riskfunddate_2='2025-12-12' and RegionID = '05'
select sum(upfrontfee) as ProcessingFee from clientloansubscription (nolock)where upfrontfeedate='2025-02-28' and RegionID = '10'
select sum(LoanAmountDisbursed) as DisbursementAmount from clientloansubscription (nolock)where DisbursementDate='2025-02-28' and RegionID = '10'
select sum(PrincipalCollected)as PrincipalCollected,sum(InterestCollected)as InterestCollected from loanledger (nolock)where WeeklyTransactionDate='2025-02-28' and RegionID = '10'

declare @rid varchar(2)='05'                                                                                                                                                              
declare @date date=(convert(nvarchar(10),getdate()-1,23))
select  (select sum(CAST(PrincipalOutstanding AS FLOAT)) from clientloansubscription with (nolock) where ActualPaidUpDate is null and regionid=@rid)  AmountOutstanding ,
(select sum(riskfund) from clientloansubscription with (nolock) where riskfunddate=@date and regionid=@rid) InsuranceFee,
(select sum(riskfund_2) from clientloansubscription with (nolock) where riskfunddate_2=@date and regionid=@rid) InsuranceFee2,
(select sum(upfrontfee) from clientloansubscription with (nolock) where upfrontfeedate=@date and regionid=@rid) ProcessingFee,
(select sum(LoanAmountDisbursed)  from clientloansubscription with (nolock) where DisbursementDate=@date and regionid=@rid)DisbursementAmount,
sum(PrincipalCollected)as PrincipalCollected,sum(InterestCollected)as InterestCollected from loanledger with (nolock) where WeeklyTransactionDate=@date and regionid=@rid

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

select
                isnull(sum(cast(PrincipalOutstanding as bigint)), 0) as Outstanding,
                isnull(sum(case when RiskFundDate = '2025-03-03'  then RiskFund  end), 0) Insurance1,
                isnull(sum(case when RiskFundDate_2 = '2025-03-03'  then RiskFund_2  end), 0) Insurance2,
                isnull((sum(case when RiskFundDate = '2025-03-03'  then RiskFund  end))+(sum(case when RiskFundDate_2 = '2025-03-03'  then RiskFund_2  end)),0) as SumInsuranceAmt,
                isnull(sum(case when UpFrontFeeDate = '2025-03-03' then UpFrontFee   end), 0) as processing,
                isnull(sum(case when DisbursementDate= '2025-03-03' then LoanAmountDisbursed end), 0) as TodayDisb_CLS,
                isnull(sum(case when DisbursementDate <> ActualDisbursementDate  and DisbursementDate = '2025-03-03' and DisbursementMode In('2','4')
                                then LoanAmountDisbursed end), 0) as LastAPBSDisb_CLS,
                (select isnull(sum (principalcollected), 0) from LoanLedger where weeklytransactiondate = '2025-03-03' and regionid = '28') as 'PrincipalColl',
                (select isnull(sum (InterestCollected), 0) from LoanLedger  with(nolock) where weeklytransactiondate = '2025-03-03' and regionid = '28' ) as 'InterestColl'
from ClientLoanSubscription with(nolock) where regionid = '28'

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Disbursement Not Show In Account Local

select * from ClientLoanSubscription with(nolock) where ClientLoanID like '21:14:13:01:23%' 
select * from AtClientLoanSubscription with(nolock) where ClientLoanID like '14:04:A1:01:69%' 

---  for utr
select CASHPORONE..ClientLoanSubscription.clientloanid,[Benef Name]as Client_Name,[Benef Ac No]as Account_No,[BENEF IFSC CODE]as IFSC_CODE,
[UTR Sr No]as UTR_No,
CASHPORONE..ClientLoanSubscription.LoanAmountDisbursed,CASHPORONE..ClientLoanSubscription.DisbursementDate
from cashpor..ReversedMISDetailReverse 
With(Nolock)inner join CASHPORONE..ClientLoanSubscription on cashpor..ReversedMISDetailReverse.[Benef Ac No]=
CASHPORONE..ClientLoanSubscription.accountno

where clientloanid = '21:12:54:01:46:R0:01'--
--Where [benef Ac No] ='05763211099116'
order by DisbursementDate desc

--Penny Less Documentation And Disbursement Check
declare @clientid  varchar(14) = '10:02:37:01:57'
SELECT  cls.clientloanid,cls.disbursementdate,cls.ifsccode,cls.accountno,p.Remark , p.matchstas,p.response
FROM  Playground..PennyLessDocumentation p with(nolock) INNER JOIN clientloansubscription cls with(nolock)
ON cls.clientloanid = p.clientloanid  where left(cls.clientloanid ,14)   = @clientid

--Select * from cashpor..ReversedMISDetailReverse 

Select Amount, [Beneficiary name], [IFSC Code], [Bemeficiary account no], [UTR NO], [Payment date]
From cashpor..ReversedMISICICI Where [Bemeficiary account no] = '05763211099116'

SELECT * from FieldStaff where Staffid in ('22555')

Select * From DICDS1 With (NoLock) Where CenterId Like '14:12%'
Select * from DIcds2 With (NoLock) Where ClientID Like '05:04:05:01:08'
Select * from DICDS3 With (NoLock) Where ClientID Like '14:12%'

Select * From FieldStaff With (NoLock) where Designation = '14' And exitdate is null And BranchID like '14:17%' order by branchid

Select * From MyBranchPerformance Where BranchId like '14:21%' And Designation='14'--Bm Performance

Select * From MyPerformance With (NolOck) where StaffId = '12406'

Select ClientLoan2UpFrontFee,ClientLoan1UpFrontFee,ClientLoan2InstallmentNumber,ClientLoan1TotalCollected,* 
From cds2 With (NoLock) Where ClientID Like '14:29:J2:01:58%'
Select * from DIcds2 With (NoLock) Where ClientID = '14:01:68:03:47'

Select Sum(ClientLoan1TotalCollected) As TotalCollection, Sum(ClientLoan2UpFrontFee) As Insurance, Sum(ClientLoan1UpFrontFee) As Processing
From cds2 With (NoLock) Where ClientID Like '14:06:S1:01:06%'--Back date collection Deatils

Select * From Insurance_Master Where RID = '28'--For Interest Rate
Select * From InsuranceMaster Where RID = '14'--For Interest Rate

Select * from Loan_Utilisation With (NoLock) Where ClientLoanID Like '21:26:66:01:21%'

Select * From Audit..SettlementReport With (NoLock) Where PartnerTxnRefNo = '414808488727'
Select * From Audit..SettlementReport With (NoLock) Where PartnerTxnRefNo = '331009661385'

Select Staffid,deathdate,DeathEntryDate,riskfund as InsuranceAmount1,RiskfundDate as InsuranceEntryDate1,
riskfund_2 as InsuranceAmount2,RiskFundDate_2 as InsuranceEntryDate2,upfrontfee,upfrontfeedate,numpersoninsured,DeathPerson,* From ClientLoanSubscription 
With (NoLock) Where SUBSTRING(ClientLoanID,16,2)='6Y' and ClientLoanID Like '05%' and ActualPaidUpDate IS NULL and LoanAmountDisbursed = '200000'
and LoanDurationInWeeks='104' and CurrentInstallmentPeriod = '2'

Select principaloutstanding,* From ClientLoanSubscription With (NoLock) Where ClientLoanID Like '14:08:73:01:81%' and ActualPaidUpDate is null
Select principaloutstanding,* From ClientLoanSubscription With (NoLock) Where ClientLoanID Like '24:05:20:01:31%' and principaloutstanding > '0'

Select ClientLoanID,deathdate,DeathEntryDate,riskfund as InsuranceAmount1,RiskfundDate as InsuranceEntryDate1,RiskFund_2 InsuranceAmount2,RiskFundDate_2 InsuranceEntryDate2,
upfrontfee,upfrontfeedate,numpersoninsured,DeathPerson,Staffid,SumAssuredAmt,CMC_Part,PrincipalInArrears,InterestInArrears, * From ClientLoanSubscription
With (NoLock) Where ClientLoanID like '05:31:02:01:14%' AND ActualPaidUpDate is null

Select clientLoanId,SumAssuredAmt,CMC_Part,ActualPaidUpDate,PrincipalInArrears,InterestInArrears,Staffid,deathdate,DeathEntryDate,riskfund as InsuranceAmount,
RiskfundDate as InsuranceEntryDate,upfrontfee,upfrontfeedate,numpersoninsured,DeathPerson, * From ClientLoanSubscription
With (NoLock) Where ClientLoanID like '14:22:W4:01:52:R4:01%' --and  ActualPaidUpDate > '2023-12-01'

--Health Insurance
Select ClientLoanID,HealthInsurance,HealthInsuranceSpouse,HealthInsuranceDate,HealthInsuranceSendDate,HealthInsuranceSpouseSendDate 
From ClientLoanSubscription With (NoLock) Where ClientLoanId Like '10:24%'  and HealthInsuranceDate = '2025-01-02'

--Select * From NeftdisbTransaction with (NoLock) where LoanProposalId IN ('14:10:31014')
select CollectionMode,BalanceOutstanding,* from LoanLedger where ClientLoanID like '14:19:ZR:01:52:R2:01%'  Order By WeeklyTransactionDate --and WeeklyTransactionDate = '2024-02-10'

select CollectionMode,BalanceOutstanding,* from closedLoanLedger where ClientLoanID like '05:22:D3:03:46:P2:01%'  Order By WeeklyTransactionDate

select CollectionMode,BalanceOutstanding,* from LoanLedger where ClientLoanID in ('05:06:EV:01:75') 
AND cast(WeeklyTransactionDate as date) = '2024-10-20' Order By ClientLoanID,WeeklyTransactionDate--And cast(WeeklyTransactionDate as date) = '2024-03-06' 

Select * From products where ProductID in ('v1','v9','r9','F0','F4','G3','G5','G8','L4','U4')
Select * From products where ProductID in ('88','C0','C1','W1')

Select deathdate,DeathEntryDate,riskfund,RiskfundDate,upfrontfee,upfrontfeedate,numpersoninsured,DeathPerson, * From ClientLoanSubscription 
With (NoLock) Where ClientLoanID like '10:16:J1:01:64:I9:01%' --and cast(DateofUpdation as Date) = '2023-10-06'

--Select * From Wir With (NoLock) Where ProductID = 'R4' And LoanAmount = '30000' order By InstallMentNo--kist
Select deathdate,DeathEntryDate,riskfund,RiskfundDate,upfrontfee,upfrontfeedate,numpersoninsured,DeathPerson, * From ATClientLoanSubscription 
With (NoLock) Where ClientLoanID like '10:12:d8:01:63%'

Select deathdate,DeathEntryDate,riskfund,RiskfundDate,upfrontfee,upfrontfeedate,numpersoninsured,DeathPerson,HealthInsuranceDate,HealthInsurance,
* From ClientLoanSubscription 
With (NoLock) Where ClientLoanID Like '28:12:69:01:40:R1:01%'

Select deathdate,DeathEntryDate,riskfund,RiskfundDate,upfrontfee,upfrontfeedate,numpersoninsured, * From ATClientLoanSubscription 
With (NoLock) Where ClientLoanID Like '10:04:n3:01:65%'

--Insurane correction
Select ClientLoanID,LoanProposalID,DisbursementDate,DateofUpdation as LoanCancelDate,riskfund as Insurance,RiskfundDate as InsuranceEntryDate,
upfrontfee as Processing,upfrontfeedate  as ProcessingEntryDate
from AtclientloanSubscription
where ClientLoanId Like '14:14:ii:01:86%'

Select left(clientloanID,5) as BranchID, sum(LoanAmountDisbursed) as DisbursedAmount from ClientLoanSubscription Where Actualdisbursementdate = '2023-14-02' and clientloanID like '14:28%'
group by left(clientloanID,5)

----------------------------------Insurance
Select ClientLoanID,RiskfundDate as InsuranceEntryDate1,riskfund as Insurance1 from ClientLoanSubscription With (NoLock) Where ClientLoanID Like '14:21%' 
And cast(RiskfundDate as date) = '2026-03-06'

Select ClientLoanID,RiskFundDate_2 as InsuranceEntryDate2,RiskFund_2 as Insurance2 from ClientLoanSubscription With (NoLock) Where ClientLoanID Like '14:21%' 
And cast(RiskFundDate_2 as date) = '2026-03-06'

----------------------------------Processing
Select ClientLoanID,upfrontfeedate as ProcessingEntryDate,upfrontfee as Processing from ClientLoanSubscription With (NoLock) Where ClientLoanID Like '14:21%'
And cast(upfrontfeedate as date) = '2026-03-06'

--Select sum(riskfund-2) as Insurance,RiskfundDate as InsuranceEntryDate from ClientLoanSubscription With (NoLock) Where ClientLoanID Like '14:18%' 
--And cast(RiskFundDate_2 as date) = '2023-12-13'
--group by RiskfundDate

--Select sum(upfrontfee) as Processing,upfrontfeedate as ProcessingEntryDate from ClientLoanSubscription With (NoLock) Where ClientLoanID Like '14:12%' 
--And cast(upfrontfeedate as date) = '2023-12-04'
--group by upfrontfeedate

select * from tempdailyclosingdtl where branchid='14:28'

select * from atclientloansubscription where loanproposalid='14:28:23791'

--For Settlement
Select ClientLoanID,WeeklytransactionDate,PrincipalinstallmentAmt,PrincipalCollected,interestInstallMentAmt,interestCollected,
BalanceOutStanding From LoanLedger With (NoLock) 
Where ClientLoanID Like '10:26%' And WeeklyTransactionDate = '2024-07-18'

--Settle ClientDetails
Select c.ClientLoanID,l.WeeklytransactionDate MeetingDate,l.PrincipalinstallmentAmt PrincDue,l.PrincipalCollected PrinColl,l.interestInstallMentAmt InsDue,l.interestCollected InsColl,
l.BalanceOutStanding Outstanding From LoanLedger l With (NoLock) 
Inner Join ClientLoanSubscription c on c.ClientLoanID=l.ClientLoanID
Where c.ClientLoanID Like '05:05%' And l.WeeklyTransactionDate = '2025-11-29' and (c.ActualPaidUpDate is not Null or c.ActualPaidUpDate is Null) and
(l.PrincipalinstallmentAmt >= 0 or l.interestInstallMentAmt >= 0) and (l.PrincipalCollected > l.PrincipalinstallmentAmt or l.interestInstallMentAmt > l.interestCollected)

---Settle ALL ClientDetails
Select c.ClientLoanID,l.WeeklytransactionDate MeetingDate,l.PrincipalinstallmentAmt PrincDue,l.PrincipalCollected PrinColl,l.interestInstallMentAmt InsDue,l.interestCollected InsColl,
l.BalanceOutStanding Outstanding From LoanLedger l With (NoLock) 
Inner Join ClientLoanSubscription c on c.ClientLoanID=l.ClientLoanID
Where c.ClientLoanID Like '05:05%' And l.WeeklyTransactionDate = '2025-11-17' and c.ActualPaidUpDate is not Null

----------BranchWise Collection
Select left(ll.ClientLoanID,5) as Branchid,b.Branchname,Sum(PrincipalCollected+InterestCollected) As Collection  From Loanledger  as ll With (noLock) 
inner join branches as b on b.branchid=left(ll.ClientLoanID,5)
Where ll.ClientLoanID like '05%' And ll.WeeklyTransactionDate between '2026-02-23' and '2026-02-23' and CollectionMode not IN ('4','7','6','5')
group by left(ll.ClientLoanID,5), b.Branchname
order by left(ll.ClientLoanID,5), b.Branchname

----------Center Wise Collection
Select left(ll.ClientLoanID,5) as Branchid,b.Branchname,left(ll.ClientLoanID,8) as CenterID,c.CenterName,ll.WeeklyTransactionDate as CollectionDate,
Sum(PrincipalCollected+InterestCollected) As Collection
From Loanledger  as ll With (noLock) 
inner join branches as b on b.branchid=left(ll.ClientLoanID,5)
inner join Centers as c on c.centerid=left(ll.ClientLoanID,8)
Where ll.ClientLoanID like '14:07%' And ll.WeeklyTransactionDate between '2026-03-13' and '2026-03-13' and ll.CollectionMode IN ('4','7','6','5')
group by left(ll.ClientLoanID,8),c.CenterName,left(ll.ClientLoanID,5),b.Branchname,ll.WeeklyTransactionDate
order by left(ll.ClientLoanID,5), b.Branchname

----------ClientWise Collection
Select left(ll.ClientLoanID,5) as BranchID,B.Branchname,left(ll.ClientLoanID,8) as CenterID,c.CenterName,left(ll.ClientLoanID,14) as ClientID,
cast(ll.WeeklyTransactionDate as date) as CollectionDate,Sum(PrincipalCollected+InterestCollected) As Collection  From Loanledger  as ll With (noLock) 
inner join branches as b on b.branchid=left(ll.ClientLoanID,5)
inner join Centers as c on c.centerid=left(ll.ClientLoanID,8)
Where ll.ClientLoanID like '14:21:O4%' And ll.WeeklyTransactionDate between '2026-03-03' and '2026-03-03' and ll.CollectionMode IN ('4','7','6','5')
group by left(ll.ClientLoanID,14),left(ll.ClientLoanID,5),left(ll.ClientLoanID,8),b.Branchname,c.CenterName,ll.WeeklyTransactionDate
order by left(ll.ClientLoanID,14), b.Branchname

--UPI Collection
Select left(ll.ClientLoanID,05) as BranchID,b.Branchname,left(ll.ClientLoanID,20) as ClientLoanID,
CASE WHEN ll.CollectionMode = 0 THEN 'CASH'
	 WHEN ll.CollectionMode IN ('4','7','6','5') THEN 'UPI'
	 ELSE 'BackDateUPI' End As PayMentMode,
ll.WeeklyTransactionDate as MeetingDate,Sum(PrincipalCollected+InterestCollected) As Collection,ll.CollectionMode
From Loanledger  as ll With (noLock) 
inner join branches as b on b.branchid=left(ll.ClientLoanID,5)
Where ll.ClientLoanID like '05:21%' And ll.WeeklyTransactionDate between '2026-03-13' and '2026-03-13'
group by left(ll.ClientLoanID,20),left(ll.ClientLoanID,05), b.Branchname,ll.CollectionMode,ll.WeeklyTransactionDate
order by left(ll.ClientLoanID,20),left(ll.ClientLoanID,05), b.Branchname,ll.CollectionMode,ll.WeeklyTransactionDate

--Branch Wise Disbursement
Select Left(cls.ClientLoanID,5) As BranchID,b.BranchName, count(cls.ClientLoanID) as NoOfDisB, Sum(cls.LoanAmountDisbursed) As DisburseAmount
From ClientLoanSubscription as cls
inner join branches as b on b.branchId=Left(cls.ClientLoanID,5)
where cls.DisbursementDate between '2026-02-01' and '2026-02-28' and cls.ActualPaidUpDate is NULL and cls.RegionID = '05'
Group by Left(ClientLoanID,5),b.BranchName
order by Left(ClientLoanID,5)

------DCR COLLECTION
Select BranchID,SUM(TotalCollection+DigiCollFingPay+Upi_Collection) TotalCollection From DailyClosingDTL With (NoLock) Where BranchID Like '05%'
group by BranchID
order by BranchID


--select ClientLoan1ID,SUM(ClientLoan1PrincipalDue+ClientLoan1InterestDue) Due,SUM(ClientLoan1PrincipalCollected+ClientLoan1InterestCollected) 
--Collection From prevcds2 where clientloan1id like '10:04%'
--group by ClientLoan1ID
--having SUM(ClientLoan1PrincipalCollected+ClientLoan1InterestCollected) >0


--Select ll.ClientLoanID as ClientLoanID,sum(ll.PrincipalCollected+ll.InterestCollected) as Collection From LoanLedger as ll With (noLock) 
--Where ll.ClientLoanID like '10:04%' and Weeklytransactiondate = '2025-04-17'
--group By ll.ClientLoanID
--having sum(ll.PrincipalCollected+ll.InterestCollected)>0

--------------backdate due report
select * from MasterActivity..DueReport where meetingdate between '2023-11-01' and '2023-11-30' and RegionID = '14' order by branchid ,MeetingDate desc	

--Collection details
Select LEFT(ClientLoanID,20) as ClientLoanID,sum(PrincipalCollected+InterestCollected) as Collection From LoanLedger With (noLock) 
Where WeeklyTransactionDate = '2026-03-12' 
and ClientLoanID like '14:29%'
group By LEFT(ClientLoanID,20)

--Cash collection Total
Select sum(PrincipalCollected+InterestCollected) as CashCollection From LoanLedger With (noLock) 
Where WeeklyTransactionDate = '2026-02-27'  
and ClientLoanID like '14:24%' and CollectionMode not IN ('4','7','6','5')

--QRCashless collection Total
Select sum(PrincipalCollected+InterestCollected) as QRCollection From LoanLedger With (noLock) 
Where WeeklyTransactionDate = '2026-01-03' and CollectionMode IN ('4','7','6','5') and Payment_Tran_ID is not NULL
and ClientLoanID like '05:06%'

--AirtelCashless collection Total
Select sum(PrincipalCollected+InterestCollected) as UPICollection From LoanLedger With (noLock) 
Where WeeklyTransactionDate = '2026-01-03' and CollectionMode IN ('4','7','6','5') and Payment_Tran_ID is NULL
and ClientLoanID like '05:06%'


--ClientWise Settlement
Select LEFT(ll.ClientLoanID,20) as CenterId,sum(ll.PrincipalCollected+ll.InterestCollected) as Collection From LoanLedger as ll With (noLock) 
inner join ClientLoanSubscription as cls on cls.ClientLoanID=ll.ClientLoanID and cls.ActualPaidUpDate=ll.WeeklyTransactionDate
Where ActualPaidUpDate = '2026-02-20'
and ll.ClientLoanID like '05:05%'
group By LEFT(ll.ClientLoanID,20)

--UPI Rectification
select ClientLoanID,WeeklyTransactionDate,PrincipalInstallmentAmt	,PrincipalCollected,InterestInstallmentAmt,
InterestCollected,CollectionMode from LoanLedger where ClientLoanID IN ('14:18:H7:04:14:P3:01') And WeeklyTransactionDate = '2023-03-15'

Select * From Prevcds2 Where ClientID Like '14:14%' and ClientLoan1AmountDisbursed >'0'

Select * From products where ProductID IN ('h2','o7','r4')

select * from ClientLoanSubscription with(nolock) where SUBSTRING(ClientLoanID,14,2) = 'O2' And LoanAmountDisbursed = '30000'
And CurrentInstallmentPeriod = '120' and LoanDurationInWeeks = '120'

--Cashless
Select BranchID,Sum(PrincipalCollected+InterestCollected) UPICollection,WeeklyTransactionDate TransactionDate From LoanLedger With (NoLock) 
Where ClientLoanID Like '14:14%' And CollectionMode in ('4','5','6','7') and  
weeklyTransactionDate = '2025-10-08'
Group By BranchID,WeeklyTransactionDate

--cash
Select BranchID,Sum(PrincipalCollected+InterestCollected) CashCollection,WeeklyTransactionDate TransactionDate From LoanLedger With (NoLock) 
Where ClientLoanID Like '05:02%' And CollectionMode not in ('4','5','6','7') and  
weeklyTransactionDate = '2025-10-15'
Group By BranchID,WeeklyTransactionDate

--UPI Collection BranchWise
Select b.BranchID,b.Branchname,Sum(l.PrincipalCollected+l.InterestCollected) UPICollection,WeeklyTransactionDate TransactionDate From LoanLedger l With (NoLock)
Inner Join Branches as b on b.BranchID = l.BranchID
Where l.ClientLoanID Like '05%' And l.CollectionMode in ('4','5','6','7') and  
weeklyTransactionDate = '2025-10-07'
Group By b.BranchID,b.Branchname,l.WeeklyTransactionDate

----UPI Collection CenterWise
Select b.BranchID,b.BranchName,c.CenterID,c.CenterName,WeeklyTransactionDate TransactionDate,Sum(PrincipalCollected+InterestCollected) UPICollection From LoanLedger l With (NoLock) 
Inner Join Branches as b on b.BranchID = l.BranchID
Inner Join Centers as c on c.CenterID = l.CenterID
Where ClientLoanID Like '14:01%' And l.CollectionMode not in ('4','5','7') and  
weeklyTransactionDate = '2026-01-07'
Group By b.BranchID,b.BranchName,c.CenterID,c.CenterName,WeeklyTransactionDate

--Cashless

Select clientloanID,(principalCollected+InterestCollected) as Collection From LoanLedger With (NoLock) Where ClientLoanID Like '10:24%'
and weeklytransactiondate = '2025-09-15' and collectionMode in ('4','7','5','6') and regionid = '21'

select * from Clients where ClientID Like '21:14:79%' and DropOutStatus = '0' order by ClientID
--
Select * From RptDailyClosingDtl With (Nolock) where BranchID like '05:05%' and MeetingDate = '2026-03-09'
Select * From BackDateDailyClosingDtl With (Nolock) where BranchID like '14:05%' and MeetingDate = '2026-01-02'

----DCR Collection
Select BranchID,BranchName,Sum(DigiCollFingPay+UPI_Collection) as UPI_Collection,Sum(TotalCollection) Cash_Collection From DailyClosingDtl With (Nolock) where BranchID like '05%' 
and MeetingDate Between '2026-02-01' and '2026-02-28'
Group By BranchID,BranchName
Order By BranchID,BranchName

SELECT  eligibleforfl,Eligible_Flexi_Amount,loancycle,eligibleLoanAmount,* FROM Clients WITH(NOLOCK) 
WHERE CLIENTID IN ('05:01:K7:01:52')
Select maritialstatus,* From Targets with (NoLock) Where TargetID = '10:06:15990'----0=Married,1=Seperated,2=Widow
--SELECT * FROM ATClients WITH(NOLOCK) WHERE CLIENTID LIKE '14:21:80:03:49%'
Select maritialstatus,* from Targets Where TargetID = '21:20:00234'
SELECT  eligibleforfl,Eligible_Flexi_Amount,loancycle,eligibleLoanAmount,*
FROM Clients WITH(NOLOCK) WHERE CLIENTID LIKE '21:02:01:01:15%'
Select AccountNo,IFSCCode,* From ClientLoanSubscription With (NoLock) Where ClientLoanId Like '14:19:11:03:25%'
Select AccountNo,IFSCCode,* From ClientLoanSubscriptionClosed With (NoLock) Where ClientLoanId Like '10:15:02:01:34%'
Select * From ClientLoanProposal With (NoLock) Where ClientID Like '14:02:E1:01:73%'
select * from ClientLoanProposalClosed (NoLock) Where ClientID Like '14:02:E1:01:73%'
Select * From ClientLoanProposal With (NoLock) Where ClientID Like '10:16:36:01:73%' And PrincipalOutstanding = '1'
Select ClientLoan2UpFrontFee as Insurance_Amount,RISKFUNDDATE as Insurance_Fee_Entry_Date,ClientLoan1UpFrontFee as Processing_Fee,UPFRONTFEEDATE as Processing_Fee_Entry_Date,
ClientLoan2InstallmentNumber,ClientLoan1TotalCollected,* From cds2 With (NoLock) Where ClientLoan1ID Like '21:02:01:01:15%'
Select * From ClientLoanProposal With (NoLock) Where LoanProposalID IN ('14:09:42357') And PrincipalOutstanding = '1'
Select * From ClientLoanProposal With (NoLock) Where ClientID IN () And PrincipalOutstanding = '1'
Select * From ATClientLoanProposal With (NoLock) Where ClientID Like '14:02:E1:01:73%'
select  * from RejectedProposal with(nolock)where clientid like '14:02:E1:01:73%'
select  * from Proposal_Rejected_BY_BCBANK with(nolock)where clientid like '05:32:93:01:27%'
select  * from Aadhardisbursement with(nolock)where clientid like '11:03:C9:01:95%'
Select * From DailyClosingDTL With (NoLock) Where BranchID Like '14:06%' and send = '0' order by Branchid--2023-06-14 17:23:14.613
select * from Insurance_Master where rid = '14'
select * from Insurance_Master1 where rid = '14'
Select * From products where ProductID in ('84','85','88','C0','C4','E3','G0','H4','O2')

select * from ClientLoanSubscription with(nolock) where LoanProposalID like '05:01:43785%' 
select * from AtClientLoanSubscription with(nolock) where LoanProposalID like '05:01:43785%' 

--delete ClientLoanProposal Where LoanProposalID IN ('14:28:17718')

--INSERT INTO atdataentrybc values
--('21:11:ZB:01:53','21:11:36641','Approved','','','','','','7066','2022-14-14 12:30:30.123')

Select * from Cashpor..ATNeftClientBankDetail With (NoLock) Where AccountNumber = '35030937764'--Roe Neft Entry Time-34311755614
Select * from Cashpor..ATNeftClientBankDetail With (NoLock) Where IFSCCode = 'CBIN0R10001'--Roe Neft Entry Time
Select * from Cashpor..ATNeftClientBankDetail With (NoLock) Where ClientID = '10:22:32:01:15'

Insert into Cashpor..ATNeftClientBankDetail (LoanProposalID,ClientId,AccountNumber,IFSCCode,Datestamp)
values('14:11:14663','14:11:ZD:01:31','1021811030037724','CBIN0R10001','2023-10-31 15:06:41.273')

--------Indusend review ---------

Select Approved,* From INDUSendReview With (NoLock) Where Excustomerid in ('21:02:01:01:15')
Select * From LoanFundReleased With (NoLock) Where ExternalLoanNo = '21:02:01:01:15'--Sanction detail date
Select * From LoanMaster With (NoLock) Where ExternalLoanNo = '21:02:01:01:15'--proposal expiry after 21 days of snaction date

Select Approved,* From INDUSendReview With (NoLock) Where Loanproposalid in ('16:18:43968','16:18:43974')--BC Review
Select * From LoanFundReleased With (NoLock) Where ExternalLoanNo = '16:07:42733'--Sanction detail date
Select * From LoanMaster With (NoLock) Where ExternalLoanNo = '16:07:42733'--proposal expiry after 21 days of snaction date

select * from indusindstatus
--------ICICI review ---------
select * from BC_Status
Select * From ICICIBCAPPROVEDSTATUS with (NoLock)
Select * From cashpor..EKYCICICI With (NoLock) Where ClientID = '14:04:E6:01:61'--ekyc print

Select Approved,Remark,* From ICICIREVIEW With (NoLock) Where CustomerID IN ('21:02:01:01:15')
Select * From BCLoanFundReleasedICICI With (NoLock) Where ClientID in ('21:02:01:01:15')
Select * From BCLoanMasterICICI With (NoLock) Where ExternalCustomerID = '21:02:01:01:15'

Select Approved,Remark,* From ICICIREVIEW With (NoLock) Where Loanproposalid in ('10:25:35895')
Select * From BCLoanFundReleasedICICI With (NoLock) Where Loanproposalid in ('10:25:35895')
Select * From BCLoanMasterICICI With (NoLock) Where ExternalLoanNo in ('10:25:35895')--ICICI Loan CHECK

--------SIDBI review ---------
Select loanproposalID,Approved,Remark,* From SidbiReview With (NoLock) Where CustomerID IN ('21:02:01:01:15')
Select * From BCLoanFundReleasedSIDBI With (NoLock) Where ClientID in ('21:02:01:01:15')
Select * From BCLoanMasterSIDBI With (NoLock) Where ExternalCustomerID = '21:02:01:01:15'

Select Approved,Remark,* From SidbiReview With (NoLock) Where LoanProposalID IN ('05:18:66669')
Select * From BCLoanFundReleasedSIDBI With (NoLock) Where LoanProposalID in ('05:18:66669')
Select * From BCLoanMasterSIDBI With (NoLock) Where ExternalLoanNo = '05:18:66669'

select * from Sidbireview
--delete clientloanproposal Where Loanproposalid in ('16:07:42733','14:27:39176')
--------IDBI review ---------
Select approved,loanproposalID,* From IDBIReview With (NoLock) Where CustomerID Like '21:02:01:01:15%'
Select * From BCLoanFundReleased With (NoLock) Where ClientID in ('21:02:01:01:15')--IDBI review me approved no 1 hone par record isame ayega
Select * From BCLoanMaster With (NoLock) Where ExternalCustomerID = '21:02:01:01:15'--IDBI review me approved no 1 hone par record isame ayega

Select approved,loanproposalID,* From IDBIReview With (NoLock) Where LoanProposalID in ('14:27:39176')
Select * From BCLoanFundReleased With (NoLock) Where LoanProposalID in ('14:27:39176')
Select * From BCLoanMaster With (NoLock) Where ExternalLoanNo = '14:27:39176'

select * from IDBIStatus

--------Kotak review ---------
Select Approved,Remark,* From KotakReview With (NoLock) Where CustomerID in ('21:02:01:01:15')
Select * From BCLoanFundReleasedKOTAK With (NoLock) Where ClientID in ('21:02:01:01:15')
Select * From BCLoanMasterKOTAK With (NoLock) Where ExternalCustomerID = '21:02:01:01:15'

Select Approved,Remark,* From KotakReview With (NoLock) Where Loanproposalid in ('22:14:24026')
Select * From BCLoanFundReleasedKOTAK With (NoLock) Where LoanProposalID in ('22:14:24026')
Select * From BCLoanMasterKOTAK With (NoLock) Where ExternalLoanNo = '22:14:24026'

--------IDFC review ---------
Select approved,loanproposalID,* From IDFCReview With (NoLock) Where ClientID Like '38:02:90:01:19%'

Select * from pfrdacollection where ClientId Like '14:12:E9:01:04%'--database PFRDA Local

Select remark,CustomerId,LoanProposalID,customername,LoanamountApproved,Approved,VerifyDate,* From ICICIREVIEW 
With (NoLock) Where Loanproposalid in ('21:09:29323')

select  * from RejectedProposal with(nolock)where clientid like '10:18:22:01:14%'

select * from ClientLoanSubscription with(nolock) where ClientLoanID like '14:03:14:01:83%' and substring(ClientloanID,14,2)='R2'and LoanAmountDisbursed='20000'
and LoanDurationInWeeks='98'--product ka interest aur principal check karana hai

Select  * From ICICIPennyResponse Where TranRefNO = '17523232'
Select * From Playground..pennylessdocumentation where TRNLOAN_ID = '18029599'
Select AccountNo,IFSCCode,* From ClientLoanSubscription With (NoLock) Where ClientLoanId Like '14:28:AO:01:26%'

select * from WIR Where productid in ('4X') and loanamount = '90000' order by InstallmentNO
select * from CompleteWIRSheet Where productid in ('6Y') and loanamount = '200000' order by InstallmentNO

select * from ClientLoanSubscription with(nolock) where ClientLoanID like '05:27:E8:01:69:R1:01%'
select * from LoanLedger where ClientLoanID like '05:19:Q7:01:84:P3:02%' Order By WeeklyTransactionDate

select PrincipalOutstanding,* from ClientLoanSubscription with(nolock) where ClientID in ('14:01:12:01:41') and ActualPaidUpDate is Null
Select CollectionMode,BalanceOutstanding,* From LoanLedger Where ClientID in ('05:32:AB:01:64') And WeeklyTransactionDate = '2025-12-08' Order By WeeklyTransactionDate

select PrincipalOutstanding,* from ClientLoanSubscription with(nolock) where ClientLoanID like '14:28:30:01:29:R1:02%' and ActualPaidUpDate is Null
select CollectionMode,BalanceOutstanding,* from LoanLedger where ClientLoanID like '14:01:T2:01:14%' And WeeklyTransactionDate = '2026-03-11' Order By WeeklyTransactionDate
select CollectionMode,BalanceOutstanding,* from LoanLedger where ClientLoanID like '05:31:02:01:14:6Y:01%' Order By WeeklyTransactionDate

select * from LoanLedger where ClientLoanID like '14:01%' And WeeklyTransactionDate = '2025-09-09' and 
(PrincipalInstallmentAmt > 0 or InterestInstallmentAmt > 0) and (PrincipalCollected = 0 and InterestCollected = 0)

select * from ATLoanLedger where ClientLoanID like '21:14:53:01:39:H2:01%' Order By WeeklyTransactionDate
select * from ClientStatus with(nolock)where clientid like '14:14:12:01:29%'
select * from ATDataEntryBC with(nolock) where clientid like '14:30:O7:01:73%'
select * from cashporone..ATDataEntryBC with(nolock) where clientid In ('14:27:39176')
select * from Cashpor..clientpassbookimages with(nolock)where clientid like '24:20:40:01:22%'
select * from Cashpor..clientpassbookimages1 with(nolock)where clientid like '14:14:KI:02:01%'
select * from Cashpor..clientpassbookimages with (nolock) WHERE Clientid IN ('14:21:A5:04:25','14:23:EB:01:72')
SELECT * FROM ClientAadhar with(nolock)where clientid like '21:20:AJ:01:01'
SELECT * FROM Clientaadhar with(nolock)where Adharid like '640928874799%'
select * from Husbandadhar with(nolock)where Adharid like '640928874799%'
select * from Husbandadhar with(nolock)where clientid like  '21:13:B2:01:71%'
select * from ClientLoanSubscription with(nolock) where ClientLoanID like '14:12:82:01:94%'
select * from AtClientLoanSubscription with(nolock) where ClientLoanID like '10:22:16:02:14%'
select * from ClientLoanSubscription with(nolock) where LoanProposalID like '14:09:42357%' 
select * from AtClientLoanSubscription with(nolock) where LoanProposalID like '14:28:20366%' 
Select * from Loan_Utilisation With (NoLock) Where ClientLoanID Like '31:14:14:01:56%'
Select * from AadharDisbursement With (NoLock) Where LoanProposalID like '22:30:14010'
Select ClientID,* From cashporbc..ekycdata With (NoLock) Where ClientID in ()--Local
select * from MyBranchPerformance where branchID like '14:21%'--BranchPerformance

--update cashporbc..ekycdata set Pincode = '841241' Where ClientID in ('14:01:A7:01:24') and ID = '641554'

select * from LoanLedger where ClientLoanID like '21:26:72:01:34:O0:01%' and principalcollected>0 order by  WeeklyTransactionDate -- > ='2022-04-22'
--PayMent check
select * from ClientLoanSubscription with(nolock) where ClientLoanID like '14%' And ActualPaidUpDate is NULL and 
LoanDurationInWeeks='90' And LoanAmountDisbursed='900000' And substring(ClientLoanID,16,2) = '4X'

 select * from cds2 where clientid = '14:14:i6:01:14'

Select * From Cashpor..ClientPassbookImages With (NoLock) Where Clientid=''
Select * From Cashpor..ClientPassbookImages With (NoLock) Where Clientid in ()
Select * from cashpor..clientpassbookimages where ClientID like '14:17:O9:01:29%'

 Select * From Cashpor..ATNeftClientBankDetail Where ClientID = '22:24:89:01:48'-- Duplicate account

 Select * From Cashpor..OwnBanInBCBranch With (NoLock) Where ClientID Like '31:20:67:01:11%'-- 


--Local
select * from ClientLoanSubscription with(nolock) where LoanProposalID in ('28:15:06918',
'28:30:05276')--bc settlement
select * from AtClientLoanSubscription with(nolock) where LoanProposalID in ('28:15:06918',
'28:30:05276')--own/flaxi neft cancel

--Amresh sir Loan Settle local

--Dear sir(Account, RM, DRM, ROE, CHIB, BM)
--With this mail I would like to inform you as per chain mail that client’s loan disbursement amount has been settled (Cancel Loan).

Select ClientLoanID,DisbursementDate,ActualPaidUpDate,LoanAmountDisbursed,InterestPaidToDate,Comments,RiskFund
From ClientLoanSubscription With (Nolock) Where ClientLoanID in ('14:07:IP:01:64:2E:01')

Select ClientLoanID,WeeklyTransactionDate,PrincipalInstallmentAmt,PrincipalCollected,InterestInstallmentAmt,InterestCollected,BalanceOutstanding
From LoanLedger With (NoLock) Where ClientLoanID in ('14:07:IP:01:64:2E:01')

--settlement check
Select riskfunddate,riskfund,* From ClientLoanSubscription With (NoLock) Where ClientLoanID Like '14:07%' And ActualPaidUpdate = '2025-10-13' and Comments like '%%DIS%%'
and CurrentInstallmentPeriod='1'
Select riskfunddate,riskfund,* From ClientLoanSubscription With (NoLock) Where ClientLoanID Like '24%' And ActualPaidUpdate = '2023-14-25' and Comments like '%%DIS%%'
and CurrentInstallmentPeriod='1'
Select * From ATClientLoanSubscription With (NoLock) Where ClientLoanID Like '13:21%' And DateOfUpdation >= '2023-04-18' and Comments like '%%DIS%%'
and CurrentInstallmentPeriod='1'


 select * from Loan_Utilisation where ClientLoanID like '14:13:zm:01:14%'

 select * from CreditNeedAccessment where Clientid = '13:21:fv:01:42'
 

 SELECT * FROM CENTERS WHERE centerid = '14:27:02'


select * from clientstatus WITH(NOLOCK) WHERE CLIENTID LIKE  '14:17:W6:01:55%'
select * from LoanLedger  with(nolock) where ClientLoanID like '14:18:o8:01:70%' and  WeeklyTransactionDate = '2022-04-15' 

select ClientLoan1ProductName,ClientLoan1TotalCollected,ClientLoan2InstallmentNumber , * from cds2 
with (nolock) where clientid like  '14:24:42:01:06%'

select * from centers where    CenterMeetingDay  = 4 and DissolvedDate is NULL

select * from centers where  CenterID= '14:14:23'
select * from Centers where staffid = 'BA14' and DissolvedDate is Null
select * from Centers where staffid = '4579' and DissolvedDate is Null
  
---- branch due (check both local and upper too)
SELECT * from dicds2 with (nolock) where clientid like '14:02%'and ClientLoan1AmtDueDisbursed > 0 order by clientloan1Id

SELECT * FROM  WIR WHERE PRODUCTID = 'ZU' AND LoanAmount = '100000' ORDER BY InstallmentNo

select ClientLoan1ProductName ,
ClientLoan1TotalCollected,
ClientLoan2InstallmentNumber,* from cds2 where ClientID like '14:21:pc:01:27%'

select * from Centers where staffid ='BA18'
select * from centers where centerid in ()
select * from FieldStaff where StaffID = '13463' --and ExitDate is NULL
select * from FieldStaff where StaffID in ('20481','17798') --and RegionID = '14'--and ExitDate is NULL
Select * from MasterActivity..Branches where BranchID in () and AMID = '8045'--For ARO
--update MasterActivity..Branches set AMID = '' where BranchID in ()

select * from cashpor..loginmaster where Branch_ID = '10:21'
select * from cashpor..login_master where Branch_Id = '10:21'
select * from cashpor..login_master1 Where Branch_ID = '10:21'
select * from cashpor..login_master11 Where Branch_ID = '10:21'


--staff web login problem
select * from fieldstaff where staffid ='13397'
select * from Centers where StaffID = '13397'
select * from cashpor..loginmaster where staff_id='13397'
select * from cashpor..login_master where staff_id='13397'
select * from cashpor..login_master1 where employee_ID='13397'
select * from cashpor..login_master11 where employee_ID='13397'
select * from cashpor..mobilelogin where BmStaffid = '13397'
select * from cashpor..mobilelogin where BranchID = '05:19'
--select * from cashpor..mobilelogincm where Cmstaffid='13397'
--select * from cashpor..mobilelogincm where Centerid='14:29:25'
select * from designationmaster where DesignationID = '7'

--update cashpor..login_master1 set Employee_id='13397',Password='147258' where branch_ID = '14:14'
--update cashpor..login_master11 set branch_ID = '05:19',Employee_type='BM',Password='258369' where Employee_id='13397'
--update cashpor..mobilelogin set BmStaffid = '13397',Bmpassword='456321'  where BranchID = '14:21'
--update cashpor..mobilelogin set Branchid = '14:14',Disttid='14',Disttname='Ballia',Bmpassword='215036'  where BmStaffid = '13397

select * from Targets where KYCNo = '324097174692'

--CHIB ARO BRANCH MAPPING MAster Activity updated Manually for CHIB

Select AMID,* From Branches Where AMID = '13094'
Select AMID,* From MasterActivity..branches Where AMID = '13094'

Select CHID,* From Branches Where CHID = '13094'
Select CHID,* From MasterActivity..branches Where CHID = '13094'

Select * from centers with (NoLock) Where CenterId In ('14:14:11')

-- due not show or not come

select ClientLoan1ProductName ,ClientLoan1TotalCollected,ClientLoan2InstallmentNumber,* from cds2
with(nolock) where clientid like  '14:14:11:01:20%' and ClientLoan1TotalCollected = '0' and ClientLoan1ProductName <> '0' order by clientid

select * from clientstatus with(nolock) where clientid like  '14:14:17:01:04%'


---Kaleidofin 
select *  from cashpor..Kaleidofin with(nolock) where Centercode like '14%' and cast(Senddate as date)='2022-14-06'   order by Senddate ,Customername


select * from FieldStaff where StaffID In ('')--  and ExitDate is NULL


-----credit help upi update logfile

select * from  UPICollectionLog where rrn='212761142915'

-----loanledger


select * from loanledger where clientloanid like '14:12:zf:01:14%'

select * from loanledger where clientloanid like '14:04:14:01:84%' and weeklytransactiondate ='2022-02-22'

select *  from backdate



---hospicash branch wise
select left(ClientLoanID,5) As 'BranchID', HealthInsurance,HealthInsuranceSpouse,HealthInsuranceDate, * from ClientLoanSubscription
 where ClientLoanID like '14:24:14:01:18%' --and HealthInsuranceDate ='2022-04-28 00:00:00'
  and (HealthInsurance>0 or HealthInsuranceSpouse>0)
order by clientloanid


select clientid, HealthInsurance as client_HealthInsurance,HealthInsuranceSpouse as husband_HealthInsurance, * from cds2
 with (nolock) where clientid like  '14:24:14:01:18%' and (HealthInsurance>0 or HealthInsuranceSpouse>0)





--EligibleLoanAmount
 
SELECT ClientID,loancycle, EligibleLoanAmount,dropoutstatus,riskfund,hotlistremark,comments,CommentedBy,* FROM Clients
 WITH(NOLOCK) WHERE CLIENTID LIKE '14:06:zk:01:09%'

 -- Eligible amount less and Other Outstanding and Mfi
SELECT ClientID, Loancycle, EligibleLoanAmount,Dropoutstatus FROM Clients
WITH(NOLOCK) WHERE CLIENTID LIKE '14:14:z2:01:37%'
SELECT Proposaldate,OtherOutstanding,TRACKING_ID FROM ClientAadhar
WITH(NOLOCK) WHERE CLIENTID LIKE '14:14:z2:01:37%'


SELECT * FROM ATClients WITH(NOLOCK) WHERE CLIENTID LIKE '14:12:zk:01:12%'
 select * from LoanLedger with(nolock) where ClientLoanID like '14:04:32:01:48:U1:01%'
select * from atClientLoanSubscription with(nolock) where clientloanid like '14:12:zk:01:12%'

select * from ClientStatus with (NOLOCK) WHERE CLIENTID LIKE '14:04:t4:01:54%'

SELECT OtherOutstanding ,* FROM ClientaAdhar with(nolock)where clientid like  '14:15:j9:01:60%'

SELECT * FROM Husbandadhar with(nolock)where clientid like  '14:01:36:01:80%'

select * from Clientloanproposal with(nolock)where clientid like '14:14:54:01:99%'

--settel amount

select PrincipalInstallmentAmt,PrincipalCollected,InterestInstallmentAmt,InterestCollected,PrincipalInArrears,* from LoanLedger with(nolock)where clientloanid like  '14:14:ZJ:01:48%'
select * from LoanLedger with(nolock)where clientloanid like  '14:03:R2:01:52%'


SELECT Proposaldate,Adharid, Verified,CBR_Status,CBR_Date,CBR_Enq_Date,TRACKING_ID FROM ClientAadhar with(nolock)where clientid like  '14:01:42:01:54%'
select * from Loan_Utilisation with(nolock)where ClientLoanID like '14:14:03:01:13%'

select * from Targets with(nolock)where targetid like '14:15:s1:01:22'

select  DisbursementMode ,* from Clientloanproposal with(nolock)where clientid like '14:14:54:01:83%' --clientid like  '14:18:m2:01:65%' 
select * from Clientloanproposal with(nolock)where clientid like '14:17:b3:01:61%' 
select Bmrecommenddate * from Clientloanproposal with(nolock)where clientid like '14:14:x7:01:67%'


select  * from ClientLoanSubscription with(nolock) where clientloanid like '14:25:92:01:13%'  order by ActualPaidUpDate --and ActualPaidUpDate is null

select PrincipalOutstanding, InterestInArrears ,LockdownInterestInsAmount,  * from ClientLoanSubscription with(nolock) where clientloanid like '14:15:j9:01:60%' and ActualPaidUpDate is null  

select * from ClientLoanSubscription with(nolock) where clientloanid like '14:14:11:01:20%'
select * from atClientLoanSubscription with(nolock)where clientloanid like '14:14:11:01:20%'




SELECT * FROM ClientAadhar with(nolock)where clientid like  '14:14:af:01:52%'


SELECT * FROM ClientAadhar with(nolock)where Adharid like '958780023204%'
select * from cds2 with (nolock) where clientid like  '14:09:U7:01:70%'

SELECT * FROM at with(nolock)where Adharid like '958780023204%'

------upi not show 
select ClientLoan1TotalCollected,ClientLoan2InstallmentNumber ,*from cds2
 with (nolock) where clientid like  '14:21:pk:01:86%'


select * from Branch_Report with (nolock)where branchid like '14%' and send ='0' order by branchid


select * from Branch_Report with (nolock)where branchid like '14%' and send ='0' order by branchid

---search table with name
select * from sys.tables with(nolock) where name like '%backup%'

select * from Sidbireview with(nolock) WHERE CUSTOMERID LIKE '14:14:dv:01:43%'

select * from FieldStaff with (nolock) where branchid like '14%'  and ExitDate is NULL 
and TelePhone='0'
--and Designation like'14'

select * from MFI_Master

SELECT * FROM Clientadhar with(nolock)where clientid like  '14:18:s6:01:30%'
select * from HMINQ_LOAN_DETAILS where traCking_id = '2144693'
select MFI , ACCOUNT_STATUS , MFI from HMINQ_LOAN_DETAILS where traCking_id = '2144693' 


SELECT * FROM Clients WITH(NOLOCK) WHERE CLIENTID LIKE '14:20:04:01:43%'
select  * from ClientLoanSubscription with(nolock) where clientloanid like '14:06:jl:01:56%'


-----disbursment problem( nahi ho pa raha)
SELECT LoanDisbursementDate,LoanAmountDisbursed,ProposalDate, * FROM ClientLoanProposal
 WITH(NOLOCK) WHERE CLIENTID LIKE '14:04:Y5:01:15%'
 ---outstanding_amount 
 select * from LoanUtilization

 select sum (PrincipalOutstanding) as outstanding_amount from ClientLoanSubscription with (nolock) where ClientLoanID like '14:14%' and  ActualPaidUpDate IS NULL


-- DISBURSMENT BT NOT SHOW IN ACCOUNT

select AccountNo, * from ClientLoanSubscription
with(nolock) where clientloanid like '14:04:75:01:21%'  AND  ActualPaidUpDate IS NULL
order by DisbursementDate 

Select UpdatedRecords,ActualDisbursementDate, * from ATClientLoanSubscription
with(nolock) where clientloanid like '14:09:f8:01:60%'  AND  ActualPaidUpDate IS NULL
order by DisbursementDate



 select * from Sidbireview with(nolock) where CustomerId like '14:04:75:01:21%'

---  for utr
select  * from ClientLoanSubscription with(nolock) where clientloanid like '14:21:80:03:49%'  and ActualPaidUpDate is null --order by ActualPaidUpDate --

select Muzaffarpur..ClientLoanSubscription.clientloanid,[Benef Name]as Client_Name,[Benef Ac No]as Account_No,[BENEF IFSC CODE]as IFSC_CODE,
[UTR Sr No]as UTR_No,
Muzaffarpur..ClientLoanSubscription.LoanAmountDisbursed,Muzaffarpur..ClientLoanSubscription.DisbursementDate
from cashpor..ReversedMISDetailReverse 
With(Nolock)inner join Muzaffarpur..ClientLoanSubscription on cashpor..ReversedMISDetailReverse.[Benef Ac No]=
Muzaffarpur..ClientLoanSubscription.accountno
where ---clientloanid like '14:14:21:01:55:U9:01%'
 [benef Ac No]='4001356855'
order by DisbursementDate desc



--- chk susspended date and active date

SELECT * FROM Clients WITH(NOLOCK) WHERE CLIENTID LIKE '14:21:11:03:37%'
SELECT * FROM ATClients WITH(NOLOCK) WHERE CLIENTID LIKE '14:21:11:03:37%'


----- daily use comand


select * from ClientLoanSubscription where clientloanid like '14:10:v3:01:46%'

---par condition
 select  * from ClientLoanSubscription WITH(NOLOCK) WHERE NumInstallmentsInArrears > 4
and CurrentInstallmentPeriod<=LoanDurationInWeeks 
 and ActualPaidUpDate is null
  and clientloanid like '14:20:h9:01:14%'


  select  * from ClientLoanSubscription WITH(NOLOCK) WHERE NumInstallmentsInArrears between  1 and 4
 and ActualPaidUpDate is null
  and CurrentInstallmentPeriod<=LoanDurationInWeeks
  and clientloanid LIKE '14:20:h9:01:14%'

 select * from atClientLoanSubscription with(nolock)where clientloanid like '14:06:jl:01:56%'

 select * from ClientLoanSubscription where clientloanid like '14:06:jl:01:56%'
 select * from fieldstaff where staffid = '11442'


---- death entry 
select entryby, DeathPerson,DeathDate, * from ClientLoanSubscription
with(nolock) where clientloanid like '21:14:45:01:14%' 

 --ActualPaidUpDate is null




select DeathPerson,DeathDate, * from ClientLoanSubscription with(nolock) where clientloanid like '14:21:x3:01:25%' and ActualPaidUpDate is null


---dcr

select * from dailyclosingdtl where branchid = '14:21'
-- chk dcr
select * from dailyclosingdtl with (nolock) where ClosingBankBalance='0'


select  * from BackDateBranch_Report where branchid = '14:15' and cast(ReportingDate as date) ='2022-03-28'

---back day coll total

select left(ClientLoanID,8) center,left(ClientLoanID,21) clientid, PrincipalCollected+InterestCollected totalcoll from LoanLedger with (nolock) where ClientLoanID like '14:15%' and WeeklyTransactionDate ='2022-03-28' --and CollectionMode <> 0





select * from WIR where loanamount ='30000' and productid = 'o2' order by installmentno


select * from Audit..settlementreport 

select count(*) from Branch_Report with (nolock)where branchid like '14%' and send ='0' order by branchid

select LoanProposalID,ProposalDate, Bmrecommenddate ,* from Clientloanproposal with(nolock)where clientid like '14:14:03:01:13%'




Select ClientLoanID,ActualDisbursementDate,RiskFund as insurance , UpFrontFee as processing from ClientLoanSubscription where ActualDisbursementDate between '2021-11-01' and '2021-12-20' and ActualPaidUpDate is null  


Select * from Targets where BranchID = '14:21'

 select  NumInstallmentsInArrears,* from ClientLoanSubscription WITH(NOLOCK) WHERE ClientLoanID like '14:21:11:03:37%' and NumInstallmentsInArrears between  1 and 4  

---Sattelment amt

 select PrincipalOutstanding, InterestInArrears ,LockdownInterestInsAmount,  * from ClientLoanSubscription
 with(nolock) where clientloanid like '14:22:cy:01:09%' and ActualPaidUpDate is null  

 select * from loanledger with(nolock) where clientloanid like '14:17:ZS:01:41:U0:01%' and WeeklyTransactionDate >='2021-12-21'



 select TargetID,TargetName,TargettingDate ,StaffID,* from Targets with (nolock)where BranchID  like'14:22%' and TargettingDate >= '2021-12-01'  --order by TargettingDate

 select TargetID, 
  (Select clientid from ClientAadhar Where targetid=b.targetid)'ClientID',
  TargetName as ClientName,TargettingDate ,StaffID from Targets as b with (nolock)where BranchID  like'14:22%' and TargettingDate >= '2021-12-01'
 


 ---sidbi loan
 select * from Sidbireview with(nolock) where CustomerId like '14:09:ZQ:01:21%'


 ---search column by name

select sys.columns.name AS columnName,
tables.name AS TableName
from 
sys.columns 
join sys.tables ON
sys.columns.object_id=tables.object_id
where sys.columns.name LIKE '%PRODUCTNAME%'

---search table with name
select * from sys.tables with(nolock) where name like '%coll%'

---branch report baranch  wise
select totalcollection,insurance,processing,DisbursementNeft,Cashless_Collection,Minsurecollection,heathInsurance,
* from BackDateBranch_Report with(nolock) where branchid='14:18' order by ReportingDate  -- and ReportingDate like '2022-01-13%'

select * from SettlementReport with (nolock) where Settlementdate = '2022-01-27 00:00:00.000' and OriginalAmount ='730'
---field staff with staffid

select * from fieldstaff where Designation = '14'and exitdate is null order by branchid

select * from fieldstaff with (nolock) where staffid like '13134%'
 where BranchID like '14:14%' and Designation = '14'and exitdate is null and StatusAct='1' order by branchid



Select * from ClientLoanProposal Where clientid='14:15:22:01:11'

---hospicash
select HealthInsurance,HealthInsuranceSpouse,DateStamp,* from ClientLoanSubscription
 where ClientLoanID like '14:09:94:01:73%'   and (HealthInsurance>0 or HealthInsuranceSpouse>0)  --order by DateStamp
--and HealthInsuranceDate = '2022-02-21 00:00:00'
  and ActualPaidUpDate is null

  HealthInsuranceDate
2021-12-27 00:00:00

 select HealthInsuranceSpouse , * from cds2 where clientid like '14:03:o3:01:04%'

 select ClientLoan1TotalCollected,ClientLoan2InstallmentNumber ,*from Prevcds2 
with (nolock) where clientid like  '17:20:51:01:27%'


select * from dailyclosingdtl where BranchID='14:14'


select * from targets with(nolock) where 
TargetID = '17:20:00145'


---- check log file

select * from LogFile with (nolock) where IniProcDate = '2022-14-11' ORDER BY  WorkEndDT DESC


select * from prevcds1 where meetingdate = '2022-14-11' and branchid = '14:06'



select * from FieldStaff where Designation ='14' and BranchID like '14%'  and exitdate is null and  StatusAct = '1'

select * from FieldStaff where Designation ='21' and BranchID like '14%'

select * from DesignationMaster 

select * from  BackDateBranch_Report where Branchid like '14:14' order by ReportingDate 

select * from Kaleidofin  where Centercode like '14:18%' 

select * from FieldStaff where staffid='3676'

select * from LoanLedger where entryby ='15266' and weeklytransactiondate between '2022-01-01' and '2022-01-21'

select * from centers where staffid='11495' and dissolveddate is null order by centerid

select * from CenterSwitching where branchid='14:10' and staffid='15266' and datestamp>='2022-01-01' order by datestamp

14:25:14:01:01
 select * from LoanLedger where ClientLoanID ='14:01:40:01:24:U1:02' and  WeeklyTransactionDate > = '2022-03-12' 

 ---- find direct payment with utr no
 select * from fieldstaff where staffid = '14661' 
 select * from designationmaster

 select * from audit..SettlementReport where PartnerTxnRefNo = '210911424752'

 select CollectionMode,(PrincipalCollected+InterestCollected)  ,* from loanledger where clientloanid like '14:14:X7:01:20:U1:02%' and  weeklytransactiondate > = '2022-04-14'


 select * from cashpor..AdvanceCashlessCollection where ClientId = '14:14:X7:01:20'



 select * from upicollectionlog where clientloanid like '14:14:X7:01:20:U1:02%'

 
select * from Centers where CenterID = '14:23:F4'

select * from report..databasename where rid in ('14','14','14')

select MeetingDate , * from dailyclosingdtl  order by branchid

select * from logfile 





 select * from Centers where staffid = '4699'

select * from loanledger where clientloanid like '14:14:I6:01:14%' and  weeklytransactiondate  = '2022-04-22'


Select * from loanledger Where Clientloanid like'14:24:42:01:06%' and WeeklyTransactionDate='2022-03-02' and Collectionmode<>0
 
select ClientLoan1TotalCollected,ClientLoan2InstallmentNumber ,*from cds2 
with (nolock) where clientid like  '14:14:B5:01:49%'

select  collectionmode , * from LoanLedger where ClientLoanID ='14:14:B5:01:49:U1:01' and WeeklyTransactionDate ='2022-02-14'

---login problem

select * from Fieldstaff where Staffid like '13397%'

select * from cashpor..loginmaster (nolock)where staff_id='13397'
select * from cashpor..login_master (nolock)where staff_id='13397'
select * from cashpor..login_master1 (nolock)where employee_id='13397'
select * from cashpor..login_master11 (nolock)where employee_id='13397'
select * from cashpor..mobilelogin (nolock)where BmStaffid='13397'
select * from cashpor..mobilelogin (nolock)where BranchID='14:15:JS'
--select * from cashpor..mobilelogincm (nolock)where cmstaffid='13397'

-- chk dcr
select ClosingBankBalance,branchid,branchname,* from dailyclosingdtl with (nolock) where ClosingBankBalance='0'


select * from loanledger where clientloanid like '14:18%' and weeklytransactiondate  >= '2022-03-02'

select * from BackDateBranch_Report where Branchid = '14:01' order by ReportingDate --='2022-03-02 00:00:00.000'

select * from dailyclosingdtl with (nolock) where BranchID = '14:21' order by MeetingDate 


select * from dailyclosingdtl with (nolock) where BranchID = '14:21' order by MeetingDate 

---client not in cashpor
select * from cashpor..ATNeftClientBankDetail with (nolock) where   AccountNumber ='33666924806'   --ClientId='14:22:bc:01:95'

select * from ATDataEntryBC with (nolock) where ClientId='14:22:bc:01:95'


---- insurance date wise


select RiskFund,* from ClientLoanSubscription where ClientLoanID like '14:22%' and RiskFundDate = '2022-02-21'

---m insurance
select BranchID,ClientID,ClientName,CollAmount,collDate ,
PaymentMode,ServiceExpiryDate from MInsureSurvey
with(nolock) where ClientID like '14:04%'  and collDate ='2022-02-14' and WriteoffDate is null AND RejectedBy IS NULL 
order by clientid

---check day close and  day initialazition region wise

select * from REPORT..databasename where  RID in ('14','14','14','17','11','13','17','38','13')   --'10'

select * from logfile with ( nolock) where iniprocdate='2022-14-14'  and WorkEndDT is not null order by WorkEndDT desc



or DayCloseStatus ='1' or DayIniStatus ='1'

select * from REPORT..databasename where   DayCloseStatus ='1'  or DayIniStatus ='1'



   RID in ('14','14','14','11')

----day initialazition local 
select * from logfile with ( nolock) where iniprocdate='2022-14-14'  and WorkEndDT is not null order by WorkEndDT desc

select * from dailyclosingdtl where branchid in ('14:14','14:03') order by branchid


select UPI_Collection,DateStamp , * from BackDateDailyClosingDtl where branchid ='14:14' order by MeetingDate desc

--Neft
Select * From ClientLoanProposal Where ClientID in ('31:23:41:01:06',
'31:23:46:01:30') and PrincipalOutstanding='1'

--PassBook
Select * From Cashpor..ClientPassbookImages With (NoLock) Where Clientid in ('31:23:41:01:06',
'31:23:46:01:30')

--UPI Correction
Select * From ClientLoanSubscription With (NoLock) Where ClientLoanID Like '31:14:91:01:14%'

Select ClientLoanID,WeeklyTransactionDate,PrincipalInstallmentAmt,PrincipalCollected,InterestInstallmentAmt,InterestCollected,CollectionMode
From LoanLedger With (NoLock) Where ClientLoanID Like '31:14:91:01:14:R1:01%' and WeeklyTransactionDate = '2022-11-02'

--Weekly Report Amount OutStanding Check Cosolidate database.
select sum(NumLoanClients) as Loan_Clients,sum(totaloutstanding) as Outs from PermanentStorage where branchid like '21%' 
and dateofreport='2022-11-30'


--SIDBI Pending Proposal Status
Select b.branchID,b.branchname,clp.clientId,clp.targetname as ClientName,clp.entryBy as CM_Staff_ID,clp.proposaldate,clp.clientRequestedamount,
clp.BMID as BM_Staff_ID,clp.finalReviewdate as BM_Review,clp.loanAmountApproved,clp.ApprovalRemarks,clp.productCategory
case when clp.loanamountApproved<='100000' and clp.finalreviewdate is NULL
then 'NOt Reviewed By BM' Else 'Reviewed By BM' end as ReviewStatus

From ClientLoanProposal as clp With (noLock) 
inner Join Branches as b on b.branchID=left(loanProposalID,5)
Where clp.proposalDate>='2022-12-14' and clp.LoanDisbursementDate is Null And clp.ProductCategory Like '%%SIDBI%%' and branchID Like '21%'


Select  clp.targetname As ClientName,clp.clientId,cls.clientLoanId,cls.loanProposalId,cls.Disbursementdate,cls.actualpaidupdate,clp.finalreviewdate,
cls.loanAmountDisbursed,
cls.currentInstallmentPeriod,cls.LoanDurationInWeeks,clp.entryby as StaffID,fs.staffname,clp.Bmid as BMID,
(Select staffname from FieldStaff Where StaffId=clp.BmID) as BmName From ClientLoanSubscription as cls
With (NoLock) 
inner join Fieldstaff as fs on fs.staffid=cls.entryby
inner join ClientLoanProposal as clp on clp.loanProposalId=cls.loanProposalId
Where cls.ClientLoanID IN ('') 

--Documentation
Select b.BranchID,b.branchname,c.CenterID,C.CenterName,clp.ClientID,clp.Targetname as ClientName,clp.ProposalDate,clp.LoanProposalID,clp.productID,clp.ProductCategory,
cls.ClientLoanID,cls.DisbursementDate,cls.CurrentInstallmentPeriod,cls.LoanDurationInWeeks,cls.LoanAmountDisbursed,clp.FinalReviewDate,
clp.PrincipalOutstanding,cls.ActualPaidUpDate,fs.staffId as CMID,fs.StaffName as CMName,clp.Bmid as BMID,
(Select staffname from FieldStaff Where StaffId=clp.BmID) as BmName
from ClientLoanSubscription as cls with (NoLock) 
inner join clientLoanProposal as clp on clp.LoanProposalID=cls.LoanProposalID
inner join branches as b on b.branchId=left(cls.LoanProposalID,5)
inner join centers as c on c.centerID=left(cls.LoanProposalID,8)
inner join fieldstaff as fs on fs.StaffID=clp.entryby
Where cls.ClientLoanId Like '28%' and cls.DisbursementDate between '2025-03-20' and '2025-04-05'
order by b.BranchID,b.branchname
--and clp.entryby = '13130'


Select cls.LoanDurationInWeeks,cls.CurrentInstallmentPeriod, * from ClientLoanProposal as clp With (Nolock) 
inner join branches as b on b.branchId = left(clp.clientId,5)
Inner join ClientloanSubscription as cls on left(cls.ClientLoanID,14)=clp.ClientId
inner join products as p on p.productId = substring(cls.clientloanid,14,2)
Where ClientId Like '14%' and clp.LoanDisbursementDate IS NULL and clp.PrincipalOutstanding = '1' and 
clp.ProductCategory Like '%Bridge%%' and clp.NumberOfInstallments>(cls.LoanDurationInWeeks-cls.CurrentInstallmentPeriod) and cls.ActualPaidUpDate IS
NULL and p.Loan_category not in ('7') order by clp.clientID


Select * from products


--Center handle with interest collection
Select left(l.ClientLoanId,8) as CenterID,c.CenterName,Sum(l.InterestCollected) as InterestCollected,l.entryBy as StaffID from LoanLedger as l With (NOLock) 
inner join centers as c on c.centerId=left(l.ClientLoanId,8)
Where l.ClientLoanId Like '14%' and 
l.WeeklyTransactionDate between '2022-09-01' and '2022-09-30' And l.EntryBy = '7437'
Group by left(l.ClientLoanId,8),c.CenterName,l.entryBy
order By left(l.ClientLoanId,8)

--Active Loan Clients Details
Select b.branchId,b.BranchName,clp.clientId,Clp.TargetName as ClientName,cls.ClientLoanID,clp.LoanProposalID,Clp.ProposalDate,clp.ProductCategory,
clp.ProductID,cls.LoanAmountDisbursed,clp.FinalReviewDate,cls.DisbursementDate,cls.LoanDurationInWeeks,cls.CurrentInstallmentPeriod,cls.PrincipalOutstanding
from ClientloanSubscription as cls With (NoLock) 
inner join clientLoanProposal as clp on clp.LoanProposalID=cls.LoanProposalID 
inner Join branches as b on b. BranchID=left(cls.ClientLoanID,5)
Where cls.ClientLoanId Like '05%' and cls.ActualPaidUpDate is NULL

--SIDBI Documentation
Select * from ClientLoanSubscription as cls With (NoLock) where ClientLoanId like '14%' and ActualPaidUpDate Is Null and
DisbursementDate >= '2023-04-01' and SUBSTRING(ClientLoanId,14,2) in ('w6','6x')

--Interest Collection
Select left(l.clientloanId,8) as Centers,c.CenterName,l.EntryBy as StaffID,fs.StaffName,Sum(l.InterestCollected) as Interest from loanLedger as l With (NoLock) 
inner join centers as c on c.centerId = left(l.clientloanId,8)
Inner join FieldStaff as fs on fs.StaffID = l.EntryBy
Where l.clientloanId Like '14%' and l.EntryBy = '18599' and 
l.WeeklyTransactionDate between '2025-11-03' and '2025-12-05' and l.RegionID = '14' 
Group By left(l.clientloanId,8),l.EntryBy,fs.StaffName,c.CenterName
order By left(l.clientloanId,8)

Select left(l.clientloanId,8) as Centers,c.CenterName,l.EntryBy as StaffID,fs.StaffName,Sum(l.InterestCollected) as Interest from loanLedger as l With (NoLock) 
inner join centers as c on c.centerId = left(l.clientloanId,8)
Inner join FieldStaff as fs on fs.StaffID = l.EntryBy
Where left(l.clientloanId,8) in () and 
l.WeeklyTransactionDate between '2025-11-03' and '2025-12-05'
Group By left(l.clientloanId,8),l.EntryBy,fs.StaffName,c.CenterName
order By left(l.clientloanId,8)

Select * from loanLedger  With (NoLock) 
Where clientloanId Like '14%' and EntryBy = '6151' and 
WeeklyTransactionDate between '2023-01-22' and '2023-02-28'

--loan disbured details
Select b.branchid,b.branchname,clp.clientID,clp.targetname as ClientNmae,clp.husbandname,clp.nominee,cls.loanproposalid,cls.clientloanid,clp.proposaldate,cls.disbursementdate,
clp.productid,clp.productcategory,clp.finalreviewdate,cls.LoanAmountDisbursed,cls.principaloutstanding,cls.CurrentInstallmentPeriod,cls.LoanDurationInWeeks,
cls.riskfund as Insurance,cls.RiskFundDate as InsuranceEntryDate,cls.UpFrontFee as Processing,cls.UpFrontFeeDate as ProccessingEntryDate,
cls.StaffID as CMID,f.staffname as CMName,clp.bmid as BMID,fs.staffname as BMName
From ClientLoanSubscription as cls With (NoLock) 
inner join clientLoanProposal as clp on clp.loanproposalid=cls.loanproposalid
inner join branches as b on b.branchid=left(cls.ClientLoanID,5)
inner join fieldstaff as f on f.staffid=cls.StaffID 
inner join fieldstaff as fs on fs.staffid=clp.BMID 
Where cls.ClientLoanID like '05:23:SM:01:23%' and cls.ActualPaidUpDate IS NULL and ActualDisbursementDate = '2023-09-27'


--Bridge loan disbursement Details
select b.BranchID,b.BranchName,clp.clientid,clp.targetname as ClientName,clp.ProposalDate,clp.LoanproposalId,cls.ClientLoanID,cls.LoanAmountDisbursed,clp.ProductID,clp.ProductCategory,
cast(cls.disbursementdate as date) as DisbursementDate,clp.FinalReviewDate,cls.CurrentInstallmentPeriod,cls.LoanDurationInWeeks,cls.PrincipalOutstanding,cls.staffid as CMID,f.staffname AS CMName,clp.BMID as BMID,
fs.staffName as BMName
from ClientLoanProposal as clp 
inner join clientLoansubscription as cls on cls.loanproposalid=clp.loanproposalid
inner join branches as b on b.branchid=left(clp.clientid,5)
inner join Fieldstaff as f on f.staffid=cls.staffid
inner join Fieldstaff as fs on fs.staffid=clp.BMID
Where clp.ClientID Like '14%' and clp.ProductCategory like '%%SIDBI%%' and clp.Principaloutstanding > '1' --and cls.DisbursementDate Between '2025-10-01' and '2025-12-31' and cls.ActualPaidupdate is NULL
order by cls.disbursementdate

---------------------------Interest Collection
--Trunch 4
select l.Weeklytransactiondate as CollectionDate,sum(InterestCollected) As Collection from LoanLedger as l With (NoLock) 
where substring(l.clientloanID,14,2) in ('T7','W1','W4') and Weeklytransactiondate between '2023-04-01' and '2023-14-17' and l.ClientLoanID like '14%'
Group By l.Weeklytransactiondate


--Trunch 5
select l.Weeklytransactiondate as CollectionDate,sum(InterestCollected) As Collection from LoanLedger as l With (NoLock) 
where substring(l.clientloanID,14,2) in ('Y2','Y4','Y5','Y7','Y8','Y9','Z1','Z2','Z3') and Weeklytransactiondate between '2023-04-01' and '2023-14-17' and l.ClientLoanID like '14%'
Group By l.Weeklytransactiondate


select * from clientLoanSubscription as cls With (NoLock) 
inner join LoanLedger as l on l.clientLoanId=cls.clientloanid 
where cls.clientLoanId like '14:12%' And cls.ActualPaidUpDate IS NULL and l.WeeklyTransactionDate between '2023-04-01' and '2023-06-30'


--BranhWise Collection

Select left(ClientLoanId,5) as BranchID,B.BranchName,sum(l.PrincipalCollected)as PrincipalCollected,sum(l.InterestCollected) as InterestCollected,l.weeklytransactiondate as CollectionDate 
from LoanLedger as l With (NoLock)
inner join branches as b on b.BranchID=left(ClientLoanId,5)
where l.ClientLoanId like '14%' and l.weeklytransactiondate = '2023-03-06'
group by left(ClientLoanId,5),B.BranchName,l.weeklytransactiondate
ORDER BY left(ClientLoanId,5),B.BranchName,l.weeklytransactiondate

----BranchWise And CenterWise Collection

Select left(ll.ClientLoanID,5) as Branchid,b.BranchName,left(ll.ClientLoanID,8) as CenterID,c.CenterName,
Sum(PrincipalCollected+InterestCollected) As Collection,ll.WeeklyTransactionDate As CollectionDate,ll.EntryBy as CMID,fs.StaffName as CMName  From Loanledger  as ll With (noLock) 
inner join branches as b on b.branchid=left(ll.ClientLoanID,5)
inner join FieldStaff as fs on fs.StaffID=ll.EntryBy
inner join Centers as c on c.CenterID=left(ll.ClientLoanID,8)
Where ll.ClientLoanID like '10:12%' And ll.WeeklyTransactionDate between '2025-09-01' and '2025-10-30' and EntryBy = '19099'
group by left(ll.ClientLoanID,5), b.Branchname,left(ll.ClientLoanID,8),c.CenterName,ll.WeeklyTransactionDate,ll.EntryBy,fs.StaffName
order by left(ll.ClientLoanID,5), b.Branchname,left(ll.ClientLoanID,8),c.CenterName,ll.WeeklyTransactionDate

--Branch wise processing details

select left(cls.ClientLoanID,5) as BranchID,b.BranchName,cls.UpFrontFeeDate as ProsecssingFeeDate,sum(cls.upfrontfee) as ProsecssingFee from ClientLoanSubscription as cls 
inner join clientLoanProposal as clp on clp.loanproposalid=cls.loanproposalid
inner join branches as b on b.branchId=left(cls.ClientLoanID,5)
Where cls.ClientLoanID like '14%' and clp.ProductCategory like 'SIDBI' and cls.upfrontfeedate = '2023-14-14'
group by left(cls.ClientLoanID,5),cls.upfrontfeedate,b.BranchName
order by left(cls.ClientLoanID,5)

--prepayment details or collection

Select cls.ClientLoanID,Sum(l.PrincipalCollected+l.InterestCollected) as Collection,cls.ActualPaidUpDate as SettlementDate,l.WeeklyTransactionDate as MeetingDate 
from ClientLoanSubscription as cls With (Nolock) 
inner join loanledger as l on l.ClientLoanID=cls.ClientLoanID
where cls.ActualPaidUpDate = '2023-09-15' and cls.clientloanid like '14:25%' and l.WeeklyTransactionDate = '2023-09-15'
group by cls.ClientLoanID,cls.ActualPaidUpDate,l.WeeklyTransactionDate
order by cls.ClientLoanID,cls.ActualPaidUpDate,l.WeeklyTransactionDate

use Ballia
select * from report..DataBaseName where  DayCloseStatus = '1' and Name like '%%Ballia%%'
select * from Centers where staffid = '23470' and DissolvedDate is Null

----------ALC client with Aadhar details
select b.BranchID,b.BranchName,clp.ClientID,clp.TargetName as ClientName,cls.LoanAmountDisbursed,cls.DisbursementDate,clp.KYCName,
Case When KYCName like 'Aadhar%' Then '********'+Right(KYCNo,4) Else  KYCNo End KYCNumber,clp.ProposalDate,clp.EntryBy as StaffID,fs.StaffName
from clientloansubscription as cls with (nolock) 
inner join clientloanproposal as clp on clp.loanproposalid=cls.loanproposalid
inner join branches as b on b.branchid=left(cls.clientloanid,5)
inner join fieldstaff as fs on fs.staffid=clp.entryby
where cls.ActualPaidUpDate is null and cls.regionid = '14'

---Proposal not entry but igl settle between date
Select cls.BranchID,b.BranchName,Left(cls.ClientLoanID,14) As ClientID,clp.TargetName as ClientName,clp.LoanProposalID,clp.ProposalDate,clp.ProductCategory,cls.LoanAmountDisbursed,clp.PrincipalOutstanding,
cls.CurrentInstallmentPeriod,cls.LoanDurationINWeeks,cls.DisbursementDate,cls.ActualPaidupDate from ClientLoanSubscription as cls With (NoLock) 
inner join ClientLoanProposal as clp on clp.LoanProposalId=cls.LoanProposalId
inner join Branches as b on b. BranchID=cls.BranchID
Where cls.ClientLoanID like '05%' and cls.ActualPaidUpDate between '2024-08-01' and '2024-08-30' and cls.ProductID IN (Select ProductID from Products where Loan_Category = '0')
and cls.ClientID not in  (Select ClientID from ClientLoanProposal where principalOutstanding > '0')
Group By Left(cls.ClientLoanID,14),clp.TargetName,clp.LoanProposalID,clp.ProposalDate,cls.LoanAmountDisbursed,clp.PrincipalOutstanding,cls.CurrentInstallmentPeriod,cls.LoanDurationINWeeks,cls.DisbursementDate,
cls.ActualPaidupDate,clp.ProductCategory,cls.BranchID,b.BranchName
order by cls.BranchID,b.BranchName,Left(cls.ClientLoanID,14)

----------Death Settle Check-------ritesh sir
select regionid,branchid ,sum(PrincipalCollected+Interestcollected) as DeathSettlement from loanledger 
where regionid in  ('14')  and entryby='0959' and weeklytransactiondate='2026-01-08'
group by regionid,branchid ,entryby
order by regionid

--------Rajiv sir-------------
select Regionid,BranchID ,sum(PrincipalCollected+Interestcollected) as DeathSettlement from loanledger 
where regionid in  ('14')  and entryby='0828' and weeklytransactiondate='2026-01-08'
group by regionid,branchid ,entryby
order by regionid

--------Admin-------------
select Regionid,BranchID ,sum(PrincipalCollected+Interestcollected) as DeathSettlement from loanledger 
where regionid in  ('14')  and entryby='0000' and weeklytransactiondate='2026-03-12'
group by regionid,branchid ,entryby
order by regionid

-------------------------------------------------------------------------------------------
Select b.BranchID,b.BranchName,clp.ClientID,clp.TargetName as ClientName,clp.ProposalDate,clp.LoanProposalID,cls.ClientLoanID,cls.LoanDurationInWeeks,cls.CurrentInstallmentPeriod,cls.LoanAmountDisbursed,cls.PrincipalOutstanding,
clp.ProductCategory,clp.FinalReviewDate,clp.KYCName,(case when clp.KycName in ('Aadhar','Voter ID','Pan','Ration Card') then ('XXXXXXXX'+right(clp.KYCNO,4)) else clp.KYCNO end) KYCNO,cls.DisbursementDate,cls.ActualPaidUpDate from ClientLoanSubscription as cls With (NoLock) 
inner join ClientLoanProposal as clp on clp.LoanProposalId = cls.LoanProposalID
inner join branches as b on b.branchid=left(cls.clientloanid,5)
Where cls.BranchID IN ('05:29','05:12','10:21','05:02','05:04','05:30') and cls.actualDisbursementdate Between '2024-01-01' and '2024-06-27'

select b.BranchID,b.BranchName,clp.ClientID,clp.TargetName as ClientName,cls.LoanAmountDisbursed,cls.DisbursementDate,clp.KYCName,
Case When KYCName like 'Aadhar%' Then '********'+Right(KYCNo,4) Else  KYCNo End KYCNumber,clp.ProposalDate,clp.EntryBy as StaffID,fs.StaffName
from clientloansubscription as cls with (nolock) 
inner join clientloanproposal as clp on clp.loanproposalid=cls.loanproposalid
inner join branches as b on b.branchid=left(cls.clientloanid,5)
inner join fieldstaff as fs on fs.staffid=clp.entryby
where cls.ActualDisbursementDate >= '2024-01-01' and cls.BranchID IN ('05:29','05:12','10:21','05:02','05:04','05:30')

------------------------------------------------------------------------------------------
----------PRODUCT WISE INTEREST COLLECTION FOR LOAN ACTIVITY-----------------
SELECT PRODUCT_ID,SUM(PRINCIPALCOLLECTED) PRINCIPALCOLLECTED,SUM(INTERESTCOLLECTED) INTERESTCOLLECTED FROM LOANlEDGER
WHERE CLIENTLOANID LIKE '24%' AND WEEKLYTRANSACTIONDATE = '2024-07-03'
GROUP BY PRODUCT_ID
ORDER BY PRODUCT_ID


SELECT SUBSTRING(CLIENTLOANID,16,2) AS PRODUCTID,SUM(PRINCIPALCOLLECTED) PRINCIPALCOLLECTED,SUM(INTERESTCOLLECTED) INTERESTCOLLECTED FROM LOANlEDGER
WHERE CLIENTLOANID LIKE '24%' AND WEEKLYTRANSACTIONDATE = '2024-07-03'
GROUP BY SUBSTRING(CLIENTLOANID,16,2)
ORDER BY SUBSTRING(CLIENTLOANID,16,2)

----------------------INSURANCE AND PROCESSING FOR ACTIVITY------------------------------
select txtField2 PID, Type, sum(cast(dblField12 as bigint)) Upfrontfee  from ConsolidatedActivity c
inner join products p on p.ProductID=c.txtField2
where dtField1='2024-03-27' and txtField1 like '16%' and dblField12<>0
group by txtField2, type

select txtField2 PID, Type, sum(cast(dblField9 as bigint)) Insurancefee  from ConsolidatedActivity c
inner join products p on p.ProductID=c.txtField2
where dtField1='2024-03-27' and txtField1 like '16%' and dblField12<>0
group by txtField2, type


-------------SIDBI PRAYAS DETAILS---------------
Select b.Zone,B.BranchID,B.BranchName,clp.ClientID,clp.TargetName as ClientName,clp.ProposalDate,clp.LoanProposalID,cls.ClientLoanID,clp.FinalReviewDate,clp.ProductCategory,cls.CurrentInstallmentPeriod,cls.LoanDurationInWeeks,cls.ActualDisbursementDate,cls.DisbursementDate,cls.LoanAmountDisbursed,cls.PrincipalOutstanding,clp.EntryBY as CMID,fs.StaffName as CMName,clp.BMID,FS1.StaffName as BMName from ClientLoanSubscription as cls With (NoLock) 
inner join ClientLoanProposal as clp on clp.LoanProposalID=cls.LoanProposalID
inner join Branches as b on b.BranchID=cls.BranchID
inner join Fieldstaff as fs on fs.StaffID=clp.EntryBY
inner join Fieldstaff as fs1 on fs1.StaffID=clp.BMID
Where cls.ClientloanID like '05:08%' and cls.DisburseMentDate Between '2024-04-01' and '2024-08-05' and clp.ProductCategory = 'SIDBI' and cls.ActualPaidUpDate is NULL
Select * From products where ProductID in ('6X','w6')

-----------Settle loan of particular date--------------------

Select cls.ClientLoanID,clp.TargetName As ClientName,cls.ActualPaidUpDate as Settle_Date,ll.PrincipalInstallmentAmt,ll.PrincipalCollected,ll.InterestInstallmentAmt,ll.InterestCollected,
Sum(ll.PrincipalCollected+ll.InterestCollected) as TotalCollected
from ClientLoanSubscription As cls With (NoLock) 
Inner Join LoanLedger as ll on LL.ClientLoanID=cls.ClientLoanID 
Inner join ClientLoanProposal as clp on clp.LoanProposalID=cls.LoanProposalID
Where cls.ClientLoanID like '16:29%' and cls.Actualpaidupdate = '2024-09-05' and ll.WeeklytransactionDate = '2024-09-05'
Group by cls.ClientLoanID,clp.TargetName,cls.ActualPaidUpDate,ll.PrincipalInstallmentAmt,ll.PrincipalCollected,ll.InterestInstallmentAmt,ll.InterestCollected

------IDBI loan client detail
SELECT b.BranchID,b.BranchName,cls.CLIENTID,cls.ClientLoanID,clp.TargetName as ClientName,clp.Proposaldate,clp.loanProposalID,clp.LoanAmountDisbursed,clp.LoanDisbursementDate,
cls.LoandurationInWeeks,cls.CurrentInstallmentPeriod,cls.PrincipalOutstanding,cls.Actualpaidupdate,
clp.ProductCategory,clp.EntryBy as StaffID,fs.StaffName FROM CLIENTLOANSUBSCRIPTION as cls
INNER JOIN ClientloanProposal as clp on clp.LoanProposalID=cls.LoanproposalID
INNER JOIN products as p on p.ProductID=clp.ProductID
INNER JOIN FIELDSTAFF AS FS ON FS.StaffID=clp.EntryBY
inner join Branches as b on b.BranchID=cls.BranchID
WHERE cls.REGIONID='10' AND cls.LOANPROPOSALID IN 
(SELECT LOANPROPOSALID   FROM IDBIREVIEW WHERE Approved='36' AND LOANPROPOSALID LIKE '10%')


-----principal outstanding clientwise
Select c.CenterID,c.CenterName,cls.ClientLoanID,Clp.Targetname as CLientName,Sum(cls.PrincipalOutStanding) as PrincipalOutStanding 
from clientLoanSubscription cls With (Nolock) 
Inner Join ClientLoanProposal  as clp on clp.LoanProposalID=cls.LoanProposalID
inner Join Centers as c on c.CenterID=cls.CenterID
Where cls.CenterID Like '28%'
Group by cls.ClientLoanID,Clp.Targetname,c.CenterID,c.CenterName


select ClientLoanId,LoanDurationInWeeks,CurrentinstallmentPeriod,NumInstallmentsInArrears,
Sum(PrincipalOutstanding+InterestinArrears) TotalBalance,PrincipalOutstanding PrincipalBalance,
InterestOutstanding InterestBalance
from ClientLoanSubscription as cls with(nolock) 
where cls.ClientLoanID IN ('10:01:46:04:46:2D:01')
group by ClientLoanId,LoanDurationInWeeks,CurrentinstallmentPeriod,NumInstallmentsInArrears,
PrincipalOutstanding,InterestOutstanding


---FOR SETTLE MENT CLIENT
WITH FilteredLedger AS (
    SELECT * 
    FROM LoanLedger WITH (NOLOCK)
    WHERE WeeklyTransactionDate = '2025-07-18'
)
SELECT 
    c.ClientLoanID,
    l.WeeklyTransactionDate AS MeetingDate,
    l.PrincipalinstallmentAmt AS PrincDue,
    l.PrincipalCollected AS PrinColl,
    l.interestInstallMentAmt AS InsDue,
    l.interestCollected AS InsColl,
    l.BalanceOutStanding AS Outstanding
FROM 
    FilteredLedger l
INNER JOIN 
    ClientLoanSubscription c WITH (NOLOCK) ON c.ClientLoanID = l.ClientLoanID
WHERE 
    c.ClientLoanID LIKE '10:01%' 
    AND c.ActualPaidUpDate IS NOT NULL
    AND (
        l.PrincipalCollected > ISNULL(l.PrincipalinstallmentAmt, 0)
        OR ISNULL(l.interestInstallMentAmt, 0) > ISNULL(l.interestCollected, 0)
    )

--Cm BM Deatils

Select cls.ClientLoanID,clp.EntryBY as CMID,fs.StaffName CMName,clp.BMID as BMID,fst.StaffName as BMName from ClientLoanSubscription as cls With (NoLock) 
Inner Join ClientLoanProposal as clp on clp.LoanProposalID=cls.LoanProposalID
Inner join fieldstaff as fs on fs.StaffID=clp.EntryBY
Inner join fieldstaff as fst on fst.StaffID=clp.BMID
Where cls.ClientLoanID in ('10:09:19:01:42:R1:01')

--own loan disbursement details 
Select cls.BranchID,b.BranchName,Count(cls.ClientLoanID) NoOfDisB,Sum(cls.LoanAmountDisbursed) As DisburseAmount from ClientLoanSubscription cls With (NoLock) 
Inner join Products p on p.productId=cls.productID
Inner Join branches b on b.BranchId=cls.BranchID
Where cls.DisbursementDate Between '2025-10-01' and '2025-12-31' and p.type like 'SIDBI%' and cls.RegionId = '22'
Group by cls.BranchID,b.BranchName
Order by cls.BranchID,b.BranchName

select * from Disbursement

--Selected Previous Date Due Collection
Select l.BranchID,b.BranchName BranchName,l.WeeklyTransactionDate MeetingDate,SUM(PrincipalInstallmentAmt+InterestInstallmentAmt) Collection from LoanLedger l With (NoLock) 
inner join Branches b on b.BranchID=l.BranchID
Where ClientID Like '14%' and WeeklyTransactionDate = '2025-10-11'
Group By l.BranchID,b.BranchName,l.WeeklyTransactionDate

-----Bm Documentation but Not Disbursed in Account
Select B.BranchID,B.BranchName,cls.ClientLoanID,cls.LoanProposalID,clp.TargetName ClientName,cls.ActualDisbursementDate BMDocumentationDate,cls.LoanAmountDisbursed,cls.LoanDurationInWeeks,p.Name ProductName,* from ClientLoanSubscription cls With (NoLock) 
Inner Join Products p on p.ProductID=cls.ProductID and p.type like '%SIDBI%' and p.BCIDNO='5'
Inner Join ClientLoanProposal clp on clp.LoanProposalID=cls.LoanProposalID
Inner Join Branches b on b. BranchID=cls.BranchID
Where cls.RegionID = '05' and cls.ActualdisbursementDate Between '2025-12-11' and '2025-12-25' and DisbursementDate is NULL

----OWN Loan Disbursement Query
Select B.BranchID,B.BranchName,c.CenterID,C.CenterName,clp.ClientID,cls.ClientLoanID,clp.TargetName ClientName,clp.ProposalDate,clp.ProductCategory,cls.LoanProposalID,clp.FinalReviewDate,cls.ActualDisbursementDate,cls.DisbursementDate,cls.LoanAmountDisbursed,cls.PrincipalOutstanding,cls.LoanDurationInWeeks,cls.EntryBy StaffID,f.StaffName from  ClientLoanSubscription cls With (NoLock) 
Inner Join ClientLoanProposal clp With (NoLock) on clp.LoanProposalID=cls.LoanProposalID
Inner Join Branches b With (NoLock) on b.BranchID=cls.BranchID
Inner Join Centers c With (NoLock) on c.CenterID=cls.CenterID
Inner Join FieldStaff f With (NoLock) on f.StaffID=cls.EntryBY
Where cls.RegionId = '14' and cls.ActualDisbursementDate >= '2026-01-01' and clp.ProductCategory not in ('BC BADA LOAN','BC','SIDBI','SIDBI WCTL')