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
	select * from LoanLedger with(nolock) where WeeklyTransactionDate>='2022-03-31' and BalanceOutstanding<0

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
	and ActualPaidUpDate between '2023-02-25' and '2023-02-25' and InterestCollected<0 and ll.InterestInstallmentAmt>0

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

	--exec updatecls '21:082023-02-25
	-------------------
	----and actualdisbursementdate='2023-02-25'
	--order by actualdisbursementdate,ClientLoanID
	-------------------------
	--exec proc_smstextapbs_dayclose '14:03'
	---------------------------------------------------
	select * from ClientLoanSubscription with(nolock) where DisbursementDate is null
	and actualpaidupdate>='2023-02-25' order by ClientLoanID

	select * from ClientLoanSubscription with(nolock) where ActualDisbursementDate='2023-02-25' 
	and actualpaidupdate='2023-02-25' order by ClientLoanID
	select * from ClientLoanSubscription with(nolock) where ActualDisbursementDate='2023-02-25'    
	and DisbursementDate is null and LoanAmountDisbursed<='5000' and disbursementmode='0'

	select * from clientloansubscription with(nolock) where 
	cast(actualdisbursementdate as date)='2023-02-25'
	and DisbursementMode in('6')     order by clientloanid
 
	------------
	select * from PrevCDS2 (nolock) where  (HealthInsurance>0 or  HealthInsuranceSpouse>0) and ClientLoan1Balance>0 
	and clientloan1id in(SELECT clientloanid FROM clientloansubscription where (HealthInsurance=0 or   HealthInsuranceSpouse=0) 
	or  (HealthInsurance = '0' or      HealthInsuranceSpouse = '0') )

--disbursement date check
	select * from clientloansubscription with(nolock) where actualdisbursementdate<=(convert(nvarchar(10),getdate()-1,23)) and disbursementdate is null 
and LoanProposalID in(select LoanProposalID 
from cashpor..APBSNEFTDisbursement) order by clientloanid

select * from clientloansubscription with(nolock) where actualdisbursementdate<=(convert(nvarchar(10),getdate()-2,23)) and disbursementdate is null 
and LoanProposalID in(select LoanProposalID 
from cashpor..APBSNEFTDisbursement) order by  clientloanid