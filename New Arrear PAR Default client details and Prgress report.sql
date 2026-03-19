    
	                                
---Monthly Arrears----

Select distinct b.zone,b.Districtname, MANA.BranchID,MANA.BranchName,MANA.ClientLoanID,MANA.TransactionDate,MANA.TargetName,MANA.PrincipalInstallmentAmt,MANA.PrincipalCollected,
MANA.InterestInstallmentAmt,MANA.InterestCollected,MANA.PrincipalInArrears,MANA.InterestInArrears,
Case When CLS.DeathPerson=0 Then 'Actual Arrear' When CLS.DeathPerson=1 Then 'Client Death' When CLS.DeathPerson=2 Then 'Husband Death' End as Reason,
NULL as Remark,SUBSTRING(MANA.ClientLoanID,16,2) as ProductID,Cls.DeathEntryDate,cls.NumInstallmentsInArrears
from ClientLoanSubscription as CLS  (nolock)  inner join MasterActivity..NewArrears (nolock)  as MANA ON CLS.LoanProposalID=MANA.LoanProposalID
inner join branches (nolock)  b on left(cls.clientloanid,5)=b.branchid
and CLS.ActualPaidUpDate is null and MANA.TransactionDate between '2025-04-01' and '2026-01-17' and cls.NumInstallmentsInArrears>0 and cls.RegionID in('14')
order by MANA.BranchID,MANA.ClientLoanID

-----Monthly Risk----

Select distinct b.zone,b.Districtname, MANA.BranchID,MANA.BranchName,MANA.ClientLoanID,MANA.TransactionDate,MANA.TargetName,MANA.PrincipalInstallmentAmt,MANA.PrincipalCollected,
MANA.InterestInstallmentAmt,MANA.InterestCollected,MANA.PrincipalInArrears,MANA.InterestInArrears,
Case When CLS.DeathPerson=0 Then 'Actual Arrear' When CLS.DeathPerson=1 Then 'Client Death' When CLS.DeathPerson=2 Then 'Husband Death' End as Reason,
NULL as Remark,SUBSTRING(MANA.ClientLoanID,16,2) as ProductID,Cls.DeathEntryDate,cls.NumInstallmentsInArrears
from ClientLoanSubscription (nolock) as CLS inner join MasterActivity..NewRisk (nolock)  as MANA ON CLS.LoanProposalID=MANA.LoanProposalID
  inner join branches b (nolock)  on left(cls.clientloanid,5)=b.branchid
and CLS.ActualPaidUpDate is null and MANA.TransactionDate between  '2025-04-01' and '2026-01-17' and cls.NumInstallmentsInArrears>0 and cls.RegionID in('14')
order by MANA.BranchID,MANA.ClientLoanID

-----New Defaulter-----

select  B.Zone,DistrictName,B.BranchID,B.BranchName,Cls.ClientLoanID,L.WeeklyTransactionDate,
L.PrincipalInstallmentAmt,l.PrincipalCollected,L.InterestInstallmentAmt,L.InterestCollected,L.PrincipalInArrears,L.InterestInArrears,
cls.Principaloutstanding,Currentinstallmentperiod,LoanDurationInWeeks

from clientloansubscription Cls  (nolock)  inner join clientloanproposal clp (nolock) on clp.loanproposalid=cls.loanproposalid
inner join Loanledger l (Nolock) on l.clientloanid=cls.Clientloanid
inner join Branches b (nolock) on b.Branchid=cls.Branchid
where Actualpaidupdate is null and lastTransactiondate between  '2025-04-01' and '2026-01-17' and L.WeeklyTransactionDate between '2025-04-01' and '2026-01-17' 
and Currentinstallmentperiod-LoanDurationInWeeks=1 
and cls.RegionID in('05','14','16')
order by B.Zone,DistrictName,B.BranchID


-----Prgress Report----

select LEFT(p.Branchid,2),sum(NumLoanClients) as ALC,sum(cast(TotalOutstanding as numeric)) as TotalOutstanding,                                             
sum(NumClients1InstallmentInArrears+NumClients2InstallmentInArrears+NumClients3InstallmentInArrears+NumClients4InstallmentInArrears) as ArearClients ,
sum(AmountInArrears1InstallmentBehind+AmountInArrears2InstallmentBehind+AmountInArrears3InstallmentBehind+AmountInArrears4InstallmentBehind) as ArearAmt,                                    
sum(NumClients5PlusInstallmentInArrears) as RiskClient,sum(AmountInArrears5PlusInstallmentBehind) as RiskAMT,                                        
sum(NumClientsDefaultersInstallmentInArrears) as DefaaultClient,sum(OutstandingDefaultersInstallmentInArrears) as DefaaultAMT                                  
              
from  backdateRptBranches p with(nolock)                                          
 where  Reportingdate='2025-07-31' and LEFT(p.Branchid,2)IN('10')                                           
group by LEFT(p.Branchid,2)                                               
order by LEFT(p.Branchid,2)       
