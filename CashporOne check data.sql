
declare @rid varchar(2)='05'

select a.BranchID, isnull(a.Collection,0)Collection_LDB, isnull(b.Ins1Year,0)Ins1Year_LDB, isnull(c.Ins2Year,0)Ins2Yea_LDBr, 
isnull(d.Processing,0)Processing_LDB, isnull(i.DisbAmtLDB,0) DisbAmtLDB,
isnull(e.collection,0) collection_C1, isnull(f.Ins1Year,0) Ins1Year_C1, isnull(g.Ins2Year,0) Ins2Year_C1, isnull(h.Processing,0) Processing_C1,
isnull(j.DisbAmtC1,0) DisbAmtLDB,
isnull((isnull(a.Collection,0)-isnull(e.Collection,0)),0) CollDiff, isnull((isnull(b.ins1Year,0)-isnull(f.ins1Year,0)),0) ins1YearDiff, isnull((isnull(c.ins2Year,0)-isnull(g.ins2Year,0)),0) ins2YearDiff, 
isnull((isnull(d.Processing,0)-isnull(h.Processing,0)),0) ProcDiff, isnull((isnull(i.DisbAmtLDB,0)-isnull(j.DisbAmtC1,0)),0) DisbDIff
from
(
select left(clientloanid,5) BranchID, sum(ll.interestcollected+ll.principalcollected) Collection from loanledger ll with (nolock)
where cast(weeklytransactiondate as date) = cast(getdate()-1 as date)
group by left(clientloanid,5)
) a 
left join
(
select left(clientloanid,5) BranchID, sum(riskfund) ins1Year from clientloansubscription cls with (nolock)
where cast(riskfunddate as date) = cast(getdate()-1 as date)
group by left(clientloanid,5)
) b on b.branchid=a.branchid
left join
(
select left(clientloanid,5) BranchID, sum(RiskFund_2) ins2Year from clientloansubscription cls with (nolock)
where cast(riskfunddate_2 as date) = cast(getdate()-1 as date)
group by left(clientloanid,5)
) c on c.branchid=a.branchid
left join
(
select left(clientloanid,5) BranchID, sum(upfrontfee) Processing from clientloansubscription cls with (nolock)
where cast(upfrontfeedate as date) = cast(getdate()-1 as date)
group by left(clientloanid,5)
) d on d.branchid=a.branchid
left join
(
select BranchID, isnull(sum(ll.interestcollected+ll.principalcollected),0) Collection from cashporone..loanledger ll with (nolock)
where cast(weeklytransactiondate as date) = cast(getdate()-1 as date) and regionid=@rid
group by BranchID
) e on e.branchid=a.branchid 
left join
(
select BranchID, sum(riskfund) ins1Year from cashporone..clientloansubscription cls with (nolock)
where cast(riskfunddate as date) = cast(getdate()-1 as date) and regionid=@rid
group by BranchID
) f on f.branchid=a.branchid
left join
(
select BranchID, sum(RiskFund_2) ins2Year from cashporone..clientloansubscription cls with (nolock)
where cast(riskfunddate_2 as date) = cast(getdate()-1 as date) and regionid=@rid
group by BranchID
) g on g.branchid=a.branchid
left join
(
select BranchID, sum(upfrontfee) Processing from cashporone..clientloansubscription cls with (nolock)
where cast(upfrontfeedate as date) = cast(getdate()-1 as date) and regionid=@rid
group by BranchID
)h on h.branchid=a.branchid
left join
(
select left(clientloanid,5) BranchID, sum(LoanAmountDisbursed) DisbAmtLDB from clientloansubscription cls with (nolock)
where cast(DisbursementDate as date) = cast(getdate()-1 as date)
group by left(clientloanid,5)
) i on i.branchid=a.branchid
left join
(
select BranchID, sum(LoanAmountDisbursed) DisbAmtC1 from cashporone..clientloansubscription cls with (nolock)
where cast(DisbursementDate as date) = cast(getdate()-1 as date) and regionid=@rid
group by BranchID
)j on j.branchid=a.branchid
order by a.branchid
