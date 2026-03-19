SELECT      LEFT(b.ClientLoanID, 5) AS branchid, SUM(b.PrincipalOutstanding) AS PrincipalOutstanding
FROM         FinancialData..bookdept b with (nolock) INNER JOIN
                      ClientLoanProposal ON b.LoanProposalID = ClientLoanProposal.LoanProposalID
                      inner join MasterActivity..Product a with (nolock) on ClientLoanProposal.ProductID=a.ProductID
WHERE     (b.ActualPaidUpDate IS NULL) AND (b.PrincipalOutstanding > 0) and Cast(MonthDate as Date)='2022-03-31'
AND a.Funding='Own' or a.ProductID in ('T1','T2','S2','S3','S4','W3','W4','W5','T6','T7','R7')
GROUP BY LEFT(b.ClientLoanID, 5)
ORDER BY branchid
