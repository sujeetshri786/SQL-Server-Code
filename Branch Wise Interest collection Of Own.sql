--Branch Wise Interest collection of Own
select LEFT(ClientLoanID, 5) as BranchID, SUM(PrincipalCollected) P,SUM(InterestCollected) I from LoanLedger with(nolock) inner join 
MasterActivity..Product with(nolock) on SUBSTRING(LoanLedger.ClientLoanID,16,2)=Product.ProductID
where WeeklyTransactionDate between '2024-07-03' and '2024-07-03'
and ( Funding='Own' or ProductID in ('T1','T2','S2','S3','S4','W3','W4','W5','t6','T7','R7')) and ClientLoanID like'24%'
Group by LEFT(ClientLoanID, 5)
Order by LEFT(ClientLoanID, 5)
