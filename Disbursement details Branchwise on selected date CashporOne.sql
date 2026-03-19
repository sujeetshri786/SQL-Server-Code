----Disbursement details Branchwise on selected date CashporOne 

select B.BranchName,LEFT(clp.ClientLoanID,5) as BranchId,
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
where clp.disbursementdate  between '2025-03-20' and '2025-04-05'  and clientloanid like'28%' and actualpaidupdate is null
group by LEFT(clp.ClientloanID,5),B.BranchName
order by LEFT(clp.ClientloanID,5)



------------------Own Disbursemenet
--Select left(ClientLoanID,5) as BranchID,b.BranchName,count(cls.ClientLoanID) as NoOfDisB,Sum(cls.LoanAmountDisbursed) As DisburseAmount 
--from clientloansubscription As cls With (Nolock) 
--inner join branches as b on b.branchid=left(ClientLoanID,5)
--inner join products as p on p.ProductID = SUBSTRING(ClientLoanID,16,2)
--where cls.DisbursementDate = '2023-12-18' and cls.RegionID = '14' and p.type like '%%Own%%'
--Group by Left(ClientLoanID,5),b.BranchName
--order by Left(ClientLoanID,5)

-----------------Sidbi Disbursemenet
--Select left(ClientLoanID,5) as BranchID,b.BranchName,count(cls.ClientLoanID) as NoOfDisB,Sum(cls.LoanAmountDisbursed) As DisburseAmount 
--from clientloansubscription As cls With (Nolock) 
--inner join branches as b on b.branchid=left(ClientLoanID,5)
--inner join products as p on p.ProductID = SUBSTRING(ClientLoanID,16,2)
--where cls.DisbursementDate = '2023-12-18' and cls.RegionID = '14' and p.type like '%%Sidbi%%'
--Group by Left(ClientLoanID,5),b.BranchName
--order by Left(ClientLoanID,5)


-----------------IDBI Disbursemenet
--Select left(ClientLoanID,5) as BranchID,b.BranchName,count(cls.ClientLoanID) as NoOfDisB,Sum(cls.LoanAmountDisbursed) As DisburseAmount 
--from clientloansubscription As cls With (Nolock) 
--inner join branches as b on b.branchid=left(ClientLoanID,5)
--inner join products as p on p.ProductID = SUBSTRING(ClientLoanID,16,2)
--where cls.DisbursementDate = '2023-12-18' and cls.RegionID = '14' and p.type = 'BC IDBI'
--Group by Left(ClientLoanID,5),b.BranchName
--order by Left(ClientLoanID,5)


---------------ICICI Disbursemenet
--Select left(ClientLoanID,5) as BranchID,b.BranchName,count(cls.ClientLoanID) as NoOfDisB,Sum(cls.LoanAmountDisbursed) As DisburseAmount 
--from clientloansubscription As cls With (Nolock) 
--inner join branches as b on b.branchid=left(ClientLoanID,5)
--inner join products as p on p.ProductID = SUBSTRING(ClientLoanID,16,2)
--where cls.DisbursementDate = '2023-12-18' and cls.RegionID = '14' and p.type like '%%ICICI%%'
--Group by Left(ClientLoanID,5),b.BranchName
--order by Left(ClientLoanID,5)

