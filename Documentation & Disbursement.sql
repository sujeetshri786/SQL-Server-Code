--IGL&Flexi/Bridge/BC loan Documentation from 18.11.2022 from to till date day wise.

select B.BranchName,LEFT(clp.ClientLoanID,5) as BranchId,clp.actualdisbursementdate,
count(case when p.type like'%own%' and p.Loan_Category not in('5','7')  then 1 end) as 'NoOfOwnIGL',
ISNULL(Sum(case when p.type like'%own%' and p.Loan_Category not in('5','7')  then Loanamountdisbursed end),0) as 'OwnAmt',
count(case when p.type like'%BC ICICI%' and p.Loan_Category not in('5','7')  then 1 end) as 'NoOfBCICICI',
ISNULL(Sum(case when p.type like'%BC ICICI%' and p.Loan_Category not in('5','7')  then Loanamountdisbursed end),0) as 'BCICICIAmt',
count(case when p.type like'%BC IDBI%' and p.Loan_Category not in('5','7')  then 1 end) as 'NoOfBCIDBI',
ISNULL(Sum(case when p.type like'%BC IDBI%' and p.Loan_Category not in('5','7')  then Loanamountdisbursed end),0) as 'BCIDBIAmt',
count(case when p.type like'%BC SIDBI%' and p.Loan_Category not in('5','7')  then 1 end) as 'NoOfBCSIDBI',
ISNULL(Sum(case when p.type like'%BC SIDBI%' and p.Loan_Category not in('5','7')  then Loanamountdisbursed end),0) as 'BCSIDBIAmt',
count(case when p.Loan_Category in('5') then 1 end) as 'NoOfFLEXI',
ISNULL(Sum(case when p.Loan_Category in('5') then Loanamountdisbursed end),0) as 'FlexiAmt',
count(case when p.Loan_Category in('7') then 1 end) as 'NoOfBridge',
ISNULL(Sum(case when p.Loan_Category in('7')  then Loanamountdisbursed end),0) as 'BridgeAmt',
Count(Loanproposalid) as TotalDis,sum(Loanamountdisbursed) TotalAmount
from ClientLoansubscription as clp inner join products p on Substring(clp.clientloanId,16,2)=p.productid
inner join Branches b on LEFT(clp.ClientLoanID,5)=b.BranchID
where clp.actualdisbursementdate between'2025-08-01' and '2025-08-31' and clientloanid like'21%' and actualpaidupdate is null
group by LEFT(clp.ClientloanID,5),B.BranchName,clp.actualdisbursementdate
order by LEFT(clp.ClientloanID,5),clp.actualdisbursementdate

--IGL&Flexi/Bridge/BC loan Documentation from 18.11.2022 from to till date StaffWIse.

select B.BranchName,LEFT(clp.ClientLoanID,5) as BranchId,clp.actualdisbursementdate,
count(case when p.type like'%own%' and Loan_Category not in('5','7')  then 1 end) as 'NoOfOwnIGL',
ISNULL(Sum(case when p.type like'%own%' and Loan_Category not in('5','7')  then Loanamountdisbursed end),0) as 'OwnAmt',
count(case when p.type like'%BC ICICI%' and Loan_Category not in('5','7')  then 1 end) as 'NoOfBCICICI',
ISNULL(Sum(case when p.type like'%BC ICICI%' and Loan_Category not in('5','7')  then Loanamountdisbursed end),0) as 'BCICICIAmt',
count(case when p.type like'%BC IDBI%' and Loan_Category not in('5','7')  then 1 end) as 'NoOfBCIDBI',
ISNULL(Sum(case when p.type like'%BC IDBI%' and Loan_Category not in('5','7')  then Loanamountdisbursed end),0) as 'BCIDBIAmt',
count(case when p.type like'%BC SIDBI%' and Loan_Category not in('5','7')  then 1 end) as 'NoOfBCSIDBI',
ISNULL(Sum(case when p.type like'%BC SIDBI%' and Loan_Category not in('5','7')  then Loanamountdisbursed end),0) as 'BCSIDBIAmt',
count(case when Loan_Category in('5') then 1 end) as 'NoOfFLEXI',
ISNULL(Sum(case when Loan_Category in('5') then Loanamountdisbursed end),0) as 'FlexiAmt',
count(case when Loan_Category in('7') then 1 end) as 'NoOfBridge',
ISNULL(Sum(case when Loan_Category in('7')  then Loanamountdisbursed end),0) as 'BridgeAmt',
Count(Loanproposalid) as TotalDis,sum(Loanamountdisbursed) TotalAmount
from ClientLoansubscription as clp inner join products p on Substring(clp.clientloanId,16,2)=p.productid
inner join Branches b on LEFT(clp.ClientLoanID,5)=b.BranchID
where clp.actualdisbursementdate between '2024-06-07' and '2024-06-13' and clientloanid like'24%' and actualpaidupdate is null
group by LEFT(clp.ClientloanID,5),B.BranchName,clp.actualdisbursementdate
order by LEFT(clp.ClientloanID,5),clp.actualdisbursementdate
--Select * From ClientLoanSubscription as cls With (NoLock) 
--inner join ClientloanProposal as clp on clp.LoanProposalID=cls.LoanProposalID
--inner Join branches as b on b. BranchID=LEFT(cls.LoanProposalID,5)

--Where cls.ActualDisbursementDate between '2022-11-18' and '2022-12-06' and cls.actualpaidupdate is null

--Select * From Branches
--Select * From ClientLoanSubscription
--Select * From ClientloanProposal