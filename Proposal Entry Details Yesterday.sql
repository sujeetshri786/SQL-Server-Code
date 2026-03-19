--Proposal Entry Details Yesterday Appcashpor
select B.BranchName,LEFT(clp.ClientID,5) as BranchId,
count(case when p.type like'%own%' and Loan_Category not in('5','7')  then 1 end) as 'NoOfOwnIGL',
ISNULL(Sum(case when p.type like'%own%' and Loan_Category not in('5','7')  then ClientRequestedAmount end),0) as 'OwnAmt',
count(case when p.type like'%BC ICICI%' and Loan_Category not in('5','7')  then 1 end) as 'NoOfBCICICI',
ISNULL(Sum(case when p.type like'%BC ICICI%' and Loan_Category not in('5','7')  then ClientRequestedAmount end),0) as 'BCICICIAmt',
count(case when p.type like'%BC IDBI%' and Loan_Category not in('5','7')  then 1 end) as 'NoOfBCIDBI',
ISNULL(Sum(case when p.type like'%BC IDBI%' and Loan_Category not in('5','7')  then ClientRequestedAmount end),0) as 'BCIDBIAmt',
count(case when p.type like'%BC SIDBI%' and Loan_Category not in('5','7')  then 1 end) as 'NoOfBCSIDBI',
ISNULL(Sum(case when p.type like'%BC SIDBI%' and Loan_Category not in('5','7')  then ClientRequestedAmount end),0) as 'BCSIDBIAmt',
count(case when Loan_Category in('5') then 1 end) as 'NoOfFLEXI',
ISNULL(Sum(case when Loan_Category in('5') then ClientRequestedAmount end),0) as 'FlexiAmt',
count(case when Loan_Category in('7') then 1 end) as 'NoOfBridge',
ISNULL(Sum(case when Loan_Category in('7')  then ClientRequestedAmount end),0) as 'BridgeAmt',
ISNULL(Sum(case when Loan_Category in('3')  then 1 end),0) as 'NoOfWat',
ISNULL(Sum(case when Loan_Category in('3')  then ClientRequestedAmount end),0) as 'WatAmt',
count(case when FinalReviewDate is not null then 1 end) as 'NoOfReviewedByBM',
ISNULL(Sum(case when FinalReviewDate is not null then LoanAmountApproved end),0) as 'ReviewedByBMAmt',
Count(Loanproposalid) as TotalProposal,sum(ClientrequestedAmount) TotalAmount
from ClientLoanProposal as clp inner join products p on clp.productid=p.productid
  inner join Branches b on LEFT(clp.ClientID,5)=b.BranchID
where  clientid like'16%' and LoanDisbursementDate is null and PrincipalOutstanding=1 And ProposalDate between '2023-10-14' and '2023-10-14'
group by LEFT(clp.ClientID,5),B.BranchName
order by LEFT(clp.ClientID,5)

--Select left(ClientID,5) As BranChID From ClientLoanProposal With (NoLock) 
--Where ClientId Like '14%' And FinalReviewDate is NULL And PrincipalOutstanding='1' And LoanDisbursementDate is NULL
--And ProposalDate = '2023-03-22'
--Group By left(ClientID,5)
--Order By left(ClientID,5)

