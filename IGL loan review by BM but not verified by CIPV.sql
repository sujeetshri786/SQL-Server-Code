------------IGL loan review by BM but not verified by CIPV

select B.BranchID,b.BranchName,clp.ClientID,clp.Targetname as clientName,clp.ProposalDate,clp.LoanProposalID,clp.LoanAmountApproved,clp.NumberOfInstallments,
clp.FinalReviewDate,clp.ProductID,clp.productcategory,clp.EntryBy As CMID,fs.StaffName as CMNAME,clp.BMID,f.StaffName As BMNAME
from clientloanproposal as clp With (Nolock) 
inner join branches as b on b.branchid=left(clp.ClientID,5)
inner join products as p on p.ProductID=clp.ProductID
inner join FieldStaff as fs on fs.staffID=clp.entryBY
inner join FieldStaff as f on f.staffID=clp.BMID
where clp.ClientID like '16%' and clp.PrincipalOutstanding = '1' and clp.FinalReviewDate is not null and p.Type not like '%%BC%%' and 
clp.TRNLoanID not in (select TRNLoanID from KycVerificationTRN)
order by B.BranchID
