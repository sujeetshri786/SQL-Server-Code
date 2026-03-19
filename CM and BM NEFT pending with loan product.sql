--CM and BM NEFT pending with loan product 
select (select DistrictName  from Branches where Branchid = left(a.ClientID,5) ) 'DistrictName',
(select left(UPPER(chname) , 14)  from Branches where Branchid = left(a.ClientID,5))'chibname',
left(ClientID,5) as BranchID,
(select UPPER(BranchName)  from Branches where Branchid = left(a.ClientID,5))'BranchName',
EntryBy as StaffID,upper((select StaffName  from fieldstaff where StaffID = a.EntryBy))'StaffName',
ClientID,upper(Targetname) ClientNmae ,upper(HusbandName) HusbandNmae,ClientRequestedAmount as Amount,ProposalDate,ProductCategory,
FinalReviewDate,AccountNumber as Cm_AccountNumber,bmAccountNumber,
(case when AccountNumber = '0' then 'NEFT PENDING By CM' else 'NEFT PENDING By BM'  end) remark
from ClientLoanProposal a 
with (nolock) where left(ClientID,2) IN ('14') and ProposalDate >= '2022-05-23' and LoanDisbursementDate is  NULL
and ( AccountNumber = '0' or BmAccountNumber = '0' ) 
and ApprovalRemarks like 'OK%' --and left(ProductCategory,3)  not in ('igl','own')
order by DistrictName ,  left(ClientID,5),chibname


------Neft Pending By ROE
--SELECT B.DistrictName AS RegionName,b.BranchID,b.BranchName,clp.EntryBY AS StaffID,fs.StaffName,clp.clientID,clp.targetname as ClientName,clp.HusbandName,
--clp.LoanProposalID,clp.LoanAmountApproved AS Amount,clp.ProductCategory,clp.FinalReviewDate,clp.AccountNumber,clp.BMAccountNumber,clp.FINALAccountNumber,
--clp.CBREnquiry,clp.ApprovalRemarks
--FROM ClientLoanProposal as clp With (NoLock)
--Inner Join Branches AS b on b.BranchID=left(clp.ClientId,5)
--Inner Join FieldStaff AS fs on fs.StaffID=clp.EntryBY
--Where clp.ClientID LIKE '05%' and clp.ProposalDate >= '2022-05-23' and clp.LoanDisbursementDate is NULL AND
--clp.BmAccountNumber NOT IN ('0') AND clp.FinalAccountNumber IN ('0')
--and clp.ApprovalRemarks like'OK%' 
--order by clp.ProposalDate


--SELECT * FROM ClientLoanProposal Where clientID = '22:23:67:01:44'
--SELECT * FROM Branches
--SELECT * FROM FieldStaff