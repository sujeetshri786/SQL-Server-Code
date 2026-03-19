-------------- Check ClientLoanSubscription ---------------------
Select * from ClientLoanSubscription  With (Nolock) where PrincipalOutstanding<0 and regionid='05'
Select * from ClientLoanSubscription  With (Nolock) where PrincipalOutstanding is null and regionid='05'
Select * from ClientLoanSubscription  With (Nolock) where CurrentInstallmentPeriod is null and regionid='05'
Select * from ClientLoanSubscription  With (Nolock) where ActualPaidUpDate is null and CurrentInstallmentPeriod is null and regionid='05'
Select * from ClientLoanSubscription  With (Nolock) where ActualPaidUpDate=cast (getdate() as date) 
and actualdisbursementdate=cast (getdate() as date) and regionid='05'


-------------- Check Null Value in  ClientLoanSubscription---------------------
With temp as(
Select ClientLoanSubscription.ClientLoanID,ClientLoanSubscription.DisbursementDate,ClientLoanSubscription.LoanAmountDisbursed,
ClientLoanSubscription.PrincipalReturnedToDate,ClientLoanSubscription.PrincipalOutstanding,SUM(loanledger.PrincipalCollected)
as principalcollection,ClientLoanSubscription.ActualPaidUpDate from ClientLoanSubscription With (Nolock) inner join
LoanLedger With (Nolock) on ClientLoanSubscription.ClientLoanID=LoanLedger.ClientLoanID 
where ClientLoanSubscription.ActualPaidUpDate>=cast (getdate() as date) and ClientLoanSubscription.regionid='05'
group by ClientLoanSubscription.ClientLoanID,ClientLoanSubscription.DisbursementDate,ClientLoanSubscription.ActualPaidUpDate,
ClientLoanSubscription.PrincipalReturnedToDate,ClientLoanSubscription.PrincipalOutstanding,
ClientLoanSubscription.LoanAmountDisbursed)
Select * from temp a (nolock)
Join clientloansubscription b on a.clientloanid=b.clientloanid
Where a.principalcollection<>b.PrincipalReturnedToDate and b.regionid='05'


Select clientloansubscription.ClientLoanID,PrincipalOutstanding,clientloansubscription.PrincipalInArrears,LastTransactionDate,
PrincipalOutstanding-clientloansubscription.PrincipalInArrears as morearreas ,
loanledger.PrincipalInstallmentAmt as LLPInstallment,LoanLedger.PrincipalInArrears as LLPArrears,
WeeklyTransactionDate,(LoanLedger.PrincipalInstallmentAmt+PrincipalOutstanding-clientloansubscription.PrincipalInArrears)-PrincipalCollected as 
ProposedPArrearLL
from ClientLoanSubscription (nolock)
inner join LoanLedger (nolock) on loanledger.clientloanid=clientloansubscription.ClientLoanID and LastTransactionDate=WeeklyTransactionDate
where PrincipalOutstanding>0 and CurrentInstallmentPeriod>LoanDurationInWeeks and PrincipalOutstanding<clientloansubscription.PrincipalInArrears 
and clientloansubscription.regionid='05'


select LEFT(clientloanid,5) as BRANCH_ID, branches.BranchName as BRANCH_NAME, count(clientloanid) as NUM_LOANCLIENT_CLS, 
SUM(LoanAmountDisbursed) as DISBURSED_AMT_CLS, 
COUNT(clientloanid)*200 as STAMPAMOUNT_CLS,
(select ISNULL(sum(StampPeperColl),0) from DailyClosingDtl with(Nolock) where BranchID=LEFT(clientloanid,5)) as 'STAMP_AMOUNT_DCR',
case when COUNT(clientloanid)*200=(select ISNULL(sum(StampPeperColl),0) from DailyClosingDtl  with(Nolock)
where BranchID=LEFT(clientloanid,5)) then 'True' else 'False' End as 'STAMP_MATCH_CLS_DCR STATUS'
from clientloansubscription with(Nolock) inner join Branches with(Nolock) on branches.BranchID=LEFT(clientloanid,5)
where ActualDisbursementDate>=CONVERT(varchar(10), GETDATE() ,23) and SUBSTRING(clientloanid,16,2) in ('W6','5X')
and clientloansubscription.RegionID='05'
group by LEFT(clientloanid,5),BranchName


Select clientloansubscription.ClientLoanID,PrincipalOutstanding,clientloansubscription.PrincipalInArrears,LastTransactionDate,PrincipalOutstanding-clientloansubscription.PrincipalInArrears as lessarrears ,
loanledger.PrincipalInstallmentAmt,LoanLedger.PrincipalInArrears,WeeklyTransactionDate,(LoanLedger.PrincipalInstallmentAmt+PrincipalOutstanding-clientloansubscription.PrincipalInArrears)-PrincipalCollected as ProposedPArrearLL
from ClientLoanSubscription with(Nolock) 
inner join LoanLedger with(Nolock) on loanledger.clientloanid=clientloansubscription.ClientLoanID and LastTransactionDate=WeeklyTransactionDate
where PrincipalOutstanding>0 and CurrentInstallmentPeriod>LoanDurationInWeeks and PrincipalOutstanding>clientloansubscription.PrincipalInArrears
and clientloansubscription.RegionID='05'

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Select counT(*),sum(Loanamountdisbursed) from ClientLoanProposal with(nolock) 
where LoanDisbursementDate=cast (getdate() as date) and FinalIfsccode<>'0' and FinalAccountNumber<>'0' and DisbursementMode in('4','2') 
and FinalAccountNumber is not null and RegionID= '05'


Select counT(*),sum(Loanamountdisbursed) from ClientLoanSubscription with(nolock) 
where ActualDisbursementDate=cast (getdate() as date)  and DisbursementMode in('4','2') 
and DisbursementDate is  null and regionid='05'

Select counT(*),sum(LoanAmount) from AadharDisbursement 
with(nolock) where DocumentationDate=cast (getdate() as date)  
and DisbursementMode in('4','2') and LoanDisbursementDate is  null and regionid='05'

select ClientLoanID from clientloansubscription cls with(nolock) 
Join neftdisbtransaction b with(nolock)  
on cls.loanproposalid=b.loanproposalid 
where actualdisbursementdate<=(convert(nvarchar(10),getdate()-1,23)) and cls.regionid='05'
and disbursementdate is null 

--Select actualdisbursementdate, * from clientloansubscription where cast(actualdisbursementdate as date)<cast(getdate() as date) 
--and clientloansubscription.regionid='05' and disbursementdate is null and disbursementdate is null


------DISBURSEMENT DATE PADA HAI KI NAHI CHECK KARNE K LIYE PROCEDURE (LOCAL DATABASE MEI)-----------
select actualdisbursementdate,disbursementdate,* from clientloansubscription with(nolock) 
where actualdisbursementdate<=(convert(nvarchar(10),getdate(),23)) and disbursementdate is null 
and loanproposalid in (select loanproposalid from cashpor..APBSNEFTDisbursement)
and clientloansubscription.regionid='05'

----select * from cashpor..APBSNEFTDisbursement where LoanProposalID='32:18:00546'

----select deathperson,deathdate,deathentrydate,AccountNo,IFSCCode,* from ClientLoanSubscription with (nolock) where LoanProposalID='32:18:00546'
----select deathperson,deathdate,deathentrydate,AccountNo,IFSCCode,* from atClientLoanSubscription with (nolock) where LoanProposalID='32:18:00546'

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------DISBURSEMENT DATE NA PADNE PE CHECK KARNE K LIYE PROCEDURE (LOCAL DATABASE MEI)-----------
----select ClientPrimaryKycmember,ClientPrimaryNameasperkyc,HusbandPrimaryNameasperkyc,* from kyc where ClientPrimaryKycmember='686156249054'
----select Trnloanid,clientid,kycno,* from ClientLoanProposal with (nolock) where ClientID='05:05:28:01:31'

----select Trnloanid,clientid,kycno,* from ClientLoanProposal with (nolock) where LoanProposalID='05:05:17281'
----select aadharnumber,* from aadhardisbursement with (nolock) where LoanProposalID='05:05:17281'
----Select aadharnumber,* From Cashpor..APBSNEFTDisbursement with (nolock) where LoanProposalID='05:05:17281'

----update aadhardisbursement set aadharnumber='220126776160' where LoanProposalID='05:05:17281'
----update Cashpor..APBSNEFTDisbursement set aadharnumber='220126776160' where LoanProposalID='05:05:17281'

--Branch wise disbursement by HO (APBS & NEFT)
--select left(ClientLoanID,5) as BranchID, SUM(LoanAmountDisbursed) as TotalDisbursementHO 
--from ClientLoanSubscription with(nolock) 
--where DisbursementDate=cast(GETDATE() as date) and disbursementmode in (2,4) 
--group by left(ClientLoanID,5)  

--select BranchID, TotalDisbursementHO from DailyClosingDtl with(nolock) where TotalDisbursementHO>0 
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

select b.BranchID, b.TotalDisbursementHO as TotalDisbursementHO_DTL,a.TotalDisbursementHO
from (select left(ClientLoanID,5) as BranchID, SUM(LoanAmountDisbursed) as TotalDisbursementHO 
from ClientLoanSubscription with(nolock) 
where DisbursementDate=cast(GETDATE() as date) and disbursementmode in (2,4) 
group by left(ClientLoanID,5)) a 
join tempDailyClosingDtl b with(nolock) on a.BranchID=b.BranchID
where  b.TotalDisbursementHO<>a.TotalDisbursementHO and b.branchid like '05%'

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------Interest Outstanding getting negative------
Select interestduetodate, interestpaidtodate,* from ClientLoanSubscription where (actualpaidupdate=cast(getdate() as date)) 
and InterestOutstanding<0 and regionid='05'
----update ClientLoanSubscription set PrincipalOutstanding='1',ActualPaidUpDate=null where LoanProposalID='30:23:03728'

------Interest in Arrears getting negative------
Select * from ClientLoanSubscription where ( actualpaidupdate=cast(getdate() as date)) and InterestInArrears<0 and regionid='05'
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------Installment collected with out due(Principal or Interest)------ 
Select * from loanledger a (nolock) 
Join clientloansubscription b (nolock) on a.clientloanid=b.ClientLoanID
where  ((a.PrincipalInstallmentAmt=0 and a.PrincipalCollected>0) or (a.InterestInstallmentAmt=0 and InterestCollected>0) ) 
and CurrentInstallmentPeriod<=LoanDurationInWeeks and WeeklyTransactionDate=cast(getdate() as date) and (b.Comments not like '%Fail%' or 
b.Comments is null) and b.deathdate is  null and b.regionid='05'

------Disbursement done without Insurance------ 
Select DistrictName,Br.BranchID,BranchName,Cls.ClientLoanID,cls.LoanProposalID,Targetname,Targetage,CoBorrowerName,CoBorrowerAge,DisbursementDate,ActualDisbursementDate,
cls.LoanAmountDisbursed,CurrentInstallmentPeriod,LoanDurationInWeeks,cls.UpFrontFee,cls.RiskFund from ClientLoanSubscription cls (nolock) 
Join Products p (nolock) on p.ProductID=SUBSTRING(cls.clientloanid,16,2)
join clientloanproposal clp (nolock) on clp.loanproposalid=cls.loanproposalid
Join Branches Br (nolock) on Br.branchid=left(cls.clientloanid,5)
where ActualDisbursementDate= cast(getdate()-1 as date) and cls.RiskFund=0   and Targetage<60 
and ((p.Loan_Category in(0,7)) or(p.BCIDNO<>0 and p.Loan_Category=5)) and actualpaidupdate is null and cls.regionid='05'

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------NPA DATE should not null or blank------

--------NPA Date Checking--For Defaulter clisnts------------
  select cls.ClientLoanId, cls.LoanProposalID,  c.URNID,      t.TargetName,       cls.LoanAmountDisbursed,cls.DisbursementDate,cls.ExpectedPaidUpDate,
ActualPaidupDate,                
cls.PrincipalOutstanding,cls.NumMissedInstallments,cls.NumInstallmentsInArrears,cls.CurrentInstallmentPeriod,cls.LoanDurationInWeeks, NULL as       NPADate, NULL as     BalanceasonNPADate,'Defaulter' as remark,NULL as       LockdownNumMissedInstallments,null as    dataflag,cls.DeathDate            
from ClientLoanSubscription cls with (nolock)                                            
inner join ClientLoanProposal clp with (nolock) on clp.LoanProposaLId=cls.LoanProposalID                                         
inner join Clients c with (nolock) on c.ClientId=clp.ClientId                                                
inner join Targets t with (nolock) on t.targetId=c.targetId                                           
Where cls.NPA_Date is NULL and  cls.CurrentInstallmentPeriod>cls.LoanDurationinWeeks 
 and cls.principalOutstanding>0   and cls.regionid='05'

--------For Risk clients------------
select cls.ClientLoanId, cls.LoanProposalID,  c.URNID,      t.TargetName,       cls.LoanAmountDisbursed,cls.DisbursementDate,cls.ExpectedPaidUpDate,
ActualPaidupDate,                
cls.PrincipalOutstanding,cls.NumMissedInstallments,cls.NumInstallmentsInArrears,cls.CurrentInstallmentPeriod,cls.LoanDurationInWeeks, NULL as       NPADate, NULL as     BalanceasonNPADate,'Defaulter' as remark,NULL as       LockdownNumMissedInstallments,null as    dataflag,cls.DeathDate            
from ClientLoanSubscription cls with (nolock)                                            
inner join ClientLoanProposal clp with (nolock) on clp.LoanProposaLId=cls.LoanProposalID                                         
inner join Clients c with (nolock) on c.ClientId=clp.ClientId                                                
inner join Targets t with (nolock) on t.targetId=c.targetId                                           
Where cls.NPA_Date is NULL and  cls.CurrentInstallmentPeriod<=cls.LoanDurationinWeeks and cls.NumInstallmentsInArrears>4
and cls.principalOutstanding>0    and cls.regionid='05'
