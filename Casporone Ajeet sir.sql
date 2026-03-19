select F.Branchid, isnull(L_collection,0) L_collection, isnull(LoanAmountdisbursed,0) LoanAmountdisbursed, isnull(ins,0) Insurance, isnull(Procs,0) Procs,
e.Totalcollection, isnull(e.DailyDocumentAmt,0)DailyDocumentAmt,isnull(e.ProcessingFees,0) ProcessingFees,isnull(insurancecollection,0) insurancecollection,

(isnull(L_collection,0)-e.Totalcollection) Diff_coll,(isnull(LoanAmountdisbursed,0)- isnull(e.DailyDocumentAmt,0)) Diff_dis,(isnull(ins,0)-isnull(insurancecollection,0))Ins_diff,
(isnull(Procs,0)-isnull(e.ProcessingFees,0))Diff_proc
from 
 (
       select BRanchid from Branches (nolock) where dissolveddate is null and RegionID in('05','14','16')
) F left join
(

select Branchid,sum(principalcollected+interestcollected) L_collection from loanledger (nolock) where Weeklytransactiondate=Cast(getdate () as date) and RegionID in('05','14','16')
group by Branchid
)a  on f.Branchid=a.branchid left join
(
select  Branchid,sum(LoanAmountdisbursed) LoanAmountdisbursed from Clientloansubscription (nolock) where Actualdisbursementdate=Cast(getdate () as date) and RegionID in('05','14','16')
group by Branchid
)b on f.Branchid=b.Branchid left join
(
select  Branchid,sum(case when riskfunddate=cast(getdate () as date) then  riskfund when riskfunddate_2=cast(getdate () as date)   then riskfund_2 else 0 end) ins 
from Clientloansubscription (nolock) where isnull(RiskFundDate_2,riskfunddate)=Cast(getdate() as date) and RegionID in('05','14','16')
group by Branchid
)c on f.Branchid=c.Branchid left join

(
select Branchid,sum(upfrontfee) Procs from Clientloansubscription (nolock) where upfrontfeedate=Cast(getdate () as date) and RegionID in('05','14','16')
group by Branchid
)d on f.Branchid=d.Branchid left join

(
select Branchid, (Totalcollection+upi_collection+DigiCollFingPay)Totalcollection ,DailyDocumentAmt,ProcessingFees,insurancecollection from tempdailyclosingdtl (nolock) 
where cast(meetingdate as date)=Cast(getdate () as date) and left(Branchid,2) in('05','14','16')
) e on f.Branchid=e.Branchid

order by f.Branchid

-------------------------
--Select f.BranchID,isnull(a.LoanAmountdisbursed,0) as Disbursement,isnull(c.Outstanding,0) as Outstanding
--from 
-- (
--       select BRanchid from Branches (nolock) where dissolveddate is null and RegionID in('05','14','16')
--) F left join
--(
--select  Branchid,sum(LoanAmountdisbursed) LoanAmountdisbursed from Clientloansubscription (nolock) where disbursementdate=Cast(getdate()-1 as date) and RegionID in('05','14','16')
--group by Branchid
--)a on f.Branchid=a.Branchid left join

--(
--select  Branchid,sum(Principaloutstanding)  Outstanding from Clientloansubscription (nolock) where actualpaidupdate is null and principaloutstanding>0 and RegionID in('05','14','16')
--group by Branchid
--)c on f.Branchid=c.Branchid
--order by f.Branchid


--EXEC updatecls_help '07:06'
--EXEC updateclscashpor_help '07:06'
--select * from prevcds2 where ClientID like '07:20%' and ClientLoan1AmountDisbursed > '0'

--select * from cds2 where ClientID like '07:20%' and ClientLoan1AmountDisbursed > '0'

--select * from ClientLoanSubscription with (NOLOCK) where ActualDisbursementDate = '2023-12-07' and ClientLoanID like '07:20%'

--------Insurance
--select ClientLoan1ID,ClientLoan2UpFrontFee,RiskFundDate from prevcds2 where clientid like '07:20%' and RiskFundDate is not null


--select ClientLoanID,RiskFund,RiskFundDate from clientloansubscription where clientloanid like '07:20%' and RiskFundDate = '2023-12-27'

--select ClientLoanID,RiskFund_2,RiskFundDate_2 from clientloansubscription where clientloanid like '07:20%' and RiskFundDate_2 = '2023-12-27'

select F.Branchid, isnull(L_collection,0) L_collection, isnull(LoanAmountdisbursed,0) LoanAmountdisbursed, isnull(ins,0) Insurance, isnull(Procs,0) Procs,
e.Totalcollection, isnull(e.DailyDocumentAmt,0)DailyDocumentAmt,isnull(e.ProcessingFees,0) ProcessingFees,isnull(insurancecollection,0)insurancecollection,

(isnull(L_collection,0)-e.Totalcollection) Diff_coll,(isnull(LoanAmountdisbursed,0)- isnull(e.DailyDocumentAmt,0)) Diff_dis,(isnull(ins,0)-isnull(insurancecollection,0))Ins_diff,
(isnull(Procs,0)-isnull(e.ProcessingFees,0))Diff_proc
from 
 (
       select BRanchid from Branches (nolock) where dissolveddate is null and RegionID in('05','14','16')
) F left join
(

select Branchid,sum(principalcollected+interestcollected) L_collection from loanledger (nolock) where Weeklytransactiondate=Cast(getdate ()-1 as date) and RegionID in('05','14','16')
group by Branchid
)a  on f.Branchid=a.branchid left join
(
select  Branchid,sum(LoanAmountdisbursed) LoanAmountdisbursed from Clientloansubscription (nolock) where Actualdisbursementdate=Cast(getdate ()-1 as date) and RegionID in('05','14','16')
group by Branchid
)b on f.Branchid=b.Branchid left join
(
select  Branchid,sum(case when riskfunddate=cast(getdate ()-1 as date) then  riskfund when riskfunddate_2=cast(getdate ()-1 as date)   then riskfund_2 else 0 end) ins 
from Clientloansubscription (nolock) where isnull(RiskFundDate_2,riskfunddate)=Cast(getdate()-1 as date) and RegionID in('05','14','16')
group by Branchid
)c on f.Branchid=c.Branchid left join

(
select Branchid,sum(upfrontfee) Procs from Clientloansubscription (nolock) where upfrontfeedate=Cast(getdate ()-1 as date) and RegionID in('05','14','16')
group by Branchid
)d on f.Branchid=d.Branchid left join

(
select Branchid, (Totalcollection+upi_collection+DigiCollFingPay)Totalcollection ,DailyDocumentAmt,ProcessingFees,insurancecollection from Dailyclosingdtl (nolock) 
where cast(meetingdate as date)=Cast(getdate ()-1 as date) and left(Branchid,2) in('05','14','16')
) e on f.Branchid=e.Branchid

order by f.Branchid
