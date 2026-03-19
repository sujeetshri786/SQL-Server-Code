--Track Visit (Visit Report) Appcashpor

select fieldstaff.BranchID,TrackVisit.Staffid,FieldStaff.StaffName,CASE WHEN Fieldstaff.Designation = '16' THEN 'BM' 
when Fieldstaff.Designation ='24' then 'DRM' 
when Fieldstaff.Designation ='23' then 'RM'
when Fieldstaff.Designation ='30' then 'CHIB'
when Fieldstaff.Designation ='31' then 'CHIB'
when Fieldstaff.Designation ='12' then 'SCM'
when Fieldstaff.Designation ='13' then 'CM'
when Fieldstaff.Designation ='14' then 'PCM'
when Fieldstaff.Designation ='15' then 'TCM'
when Fieldstaff.Designation ='25' then 'ZRO'
when Fieldstaff.Designation ='26' then 'DRO'
when Fieldstaff.Designation ='7' then 'ARO'
END AS 'Position',count(distinct TrackVisit.Location_id)as Visit
from TrackVisit inner join fieldstaff on trackvisit.Staffid=fieldstaff.StaffID
inner join Branches as b on b.BranchID=fieldstaff.BranchID where fieldstaff.ExitDate is null
and left(FieldStaff.branchid,2) in('07') 
--and TrackVisit.Location_id in('10:05:17','10:05:E5')
and fieldstaff.Designation  in ('30','31','23','24','16','7','12','13','14','15','25','26')
and TrackVisit.Datestamp between '2022-04-01' and '2022-09-30'
group by TrackVisit.Staffid,FieldStaff.StaffName,fieldstaff.BranchID,fieldstaff.Designation
order by fieldstaff.BranchID,TrackVisit.Staffid,FieldStaff.StaffName
