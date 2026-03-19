---------------TL outstanding-------------

SELECT      LEFT(ClientLoanSubscription.ClientLoanID, 5) AS branchid, SUM(ClientLoanSubscription.PrincipalOutstanding) AS PrincipalOutstanding
FROM         ClientLoanSubscription with (nolock) INNER JOIN
                      ClientLoanProposal ON ClientLoanSubscription.LoanProposalID = ClientLoanProposal.LoanProposalID
                      inner join MasterActivity..Product a with (nolock) on ClientLoanProposal.ProductID=a.ProductID
WHERE     (ClientLoanSubscription.ActualPaidUpDate IS NULL) AND (ClientLoanSubscription.PrincipalOutstanding > 0)
AND a.Funding='Own' or a.ProductID in ('T1','T2','S2','S3','S4','W3','W4','W5','T6','T7','R7')
GROUP BY LEFT(ClientLoanSubscription.ClientLoanID, 5)
ORDER BY branchid

----------Collection report------------------------
Select LEFT(ClientLoanID, 5) as BranchID,B.BranchName, SUM(PrincipalCollected) Principal,SUM(InterestCollected) Interest from LoanLedger with(nolock) 
Inner Join Branches as B on B.BranchID=LEFT(ClientLoanID, 5)
inner join MasterActivity..Product with(nolock) on SUBSTRING(LoanLedger.ClientLoanID,16,2)=Product.ProductID
where WeeklyTransactionDate between '2024-02-01' and '2024-02-29'
and ( Funding='Own' or ProductID in ('T1','T2','S2','S3','S4','W3','W4','W5',)) and ClientLoanID like'05%'
Group by LEFT(ClientLoanID, 5),B.BranchName
Order by LEFT(ClientLoanID, 5)
--'T1','T2','S2','S3','S4','W3','W4','W5','1x','2x','3x','4x','k7','l8','n9','o0','o1','o2','o4','o7','p9','r0','r1','r2','r4','r9','x6','x7','x8','x9','7A','8A','Y2','T7','X0','X2','O3','R3','X1'

------------Product wise collection report---------
select ProductID,Funding,WeeklyTransactionDate, SUM(PrincipalCollected) P,SUM(InterestCollected) I from LoanLedger inner join 
MasterActivity..Product on SUBSTRING(LoanLedger.ClientLoanID,16,2)=Product.ProductID
where WeeklyTransactionDate between '2024-07-03' and '2024-07-03'
Group by WeeklyTransactionDate,ProductID,Funding
Order by WeeklyTransactionDate

-----------------------New------

select LEFT(ClientLoanID, 5),WeeklyTransactionDate, SUM(PrincipalCollected) P,SUM(InterestCollected) I from LoanLedger with(nolock) inner join 
MasterActivity..Product with(nolock) on SUBSTRING(LoanLedger.ClientLoanID,16,2)=Product.ProductID
where WeeklyTransactionDate between '2022-04-01' and '2022-09-13'
and ProductName like'%sbi%' and ClientLoanID like'14%'
Group by LEFT(ClientLoanID, 5),WeeklyTransactionDate
Order by LEFT(ClientLoanID, 5),WeeklyTransactionDate

select LEFT(ClientLoanID, 5),B.BranchName,WeeklyTransactionDate, SUM(PrincipalCollected) Principal,SUM(InterestCollected) Interest from LoanLedger with(nolock) 
Inner Join Branches as B on B.BranchID=LEFT(ClientLoanID, 5)
Inner join MasterActivity..Product with(nolock) on SUBSTRING(LoanLedger.ClientLoanID,16,2)=Product.ProductID
where WeeklyTransactionDate between '2024-02-01' and '2024-02-29'
and ( Funding='Own' or ProductID in ('T1','T2','S2','S3','S4','W3','W4','W5')) and ClientLoanID like'05%'
Group by LEFT(ClientLoanID, 5),WeeklyTransactionDate,B.BranchName
Order by LEFT(ClientLoanID, 5),WeeklyTransactionDate