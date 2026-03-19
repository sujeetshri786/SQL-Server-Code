
declare @RID VARCHAR (2) ='21'
select F.Branchid, isnull(L_collection,0) L_collection, isnull(LoanAmountdisbursed,0) LoanAmountdisbursed, isnull(ins,0) Insurance, isnull(Procs,0) Procs,
e.Totalcollection, isnull(e.DailyDocumentAmt,0)DailyDocumentAmt,isnull(e.ProcessingFees,0) ProcessingFees,isnull(insurancecollection,0)insurancecollection,
(isnull(L_collection,0)-e.Totalcollection) Diff_coll,(isnull(LoanAmountdisbursed,0)- isnull(e.DailyDocumentAmt,0)) Diff_dis,(isnull(ins,0)-isnull(insurancecollection,0))Ins_diff,
(isnull(Procs,0)-isnull(e.ProcessingFees,0))Diff_proc
from 
(
       select BRanchid from Branches (nolock) where dissolveddate is null and RegionID =@RID
) F left join
(
select Branchid,sum(principalcollected+interestcollected) L_collection from loanledger (nolock) where Weeklytransactiondate=Cast(getdate() as date) and RegionID =@RID
group by Branchid
)a  on f.Branchid=a.branchid left join
(
select Branchid,sum(LoanAmountdisbursed) LoanAmountdisbursed from Clientloansubscription (nolock) where Actualdisbursementdate=Cast(getdate() as date) and RegionID =@RID
group by Branchid
)b on f.Branchid=b.Branchid left join
(
select Branchid,sum(case when riskfunddate=cast(getdate () as date) then  riskfund when riskfunddate_2=cast(getdate () as date)   then riskfund_2 else 0 end) ins from Clientloansubscription (nolock) where isnull(RiskFundDate_2,riskfunddate)=Cast(getdate() as date) and RegionID =@RID
group by Branchid
)c on f.Branchid=c.Branchid left join
(
select Branchid,sum(upfrontfee) Procs from Clientloansubscription (nolock) where upfrontfeedate=Cast(getdate() as date) and RegionID =@RID
group by Branchid
)d on f.Branchid=d.Branchid left join
(
select Branchid, (Totalcollection+upi_collection)Totalcollection ,DailyDocumentAmt,ProcessingFees,insurancecollection from tempdailyclosingdtl (nolock) where cast(meetingdate as date)=Cast(getdate() as date) and left(Branchid,2) =@RID
) e on f.Branchid=e.Branchid
order by f.Branchid


-------------------------------------------------------------
---rajeev sir settlment


select branchid ,Sum(PrincipalCollected+Interestcollected)  as Total_colllected 
from loanledger where regionid      in   ('28','34','37','21','22','10','01','02','12','15')  and entryby='0507' and weeklytransactiondate='2025-01-16'
group by branchid 
order by branchid





	select F.Branchid, isnull(L_collection,0) L_collection, isnull(LoanAmountdisbursed,0) LoanAmountdisbursed, isnull(ins,0) Insurance, isnull(Procs,0) Procs,
	e.Totalcollection, isnull(e.DailyDocumentAmt,0)DailyDocumentAmt,isnull(e.ProcessingFees,0) ProcessingFees,isnull(insurancecollection,0)insurancecollection,
	(isnull(L_collection,0)-e.Totalcollection) Diff_coll,(isnull(LoanAmountdisbursed,0)- isnull(e.DailyDocumentAmt,0)) Diff_dis,(isnull(ins,0)-isnull(insurancecollection,0))Ins_diff,
	(isnull(Procs,0)-isnull(e.ProcessingFees,0))Diff_proc
	from 
	(
		   select BRanchid from Branches (nolock) where dissolveddate is null and RegionID   in    ('28','34','37','21','22','10')
	) F left join
	(
	select Branchid,sum(principalcollected+interestcollected) L_collection from loanledger (nolock) where Weeklytransactiondate=Cast(getdate() as date) and RegionID   in    ('28','34','37','21','22','10')
	group by Branchid
	)a  on f.Branchid=a.branchid left join
	(
	select Branchid,sum(LoanAmountdisbursed) LoanAmountdisbursed from Clientloansubscription (nolock) where Actualdisbursementdate=Cast(getdate() as date) and RegionID   in    ('28','34','37','21','22','10')
	group by Branchid
	)b on f.Branchid=b.Branchid left join
	(
	select Branchid,sum(case when riskfunddate=cast(getdate () as date) then  riskfund when riskfunddate_2=cast(getdate () as date)   then riskfund_2 else 0 end) ins from Clientloansubscription (nolock) where isnull(RiskFundDate_2,riskfunddate)=Cast(getdate() as date) and RegionID   in    ('28','34','37','21','22','10')
	group by Branchid
	)c on f.Branchid=c.Branchid left join
	(
	select Branchid,sum(upfrontfee) Procs from Clientloansubscription (nolock) where upfrontfeedate=Cast(getdate() as date) and RegionID   in    ('28','34','37','21','22','10')
	group by Branchid
	)d on f.Branchid=d.Branchid left join
	(
	select Branchid, (Totalcollection+upi_collection)Totalcollection ,DailyDocumentAmt,ProcessingFees,insurancecollection from tempdailyclosingdtl (nolock) where cast(meetingdate as date)=Cast(getdate() as date) and left(Branchid,2)   in    ('28','34','37','21','22','10')
	) e on f.Branchid=e.Branchid
	order by f.Branchid

