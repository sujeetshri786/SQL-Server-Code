
--------------------------------NIKHILE SIR (DAY CLOSE DATA CHECK QUERY- Cashporone )--------------------------------------


-------yashpal sir day clos Disbursement chk query 
Select * From neftdisbtransaction with(nolock) where loanproposalid in(
select loanproposalid from clientloansubscription with(nolock) where actualdisbursementdate<=(convert(nvarchar(10),getdate()-1,23)) and disbursementdate is null
and RegionID IN ('05','14','16')
 ) order by LoanProposalID
 /*

-------GAURAV sir day clos Disbursement chk query 
select actualdisbursementdate,*  from clientloansubscription with(nolock) where actualdisbursementdate<=(convert(nvarchar(10),getdate()-1,23)) 
--and RegionID IN ('17')
and disbursementdate is null
and loanproposalid in (select loanproposalid from Cashpor..APBSNEFTDisbursement with(nolock) )
*/
							 --- amresh sir day close qqq chk must.......
----Interest Outstanding getting negative
Select * from ClientLoanSubscription with (nolock) where (actualpaidupdate=cast(getdate() as date)) and InterestOutstanding<0
and RegionID in ('05','14','16')

----Interest in Arrears getting negative

Select * from ClientLoanSubscription with (nolock) where ( actualpaidupdate=cast(getdate() as date)) and InterestInArrears<0
and RegionID in ('05','14','16')
AND Comments NOT LIKE '%Disbursement Fail%'

------Installment collected without due(Principal or Interest) 
Select B.CurrentInstallmentPeriod,* from loanledger a (nolock) 
Join clientloansubscription b (nolock) on a.clientloanid=b.ClientLoanID
where  ((a.PrincipalInstallmentAmt=0 and a.PrincipalCollected>0) or (a.InterestInstallmentAmt=0 and InterestCollected>0) ) and CurrentInstallmentPeriod<=LoanDurationInWeeks
and WeeklyTransactionDate=cast(getdate() as date) and (b.Comments not like '%Disbursement Fail%' or b.Comments is null) and b.deathdate is  null
and b.RegionID in ('05','14','16')

------Disbursement done without Insurance
Select DistrictName,Br.BranchID,BranchName,Cls.ClientLoanID,cls.LoanProposalID,Targetname,Targetage,CoBorrowerName,CoBorrowerAge,DisbursementDate,ActualDisbursementDate,
cls.LoanAmountDisbursed,CurrentInstallmentPeriod,LoanDurationInWeeks,cls.UpFrontFee,cls.RiskFund from ClientLoanSubscription cls (nolock) 
Join Products p (nolock) on p.ProductID=SUBSTRING(cls.clientloanid,16,2)
join clientloanproposal clp (nolock) on clp.loanproposalid=cls.loanproposalid
Join Branches Br (nolock) on Br.branchid=left(cls.clientloanid,5)
where ActualDisbursementDate= cast(getdate()-1 as date) and cls.RiskFund=0   and Targetage<60 
and ((p.Loan_Category in(0,7)) or(p.BCIDNO<>0 and p.Loan_Category=5)) and actualpaidupdate is null
and cls.RegionID in ('05','14','16')

------------------------------ (no record)
Select * from ClientLoanSubscription  With (Nolock) where PrincipalOutstanding<0 and RegionID in ('05','14','16')
Select * from ClientLoanSubscription  With (Nolock) where PrincipalOutstanding is null and RegionID in ('05','14','16')
Select * from ClientLoanSubscription  With (Nolock) where CurrentInstallmentPeriod is null and RegionID in ('05','14','16')
Select * from ClientLoanSubscription  With (Nolock) where ActualPaidUpDate is null and CurrentInstallmentPeriod is null and RegionID in ('05','14','16')
Select * from ClientLoanSubscription  With (Nolock) where ActualPaidUpDate=cast (getdate() as date) and actualdisbursementdate=cast (getdate() as date) 
and RegionID in ('05','14','16')
------------------------------ (no record)
Select clientloansubscription.ClientLoanID,PrincipalOutstanding,clientloansubscription.PrincipalInArrears,LastTransactionDate,
PrincipalOutstanding-clientloansubscription.PrincipalInArrears as morearreas ,
loanledger.PrincipalInstallmentAmt as LLPInstallment,LoanLedger.PrincipalInArrears as LLPArrears,
WeeklyTransactionDate,(LoanLedger.PrincipalInstallmentAmt+PrincipalOutstanding-clientloansubscription.PrincipalInArrears)-PrincipalCollected as ProposedPArrearLL
from ClientLoanSubscription (nolock)
inner join LoanLedger (nolock) on loanledger.clientloanid=clientloansubscription.ClientLoanID and LastTransactionDate=WeeklyTransactionDate
where PrincipalOutstanding>0 and CurrentInstallmentPeriod>LoanDurationInWeeks and PrincipalOutstanding<clientloansubscription.PrincipalInArrears
and clientloansubscription.RegionID in ('05','14','16')

----- no record
Select clientloansubscription.ClientLoanID,PrincipalOutstanding,clientloansubscription.PrincipalInArrears,LastTransactionDate,PrincipalOutstanding-clientloansubscription.PrincipalInArrears as lessarrears ,
loanledger.PrincipalInstallmentAmt,LoanLedger.PrincipalInArrears,WeeklyTransactionDate,(LoanLedger.PrincipalInstallmentAmt+PrincipalOutstanding-clientloansubscription.PrincipalInArrears)-PrincipalCollected as ProposedPArrearLL
from ClientLoanSubscription with(Nolock) 
inner join LoanLedger with(Nolock) on loanledger.clientloanid=clientloansubscription.ClientLoanID and LastTransactionDate=WeeklyTransactionDate
where PrincipalOutstanding>0 and CurrentInstallmentPeriod>LoanDurationInWeeks and PrincipalOutstanding>clientloansubscription.PrincipalInArrears
and clientloansubscription.RegionID in ('05','14','16')

------ DISB MISSMATCH IN DB AND DCR(NO RECORD)

select b.BranchID, b.TotalDisbursementHO as TotalDisbursementHO_DTL,a.TotalDisbursementHO
from (select left(ClientLoanID,5) as BranchID, SUM(LoanAmountDisbursed) as TotalDisbursementHO 
from ClientLoanSubscription with(nolock) 
where DisbursementDate=cast(GETDATE() as date) and disbursementmode in (2,4)
group by left(ClientLoanID,5)) a 
join TempDailyClosingDtl b with(nolock) on a.BranchID=b.BranchID
and b.RegionID in ('05','14','16')
where b.TotalDisbursementHO>0 and b.TotalDisbursementHO<>a.TotalDisbursementHO

-------FOR DCR CHK and log file

SELECT COUNT(*) app_dtl FROM [43.242.174.235].[Appcashpor].[dbo].DailyClosingDTL with ( nolock )WHERE SEND=1 AND BRANCHID IN (SELECT BRANCHID FROM TEMPDailyClosingDTL   with ( nolock ) WHERE  SEND=1)

 SELECT COUNT(*) local_dtl FROM TEMPDailyClosingDTL  with ( nolock ) WHERE  SEND=1
AND  LEFT(BRANCHID,2) in ('05','14','16')

select count(*) logfile  from logfile with ( nolock) where endprocdate=cast (getdate() as date) and WorkEndDT is not null 
AND LEFT(BRANCHID,2) in ('05','14','16')

----ALL THREE RECORD R SAME

Select counT(*),sum(Loanamountdisbursed) from ClientLoanProposal with(nolock) 
where LoanDisbursementDate=cast (getdate() as date) and FinalIfsccode<>'0' and FinalAccountNumber<>'0' and DisbursementMode in('4','2') 
and FinalAccountNumber is not null 
AND LEFT(BRANCHID,2) in ('05','14','16')

Select counT(*),sum(Loanamountdisbursed) from ClientLoanSubscription with(nolock) 
where ActualDisbursementDate=cast (getdate() as date)  and DisbursementMode in('4','2') 
and DisbursementDate is  null
AND LEFT(BRANCHID,2) in ('05','14','16')

Select counT(*),sum(LoanAmount) from AadharDisbursement 
with(nolock) where DocumentationDate=cast (getdate() as date)  
and DisbursementMode in('4','2') and LoanDisbursementDate is  null
AND LEFT(BRANCHID,2) in ('05','14','16')




/*
-------yashpal sir day clos Disbursement chk query 

--Select * From Cashpor..APBSNEFTDisbursement with(nolock) where loanproposalid in(
--select loanproposalid from clientloansubscription with(nolock) where actualdisbursementdate<=(convert(nvarchar(10),getdate()-1,23)) and disbursementdate is null ) order by Branchid

Select * From neftdisbtransaction with(nolock) where loanproposalid in(
select loanproposalid from clientloansubscription with(nolock) where actualdisbursementdate<=(convert(nvarchar(10),getdate()-1,23)) and disbursementdate is null 
--and regionid = '17' 
 ) order by LoanProposalID  

										 --- amresh sir day close qqq chk must.......

----Interest Outstanding getting negative
Select * from ClientLoanSubscription where (actualpaidupdate=cast(getdate() as date)) and InterestOutstanding<0 --and regionid = '17'
---- update ClientLoanSubscription set ActualPaidUpDate=null,PrincipalOutstanding=1 where LoanProposalID='17:05:40445'

----Interest in Arrears getting negative

Select * from ClientLoanSubscription where ( actualpaidupdate=cast(getdate() as date)) and InterestInArrears<0 ---and regionid = '17'

------Installment collected without due(Principal or Interest) 
Select * from loanledger a (nolock) 
Join clientloansubscription b (nolock) on a.clientloanid=b.ClientLoanID
where  ((a.PrincipalInstallmentAmt=0 and a.PrincipalCollected>0) or (a.InterestInstallmentAmt=0 and InterestCollected>0) ) and CurrentInstallmentPeriod<=LoanDurationInWeeks
and WeeklyTransactionDate=cast(getdate() as date) and (b.Comments not like '%Fail%' or b.Comments is null) and b.deathdate is  null
---and regionid = '17'

------Disbursement done without Insurance

Select DistrictName,Br.BranchID,BranchName,Cls.ClientLoanID,cls.LoanProposalID,Targetname,Targetage,CoBorrowerName,CoBorrowerAge,DisbursementDate,ActualDisbursementDate,
cls.LoanAmountDisbursed,CurrentInstallmentPeriod,LoanDurationInWeeks,cls.UpFrontFee,cls.RiskFund from ClientLoanSubscription cls (nolock) 
Join Products p (nolock) on p.ProductID=SUBSTRING(cls.clientloanid,16,2)
join clientloanproposal clp (nolock) on clp.loanproposalid=cls.loanproposalid
Join Branches Br (nolock) on Br.branchid=left(cls.clientloanid,5)
where ActualDisbursementDate= cast(getdate()-1 as date) and cls.RiskFund=0   and Targetage<60 
and ((Loan_Category in(0,7)) or(BCIDNO<>0 and Loan_Category=5)) and actualpaidupdate is null
--- and regionid = '17'


---NPA DATE should not null or blank

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
---ClientLoanSubscription and regionid = '17'  

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
---ClientLoanSubscription and regionid = '17'

------------------------------ no record
Select * from ClientLoanSubscription  With (Nolock) where PrincipalOutstanding<0 ---and regionid = '17'
Select * from ClientLoanSubscription  With (Nolock) where PrincipalOutstanding is null ---and regionid = '17'
Select * from ClientLoanSubscription  With (Nolock) where CurrentInstallmentPeriod is null ---and regionid = '17'
Select * from ClientLoanSubscription  With (Nolock) where ActualPaidUpDate is null and CurrentInstallmentPeriod is null ---and regionid = '17'
Select * from ClientLoanSubscription  With (Nolock) where ActualPaidUpDate=cast (getdate() as date) and actualdisbursementdate=cast (getdate() as date) ---and regionid = '17'


--select ClientLoanSubscription.ClientLoanID,ClientLoanSubscription.DisbursementDate,ClientLoanSubscription.LoanAmountDisbursed,
--ClientLoanSubscription.PrincipalReturnedToDate,ClientLoanSubscription.PrincipalOutstanding,SUM(loanledger.PrincipalCollected)
--as principalcollection,ClientLoanSubscription.ActualPaidUpDate from ClientLoanSubscription With (Nolock) inner join
--LoanLedger With (Nolock) on ClientLoanSubscription.ClientLoanID=LoanLedger.ClientLoanID 
--where ClientLoanSubscription.ActualPaidUpDate>=cast (getdate() as date)
--group by ClientLoanSubscription.ClientLoanID,ClientLoanSubscription.DisbursementDate,ClientLoanSubscription.ActualPaidUpDate,
--ClientLoanSubscription.PrincipalReturnedToDate,ClientLoanSubscription.PrincipalOutstanding,
--ClientLoanSubscription.LoanAmountDisbursed
--Having ClientLoanSubscription.PrincipalReturnedToDate<> SUM(loanledger.PrincipalCollected)

------------------ no record
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
---ClientLoanSubscription and regionid = '17'

------------------------ no record
Select clientloansubscription.ClientLoanID,PrincipalOutstanding,clientloansubscription.PrincipalInArrears,LastTransactionDate,
PrincipalOutstanding-clientloansubscription.PrincipalInArrears as morearreas ,
loanledger.PrincipalInstallmentAmt as LLPInstallment,LoanLedger.PrincipalInArrears as LLPArrears,
WeeklyTransactionDate,(LoanLedger.PrincipalInstallmentAmt+PrincipalOutstanding-clientloansubscription.PrincipalInArrears)-PrincipalCollected as ProposedPArrearLL
from ClientLoanSubscription (nolock)
inner join LoanLedger (nolock) on loanledger.clientloanid=clientloansubscription.ClientLoanID and LastTransactionDate=WeeklyTransactionDate
where PrincipalOutstanding>0 and CurrentInstallmentPeriod>LoanDurationInWeeks and PrincipalOutstanding<clientloansubscription.PrincipalInArrears
---ClientLoanSubscription and regionid = '17'

/*
-------------------------- no record
select BR.Branchid,BR.BranchName,
ISNULL((case when BR.heathInsurance<>DL.HealthInsurance then BR.heathInsurance-DL.HealthInsurance end),0) MIS_Helth,
ISNULL((case when BR.Cashless_Collection<>DL.UPI_Collection then DL.UPI_Collection-BR.Cashless_Collection end),0)MIS_UPI,
ISNULL((case when BR.Kaleidofinamount<>DL.KaleidofinColl then BR.Kaleidofinamount-DL.KaleidofinColl end),0)MIS_KALEDO,
ISNULL( (case when BR.Minsurecollection<>(DL.MInsuranceCollection+DL.MInsuranceCollectionByCashpor) then 0 end ),0) MIS_minsure
from branch_report BR with(Nolock)
inner join DailyClosingDtl DL with(Nolock) on br.branchid=DL.branchid
*/
--------------------------- no record
select LEFT(clientloanid,5) as BRANCH_ID, branches.BranchName as BRANCH_NAME, count(clientloanid) as NUM_LOANCLIENT_CLS, 
SUM(LoanAmountDisbursed) as DISBURSED_AMT_CLS, 
COUNT(clientloanid)*200 as STAMPAMOUNT_CLS,
(select ISNULL(sum(StampPeperColl),0) from DailyClosingDtl with(Nolock) where BranchID=LEFT(clientloanid,5)) as 'STAMP_AMOUNT_DCR',
case when COUNT(clientloanid)*200=(select ISNULL(sum(StampPeperColl),0) from DailyClosingDtl  with(Nolock)
where BranchID=LEFT(clientloanid,5)) then 'True' else 'False' End as 'STAMP_MATCH_CLS_DCR STATUS'
from clientloansubscription with(Nolock) inner join Branches with(Nolock) on BranchID=LEFT(clientloanid,5)
where ActualDisbursementDate>=CONVERT(varchar(10), GETDATE() ,23) and SUBSTRING(clientloanid,16,2) in ('W6','5X')
group by LEFT(clientloanid,5),BranchName

---------------------------------- no record
Select clientloansubscription.ClientLoanID,PrincipalOutstanding,clientloansubscription.PrincipalInArrears,LastTransactionDate,PrincipalOutstanding-clientloansubscription.PrincipalInArrears as lessarrears ,
loanledger.PrincipalInstallmentAmt,LoanLedger.PrincipalInArrears,WeeklyTransactionDate,(LoanLedger.PrincipalInstallmentAmt+PrincipalOutstanding-clientloansubscription.PrincipalInArrears)-PrincipalCollected as ProposedPArrearLL
from ClientLoanSubscription with(Nolock) 
inner join LoanLedger with(Nolock) on loanledger.clientloanid=clientloansubscription.ClientLoanID and LastTransactionDate=WeeklyTransactionDate
where PrincipalOutstanding>0 and CurrentInstallmentPeriod>LoanDurationInWeeks and PrincipalOutstanding>clientloansubscription.PrincipalInArrears
---ClientLoanSubscription and regionid = '17'

--------------------------
select ClientLoanID from clientloansubscription cls with(nolock) 
Join neftdisbtransaction b with(nolock)  
on cls.loanproposalid=b.loanproposalid 
where actualdisbursementdate<=(convert(nvarchar(10),getdate()-1,23)) 
and disbursementdate is null 
---ClientLoanSubscription and regionid = '17'


--Branch wise disbursement by HO (APBS & NEFT)
--select left(ClientLoanID,5) as BranchID, SUM(LoanAmountDisbursed) as TotalDisbursementHO 
--from ClientLoanSubscription with(nolock) 
--where DisbursementDate=cast(GETDATE() as date) and disbursementmode in (2,4) 
--group by left(ClientLoanID,5)  

--select BranchID, TotalDisbursementHO from DailyClosingDtl with(nolock) where TotalDisbursementHO>0 

----------------------------
select b.BranchID, b.TotalDisbursementHO as TotalDisbursementHO_DTL,a.TotalDisbursementHO
from (select left(ClientLoanID,5) as BranchID, SUM(LoanAmountDisbursed) as TotalDisbursementHO 
from ClientLoanSubscription with(nolock) 
where DisbursementDate=cast(GETDATE() as date) and disbursementmode in (2,4) 
group by left(ClientLoanID,5)) a 
join tempDailyClosingDtl b with(nolock) on a.BranchID=b.BranchID
where b.TotalDisbursementHO>0 and b.TotalDisbursementHO<>a.TotalDisbursementHO
---ClientLoanSubscription and regionid = '17'

--- Record Same in table
Select counT(*),sum(Loanamountdisbursed) from ClientLoanProposal with(nolock) 
where LoanDisbursementDate=cast (getdate() as date) and FinalIfsccode<>'0' and FinalAccountNumber<>'0' and DisbursementMode in('4','2') 
and FinalAccountNumber is not null
---- and regionid = '17'

Select counT(*),sum(Loanamountdisbursed) from ClientLoanSubscription with(nolock) 
where ActualDisbursementDate=cast (getdate() as date)  and DisbursementMode in('4','2') 
and DisbursementDate is  null
---- and regionid = '17'

Select counT(*),sum(LoanAmount) from AadharDisbursement 
with(nolock) where DocumentationDate=cast (getdate() as date)  
and DisbursementMode in('4','2') and LoanDisbursementDate is  null
---- and regionid = '17'
*/




