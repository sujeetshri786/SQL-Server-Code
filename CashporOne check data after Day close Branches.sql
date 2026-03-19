--------Note :- it’s execute in your concern Region DB( like Ambedkarnagar,Aurangabad etc.). After that check all checking point via previous query.
--FOR CASHPOR ONE


select F.Branchid, isnull(L_collection,0) L_collection, isnull(LoanAmountdisbursed,0) LoanAmountdisbursed, isnull(ins,0) Insurance, isnull(Procs,0) Procs,
e.Totalcollection, isnull(e.DailyDocumentAmt,0)DailyDocumentAmt,isnull(e.ProcessingFees,0) ProcessingFees,isnull(insurancecollection,0)insurancecollection,

(isnull(L_collection,0)-e.Totalcollection) Diff_coll,(isnull(LoanAmountdisbursed,0)- isnull(e.DailyDocumentAmt,0)) Diff_dis,(isnull(ins,0)-isnull(insurancecollection,0))Ins_diff,
(isnull(Procs,0)-isnull(e.ProcessingFees,0))Diff_proc
from 
 (
       select BRanchid from Branches (nolock) where dissolveddate is null and RegionID  = '05'
) F left join
(

select Branchid ,sum(principalcollected+interestcollected) L_collection from loanledger (nolock) where Weeklytransactiondate=cast(getdate ()-1 as date)
group by Branchid

)a  on f.Branchid=a.branchid left join
(
select Branchid ,sum(LoanAmountdisbursed) LoanAmountdisbursed from Clientloansubscription (nolock) where Actualdisbursementdate=cast(getdate ()-1 as date)
group by BranchID
)b on f.Branchid=b.Branchid left join
(
select Branchid ,sum(Riskfund) ins from Clientloansubscription (nolock) where riskfunddate=cast(getdate ()-1 as date)
group by Branchid
)c on f.Branchid=c.Branchid left join

(
select Branchid,sum(upfrontfee) Procs from Clientloansubscription (nolock) where upfrontfeedate=cast(getdate ()-1 as date)
group by Branchid
)d on f.Branchid=d.Branchid left join

(
select Branchid, (Totalcollection+upi_collection)Totalcollection ,DailyDocumentAmt,ProcessingFees,insurancecollection from tempdailyclosingdtl 
where cast(meetingdate as date)=cast(getdate ()-1 as date)
) e on f.Branchid=e.Branchid

order by f.Branchid

---------------------------------------------------------------------------------------------------------------------------------------------------------------------



----FOR CASHPOR X
--select F.Branchid, isnull(L_collection,0) L_collection, isnull(LoanAmountdisbursed,0) LoanAmountdisbursed, isnull(ins,0) Insurance, isnull(Procs,0) Procs,
--e.Totalcollection, isnull(e.DailyDocumentAmt,0)DailyDocumentAmt,isnull(e.ProcessingFees,0) ProcessingFees,isnull(insurancecollection,0)insurancecollection,

--(isnull(L_collection,0)-e.Totalcollection) Diff_coll,(isnull(LoanAmountdisbursed,0)- isnull(e.DailyDocumentAmt,0)) Diff_dis,
--(isnull(ins,0)-isnull(insurancecollection,0))Ins_diff,
--(isnull(Procs,0)-isnull(e.ProcessingFees,0))Diff_proc
--from 
-- (
--       select BRanchid from Branches (nolock) where dissolveddate is null
--) F left join
--(

--select left(clientloanid,5) Branchid,sum(principalcollected+interestcollected) L_collection from loanledger (nolock) 
--where Weeklytransactiondate=cast(getdate() as date)
--group by left(clientloanid,5)

--)a  on f.Branchid=a.branchid left join
--(
--select left(clientloanid,5) Branchid,sum(LoanAmountdisbursed) LoanAmountdisbursed from Clientloansubscription (nolock) 
--where Actualdisbursementdate=cast(getdate() as date)
--group by left(clientloanid,5)
--)b on f.Branchid=b.Branchid left join
--(
--select left(clientloanid,5) Branchid,sum(case when riskfunddate=cast(getdate () as date) then  riskfund when riskfunddate_2=cast(getdate () as date)
--then riskfund_2 else 0 end)  ins
--from Clientloansubscription (nolock) where isnull(RiskFundDate_2,riskfunddate)=cast(getdate() as date)
--group by left(clientloanid,5)
--)c on f.Branchid=c.Branchid left join

--(
--select left(clientloanid,5) Branchid,sum(upfrontfee) Procs from Clientloansubscription (nolock) where upfrontfeedate=cast(getdate() as date)
--group by left(clientloanid,5)
--)d on f.Branchid=d.Branchid left join

--(
--select Branchid, (Totalcollection+upi_collection)Totalcollection ,DailyDocumentAmt,ProcessingFees,insurancecollection from tempdailyclosingdtl 
--where cast(meetingdate as date)=cast(getdate() as date)
--) e on f.Branchid=e.Branchid

--order by f.Branchid



