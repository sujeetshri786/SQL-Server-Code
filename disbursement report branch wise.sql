Select left(clientLoanID,5) as branchID, disbursementDate, Sum(LoanAmountDisbursed) As Amount
from ClientLoanSubscription with (NoLock) where disbursementdate between '2022-07-16' and '2022-07-22' 
Group By DisbursementDate,left(clientLoanID,5)
order By disbursementDate

Select * from ClientLoanSubscription with (NoLock) where disbursementdate between '2022-07-16' and '2022-07-22' order by clientLoanID