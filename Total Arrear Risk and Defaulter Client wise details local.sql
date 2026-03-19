----Local

-----------------------------   Total Arrear Risk and Defaulter Client wise details ------------------
----------------Arear

SELECT     Branches.BranchID, Branches.BranchName, ClientLoanSubscription.ClientLoanID, Targets.TargetName, 
              ClientLoanSubscription.DeathDate, 
              case when DeathPerson='1' then 'ClientDeath' when deathperson=2 then 'HusbandDeath' else 'NormalArrear'end as DeathPerson,
              ClientLoanSubscription.CurrentInstallmentPeriod,
              ClientLoanSubscription.NumInstallmentsInArrears,
                       ClientLoanSubscription.PrincipalOutstanding,clientloansubscription.interestoutstanding,
                       sum(loanledger.principalinarrears+loanledger.interestinarrears) as
                                      Arrear_Amount,ClientLoanProposal.productcategory,ClientLoanSubscription.DisbursementDate,
                                         fs.staffid,fs.staffname,
                                         Case When centers.ReportingDay=1 Then 'Monday'
       When centers.ReportingDay=2 Then 'Tuesday'
       When centers.ReportingDay=3 Then 'Wednesday'
       When centers.ReportingDay=4 Then 'Thursday'
       When centers.ReportingDay=5 Then 'Friday'
       When centers.ReportingDay=6 Then 'Saturday' End as MeetingDay
FROM         Centers INNER JOIN
                      Branches With (NoLock) ON Centers.BranchID = Branches.BranchID INNER JOIN
                      Groups With (NoLock) ON Centers.CenterID = Groups.CenterID INNER JOIN
                      Clients With (NoLock) ON Groups.GroupID = Clients.GroupID INNER JOIN
                      ClientLoanProposal With (NoLock) ON Clients.ClientID = ClientLoanProposal.ClientID INNER JOIN
                      ClientLoanSubscription INNER JOIN
                      LoanLedger With (NoLock) ON ClientLoanSubscription.ClientLoanID = LoanLedger.ClientLoanID  ON 
                      ClientLoanProposal.LoanProposalID = ClientLoanSubscription.LoanProposalID INNER JOIN
                      Targets ON Clients.TargetID = Targets.TargetID
                                    inner join fieldstaff as fs With (NoLock)  on fs.staffid=centers.staffid
WHERE     (ClientLoanSubscription.ActualPaidUpDate IS NULL) AND 
                      (ClientLoanSubscription.CurrentInstallmentPeriod <= ClientLoanSubscription.LoanDurationInWeeks) AND 
                      (ClientLoanSubscription.NumInstallmentsInArrears between 1 and 4)  and ClientLoanSubscription.clientloanid like '05%'
                      --and clientloansubscription.deathdate is null
GROUP BY    Branches.BranchID, Branches.BranchName, ClientLoanSubscription.ClientLoanID, Targets.TargetName, 
              ClientLoanSubscription.DeathDate, ClientLoanSubscription.CurrentInstallmentPeriod,
              ClientLoanSubscription.NumInstallmentsInArrears,
                       ClientLoanSubscription.PrincipalOutstanding,clientloansubscription.interestoutstanding,DeathPerson,
                                     ClientLoanProposal.productcategory,ClientLoanSubscription.DisbursementDate,fs.staffid,centers.reportingday,fs.staffname
ORDER BY Branches.BranchID

---------Risk/PAR Clients


SELECT     Branches.BranchID, Branches.BranchName, ClientLoanSubscription.ClientLoanID, Targets.TargetName, 
              ClientLoanSubscription.DeathDate, case when DeathPerson='1' then 'ClientDeath' when deathperson=2
              then 'HusbandDeath' else 'NormalRisk'end as DeathPerson,
              ClientLoanSubscription.CurrentInstallmentPeriod,ClientLoanSubscription.NumInstallmentsInArrears,
                       ClientLoanSubscription.PrincipalOutstanding,clientloansubscription.interestoutstanding,
                      clientloansubscription.interestinarrears,ClientLoanSubscription.DisbursementDate,fs.staffid,fs.staffname,
                                         Case When centers.ReportingDay=1 Then 'Monday'
       When centers.ReportingDay=2 Then 'Tuesday'
       When centers.ReportingDay=3 Then 'Wednesday'
       When centers.ReportingDay=4 Then 'Thursday'
       When centers.ReportingDay=5 Then 'Friday'
       When centers.ReportingDay=6 Then 'Saturday' End as MeetingDay
FROM         Centers INNER JOIN
                      Branches With (NoLock) ON Centers.BranchID = Branches.BranchID INNER JOIN
                      Groups With (NoLock) ON Centers.CenterID = Groups.CenterID INNER JOIN
                      Clients With (NoLock) ON Groups.GroupID = Clients.GroupID INNER JOIN
                      ClientLoanProposal With (NoLock) ON Clients.ClientID = ClientLoanProposal.ClientID INNER JOIN
                      ClientLoanSubscription INNER JOIN
                      LoanLedger With (NoLock) ON ClientLoanSubscription.ClientLoanID = LoanLedger.ClientLoanID  ON 
                      ClientLoanProposal.LoanProposalID = ClientLoanSubscription.LoanProposalID INNER JOIN
                      Targets ON Clients.TargetID = Targets.TargetID
                                    inner join fieldstaff as fs With (NoLock)  on fs.staffid=centers.staffid
WHERE     (ClientLoanSubscription.ActualPaidUpDate IS NULL) AND 
                      (ClientLoanSubscription.CurrentInstallmentPeriod <= ClientLoanSubscription.LoanDurationInWeeks) AND 
                      (ClientLoanSubscription.NumInstallmentsInArrears >4)  
                                    and ClientLoanSubscription.clientloanid like '14%' and ClientLoanSubscription.DisbursementDate >= '2024-04-01'
GROUP BY    Branches.BranchID, Branches.BranchName, ClientLoanSubscription.ClientLoanID, Targets.TargetName, 
              ClientLoanSubscription.DeathDate, ClientLoanSubscription.CurrentInstallmentPeriod,ClientLoanSubscription.NumInstallmentsInArrears,
                       ClientLoanSubscription.PrincipalOutstanding,clientloansubscription.interestoutstanding,DeathPerson,
                       clientloansubscription.interestinarrears,ClientLoanSubscription.DisbursementDate,fs.staffid,fs.staffname,centers.ReportingDay
ORDER BY Branches.BranchName
----------------------------------------------------RISK----------------------------------------------
SELECT     Branches.BranchID, Branches.BranchName, ClientLoanSubscription.ClientLoanID, Targets.TargetName, 
              ClientLoanSubscription.DeathDate, case when DeathPerson='1' then 'ClientDeath' when deathperson=2
              then 'HusbandDeath' else 'NormalRisk'end as DeathPerson,
              ClientLoanSubscription.CurrentInstallmentPeriod,ClientLoanSubscription.NumInstallmentsInArrears,
                       ClientLoanSubscription.PrincipalOutstanding,clientloansubscription.interestoutstanding,
                      clientloansubscription.interestinarrears,ClientLoanSubscription.DisbursementDate,fs.staffid,fs.staffname,
                                         Case When centers.ReportingDay=1 Then 'Monday'
       When centers.ReportingDay=2 Then 'Tuesday'
       When centers.ReportingDay=3 Then 'Wednesday'
       When centers.ReportingDay=4 Then 'Thursday'
       When centers.ReportingDay=5 Then 'Friday'
       When centers.ReportingDay=6 Then 'Saturday' End as MeetingDay
FROM         Centers INNER JOIN
                      Branches With (NoLock) ON Centers.BranchID = Branches.BranchID INNER JOIN
                      Groups With (NoLock) ON Centers.CenterID = Groups.CenterID INNER JOIN
                      Clients With (NoLock) ON Groups.GroupID = Clients.GroupID INNER JOIN
                      ClientLoanProposal With (NoLock) ON Clients.ClientID = ClientLoanProposal.ClientID INNER JOIN
                      ClientLoanSubscription INNER JOIN
                      LoanLedger With (NoLock) ON ClientLoanSubscription.ClientLoanID = LoanLedger.ClientLoanID  ON 
                      ClientLoanProposal.LoanProposalID = ClientLoanSubscription.LoanProposalID INNER JOIN
                      Targets ON Clients.TargetID = Targets.TargetID
                                    inner join fieldstaff as fs With (NoLock)  on fs.staffid=centers.staffid
WHERE     (ClientLoanSubscription.ActualPaidUpDate IS NULL) AND 
                      (ClientLoanSubscription.CurrentInstallmentPeriod <= ClientLoanSubscription.LoanDurationInWeeks) AND 
                      (ClientLoanSubscription.NumInstallmentsInArrears >4)  
                                    and ClientLoanSubscription.regionid like '05%'
GROUP BY    Branches.BranchID, Branches.BranchName, ClientLoanSubscription.ClientLoanID, Targets.TargetName, 
              ClientLoanSubscription.DeathDate, ClientLoanSubscription.CurrentInstallmentPeriod,ClientLoanSubscription.NumInstallmentsInArrears,
                       ClientLoanSubscription.PrincipalOutstanding,clientloansubscription.interestoutstanding,DeathPerson,
                       clientloansubscription.interestinarrears,ClientLoanSubscription.DisbursementDate,fs.staffid,fs.staffname,centers.ReportingDay
ORDER BY Branches.BranchName

--------Defaulter clients

SELECT     Branches.BranchID, Branches.BranchName, ClientLoanSubscription.ClientLoanID, Targets.TargetName, 
              ClientLoanSubscription.DeathDate, case when DeathPerson='1' then 'ClientDeath' when deathperson=2 then 'HusbandDeath' else 'NormalDefaulter'end as DeathPerson,
              ClientLoanSubscription.CurrentInstallmentPeriod,ClientLoanSubscription.NumInstallmentsInArrears,
                       ClientLoanSubscription.PrincipalOutstanding,clientloansubscription.interestoutstanding,
                       ClientLoanSubscription.interestinarrears,fs.staffid,fs.staffname,
                                         Case When centers.ReportingDay=1 Then 'Monday'
       When centers.ReportingDay=2 Then 'Tuesday'
       When centers.ReportingDay=3 Then 'Wednesday'
       When centers.ReportingDay=4 Then 'Thursday'
       When centers.ReportingDay=5 Then 'Friday'
       When centers.ReportingDay=6 Then 'Saturday' End as MeetingDay
FROM         Centers INNER JOIN
                      Branches With (NoLock) ON Centers.BranchID = Branches.BranchID INNER JOIN
                      Groups With (NoLock) ON Centers.CenterID = Groups.CenterID INNER JOIN
                      Clients With (NoLock) ON Groups.GroupID = Clients.GroupID INNER JOIN
                      ClientLoanProposal With (NoLock) ON Clients.ClientID = ClientLoanProposal.ClientID INNER JOIN
                      ClientLoanSubscription INNER JOIN
                      LoanLedger With (NoLock) ON ClientLoanSubscription.ClientLoanID = LoanLedger.ClientLoanID  ON 
                      ClientLoanProposal.LoanProposalID = ClientLoanSubscription.LoanProposalID INNER JOIN
                      Targets ON Clients.TargetID = Targets.TargetID
                                    inner join fieldstaff as fs with(nolock) on fs.staffid=centers.StaffID
WHERE     (ClientLoanSubscription.ActualPaidUpDate IS NULL) AND 
                      (ClientLoanSubscription.CurrentInstallmentPeriod > ClientLoanSubscription.LoanDurationInWeeks) AND 
                      (ClientLoanSubscription.PrincipalInArrears >0)  
                                    and ClientLoanSubscription.clientloanid like '05%' 
                       --and clientloansubscription.deathdate is null
GROUP BY    Branches.BranchID, Branches.BranchName, ClientLoanSubscription.ClientLoanID, Targets.TargetName, 
              ClientLoanSubscription.DeathDate, ClientLoanSubscription.CurrentInstallmentPeriod,ClientLoanSubscription.NumInstallmentsInArrears,
                       ClientLoanSubscription.PrincipalOutstanding,clientloansubscription.interestoutstanding,DeathPerson,
                       ClientLoanSubscription.interestinarrears,fs.staffid,fs.staffname,centers.ReportingDay
ORDER BY Branches.Branchid

