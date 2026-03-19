------------------- center report handle by Staff ------------------local

Select B.DistrictName,B.BranchID,B.BranchName,FS.StaffID,FS.StaffName,CASE WHEN FS.Designation = '12' THEN 'SCM' 
WHEN FS.Designation = '13' THEN 'CM' WHEN FS.Designation = '14' THEN 'PCM' 
WHEN FS.Designation = '15' THEN 'TCM' WHEN FS.Designation = '46' THEN 'CTPCM' 
WHEN FS.Designation = '47' THEN 'CTTCM' WHEN FS.Designation = '27' THEN 'ABM' 
END AS 'Position',Count(C.CenterID) as NumCenters from Centers as C inner join FieldStaff As FS ON
C.StaffID=FS.StaffID and C.DissolvedDate is null and FS.ExitDate is null
inner join Branches AS B On C.BranchID=B.BranchID and B.DissolvedDate is null
Where C.CenterId like '10%'
group by B.DistrictName,B.BranchID,B.BranchName,FS.StaffID,FS.StaffName,FS.Designation
having Count(C.CenterID)>=20
order by B.BranchID,FS.StaffID



------------------- center report handle by Staff ------------------local

Select B.DistrictName,B.BranchID,B.BranchName,FS.StaffID,FS.StaffName,CASE WHEN FS.Designation = '12' THEN 'CM' 
WHEN FS.Designation = '13' THEN 'CM' WHEN FS.Designation = '14' THEN 'PCM' 
WHEN FS.Designation = '13' THEN 'CM' WHEN FS.Designation = '46' THEN 'CTPCM' 
WHEN FS.Designation = '13' THEN 'CM' WHEN FS.Designation = '47' THEN 'CTTCM' 
WHEN FS.Designation = '15' THEN 'TCM' END AS 'Position',Count(C.CenterID) as NumCenters from Centers as C inner join FieldStaff As FS ON
C.StaffID=FS.StaffID and C.DissolvedDate is null and FS.ExitDate is null
inner join Branches AS B On C.BranchID=B.BranchID and B.DissolvedDate is null
where c.StaffID in ('25831')
group by B.DistrictName,B.BranchID,B.BranchName,FS.StaffID,FS.StaffName,FS.Designation
--having Count(C.CenterID)>11
order by B.BranchID,FS.StaffID
