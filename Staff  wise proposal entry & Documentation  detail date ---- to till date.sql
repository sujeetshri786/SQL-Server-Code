--Staff  wise proposal entry & Documentation  detail date ---- to till date--Local

Select DistrictName,Br.Branchid,BranchName,
Fs.StaffID,StaffName,dm.DesignationName,(case when fs.StatusAct=1 then 'Active' else 'In-Active' end)Staff_Status,fs.BranchJoinDate,
(Case when BCIDNO=0 then count(LoanProposalID) else 0 end)  OWN_ProposalEntry,
(Case when BCIDNO=0 then Sum(Loanamountapproved) else 0 end)  OWN_ProposalAmt,
(Case when BCIDNO=0 and clp.LoanAmountDisbursed>0 then count(LoanProposalID) else 0 end)  OWN_LoanDocumentation, 
(Case when BCIDNO=0 and clp.LoanAmountDisbursed>0 then Sum(loanamountdisbursed) else 0 end)  OWN_AmtDisb,
(Case when BCIDNO<>0 and clp.ProductCategory not like '%SIDBI%' then count(LoanProposalID) else 0 end)  BC_ProposalEntry,
(Case when BCIDNO<>0 and clp.ProductCategory not like '%SIDBI%' then Sum(Loanamountapproved) else 0 end)  BC_ProposalAmt,
(Case when BCIDNO<>0 and clp.ProductCategory not like '%SIDBI%' and clp.LoanAmountDisbursed>0 then count(LoanProposalID) else 0 end)  BC_LoanDocumentation,
(Case when BCIDNO<>0 and clp.ProductCategory not like '%SIDBI%' and clp.LoanAmountDisbursed>0 then Sum(loanamountdisbursed) else 0 end)  BC_LoanAmtDisb,
(Case when BCIDNO<>0 and clp.ProductCategory  like '%SIDBI%' then count(LoanProposalID) else 0 end)  SIDBI_BC_ProposalEntry,
(Case when BCIDNO<>0 and clp.ProductCategory  like '%SIDBI%' then Sum(Loanamountapproved) else 0 end)  SIDBI_BC_ProposalAmt,
(Case when BCIDNO<>0 and clp.ProductCategory  like '%SIDBI%' and clp.LoanAmountDisbursed>0 then count(LoanProposalID) else 0 end)  SIDBI_BC_LoanDocumentation, 
(Case when BCIDNO<>0 and clp.ProductCategory  like '%SIDBI%' and clp.LoanAmountDisbursed>0 then Sum(loanamountdisbursed) else 0 end)  SIDBI_BC_LoanAmtDisb,
(select sum(principalcollected) from loanledger with(nolock) where weeklytransactiondate between '2025-02-28' and '2025-03-06' and entryby=fs.StaffId) Collection
from ClientLoanProposal clp with(nolock) 
Join products p with(nolock) on p.productid=clp.productid
Join fieldstaff fs with(nolock) on fs.staffid=clp.entryby
Join Branches br with(nolock) on br.branchid=fs.BranchID
Join DesignationMaster dm with(nolock) on dm.DesignationID=fs.Designation
where proposaldate between '2025-02-28' and '2025-03-06' and left(br.BranchID,2) in('28') 
Group by DistrictName,Br.Branchid,BranchName,Fs.StaffID,StaffName,Designation,BCIDNO,clp.LoanAmountDisbursed,
dm.DesignationName,clp.ProductCategory,fs.StatusAct,fs.BranchJoinDate


--Staff  wise proposal entry & Documentation  detail date ---- to till date--Local

Select DistrictName,Br.Branchid,BranchName,
Fs.StaffID,StaffName,dm.DesignationName,(case when fs.StatusAct=1 then 'Active' else 'In-Active' end)Staff_Status,fs.BranchJoinDate,
(Case when BCIDNO=0 and clp.ProductCategory  like '%Bridge%' then count(LoanProposalID) else 0 end)  Bridge_ProposalEntry,
(Case when BCIDNO=0 and clp.ProductCategory  like '%Bridge%' then Sum(Loanamountapproved) else 0 end)  Bridge_ProposalAmt,
(Case when BCIDNO=0 and clp.ProductCategory  like '%Bridge%' and clp.LoanAmountDisbursed>0 then count(LoanProposalID) else 0 end)  Bridge_LoanDocumentation, 
(Case when BCIDNO=0 and clp.ProductCategory  like '%Bridge%' and clp.LoanAmountDisbursed>0 then Sum(loanamountdisbursed) else 0 end)  Bridge_AmtDisb,
(Case when BCIDNO in ('0','1','2','4','5') and clp.ProductCategory  like '%Flexi%' then count(LoanProposalID) else 0 end)  Flexi_ProposalEntry,
(Case when BCIDNO in ('0','1','2','4','5') and clp.ProductCategory  like '%Flexi%' then Sum(Loanamountapproved) else 0 end)  Flexi_ProposalAmt,
(Case when BCIDNO in ('0','1','2','4','5') and clp.ProductCategory  like '%Flexi%' and clp.LoanAmountDisbursed>0 then count(LoanProposalID) else 0 end)  Flexi_LoanDocumentation, 
(Case when BCIDNO in ('0','1','2','4','5') and clp.ProductCategory  like '%Flexi%' and clp.LoanAmountDisbursed>0 then Sum(loanamountdisbursed) else 0 end)  Flexi_AmtDisb,
(Case when BCIDNO=0 then count(LoanProposalID) else 0 end)  OWN_ProposalEntry,
(Case when BCIDNO=0 then Sum(Loanamountapproved) else 0 end)  OWN_ProposalAmt,
(Case when BCIDNO=0 and clp.LoanAmountDisbursed>0 then count(LoanProposalID) else 0 end)  OWN_LoanDocumentation, 
(Case when BCIDNO=0 and clp.LoanAmountDisbursed>0 then Sum(loanamountdisbursed) else 0 end)  OWN_AmtDisb,
(Case when BCIDNO<>0 and clp.ProductCategory not like '%SIDBI%' then count(LoanProposalID) else 0 end)  BC_ProposalEntry,
(Case when BCIDNO<>0 and clp.ProductCategory not like '%SIDBI%' then Sum(Loanamountapproved) else 0 end)  BC_ProposalAmt,
(Case when BCIDNO<>0 and clp.ProductCategory not like '%SIDBI%' and clp.LoanAmountDisbursed>0 then count(LoanProposalID) else 0 end)  BC_LoanDocumentation,
(Case when BCIDNO<>0 and clp.ProductCategory not like '%SIDBI%' and clp.LoanAmountDisbursed>0 then Sum(loanamountdisbursed) else 0 end)  BC_LoanAmtDisb,
(Case when BCIDNO<>0 and clp.ProductCategory  like '%SIDBI%' then count(LoanProposalID) else 0 end)  SIDBI_BC_ProposalEntry,
(Case when BCIDNO<>0 and clp.ProductCategory  like '%SIDBI%' then Sum(Loanamountapproved) else 0 end)  SIDBI_BC_ProposalAmt,
(Case when BCIDNO<>0 and clp.ProductCategory  like '%SIDBI%' and clp.LoanAmountDisbursed>0 then count(LoanProposalID) else 0 end)  SIDBI_BC_LoanDocumentation, 
(Case when BCIDNO<>0 and clp.ProductCategory  like '%SIDBI%' and clp.LoanAmountDisbursed>0 then Sum(loanamountdisbursed) else 0 end)  SIDBI_BC_LoanAmtDisb,
(select sum(principalcollected) from loanledger with(nolock) where weeklytransactiondate between '2025-12-01' and '2025-12-31' and entryby=fs.StaffId) Collection
from ClientLoanProposal clp with(nolock) 
Join products p with(nolock) on p.productid=clp.productid
Join fieldstaff fs with(nolock) on fs.staffid=clp.entryby
Join Branches br with(nolock) on br.branchid=fs.BranchID
Join DesignationMaster dm with(nolock) on dm.DesignationID=fs.Designation
where proposaldate between '2025-12-01' and '2025-12-31' and left(br.BranchID,2) in('14') 
Group by DistrictName,Br.Branchid,BranchName,Fs.StaffID,StaffName,Designation,BCIDNO,clp.LoanAmountDisbursed,
dm.DesignationName,clp.ProductCategory,fs.StatusAct,fs.BranchJoinDate

--Select BCIDNO,* From products where Name like '%%Bridge%%'
--Select BCIDNO,* From products where Name like '%%Flexi%%'

