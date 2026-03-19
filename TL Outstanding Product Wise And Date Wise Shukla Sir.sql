select LEFT(ClientLoanID,5) as Branchid,SUM(LoanAmountDisbursed) as Disbursement,disbursementdate as date 
from ClientLoanSubscription inner join Products  with(nolock) on SUBSTRING(ClientLoanSubscription.ClientLoanID,16,2)=Products.ProductID 
where clientloanid like '05%' and FundingasperAccount='own' and DisbursementDate between '2024-02-01' and '2024-02-29' 
Group by LEFT(ClientLoanID,5),disbursementdate
Order by LEFT(ClientLoanID,5),disbursementdate

---10%
select LEFT(ClientLoanID,5) as Branchid,SUM(LoanAmountDisbursed) as Disbursement,disbursementdate as date 
from ClientLoanSubscription inner join Products  with(nolock) on SUBSTRING(ClientLoanSubscription.ClientLoanID,16,2)=Products.ProductID 
where clientloanid like '05%' and FundingasperAccount='managed' and DisbursementDate between '2024-02-01' and '2024-02-29' 
and  products.ProductID in ('R7','R8','T6','T7','T8','T9','Y0','Y1','Y2','Y3','Y4','Y5','Y6'
,'Y7','Y8','Y9','Z0','Z1','Z2','Z3','Z4','0B','7A','9A','0A','1A','2A','3A','4A'
,'5A','6A','8A')
Group by LEFT(ClientLoanID,5),disbursementdate
Order by LEFT(ClientLoanID,5),disbursementdate


select LEFT(ClientLoanID,5) as Branchid,WeeklyTransactionDate as Date,SUM(PrincipalCollected) as Principal,SUM(InterestCollected) as Interest
from LoanLedger inner join Products  with(nolock) on SUBSTRING(LoanLedger.ClientLoanID,16,2)=Products.ProductID 
where clientloanid like '05%' and FundingasperAccount='own' and WeeklyTransactionDate between '2024-02-01' and '2024-02-29' 
Group by LEFT(ClientLoanID,5),WeeklyTransactionDate
Order by LEFT(ClientLoanID,5),WeeklyTransactionDate

select LEFT(ClientLoanID,5) as Branchid,SUM(PrincipalCollected) as Principal,SUM(InterestCollected) as Interest
from LoanLedger  inner join Products  with(nolock) on SUBSTRING(LoanLedger.ClientLoanID,16,2)=Products.ProductID 
where clientloanid like '05%' and FundingasperAccount='own' and WeeklyTransactionDate between '2024-02-01' and '2024-02-29' 
Group by LEFT(ClientLoanID,5)
Order by LEFT(ClientLoanID,5)


select LEFT(ClientLoanID,5) as Branchid,WeeklyTransactionDate as Date,SUM(PrincipalCollected) as Principal,SUM(InterestCollected) as Interest
from LoanLedger inner join Products  with(nolock) on SUBSTRING(LoanLedger.ClientLoanID,16,2)=Products.ProductID 
where clientloanid like '05%' and FundingasperAccount='managed' and WeeklyTransactionDate between '2024-02-01' and '2024-02-29' 
and  products.ProductID in ('R7','R8','T6','T7','T8','T9','Y0','Y1','Y2','Y3','Y4','Y5','Y6'
,'Y7','Y8','Y9','Z0','Z1','Z2','Z3','Z4','0B','7A','9A','0A','1A','2A','3A','4A'
,'5A','6A','8A')
Group by LEFT(ClientLoanID,5),WeeklyTransactionDate
Order by LEFT(ClientLoanID,5),WeeklyTransactionDate


select LEFT(ClientLoanID,5) as Branchid,SUM(PrincipalCollected) as Principal,SUM(InterestCollected) as Interest
from LoanLedger inner join Products  with(nolock) on SUBSTRING(LoanLedger.ClientLoanID,16,2)=Products.ProductID 
where clientloanid like '05%' and FundingasperAccount='managed' and WeeklyTransactionDate between '2024-02-01' and '2024-02-29' 
and  products.ProductID in ('R7','R8','T6','T7','T8','T9','Y0','Y1','Y2','Y3','Y4','Y5','Y6'
,'Y7','Y8','Y9','Z0','Z1','Z2','Z3','Z4','0B','7A','9A','0A','1A','2A','3A','4A'
,'5A','6A','8A')
Group by LEFT(ClientLoanID,5)
Order by LEFT(ClientLoanID,5)