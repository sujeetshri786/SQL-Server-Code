------Total_ALC	Total_Portfolio	TotalRisk_Outstanding  PROGRESS


----------LOCAL  DB

SELECT   b.DistrictName,
B.BRANCHID,B.BRANCHNAME,
sum( NumLoanClients) Total_ALC ,sum(cast(TotalOutstanding as numeric))Total_Portfolio,
SUM(Outstanding5PlusInstallmentInArrears+OutstandingDefaultersInstallmentInArrears ) TotalRisk_Outstanding                                       
FROM         backdateRptBranches R (nolock)     inner join Branches b (nolock) on r.BranchID=b.BranchID                                  
WHERE     cast(r.ReportingDate as date)='2025-12-23'
and b.DissolvedDate is null and B.regionid in  ('14')                         
GROUP BY    B.BRANCHID,B.BRANCHNAME, b.DistrictName                            
ORDER BY       b.DistrictName ,  B.BRANCHID   



--Select  * from  backdateRptBranches with (NoLock) Where ReportingDate >= '2025-12-01' and branchId like '14%'
