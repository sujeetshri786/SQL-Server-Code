--Center Leader Local

select b.branchid,b.CenterID,b.CenterName,b.StaffID,f.StaffName,b.Leaderid from [43.242.214.235].[appcashpor].[dbo].leader31032023 a inner join
Centers b on a.CenterID=b.CenterID inner join FieldStaff f on f.StaffID=b.StaffID where b.DissolvedDate is null and b.FormationDate<='2025-03-31'
and a.Leaderid=b.Leaderid and left(b.branchid,2) in ('05')
order by b.CenterID
