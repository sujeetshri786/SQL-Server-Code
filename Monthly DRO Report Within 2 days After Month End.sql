-- Local Consolidate
----------------------ARO Wise Consolidate Report-----------------
SELECT   AMID, AM_NM, BranchID, BranchName, SUM(NumConfirmedCSR + NumProbationaryCSR + NumTraineeCSR) AS #Staff, NumCenters, NumLoanClients, TotalOutstanding, 
                      SUM(NumClients1InstallmentInArrears + NumClients2InstallmentInArrears + NumClients3InstallmentInArrears + NumClients4InstallmentInArrears) AS noclientInArrear, 
                      SUM(AmountInArrears1InstallmentBehind + AmountInArrears2InstallmentBehind + AmountInArrears3InstallmentBehind + AmountInArrears4InstallmentBehind) AS amtInArrear, 
                      NumClients5PlusInstallmentInArrears, AmountInArrears5PlusInstallmentBehind, NumClientsDefaultersInstallmentInArrears, OutstandingDefaultersInstallmentInArrears, 
                      NoofMembers - NumLoanClients AS #withoutloan
FROM        consolidate..PermanentStorage
WHERE     (DateofReport = CONVERT(DATETIME, '2022-01-13', 102))
GROUP BY BranchID, BranchName, DistrictName, NumConfirmedCSR, NumCenters, NumLoanClients, TotalOutstanding, NumClients1InstallmentInArrears, 
                      Outstanding1InstallmentInArrears, NumClients5PlusInstallmentInArrears, AmountInArrears5PlusInstallmentBehind, NumClientsDefaultersInstallmentInArrears, 
                      OutstandingDefaultersInstallmentInArrears, NoofMembers, AMID, AM_NM
HAVING      (BranchID LIKE N'21%')
ORDER BY AMID


----------------------CH Wise Consolidate Report-----------------

SELECT   CHID, CHName, BranchID, BranchName, SUM(NumConfirmedCSR + NumProbationaryCSR + NumTraineeCSR) AS #Staff, NumCenters, NumLoanClients, TotalOutstanding, 
                      SUM(NumClients1InstallmentInArrears + NumClients2InstallmentInArrears + NumClients3InstallmentInArrears + NumClients4InstallmentInArrears) AS noclientInArrear, 
                      SUM(AmountInArrears1InstallmentBehind + AmountInArrears2InstallmentBehind + AmountInArrears3InstallmentBehind + AmountInArrears4InstallmentBehind) AS amtInArrear, 
                      NumClients5PlusInstallmentInArrears, AmountInArrears5PlusInstallmentBehind, NumClientsDefaultersInstallmentInArrears, OutstandingDefaultersInstallmentInArrears, 
                      NoofMembers - NumLoanClients AS #withoutloan
FROM        consolidate..PermanentStorage
WHERE     (DateofReport = CONVERT(DATETIME, '2022-01-13', 102))
GROUP BY BranchID, BranchName, DistrictName, NumConfirmedCSR, NumCenters, NumLoanClients, TotalOutstanding, NumClients1InstallmentInArrears, 
                      Outstanding1InstallmentInArrears, NumClients5PlusInstallmentInArrears, AmountInArrears5PlusInstallmentBehind, NumClientsDefaultersInstallmentInArrears, 
                      OutstandingDefaultersInstallmentInArrears, NoofMembers, CHID, CHName
HAVING      (BranchID LIKE N'21%')
ORDER BY chid



--Local
------Arrear ===

SELECT Branches.zone ,   Branches.districtname ,Branches.BranchID, Branches.BranchName, Clients.ClientID, Targets.TargetName, Targets.HusbandName, ClientLoanSubscription.ClientLoanID, 
                      ClientLoanSubscription.DisbursementDate, ClientLoanSubscription.ActualPaidUpDate, ClientLoanSubscription.LoanAmountDisbursed, 
                      ClientLoanSubscription.PrincipalOutstanding, ClientLoanSubscription.PrincipalInArrears, ClientLoanSubscription.InterestOutstanding, 
                      ClientLoanSubscription.InterestInArrears, ClientLoanSubscription.NumInstallmentsInArrears, ClientLoanSubscription.DeathDate
FROM         Centers INNER JOIN
                      Branches ON Centers.BranchID = Branches.BranchID INNER JOIN
                      Groups ON Centers.CenterID = Groups.CenterID INNER JOIN
                      Clients ON Groups.GroupID = Clients.GroupID INNER JOIN
                      Targets ON Clients.TargetID = Targets.TargetID INNER JOIN
                      ClientLoanProposal ON Clients.ClientID = ClientLoanProposal.ClientID INNER JOIN
                      ClientLoanSubscription ON ClientLoanProposal.LoanProposalID = ClientLoanSubscription.LoanProposalID
WHERE     (ClientLoanSubscription.ActualPaidUpDate IS NULL) AND (ClientLoanSubscription.PrincipalOutstanding > 0) AND 
                      (ClientLoanSubscription.NumInstallmentsInArrears > 0) AND (ClientLoanSubscription.NumInstallmentsInArrears < 5) AND 
                      (ClientLoanSubscription.CurrentInstallmentPeriod < ClientLoanSubscription.LoanDurationInWeeks)  

--- par---
SELECT  Branches.zone ,   Branches.districtname ,  Branches.BranchID, Branches.BranchName, Clients.ClientID, Targets.TargetName, Targets.HusbandName, ClientLoanSubscription.ClientLoanID, 
                      ClientLoanSubscription.DisbursementDate, ClientLoanSubscription.ActualPaidUpDate, ClientLoanSubscription.LoanAmountDisbursed, 
                      ClientLoanSubscription.PrincipalOutstanding, ClientLoanSubscription.PrincipalInArrears, ClientLoanSubscription.InterestOutstanding, 
                      ClientLoanSubscription.InterestInArrears, ClientLoanSubscription.NumInstallmentsInArrears, ClientLoanSubscription.DeathDate
FROM         Centers INNER JOIN
                      Branches ON Centers.BranchID = Branches.BranchID INNER JOIN
                      Groups ON Centers.CenterID = Groups.CenterID INNER JOIN
                      Clients ON Groups.GroupID = Clients.GroupID INNER JOIN
                      Targets ON Clients.TargetID = Targets.TargetID INNER JOIN
                      ClientLoanProposal ON Clients.ClientID = ClientLoanProposal.ClientID INNER JOIN
                      ClientLoanSubscription ON ClientLoanProposal.LoanProposalID = ClientLoanSubscription.LoanProposalID
WHERE     (ClientLoanSubscription.ActualPaidUpDate IS NULL) AND (ClientLoanSubscription.PrincipalOutstanding > 0) AND 
                      (ClientLoanSubscription.NumInstallmentsInArrears >= 5) AND (ClientLoanSubscription.CurrentInstallmentPeriod < ClientLoanSubscription.LoanDurationInWeeks)   
-----Defaulter-----                
                      
SELECT  Branches.zone ,Branches.districtname , Branches.BranchID, Branches.BranchName, Clients.ClientID, Targets.TargetName, Targets.HusbandName, ClientLoanSubscription.ClientLoanID, 
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
                      (ClientLoanSubscription.CurrentInstallmentPeriod > ClientLoanSubscription.LoanDurationInWeeks)
                                    order by  Branches.BranchID
