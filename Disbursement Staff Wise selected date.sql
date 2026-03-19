select D.Zone,A.BranchID,d.Branchname,d.CHID,(select Staffname from fieldstaff where Staffid=d.chid) as CHIB_Name,
A.StaffID,A.StaffName,Position,isnull(b.Numpro,0) as BCproposal, isnull(b.LoanAmount,0) as BCproposal_AMT,isnull(c.NumDis,0) as Noofclients_BCDISB,isnull(c.LoanAmountDisbursed,0) as LoanAmountDisbursed_BC, isnull(g.NumproSidbi,0) as SIDBI_proposal,
isnull(g.LoanAmountproSiDBI,0) as SIDBI_ProposalAMT,isnull(f.NumDisSidbi,0) as DisbursedLOan_SIDBI,isnull(f.DisbursedSidbi,0) as DisbursedAmt_SIDBI, isnull(h.Numpro_own,0) Numpro_own,isnull(h.LoanAmountpro_OWN,0) LoanAmountpro_OWN,
isnull( L.Num_IGLDIS,0)NOLoanOWN_DISB, isnull(Disbursed_IGL,0)AMTOWN_DISB,isnull(Numpro_FL,0)NoofproFL,isnull( LoanAmountpro_FL,0)AMTFL,
isnull(N.Num_FLLDIS,0)Num_FLLDIS,isnull(N.Disbursed_FL,0)Disbursed_FL,
isnull(e.Adding,0) as Adding, isnull(Num_Adding,0)NumAddDISB,isnull(Num_addingDISB,0)NumaddingDISB_AMT
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
where f.Designation in('12','13','14','15','47','46') and exitdate is null and StaffName not like 'Dummy%'
) A left join 
(
select c.entryby as Staffid ,count(c.LoanProposalID) Numpro,sum(LoanAmountApproved) LoanAmount
from clientloanproposal c (nolock) 
where c.proposaldate between  '2025-02-28' and '2025-03-06'     and c.productcategory like '%BC%' 
group by c.entryby
) B on A.Staffid=b.Staffid left join 

(select cls.Staffid as Staffid,count(c.LoanProposalID) NumDis,sum(cls.LoanAmountDisbursed) LoanAmountDisbursed
from clientloanproposal c (nolock) inner join clientloansubscription cls (nolock) on c.loanproposalid=cls.loanproposalid
where c.proposaldate between  '2025-02-28' and '2025-03-06'     and cls.entryby=c.EntryBy and c.productcategory like '%BC%' 
group by cls.Staffid
) C on A.StaffID=c.Staffid left Join

(select c.entryby as Staffid ,count(c.LoanProposalID) NumproSidbi,sum(LoanAmountApproved) LoanAmountproSiDBI
from clientloanproposal c (nolock) 
where c.proposaldate between '2025-02-28' and '2025-03-06'     and c.productcategory like '%SIDBI%' 
group by c.entryby
) G on A.Staffid=g.Staffid left join 


(select cls.Staffid as Staffid,count(c.LoanProposalID) NumDisSidbi,sum(cls.LoanAmountDisbursed) DisbursedSidbi
from clientloanproposal c (nolock) inner join clientloansubscription cls (nolock) on c.loanproposalid=cls.loanproposalid
where c.proposaldate between  '2025-02-28' and '2025-03-06'     and cls.entryby=c.EntryBy and c.productcategory like '%SIDBI%' 
group by cls.Staffid
) F on A.StaffID=F.Staffid left Join

(select c.entryby as Staffid ,count(c.LoanProposalID) Numpro_own,sum(LoanAmountApproved) LoanAmountpro_OWN
from clientloanproposal c (nolock) 
where c.proposaldate between  '2025-02-28' and '2025-03-06'     and c.productcategory like '%IGL%' 
group by  c.entryby
) h on A.StaffID=h.Staffid left Join


(select cls.Staffid as Staffid,count(c.LoanProposalID) Num_IGLDIS,sum(cls.LoanAmountDisbursed) Disbursed_IGL
from clientloanproposal c (nolock) inner join clientloansubscription cls (nolock) on c.loanproposalid=cls.loanproposalid
where c.proposaldate between  '2025-02-28' and '2025-03-06'     and cls.entryby=c.EntryBy and c.productcategory like '%IGL%' 
group by cls.Staffid
) L on A.StaffID=L.Staffid left Join


(select c.entryby as Staffid ,count(c.LoanProposalID) Numpro_FL,sum(LoanAmountApproved) LoanAmountpro_FL
from clientloanproposal c (nolock) 
where c.proposaldate between  '2025-02-28' and '2025-03-06'     and c.productcategory like '%FL%' 
group by  c.entryby
) K on A.StaffID=K.Staffid left Join

(select cls.Staffid as Staffid,count(c.LoanProposalID) Num_FLLDIS,sum(cls.LoanAmountDisbursed) Disbursed_FL
from clientloanproposal c (nolock) inner join clientloansubscription cls (nolock) on c.loanproposalid=cls.loanproposalid
where c.proposaldate between '2025-02-28' and '2025-03-06'     and cls.entryby=c.EntryBy and c.productcategory like '%FL%' 
group by cls.Staffid
) N on A.StaffID=N.Staffid left Join

(select cls.Staffid as Staffid,count(c.LoanProposalID) Num_Adding,sum(cls.LoanAmountDisbursed) Num_addingDISB
from clientloanproposal c (nolock) inner join clientloansubscription cls (nolock) on c.loanproposalid=cls.loanproposalid
inner join clients cs (nolock) on cs.clientid=c.clientid
where c.proposaldate between '2025-02-28' and '2025-03-06'      and cls.entryby=c.EntryBy and c.productcategory like '%IGL%' 
and cast(cs.joindate as date) between  '2025-02-28' and '2025-03-06'  
group by cls.Staffid
) M on A.StaffID=M.Staffid left Join

(select c.entryby as Staffid ,count(c.clientid) Adding


from clients c (nolock) 
where cast(c.joindate as date) between '2025-02-28' and '2025-03-06'       
group by c.entryby,left(clientid,5)
) e     on A.Staffid=e.Staffid left join

Branches D on A.Branchid=D.Branchid
where d.DissolvedDate is null  and A.Branchid like '28%'

order by A.BranchID,A.StaffID

