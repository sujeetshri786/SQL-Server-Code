--ALC AND OUTSTANDING LOCAL BranchWIse
SELECT   Branches.BranchID,BranchName,centers.StaffID,StaffName,
count(distinct left(clientloanid,14))ALC,sum(PrincipalOutstanding) Outstanding,
count(distinct Centers.centerid) as No_of_Centers

from ClientLoanSubscription 
inner join Centers on centers.centerid=left(clientloanid,8)
inner join Branches on branches.BranchID=centers.BranchID
inner join FieldStaff on fieldstaff.StaffID=centers.StaffID
where ActualPaidUpDate is null  and clientloanid like '05%'
group by Branches.BranchID,BranchName,centers.StaffID,StaffName,fieldstaff.StaffID
order by Branches.BranchID,BranchName,centers.StaffID,StaffName



--------------------------------------------------------------------------------------------
SELECT   Branches.BranchID,BranchName,centers.StaffID,StaffName,
count(distinct left(clientloanid,14))ALC,sum(PrincipalOutstanding) Outstanding,
count(distinct ClientLoanSubscription.centerid) as No_of_Centers

from ClientLoanSubscription 
inner join Centers on centers.centerid=left(clientloanid,8)
inner join Branches on branches.BranchID=centers.BranchID
inner join FieldStaff on fieldstaff.StaffID=centers.StaffID
where ActualPaidUpDate is null  and clientloanid like '10%'
group by Branches.BranchID,BranchName,centers.StaffID,StaffName,fieldstaff.StaffID
order by Branches.BranchID,BranchName,centers.StaffID,StaffName


----------Branch Wise PrincipalOutstanding
Select b.BranchID,BranchName,Sum(Principaloutstanding) PrincipalOutstanding from ClientLoanSubscription cls With (NoLock) 
Inner Join Branches b on b.BranchID=cls.BranchID
Where ClientLoanID like '10%' and ActualPaidupdate is NULL
group by b.BranchId,BranchName
order by b.BranchId,BranchName


------Total PrincipalOutstanding
Select Sum(cast(Principaloutstanding as BIGINT)) PrincipalOutstanding from ClientLoanSubscription cls With (NoLock) 
Where ActualPaidupdate is NULL

--PrincipalOutstanding
--39377430412


--ALC AND OUTSTANDING LOCAL CenterWIse
--SELECT   Branches.BranchID,BranchName,Centers.CenterID,Centers.CenterName,centers.StaffID,StaffName,
--count(distinct left(clientloanid,14))ALC,sum(PrincipalOutstanding) Outstanding,
--count(distinct Centers.centerid) as No_of_Centers

--from ClientLoanSubscription 
--inner join Centers on centers.centerid=left(clientloanid,8)
--inner join Branches on branches.BranchID=centers.BranchID
--inner join FieldStaff on fieldstaff.StaffID=centers.StaffID
--where ActualPaidUpDate is null  and clientloanid like '05%'
--group by Branches.BranchID,BranchName,Centers.CenterID,Centers.CenterName,centers.StaffID,StaffName,fieldstaff.StaffID
--order by Branches.BranchID,BranchName,Centers.CenterID,Centers.CenterName,centers.StaffID,StaffName