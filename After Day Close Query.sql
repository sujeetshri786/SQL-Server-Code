	--local me
 
	------------------------Match Aadhar Disbursement Date from CLS Date-----------------------------------
	select * from AadharDisbursement where DocumentationDate is not null and 
	LoanDisbursementDate is not null and LoanProposalID in 
	(select loanproposalid from ClientLoanSubscription
	where ActualDisbursementDate =(convert(nvarchar(10),getdate(),23)) and DisbursementMode in ('2','4'))
	order by ClientID

	----------------------------------------
	Select COUNT(Distinct(Case when DisbursementDate is not null and DisbursementMode=4 then LoanProposalID end)) as NumAPBSDisb,
	ISNULL(SUM((Case when DisbursementDate is not null and DisbursementMode=4 then LoanAmountDisbursed end)),0) as APBSDisb,
	COUNT(Distinct(Case when DisbursementDate is not null and DisbursementMode=2 then LoanProposalID end)) as NumNEFTDisb,
	ISNULL(SUM((Case when DisbursementDate is not null and DisbursementMode=2 then LoanAmountDisbursed end)),0) as NEFTDisb,
	COUNT(Distinct(Case when DisbursementDate is not null and DisbursementMode not in (2,4) then LoanProposalID end)) as NumOtherDisb,
	ISNULL(SUM((Case when DisbursementDate is not null and DisbursementMode not in (2,4) then LoanAmountDisbursed end)),0) as OtherDisb   
	From ClientLoanSubscription where ActualDisbursementDate=Cast(getdate() as date) and ActualPaidUpDate is null

	-------------- Check ClientLoanSubscription ---------------------
	Select * from ClientLoanSubscription  With (Nolock) where PrincipalOutstanding<0 order by ClientLoanID
	Select * from ClientLoanSubscription  With (Nolock) where PrincipalOutstanding is null order by ClientLoanID
	Select * from ClientLoanSubscription  With (Nolock) where CurrentInstallmentPeriod is null order by ClientLoanID
	Select * from ClientLoanSubscription  With (Nolock) where ActualPaidUpDate is null and CurrentInstallmentPeriod is null order by ClientLoanID
	select * from clientloansubscription With (Nolock) where PrincipalOutstanding<0 and ActualPaidUpDate is null
	select * from LoanLedger with(nolock) where WeeklyTransactionDate>='2023-03-31' and BalanceOutstanding<0

	--select * from clientloansubscription With (Nolock) where InterestOutstanding<0 and ActualPaidUpDate is null order by ClientLoanID
	--update ClientLoanSubscription set PrincipalOutstanding=1,ActualPaidUpDate=Null where ClientLoanID in('21:27:18:01:21:O2:01')
	--exec updatecls '21:19'
	-------------- Check Null Value in  ClientLoanSubscription---------------------
	select ClientLoanSubscription.ClientLoanID,ClientLoanSubscription.DisbursementDate,ClientLoanSubscription.LoanAmountDisbursed,
	ClientLoanSubscription.PrincipalReturnedToDate,ClientLoanSubscription.PrincipalOutstanding,SUM(loanledger.PrincipalCollected)
	as principalcollection,ClientLoanSubscription.ActualPaidUpDate from ClientLoanSubscription With (Nolock) inner join
	LoanLedger With (Nolock) on ClientLoanSubscription.ClientLoanID=LoanLedger.ClientLoanID where ClientLoanSubscription.ActualPaidUpDate>='2013-01-01'
	group by ClientLoanSubscription.ClientLoanID,ClientLoanSubscription.DisbursementDate,ClientLoanSubscription.ActualPaidUpDate,
	ClientLoanSubscription.PrincipalReturnedToDate,ClientLoanSubscription.PrincipalOutstanding,
	ClientLoanSubscription.LoanAmountDisbursed
	Having ClientLoanSubscription.PrincipalReturnedToDate<> SUM(loanledger.PrincipalCollected) order by ClientLoanSubscription.ClientLoanID
	-----------------------
	Select cls.ClientLoanID,ll.PrincipalInstallmentAmt,ll.PrincipalCollected,ll.InterestInstallmentAmt,ll.InterestCollected from ClientLoanSubscription cls with(Nolock) 
	inner join loanledger ll with(Nolock) on ll.clientloanid=cls.ClientLoanID and LastTransactionDate=WeeklyTransactionDate
	and ActualPaidUpDate between '2023-04-07' and '2023-04-07' and InterestCollected<0 and ll.InterestInstallmentAmt>0

	----------------Collection<0-------------
	SELECT        ClientLoanID, SUM(PrincipalCollected + InterestCollected) AS Expr1
		FROM            LoanLedger
	GROUP BY ClientLoanID
	HAVING        (SUM(PrincipalCollected + InterestCollected) < 0)
	---------------------------------------------------------
	select ClientLoanSubscription.ClientLoanID,ClientLoanSubscription.DisbursementDate,ClientLoanSubscription.LoanAmountDisbursed,
	ClientLoanSubscription.PrincipalReturnedToDate,ClientLoanSubscription.PrincipalOutstanding,SUM(loanledger.PrincipalCollected)
	as principalcollection,ClientLoanSubscription.ActualPaidUpDate from ClientLoanSubscription inner join
	LoanLedger on ClientLoanSubscription.ClientLoanID=LoanLedger.ClientLoanID
	group by ClientLoanSubscription.ClientLoanID,ClientLoanSubscription.DisbursementDate,ClientLoanSubscription.ActualPaidUpDate,
	ClientLoanSubscription.PrincipalReturnedToDate,ClientLoanSubscription.PrincipalOutstanding,
	ClientLoanSubscription.LoanAmountDisbursed
	Having ClientLoanSubscription.PrincipalReturnedToDate<> SUM(loanledger.PrincipalCollected) order by ClientLoanID

	--exec updatecls '21:08'
	-------------------
	----and actualdisbursementdate='2023-04-07'
	--order by actualdisbursementdate,ClientLoanID
	-------------------------
	--exec proc_smstextapbs_dayclose '21:03'
	---------------------------------------------------
	select * from ClientLoanSubscription with(nolock) where DisbursementDate is null
	and actualpaidupdate>='2023-04-07' order by ClientLoanID

	select * from ClientLoanSubscription with(nolock) where ActualDisbursementDate='2023-04-07' 
	and actualpaidupdate='2023-04-07' order by ClientLoanID
	select * from ClientLoanSubscription with(nolock) where ActualDisbursementDate='2023-04-07'    
	and DisbursementDate is null and LoanAmountDisbursed<='5000' and disbursementmode='0'

	select * from clientloansubscription with(nolock) where 
	cast(actualdisbursementdate as date)='2023-04-07'
	and DisbursementMode in('6')     order by clientloanid

 
	------------
	--select * from PrevCDS2 (nolock) where  (HealthInsurance>0 or  HealthInsuranceSpouse>0) and ClientLoan1Balance>0 
	--and clientloan1id in(SELECT clientloanid FROM clientloansubscription where (HealthInsurance=0 or   HealthInsuranceSpouse=0) 
	--or  (HealthInsurance = '0' or      HealthInsuranceSpouse = '0') )

	--Saurabh Sir
select * from prevcds2 where (HealthInsurance>0 or HealthInsuranceSpouse>0) and LoanProposalID not in
(select LoanProposalID from ClientLoanSubscription where cast(healthinsurancedate as date)=(convert(nvarchar(10),getdate(),23)))

--disbursement date check
select * from clientloansubscription with(nolock) where actualdisbursementdate<=(convert(nvarchar(10),getdate()-1,23)) and disbursementdate is null 
and LoanProposalID in(select LoanProposalID 
from cashpor..APBSNEFTDisbursement) order by clientloanid

select * from clientloansubscription with(nolock) where actualdisbursementdate<=(convert(nvarchar(10),getdate()-2,23)) and disbursementdate is null 
and LoanProposalID in(select LoanProposalID 
from cashpor..APBSNEFTDisbursement) order by  clientloanid

--select * from logfile with(nolock) where iniprocdate=cast(getdate() as date) and EndProcDate is null order by branchid
--Select * From cashpor..APBSNEFTDisbursement with (NoLock) where LoanProposalId IN ('16:10:31019')
--select * from AtClientLoanSubscription with(nolock) where LoanProposalID in ()--own/flaxi neft cancel
--Day Close Status
--Select * From Report..DataBaseName Where DayCloseStatus = '1'
--select * from clientLoanSubscription With (NoLock) where ActualPaidUpDate='2022-08-16' and Comments like 'dis%'
--select * from prevcds2 where clientId Like '10:18%' And clientLoan1ID Not IN (Select clientLoanID From ClientLoanSubscription) and
--ClientLoan1AmountDisbursed > '0'
--select * from clientLoanSubscription with (NoLock) Where cast(ActualDisbursementDate as date) = '2023-04-07' and ClientLoanID like '10:01%'
--select * from CDS2 With (NoLock) where ClientLoan1ID like '14:08%' and ClientLoan1AmountDisbursed > '0'
--select  * from Clientloanproposal with(nolock)where LoanProposalID in ()
--Select * From BackDateBranch_report With (NoLock) Where BranchID = '14:01' And cast(ReportingDate as date) = '2023-05-03'
----select * from DICDS1 with (Nolock) Where cast(ActualMeetingDate as date) >= '2023-04-07'
--Select * from LogFile Where IniProcDate = '2023-04-07' and EndProcDate is Null 
--Select * From Branch_report With (NoLock) Where BranchID = '05:22'
--Select * From DailyClosingDTL With (NoLock) Where BranchID = '05:30'
--Select * From tempDailyClosingDTL With (NoLock) Where BranchID = '05:30'

--update tempDailyClosingDTL set DailyDocumentAmt = '400000' Where BranchID = '14:29'
--update Branch_report set Minsurecollection = '200'  Where BranchID = '05:22'
----update DailyClosingDTL set MInsuranceCollection = '900'  Where BranchID = '05:07'
--Select * From BackDateBranch_report With (NoLock) Where BranchID = '14:24' And cast(ReportingDate as date) = '2023-09-20'
----update DailyClosingDTL set MeetingDate = '2023-04-01 00:00:00',DateStamp='2023-04-24 00:00:00' Where BranchID = '10:14'
----update Branch_report set Totalcollection = '' Where BranchID = '05:07'

--Select * From RPTDailyClosingDTL With (NoLock) Where BranchID like '14:24%' And cast(MeetingDate As Date) = '2023-09-20'
----Select * From BackDateDailyClosingDTL With (NoLock) Where BranchID = '14:09%' And cast(MeetingDate As Date) = '2023-10-12'
--Select * From BackdateDailyClosingDTL With (NoLock) Where BranchID = '07:24' And MeetingDate = '2023-09-12'

--Select * From BackdateDailyClosingDTL With (NoLock) Where BranchID like '14%' And 
--cast(MeetingDate As Date) Between '2022-10-01' and '2023-03-31' order by MeetingDate,branchID

--Select * From RPTDailyClosingDTL With (NoLock) Where BranchID like '14%' And 
--cast(MeetingDate As Date) Between '2022-10-01' and '2023-03-31'

------------Select * From Branch_report With (NoLock) Where BranchID = '14:28'
--Select * From backdateBranch_report With (NoLock) Where BranchID = '14:28' And cast(ReportingDate As Date) = '2023-04-07'
--Select * from DICDS1 With (NoLock) Where BranchID Like '14:08' AND ActualMeetingDate = '2023-04-07'
----begin tran
----DELETE a FROM (
----    SELECT row_number() over(partition by branchid order by branchid) as RowNo
----    FROM dailyclosingdtl where branchid like '21:09%'
----) AS a WHERE RowNo > 1
----rollback tran
--Select * from PrevCDS1 where branchid like '14:08%'
--select * from logfile where endprocdate=cast(getdate() as date) order by WorkEndDT desc


--update RPTDailyClosingDTL set TotalCollection='308521',UPI_Collection='3220' Where BranchID = '05:18' And cast(MeetingDate As Date) = '2023-03-15'
--update BackDateDailyClosingDTL Set TotalCollection='308521',UPI_Collection='3220' Where BranchID = '05:18' And cast(MeetingDate As Date) = '2023-03-15'
