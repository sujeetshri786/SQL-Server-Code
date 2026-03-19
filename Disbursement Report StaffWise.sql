---Disbursement Report StaffWise 

Select RegionName,BranchID,BranchName,A.StaffID,StaffName,DesignationName,B.ReportingDate LastWeekReportingDate,B.NumCentersManaged LastWeekNumCentersManaged,
      B.NumLoanClients LastWeekNumLoanClients,B.TotalOutstanding LastWeekTotalOutstanding,B.OverDueClient LastWeekOverDueClient,
         B.ClientAtRisk LastWeekClientAtRisk,B.OverDueOut LastWeekOverDueOut,B.RiskOut LastWeekRiskOut,C.ReportingDate,
         C.NumCentersManaged,C.NumLoanClients,C.TotalOutstanding,C.OverDueClient,C.ClientAtRisk,C.OverDueOut,C.RiskOut,
         C.NumCentersManaged-B.NumCentersManaged CenterMangProgess,C.NumLoanClients-B.NumLoanClients ALCProgress,C.TotalOutstanding-B.TotalOutstanding OutProgess,
         C.OverDueClient-B.OverDueClient OverDueClientProgress,C.ClientAtRisk-B.ClientAtRisk RiskClientProgress,C.OverDueOut-B.OverDueOut OverDueOutProgess,
         C.RiskOut-B.RiskOut RiskOutProgress

From(
       Select DistrictName RegionName,B.BranchID,BranchName,StaffID,StaffName,DesignationName From Branches B With(NoLock)
       Inner Join FieldStaff FS With(NoLock) On B.BranchID=FS.BranchID
       Inner Join DesignationMaster D With(NoLock) On D.DesignationID=Designation
       Where Designation In(12,13,14,15,46,47) And ExitDate Is Null and left(b.branchid,2) in ('28')
)A LEFT Join
(
       Select StaffID,ReportingDate,NumCentersManaged,NumLoanClients,TotalOutstanding,
NumClients1InstallmentInArrears+NumClients2InstallmentInArrears+NumClients3InstallmentInArrears+NumClients4InstallmentInArrears OverDueClient,
       NumClients5PlusInstallmentInArrears+NumClientsDefaultersInstallmentInArrears ClientAtRisk,
Outstanding1InstallmentInArrears+Outstanding2InstallmentInArrears+Outstanding3InstallmentInArrears+Outstanding4InstallmentInArrears OverDueOut,
       Outstanding5PlusInstallmentInArrears+OutstandingDefaultersInstallmentInArrears RiskOut
    From BackDateRptFieldStaff R With(NoLock) Where ReportingDate='2024-04-01'
)B On A.StaffID=B.StaffID LEFT Join
(
       Select StaffID,ReportingDate,NumCentersManaged,NumLoanClients,TotalOutstanding,
NumClients1InstallmentInArrears+NumClients2InstallmentInArrears+NumClients3InstallmentInArrears+NumClients4InstallmentInArrears OverDueClient,
       NumClients5PlusInstallmentInArrears+NumClientsDefaultersInstallmentInArrears ClientAtRisk,
Outstanding1InstallmentInArrears+Outstanding2InstallmentInArrears+Outstanding3InstallmentInArrears+Outstanding4InstallmentInArrears OverDueOut,
       Outstanding5PlusInstallmentInArrears+OutstandingDefaultersInstallmentInArrears RiskOut
    From backdateRptFieldStaff R With(NoLock) Where ReportingDate='2024-05-18'
)C On A.StaffID=C.StaffID

order by a.branchid, a.StaffID



