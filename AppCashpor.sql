Select * From ClientAdhar With (NoLock) Where Adharid = '993289427501'
Select * From ClientAdhar With (NoLock) Where ClientID Like '10:09:y8:01:25%'
Select * From Clients With (NoLock) Where ClientID Like '22:18:47:01:41%'
Select * From ClientLoanProposal With (NoLock) Where ClientID Like '22:07:64:01:13%'--'22:07:64:01:38'

Select MFI,Name,ACCOUNT_STATUS,ACCOUNT_NUMBER,TOTAL_AMOUNT_DISBURSED,CURRENT_BALANCE,
* From HMINQ_LOAN_DETAILS With (NoLock) Where TRACKING_ID = '54483033'

Select ClientLoan2InstallmentNumber,ClientLoan1TotalCollected,* From CDS2 With (NoLock) Where ClientID Like '22:07:07:01:35%'
Select * From Branch_Report With (NoLock) Where Branchid Like '10%' and send = '0' order by Branchid


Select *  from Centers Where CenterID = '22:07:64'
