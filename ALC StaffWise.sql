---ALC StaffWise

select D.Zone,D.districtName ,A.BranchID,d.Branchname,d.CHID,(select Staffname from fieldstaff where Staffid=d.chid) as CHIB_Name,
A.StaffID,A.StaffName,Position, isnull(NumCenter,0) as NUm_Centers,isnull(h.Numpro_own,0) Numpro_own,isnull(h.LoanAmountpro_OWN,0) LoanAmountpro_OWN,   isnull(b.Numpro,0) as BCproposal, isnull(b.LoanAmount,0) as BCproposal_AMT, isnull(g.NumproSidbi,0) as SIDBI_proposal,
isnull(g.LoanAmountproSiDBI,0) as SIDBI_proposalAMT ,isnull(Numpro_FL,0)NoofproFL,isnull( LoanAmountpro_FL,0)AMTFL,
isnull(TotalProposal,0) as Total_Proposal,isnull(Total_LoanAmount,0) as Total_LoanAmount,
isnull( NumDis,0)NOLoan_DISB, isnull(LoanAmountDisbursed,0)AMT_DISB, isnull(Collected,0) as prin_Collection,
isnull(e.Adding,0) as Adding
from (
select Branchid,Staffid,StaffName ,case                                     
                                         When f.Designation='12' Then 'CM'
                                         When f.Designation='13' Then 'CM'
                                         When f.Designation='14' Then 'PCM'
                                         When f.Designation='15' Then 'TCM'
                                         When f.Designation='46' Then 'CTPCM'
                                         When f.Designation='47' Then 'CTTCM'
                                         End As 'Position'

from FieldStaff f (nolock)
where f.Designation in('12','13','14','15','47','46') and exitdate is null and left(f.branchid,2) in  ('05')
) A left join 
(
select c.entryby as Staffid ,count(c.LoanProposalID) Numpro,sum(LoanAmountApproved) LoanAmount
from clientloanproposal c (nolock) 
where c.proposaldate between  '2024-05-01' and '2024-09-27' and c.productcategory like '%BC%' and RegionID in ('05')
group by c.entryby
) B on A.Staffid=b.Staffid left join 

(select cls.Staffid as Staffid,count(c.LoanProposalID) NumDis,sum(cls.LoanAmountDisbursed) LoanAmountDisbursed
from clientloanproposal c (nolock) inner join clientloansubscription cls (nolock) on c.loanproposalid=cls.loanproposalid
where cls.disbursementdate between  '2024-05-01' and '2024-09-27' and c.RegionID in ('05') 
group by cls.Staffid
) C on A.StaffID=c.Staffid left Join

(select c.entryby as Staffid ,count(c.LoanProposalID) NumproSidbi,sum(LoanAmountApproved) LoanAmountproSiDBI
from clientloanproposal c (nolock) 
where c.proposaldate between  '2024-05-01' and '2024-09-27' and c.productcategory like '%SIDBI%' and RegionID in ('05')
group by c.entryby
) G on A.Staffid=g.Staffid left join 

(select c.entryby as Staffid ,count(c.LoanProposalID) Numpro_own,sum(LoanAmountApproved) LoanAmountpro_OWN
from clientloanproposal c (nolock) 
where c.proposaldate between  '2024-05-01' and '2024-09-27' and c.productcategory like '%IGL%' and RegionID in ('05')
group by  c.entryby
) h on A.StaffID=h.Staffid left Join

(
select c.entryby as Staffid ,count(c.LoanProposalID) TotalProposal,sum(LoanAmountApproved) Total_LoanAmount
from clientloanproposal c (nolock) 
where c.proposaldate between  '2024-05-01' and '2024-09-27'  and RegionID in ('05')
group by c.entryby
) u on A.Staffid=u.Staffid left join 


(select c.entryby as Staffid ,count(c.LoanProposalID) Numpro_FL,sum(LoanAmountApproved) LoanAmountpro_FL
from clientloanproposal c (nolock) 
where c.proposaldate between  '2024-05-01' and '2024-09-27' and c.productcategory like '%FL%' and RegionID in ('05')
group by  c.entryby
) K on A.StaffID=K.Staffid left Join

(select c.entryby as Staffid ,count(c.clientid) Adding
from clients c (nolock) 
where cast(c.joindate as date) between  '2024-05-01' and '2024-09-27' and RegionID in ('05')
group by c.entryby,left(clientid,5)
) e     on A.Staffid=e.Staffid left join
(select Staffid,count(centerid)NumCenter from centers (nolock) where dissolveddate is null and RegionID in ('05') group by Staffid
)O on A.Staffid=o.Staffid left join

(select Staffid,sum(principalcollected) as Collected from loanledger (nolock) where weeklytransactiondate between  '2024-05-01' and '2024-09-27' and RegionID in ('05') group by Staffid
) p on p.Staffid=a.Staffid inner join

Branches D on A.Branchid=D.Branchid
where d.DissolvedDate is null

order by A.BranchID,A.StaffID
