--use consolidate
---------------------------------
select left(BranchID,2) as DID, (sum(NumLoansNonIGL) + sum(NumLoansNonIGL_BC)) as NLO, (sum(AmtOutsNonIGL) + sum(AmtOutsNonIGL_BC)) as TOuts 
from RptBranchesFLPurposes With(NoLock) group by left(BranchID,2) order by left(BranchID,2) 

select left(BranchID,2) as DID, sum(NumLoansOutstanding) as NLO, sum(TotalOutstanding) as TOuts from RptBranchesFLNonIGL With(NoLock) 
group by left(BranchID,2) order by left(BranchID,2)
---------------------------------
select LEFT(branchid,5) as BID, (sum(LoanInArrIGL)+sum(LoanInArrNonIGL)+sum(LoanInArrIGL_BC)+sum(LoanInArrNonIGL_BC)) as LoanInArr, 
(sum(OutsInArrIGL)+sum(OutsInArrNonIGL)+sum(OutsInArrIGL_BC)+sum(OutsInArrNonIGL_BC)) as OutsInArr from RptBranchesFLPurposes With(NoLock)
group by LEFT(branchid,5) order by LEFT(branchid,5) 

select LEFT(branchid,5) as BID, (SUM(NumLoans1InstallmentInArrears)+SUM(NumLoans2InstallmentInArrears)+SUM(NumLoans3InstallmentInArrears)+SUM(NumLoans4InstallmentInArrears)+
SUM(NumLoans5PlusInstallmentInArrears)) as NumLoansInstallmentInArrears,
(SUM(Outstanding1InstallmentInArrears)+SUM(Outstanding2InstallmentInArrears)+SUM(Outstanding3InstallmentInArrears)+SUM(Outstanding4InstallmentInArrears)+
SUM(Outstanding5PlusInstallmentInArrears)) as OutstandingInstallmentInArrears  
from RptBranchesFL With(NoLock) group by LEFT(branchid,5) order by LEFT(branchid,5) 
---------------------------------
delete RP from RptBranchesBC_Other RP With(NoLock) 

insert into RptBranchesBC_Other 
select branchid, NumLoanClients, TotalOutstanding from rptbranchesicici With(NoLock) where (NumLoanClients>0 or TotalOutstanding>0) order by branchid
insert into RptBranchesBC_Other 
select branchid, NumLoanClients, TotalOutstanding from rptbrancheskotak With(NoLock) where (NumLoanClients>0 or TotalOutstanding>0) order by branchid
insert into RptBranchesBC_Other 
select branchid, NumLoanClients, TotalOutstanding from rptbranchesIDBI With(NoLock) where (NumLoanClients>0 or TotalOutstanding>0) order by branchid
insert into RptBranchesBC_Other 
select branchid, NumLoanClients, TotalOutstanding from RptBranchesIndusInd With(NoLock) where (NumLoanClients>0 or TotalOutstanding>0) order by branchid
insert into RptBranchesBC_Other 
select branchid, NumLoanClients, TotalOutstanding from RptBranchesSIDBI With(NoLock) where (NumLoanClients>0 or TotalOutstanding>0) order by branchid

select branchid, TotalOutstanding from RptBranchesBC With(NoLock) where (NumLoanClients>0 or TotalOutstanding>0) order by branchid
select branchid, Sum(TotalOutstanding) as Touts from RptBranchesBC_Other With(NoLock) where (NumLoanClients>0 or TotalOutstanding>0) group by branchid order by branchid 
---------------------------------
SELECT BranchID, 
(NumLoans1InstallmentInArrears+NumLoans2InstallmentInArrears+NumLoans3InstallmentInArrears+NumLoans4InstallmentInArrears+
NumLoans5PlusInstallmentInArrears) as NumLoanArr, 
(Outstanding1InstallmentInArrears+Outstanding2InstallmentInArrears+Outstanding3InstallmentInArrears+Outstanding4InstallmentInArrears+
Outstanding5PlusInstallmentInArrears) as OutsArr, 
(AmountInArrears1InstallmentBehind+AmountInArrears2InstallmentBehind+AmountInArrears3InstallmentBehind+AmountInArrears4InstallmentBehind+ 
AmountInArrears5PlusInstallmentBehind) as AmtInArr 
FROM RptBranchesNonIGL with(nolock) ORDER BY BranchID

SELECT BranchID, (LoanInArrMobile+LoanInArrSaftey+LoanInArrEnergy+LoanInArrHealth) as LoanInArr, 
(OutsInArrMobile+OutsInArrSaftey+OutsInArrEnergy+OutsInArrHealth) as OutsInArr,   
(AmtInArrMobile+AmtInArrSaftey+AmtInArrEnergy+AmtInArrHealth) as AmtInArr  
FROM RptBranchesNonIGLProducts with(nolock) ORDER BY BranchID
---------------------------------

