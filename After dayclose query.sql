--exec uspnewactivityproc '2023-08-08','2023-08-08','05'

--select ClientLoanSubscription.ClientLoanID,ClientLoanSubscription.DisbursementDate,ClientLoanSubscription.LoanAmountDisbursed,
--ClientLoanSubscription.PrincipalReturnedToDate,ClientLoanSubscription.PrincipalOutstanding,SUM(loanledger.PrincipalCollected)
--as principalcollection,ClientLoanSubscription.ActualPaidUpDate from ClientLoanSubscription With (Nolock) inner join
--LoanLedger With (Nolock) on ClientLoanSubscription.ClientLoanID=LoanLedger.ClientLoanID 
--where ClientLoanSubscription.ActualPaidUpDate>=cast (getdate() as date)
--group by ClientLoanSubscription.ClientLoanID,ClientLoanSubscription.DisbursementDate,ClientLoanSubscription.ActualPaidUpDate,
--ClientLoanSubscription.PrincipalReturnedToDate,ClientLoanSubscription.PrincipalOutstanding,
--ClientLoanSubscription.LoanAmountDisbursed
--Having ClientLoanSubscription.PrincipalReturnedToDate<> SUM(loanledger.PrincipalCollected)

select BR.Branchid,BR.BranchName,
ISNULL((case when BR.heathInsurance<>DL.HealthInsurance then BR.heathInsurance-DL.HealthInsurance end),0) MIS_Helth,
ISNULL((case when BR.Cashless_Collection<>DL.UPI_Collection then DL.UPI_Collection-BR.Cashless_Collection end),0)MIS_UPI,
ISNULL((case when BR.Kaleidofinamount<>DL.KaleidofinColl then BR.Kaleidofinamount-DL.KaleidofinColl end),0)MIS_KALEDO,
ISNULL( (case when BR.Minsurecollection<>(DL.MInsuranceCollection+DL.MInsuranceCollectionByCashpor) then 0 end ),0) MIS_minsure
from branch_report BR with(Nolock)
inner join TempDailyClosingDtl DL with(Nolock) on br.branchid=DL.branchid

--update ClientLoanSubscription set ActualPaidUpDate=null where ClientLoanID=''

--exec UpdateCLS_Help '05:31'

With temp as(
Select ClientLoanSubscription.ClientLoanID,ClientLoanSubscription.DisbursementDate,ClientLoanSubscription.LoanAmountDisbursed,
ClientLoanSubscription.PrincipalReturnedToDate,ClientLoanSubscription.PrincipalOutstanding,SUM(loanledger.PrincipalCollected)
as principalcollection,ClientLoanSubscription.ActualPaidUpDate from ClientLoanSubscription With (Nolock) inner join
LoanLedger With (Nolock) on ClientLoanSubscription.ClientLoanID=LoanLedger.ClientLoanID 
where ClientLoanSubscription.ActualPaidUpDate>=cast (getdate() as date)
group by ClientLoanSubscription.ClientLoanID,ClientLoanSubscription.DisbursementDate,ClientLoanSubscription.ActualPaidUpDate,
ClientLoanSubscription.PrincipalReturnedToDate,ClientLoanSubscription.PrincipalOutstanding,
ClientLoanSubscription.LoanAmountDisbursed)
Select * from temp a (nolock)
Join clientloansubscription b on a.clientloanid=b.clientloanid
Where a.principalcollection<>b.PrincipalReturnedToDate

----

Select Principaloutstanding,* from ClientLoanSubscription  With (Nolock) where PrincipalOutstanding<0 and RegionID in ('05','14','16')
----
Select * from ClientLoanSubscription  With (Nolock) where PrincipalOutstanding is null and RegionID in ('05','14','16')
----
Select * from ClientLoanSubscription  With (Nolock) where CurrentInstallmentPeriod is null and RegionID in ('05','14','16')
----
Select * from ClientLoanSubscription  With (Nolock) where ActualPaidUpDate is null and CurrentInstallmentPeriod is null and RegionID in ('05','14','16')
----
Select * from ClientLoanSubscription  With (Nolock) where ActualPaidUpDate=cast (getdate() as date) 
and actualdisbursementdate=cast (getdate() as date) and RegionID in ('05','14','16')

----

Select clientloansubscription.ClientLoanID,PrincipalOutstanding,clientloansubscription.PrincipalInArrears,LastTransactionDate,
PrincipalOutstanding-clientloansubscription.PrincipalInArrears as morearreas ,
loanledger.PrincipalInstallmentAmt as LLPInstallment,LoanLedger.PrincipalInArrears as LLPArrears,
WeeklyTransactionDate,(LoanLedger.PrincipalInstallmentAmt+PrincipalOutstanding-clientloansubscription.PrincipalInArrears)-PrincipalCollected as ProposedPArrearLL
from ClientLoanSubscription (nolock)
inner join LoanLedger (nolock) on loanledger.clientloanid=clientloansubscription.ClientLoanID and LastTransactionDate=WeeklyTransactionDate
where PrincipalOutstanding>0 and CurrentInstallmentPeriod>LoanDurationInWeeks and PrincipalOutstanding<clientloansubscription.PrincipalInArrears
and clientloansubscription.RegionID in ('05','14','16')

----

select LEFT(clientloanid,5) as BRANCH_ID, branches.BranchName as BRANCH_NAME, count(clientloanid) as NUM_LOANCLIENT_CLS, 
SUM(LoanAmountDisbursed) as DISBURSED_AMT_CLS, 
COUNT(clientloanid)*200 as STAMPAMOUNT_CLS,
(select ISNULL(sum(StampPeperColl),0) from DailyClosingDtl with(Nolock) where DailyClosingDtl.BranchID=LEFT(clientloanid,5)) as 'STAMP_AMOUNT_DCR',
case when COUNT(clientloanid)*200=(select ISNULL(sum(StampPeperColl),0) from DailyClosingDtl  with(Nolock)
where DailyClosingDtl.BranchID=LEFT(clientloanid,5)) then 'True' else 'False' End as 'STAMP_MATCH_CLS_DCR STATUS'
from clientloansubscription with(Nolock) inner join Branches with(Nolock) on Branches.BranchID=LEFT(clientloanid,5)
where ActualDisbursementDate>=CONVERT(varchar(10), GETDATE() ,23) and SUBSTRING(clientloanid,16,2) in ('W6','5X')
and clientloansubscription.RegionID in ('05','14','16')
group by LEFT(clientloanid,5),BranchName

----

Select clientloansubscription.ClientLoanID,PrincipalOutstanding,clientloansubscription.PrincipalInArrears,LastTransactionDate,PrincipalOutstanding-clientloansubscription.PrincipalInArrears as lessarrears ,
loanledger.PrincipalInstallmentAmt,LoanLedger.PrincipalInArrears,WeeklyTransactionDate,(LoanLedger.PrincipalInstallmentAmt+PrincipalOutstanding-clientloansubscription.PrincipalInArrears)-PrincipalCollected as ProposedPArrearLL
from ClientLoanSubscription with(Nolock) 
inner join LoanLedger with(Nolock) on loanledger.clientloanid=clientloansubscription.ClientLoanID and LastTransactionDate=WeeklyTransactionDate
where PrincipalOutstanding>0 and CurrentInstallmentPeriod>LoanDurationInWeeks and PrincipalOutstanding>clientloansubscription.PrincipalInArrears
and clientloansubscription.RegionID in ('05','14','16')

----

Select counT(*),sum(Loanamountdisbursed) from ClientLoanProposal with(nolock) 
where LoanDisbursementDate=cast (getdate() as date) and FinalIfsccode<>'0' and FinalAccountNumber<>'0' and DisbursementMode in('4','2') 
and FinalAccountNumber is not null and RegionId in ('05','14','16')

----

Select counT(*),sum(Loanamountdisbursed) from ClientLoanSubscription with(nolock) 
where ActualDisbursementDate=cast (getdate() as date)  and DisbursementMode in('4','2') 
and DisbursementDate is  null and RegionId in ('05','14','16')

----

Select counT(*),sum(LoanAmount) from AadharDisbursement 
with(nolock) where DocumentationDate=cast (getdate() as date)  
and DisbursementMode in('4','2') and LoanDisbursementDate is  null
and RegionId in ('05','14','16')

----

select cls.ClientLoanID,cls.LoanProposalID,b.Datestamp NeftDisbTransaction_Datestamp,
cls.ActualDisbursementdate  CLS_ActualDisbursementdate from clientloansubscription cls with(nolock) 
Join neftdisbtransaction b with(nolock)  
on cls.loanproposalid=b.loanproposalid 
where actualdisbursementdate<=(convert(nvarchar(10),getdate()-2,23)) 
and disbursementdate is null
and cls.RegionID in ('05','14','16')

-------yashpal sir day clos Disbursement chk query 

Select *  From neftdisbtransaction with(nolock) where loanproposalid in(
select loanproposalid from clientloansubscription with(nolock) where actualdisbursementdate<=(convert(nvarchar(28),getdate()-1,23)) and disbursementdate is null ) 
and RegionID IN ('05','14','16')
order by LoanProposalID

-------------sidbi disb date

select actualdisbursementdate,clientloanid  from clientloansubscription with(nolock) where actualdisbursementdate<=(convert(nvarchar(28),getdate()-1,23)) 
and disbursementdate is null
and loanproposalid in (select loanproposalid from Cashpor..APBSNEFTDisbursement with(nolock) )
and RegionID IN ('05','14','16')

----select * from clientloansubscription with(nolock) Where ClientLoanID = '14:04:86:01:58:6Y:01'
----select * from neftdisbtransaction with(nolock) Where LoanProposalID = '05:06:75408'

select b.BranchID, b.TotalDisbursementHO as TotalDisbursementHO_DTL,a.TotalDisbursementHO
from (select left(ClientLoanID,5) as BranchID, SUM(LoanAmountDisbursed) as TotalDisbursementHO 
from ClientLoanSubscription with(nolock) 
where DisbursementDate=cast(GETDATE() as date) and disbursementmode in (2,4) 
group by left(ClientLoanID,5)) a 
join TempDailyClosingDtl b with(nolock) on a.BranchID=b.BranchID
where b.TotalDisbursementHO>0 and b.TotalDisbursementHO<>a.TotalDisbursementHO
and RegionID in ('05','14','16')


----Daily Check Required: Loan Settlement Data Update


Select LoanProposalID,ClientLoanSubscription.ClientLoanID,ActualPaidUpDate,LoanAmountDisbursed,sum(PrincipalCollected) as PrincipalColleced,
(sum(PrincipalCollected)-LoanAmountDisbursed) As Diff,BCIDNo from ClientLoanSubscription WITH(NOLOCK) Inner Join LoanLedger WITH(NOLOCK) on 
 ClientLoanSubscription.ClientLoanID=loanledger.ClientLoanID where ActualPaidUpDate is null and ClientLoanSubscription.RegionID in ('05','14','16')
Group by LoanAmountDisbursed,ClientLoanSubscription.ClientLoanID,LoanProposalID,ActualPaidUpDate,BCIDNo Having LoanAmountDisbursed <= Sum(LoanLedger.PrincipalCollected)


----

SELECT ClientLoanid FROM ClientLoanSubscription  c  WITH (NOLOCK) WHERE c.ActualDisbursementDate=c.ActualPaidUpDate
and  c.REGIONID IN ('05','14','16')

----

SELECT ClientLoanid,* FROM ClientLoanSubscription  c  WITH (NOLOCK) WHERE c.ActualDisbursementDate=c.DisbursementDate
and  c.REGIONID IN ('05','14','16') and c.ActualPaidupdate is NULL and c.ActualDisbursementDate >='2025-09-01'

----

select * from clientloansubscription where riskfund = '0' and actualdisbursementdate>='2024-01-01'
and productid in (select productid from products where Loan_Category='0') and loanproposalId in (select loanProposalID From ClientLoanProposal Where targetAge <='60')
order by ClientID

--Select riskfunddate,riskfund,* From ClientLoanSubscription With (NoLock) Where ClientLoanID Like '22%' And ActualPaidUpdate = '2023-03-28' and Comments like '%%DIS%%'
--and CurrentInstallmentPeriod='1'

--Branch wise disbursement by HO (APBS & NEFT)
--select left(ClientLoanID,5) as BranchID, SUM(LoanAmountDisbursed) as TotalDisbursementHO 
--from ClientLoanSubscription with(nolock) 
--where DisbursementDate=cast(GETDATE() as date) and disbursementmode in (2,4) 
--group by left(ClientLoanID,5)  

--select BranchID, TotalDisbursementHO from DailyClosingDtl with(nolock) where TotalDisbursementHO>0 

--Interest Outstanding getting negative

Select * from ClientLoanSubscription where (actualpaidupdate=cast(getdate() as date)) and InterestOutstanding<0

--Interest in Arrears getting negative

Select * from ClientLoanSubscription where ( actualpaidupdate=cast(getdate() as date)) and InterestInArrears<0

--update ClientLoanSubscription set ActualPaidUpDate=NUll,PrincipalOutstanding='1' where LoanProposalID='05:03:48518'

--Installment collected with out due(Principal or Interest) 
Select * from loanledger a (nolock) 
Join clientloansubscription b (nolock) on a.clientloanid=b.ClientLoanID
where  ((a.PrincipalInstallmentAmt=0 and a.PrincipalCollected>0) or (a.InterestInstallmentAmt=0 and InterestCollected>0) ) and CurrentInstallmentPeriod<=LoanDurationInWeeks
and WeeklyTransactionDate=cast(getdate() as date) and (b.Comments not like '%Fail%' or b.Comments is null) and b.deathdate is  null

--update loanledger set 

--Disbursement done without Insurance
Select DistrictName,Br.BranchID,BranchName,Cls.ClientLoanID,cls.LoanProposalID,Targetname,Targetage,CoBorrowerName,CoBorrowerAge,DisbursementDate,ActualDisbursementDate,
cls.LoanAmountDisbursed,CurrentInstallmentPeriod,LoanDurationInWeeks,cls.UpFrontFee,cls.RiskFund from ClientLoanSubscription cls (nolock) 
Join Products p (nolock) on p.ProductID=SUBSTRING(cls.clientloanid,16,2)
join clientloanproposal clp (nolock) on clp.loanproposalid=cls.loanproposalid
Join Branches Br (nolock) on Br.branchid=left(cls.clientloanid,5)
where ActualDisbursementDate= cast(getdate()-1 as date) and cls.RiskFund=0   and Targetage<60 
and ((Loan_Category in(0,7)) or(BCIDNO<>0 and Loan_Category=5)) and actualpaidupdate is null


--NPA DATE should not null or blank

--NPA Date Checking
--For Defaulter clisnts
  select cls.ClientLoanId, cls.LoanProposalID,  c.URNID,      t.TargetName,       cls.LoanAmountDisbursed,cls.DisbursementDate,cls.ExpectedPaidUpDate,
ActualPaidupDate,                
cls.PrincipalOutstanding,cls.NumMissedInstallments,cls.NumInstallmentsInArrears,cls.CurrentInstallmentPeriod,cls.LoanDurationInWeeks, NULL as       NPADate, NULL as     BalanceasonNPADate,'Defaulter' as remark,NULL as       LockdownNumMissedInstallments,null as    dataflag,cls.DeathDate            
from ClientLoanSubscription cls with (nolock)                                            
inner join ClientLoanProposal clp with (nolock) on clp.LoanProposaLId=cls.LoanProposalID                                         
inner join Clients c with (nolock) on c.ClientId=clp.ClientId                                                
inner join Targets t with (nolock) on t.targetId=c.targetId                                           
Where cls.NPA_Date is NULL and  cls.CurrentInstallmentPeriod>cls.LoanDurationinWeeks 
 and cls.principalOutstanding>0   

--For Risk clients
select cls.ClientLoanId, cls.LoanProposalID,  c.URNID,      t.TargetName,       cls.LoanAmountDisbursed,cls.DisbursementDate,cls.ExpectedPaidUpDate,
ActualPaidupDate,                
cls.PrincipalOutstanding,cls.NumMissedInstallments,cls.NumInstallmentsInArrears,cls.CurrentInstallmentPeriod,cls.LoanDurationInWeeks, NULL as       NPADate, NULL as     BalanceasonNPADate,'Defaulter' as remark,NULL as       LockdownNumMissedInstallments,null as    dataflag,cls.DeathDate            
from ClientLoanSubscription cls with (nolock)                                            
inner join ClientLoanProposal clp with (nolock) on clp.LoanProposaLId=cls.LoanProposalID                                         
inner join Clients c with (nolock) on c.ClientId=clp.ClientId                                                
inner join Targets t with (nolock) on t.targetId=c.targetId                                           
Where cls.NPA_Date is NULL and  cls.CurrentInstallmentPeriod<=cls.LoanDurationinWeeks and cls.NumInstallmentsInArrears>4
and cls.principalOutstanding>0

--update  LoanLedger set PrincipalCollected = '438',InterestCollected='587' where ClientLoanID like '14:12:18:01:22:7R:01%' and 
--WeeklyTransactionDate = '2023-05-11'

--update ClientLoanSubscription Set ActualPaidUpDate = NULL, PrincipalOutstanding = '1' Where ClientLoanId Like '14:12:18:01:22:7R:01%' 

--select * from ClientLoanSubscription With (NOLOCK) where ClientLoanID like '14%' and ActualDisbursementDate = '2023-09-06'

--select * from ClientLoanSubscription With (NOLOCK) where ClientLoanID like '28:24:A1:01:07:R1:01%' and ActualDisbursementDate = '2023-09-06' 

--select * from AadharDisbursement With (NOLOCK) where DocumentationDate = '2023-08-21' and ClientID like '05:27:T1:01:66%'

