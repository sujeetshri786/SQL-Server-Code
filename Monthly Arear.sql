
---Monthly Arrears----(Local)
Select b.zone, MANA.BranchID,MANA.BranchName,MANA.ClientLoanID,MANA.TransactionDate,MANA.TargetName,MANA.PrincipalInstallmentAmt,MANA.PrincipalCollected,       
MANA.InterestInstallmentAmt,MANA.InterestCollected,MANA.PrincipalInArrears,MANA.InterestInArrears,       
Case When CLS.DeathPerson=0 Then 'Actual Arrear' When CLS.DeathPerson=1 Then 'Client Death' When CLS.DeathPerson=2 Then 'Husband Death' End as Reason,  
NULL as Remark,SUBSTRING(MANA.ClientLoanID,16,2) as ProductID,Cls.DeathEntryDate,cls.NumInstallmentsInArrears     
from ClientLoanSubscription as CLS inner join MasterActivity..NewArrears as MANA ON CLS.LoanProposalID=MANA.LoanProposalID    
inner join branches b on left(cls.clientloanid,5)=b.branchid 
and CLS.ActualPaidUpDate is null and MANA.TransactionDate between '2025-08-01' and '2025-08-31' and cls.NumInstallmentsInArrears between  '1' and '4'  and cls.RegionID in('21')
order by MANA.BranchID,MANA.ClientLoanID  

---Monthly Risk----  (Local)
       
Select b.zone, MANA.BranchID,MANA.BranchName,MANA.ClientLoanID,MANA.TransactionDate,MANA.TargetName,MANA.PrincipalInstallmentAmt,MANA.PrincipalCollected,       
MANA.InterestInstallmentAmt,MANA.InterestCollected,MANA.PrincipalInArrears,MANA.InterestInArrears,       
Case When CLS.DeathPerson=0 Then 'Actual Arrear' When CLS.DeathPerson=1 Then 'Client Death' When CLS.DeathPerson=2 Then 'Husband Death' End as Reason,  
NULL as Remark,SUBSTRING(MANA.ClientLoanID,16,2) as ProductID,Cls.DeathEntryDate,cls.NumInstallmentsInArrears     
from ClientLoanSubscription as CLS inner join MasterActivity..NewRisk as MANA ON CLS.LoanProposalID=MANA.LoanProposalID    
  inner join branches b on left(cls.clientloanid,5)=b.branchid 
and CLS.ActualPaidUpDate is null and MANA.TransactionDate between '2025-08-01' and '2025-08-31' and cls.NumInstallmentsInArrears>4 and (cls.CurrentInstallmentPeriod < cls.LoanDurationInWeeks) and cls.RegionID in('21')
order by MANA.BranchID,MANA.ClientLoanID  
       
----Defaulter== (Not Date Change) (Local)
       
SELECT   branches.zone,  Branches.districtname , Branches.BranchID, Branches.BranchName, Clients.ClientID, Targets.TargetName, Targets.HusbandName, ClientLoanSubscription.ClientLoanID, 
                      ClientLoanSubscription.DisbursementDate, ClientLoanSubscription.ActualPaidUpDate, ClientLoanSubscription.LoanAmountDisbursed,      
                      ClientLoanSubscription.PrincipalOutstanding, ClientLoanSubscription.PrincipalInArrears, ClientLoanSubscription.InterestOutstanding,    
                      ClientLoanSubscription.InterestInArrears, ClientLoanSubscription.NumInstallmentsInArrears, ClientLoanSubscription.CurrentInstallmentPeriod,        
                      ClientLoanSubscription.DeathDate 
FROM         Centers INNER JOIN    
                      Branches ON Centers.BranchID = Branches.BranchID INNER JOIN  
                      Groups ON Centers.CenterID = Groups.CenterID INNER JOIN      
                      Clients ON Groups.GroupID = Clients.GroupID INNER JOIN 
                      Targets ON Clients.TargetID = Targets.TargetID INNER JOIN    
                      ClientLoanProposal ON Clients.ClientID = ClientLoanProposal.ClientID INNER JOIN       
                      ClientLoanSubscription ON ClientLoanProposal.LoanProposalID = ClientLoanSubscription.LoanProposalID    
WHERE     (ClientLoanSubscription.ActualPaidUpDate IS NULL) AND (ClientLoanSubscription.PrincipalOutstanding > 0) AND 
                      (ClientLoanSubscription.CurrentInstallmentPeriod > ClientLoanSubscription.LoanDurationInWeeks)  and  expectedpaidupdate between '2025-08-01' and '2025-08-31'  and ClientLoanSubscription.NumInstallmentsInArrears>0 and ClientLoanSubscription.RegionID in('21')
       

