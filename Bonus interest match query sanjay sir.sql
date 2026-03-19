----------------------BranchWise PrincipalOutstanding----------------
Select BranchID,Sum(PrincipalOutStanding) as PrincipalOutStanding from ClientLoanSubscription With (NoLock) Where RegionID = '10' and ActualPaidUpDate is NULL
Group by BranchID
order by BranchID

----------------------StassWise PrincipalOutstanding----------------

Select BranchID,EntryBY,Sum(PrincipalOutStanding) as PrincipalOutStanding from ClientLoanSubscription With (NoLock) Where BranchID = '10:01' and ActualPaidUpDate is NULL 
Group by BranchID,EntryBY
order by BranchID

------BRANCH WISE
Select LEFT(Clientloanid,5) as BranchID,SUM(InterestCollected)  as InterestCollected from LoanLedger With (Nolock) 
where WeeklyTransactionDate between '2026-02-01' and '2026-02-28' and RegionID = '14'
Group by LEFT(Clientloanid,5)
Order by LEFT(Clientloanid,5)

---- STAFF WISE(JIS BRANCH PE DATA MISSMATCH HUA H)
Select LEFT(Clientloanid,5) as BranchID,StaffID,SUM(InterestCollected)  as InterestCollected from LoanLedger With (Nolock) 
where WeeklyTransactionDate between '2026-02-01' and '2026-02-28'
And LEFT(Clientloanid,5)='14:01'
Group by LEFT(Clientloanid,5),StaffID
Order by StaffID,LEFT(Clientloanid,5)

--------For Principal Outstanding Match StaffWise
Select BranchID,CenetrstaffID,Sum(PrincipalOutstanding) as PrincipalOutstanding from FinancialData..BOOKDEPT Where BranchID like '10%'  and MonthDate = '2025-04-30'
Group by CenetrstaffID,BranchID
order by BranchID,CenetrstaffID

--------For Principal Outstanding Match BranchWise
Select BranchID,Sum(PrincipalOutstanding) as PrincipalOutstanding from FinancialData..BOOKDEPT Where BranchID like '10%'  and MonthDate = '2025-04-30'
Group by BranchID
order by BranchID

/*
select * from fieldstaff where staffid = '16935'

Select LEFT(Clientloanid,5) as BranchID,StaffID,SUM(InterestCollected)  as InterestCollected from LoanLedger With (Nolock) where WeeklyTransactionDate between '2022-11-01' and '2022-10-30'
Group by LEFT(Clientloanid,5),StaffID
Order by LEFT(Clientloanid,5)
*/

select Cenetrstaffid,count(Distinct CenterID) centers,sum(PrincipalOutstanding) Out,count(distinct left(ClientLoanID,14)) ALC from financialdata..bookdept b with(nolock)
where b.BranchID like'36%' and cast(monthdate as date)='2024-03-31'
group by Cenetrstaffid
order by Cenetrstaffid


Select BranchID,StaffName,StaffID,Designation From FieldStaff With (NoLock) where Designation in ('31') And exitdate is null And BranchID like '28%' 
Select BranchID,StaffName,StaffID,Designation From FieldStaff With (NoLock) where StaffName = 'DUMMY' And exitdate is null And BranchID like '05%' 



