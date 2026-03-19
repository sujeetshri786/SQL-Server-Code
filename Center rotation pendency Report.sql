/*--Center rotation pendency Report ---> Appcashpor
select b.branchid,b.CenterID,b.CenterName,b.StaffID,f.StaffName,b.Leaderid from leader31032023 a inner join
Centers b on a.CenterID=b.CenterID inner join FieldStaff f on f.StaffID=b.StaffID where b.DissolvedDate is null and b.FormationDate<='2023-03-31'
and a.staffid=b.staffid
order by b.BranchID


-- center leader pendency
select b.branchid,b.CenterID,b.CenterName,b.StaffID,f.StaffName,b.Leaderid from leader31032023 a inner join
Centers b on a.CenterID=b.CenterID inner join FieldStaff f on f.StaffID=b.StaffID where b.DissolvedDate is null and b.FormationDate<='2022-03-31' And B.branchID = '21:12'
and a.Leaderid=b.Leaderid
order by b.BranchID--*/


-- center Rotation pendency
select branches.zone,branches.DistrictName,b.BranchID,branches.branchname,b.CenterID,
b.CenterName,b.StaffID,f.StaffName,b.Leaderid,b.FormationDate
from leader31032023  a inner join
Centers b on a.CenterID=b.CenterID inner join FieldStaff f on f.StaffID=b.StaffID 
 inner join branches  on branches.branchid=b.branchid 
where b.DissolvedDate is null and b.FormationDate<='2023-03-31' and left(branches.branchid,2) in('05')
and a.StaffID=b.StaffID
order by branches.districtname,b.BranchID

-- center leader pendency
select branches.zone,branches.DistrictName,b.BranchID,branches.branchname,b.CenterID,
b.CenterName,b.StaffID,f.StaffName,b.Leaderid,b.FormationDate
from leader31032023  a inner join
Centers b on a.CenterID=b.CenterID inner join FieldStaff f on f.StaffID=b.StaffID 
 inner join branches  on branches.branchid=b.branchid  where b.DissolvedDate is null and b.FormationDate<='2025-03-31'
and a.Leaderid=b.Leaderid and   left(branches.branchid,2) in('28')
order by branches.districtname,b.BranchID


-- center leader pendency Shukla sir 2025-07-01
SELECT     Branches.BranchID, Branches.BranchName, Centers.CenterID, Centers.CenterName,FieldStaff.StaffID,FieldStaff.StaffName, Centers.Leaderid,Centers.Leaderseldate
FROM         Centers INNER JOIN
                      Branches ON Centers.BranchID = Branches.BranchID inner join
                      fieldstaff on centers.StaffID=FieldStaff.StaffID
WHERE     Centers.DissolvedDate IS NULL
ORDER BY Centers.CenterID, Branches.BranchID


--select Leaderid,* from Centers where centerid like '14:04:C5%'
--select Leaderid,* from leader31032023 where centerid like '14:04:C5%'
--Select * from centers with (NoLock) Where Leaderseldate > '2023-03-31'
--Select * from centers with (NoLock) Where CenterId In ('14:12:DG')

----Center rotation pendency 2025-06-02
----Script regarding the pending of Center rotation according to circular no  1120 of all branches.
----Execute the script after the updating the field staff from TRAccount Tools application via Update StaffID In Centers From AppCashpor to Region DB option.


  select Distinct bb.Zone, BB.DistrictName, c.BranchID,BB.BranchName,c.CenterID,c.CenterName,f.staffid,StaffName   
              from  playground..Centers_31032025 c (nolock) 
              inner join Branches bb (nolock) on bb.BranchID=c.BranchID
              inner join centers cc (nolock) on cc.CenterID=c.centerid
                       inner join fieldstaff f (nolock) on f.staffid=cc.staffid
              where c.Staffid=f.staffid and cc.DissolvedDate is null and cc.staffid=c.staffid
              and cc.RegionID='17'
