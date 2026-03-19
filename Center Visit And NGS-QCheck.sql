--Center Visit And NGS-QCheck

declare @rid varchar(2)='21'
declare @sdate date='2025-08-01'
declare @edate date='2025-08-31'

select branches.branchid,trackvisit.Staffid,fs.StaffName,
case when fs.Designation  ='16' then 'BM' when Designation ='31' then 'CHIB' when Designation ='32' then 'DRO'
when Designation ='30' then 'SCHIB' when Designation ='7' then 'ARO'
when Designation ='21' then 'DDO'when Designation ='22' then 'ADO'when Designation ='23' then 'RM'when Designation ='24' then 'DRM'
when Designation ='25' then 'DRO' when Designation ='27' then 'ABM'
end as Designation,DATEpart(YEAR  ,trackvisit.Datestamp   ) as Year,DATENAME (MONTH ,trackvisit.Datestamp   ) as Month,
count (distinct case when  LEN( Location_id )='2' then CAST(trackvisit.Datestamp as date) end  ) as RegionVisit,
count ( distinct case when  LEN( Location_id )='5' then CAST(trackvisit.Datestamp as date) end ) as branchVisit,
count  (distinct case when   LEN( Location_id )='8' then Location_id  end  ) as CenterVisit
, (select  COUNT(clientloanid) from NGSQCheck where Datestamp between @sdate and @edate and 
left(Clientloanid,2)=@rid  and Staffid =TrackVisit.Staffid
and DATENAME (MONTH ,trackvisit.Datestamp)=DATENAME (MONTH ,Datestamp)  )'NGSQCheck'
from TrackVisit inner join FieldStaff as fs on TrackVisit.Staffid=fs .StaffID and fs .ExitDate is null
inner join Branches on branches.branchid=fs.branchid
and branches.dissolveddate is null
  where TrackVisit.Datestamp between @sdate and @edate  and LEFT(Location_id,2)=@rid 
  and fs .Designation in ('31','30','16','23','24''21','32','7','22','25','27') --and TrackVisit.Staffid ='2821'
   group by branches.branchid,DATEpart(YEAR  ,trackvisit.Datestamp   ),DATENAME (MONTH ,trackvisit.Datestamp ),trackvisit.Staffid,fs .StaffName,fs.Designation,datepart (MONTH ,trackvisit.Datestamp ) 
 order by trackvisit.Staffid ,DATEpart(YEAR  ,trackvisit.Datestamp   ),datepart (MONTH ,trackvisit.Datestamp )


-----------Center Visit And NGS-QCheck Saurabh Sir
declare @rid varchar(2)='07'
declare @sdate date='2023-11-01'
declare @edate date='2023-11-30'

select branches.branchid,trackvisit.Staffid,fs.StaffName,
case when fs.Designation  ='16' then 'BM' when Designation ='31' then 'CHIB' when Designation ='32' then 'DRO'
when Designation ='30' then 'SCHIB' when Designation ='7' then 'ARO'
when Designation ='21' then 'DDO'when Designation ='22' then 'ADO'when Designation ='23' then 'RM'when Designation ='24' then 'DRM'
when Designation ='25' then 'DRO' when Designation ='29' then 'HESM' 
end as Designation,DATEpart(YEAR  ,trackvisit.Datestamp   ) as Year,DATENAME (MONTH ,trackvisit.Datestamp   ) as Month,
count (distinct case when  LEN( Location_id )='2' then CAST(trackvisit.Datestamp as date) end  ) as RegionVisit,
  count ( distinct case when  LEN( Location_id )='5' then CAST(trackvisit.Datestamp as date) end ) as branchVisit,
count  (distinct case when   LEN( Location_id )='8' then Location_id  end  ) as CenterVisit
, (select  COUNT(clientloanid) from NGSQCheck where Datestamp between @sdate and @edate and 
left(Clientloanid,2)=@rid  and Staffid =TrackVisit.Staffid
and DATENAME (MONTH ,trackvisit.Datestamp)=DATENAME (MONTH ,Datestamp)  )'NGSQCheck',
count  (distinct case when   LEN( Location_id )='8' and  LocationType='C' then Location_id  end  ) as CECVisit
from TrackVisit inner join FieldStaff as fs on TrackVisit.Staffid=fs .StaffID and fs .ExitDate is null
inner join Branches on branches.branchid=fs.branchid
and branches.dissolveddate is null
where TrackVisit.Datestamp between @sdate and @edate  and LEFT(Location_id,2)=@rid 
and fs .Designation in ('16','30','31','22','23','24','29') and Branches.BranchID like'07%' --and TrackVisit.Staffid ='3867'
group by branches.branchid,DATEpart(YEAR  ,trackvisit.Datestamp   ),DATENAME (MONTH ,trackvisit.Datestamp ),trackvisit.Staffid,fs .StaffName,fs.Designation,datepart (MONTH ,trackvisit.Datestamp ) 
order by trackvisit.Staffid ,DATEpart(YEAR  ,trackvisit.Datestamp   ),datepart (MONTH ,trackvisit.Datestamp )

--Select Location_id from TrackVisit Where Staffid = '12793' and Datestamp between '2023-04-01' and '2023-04-30'   
--group by Location_id
--order by Location_id


------------------Runquery
select branches.Branchid,trackvisit.Staffid,fs.StaffName,
case when fs.Designation  ='16' then 'BM' when Designation ='31' then 'CHIB' when Designation ='32' then 'DRO'
when Designation ='30' then 'SCHIB' when Designation ='7' then 'ARO'
when Designation ='21' then 'DDO'when Designation ='22' then 'ADO'when Designation ='23' then 'RM'when Designation ='24' then 'DRM'
when Designation ='25' then 'DRO' when Designation ='29' then 'HESM' 
end as Designation,DATEpart(YEAR  ,trackvisit.Datestamp) as Year,DATENAME (MONTH ,trackvisit.Datestamp   ) as Month,
count (distinct case when  LEN( Location_id )='2' then CAST(trackvisit.Datestamp as date) end  ) as RegionVisit,
  count ( distinct case when  LEN( Location_id )='5' then CAST(trackvisit.Datestamp as date) end ) as BranchVisit,
count  (distinct case when   LEN( Location_id )='8' then Location_id  end  ) as CenterVisit
, (select  COUNT(clientloanid) from NGSQCheck where Datestamp between '2026-02-01' and '2026-02-28' and 
left(Clientloanid,2)='14'  and Staffid =TrackVisit.Staffid
and DATENAME (MONTH ,trackvisit.Datestamp)=DATENAME (MONTH ,Datestamp)  )'NGSQCheck',
count  (distinct case when   LEN( Location_id )='8' and  LocationType='C' then Location_id  end  ) as CECVisit
from TrackVisit inner join FieldStaff as fs on TrackVisit.Staffid=fs .StaffID and fs .ExitDate is null
inner join Branches on branches.branchid=fs.branchid
and branches.dissolveddate is null
where TrackVisit.Datestamp between '2026-02-01' and '2026-02-28'  and LEFT(Location_id,2)='05'
and fs .Designation in ('16','30','31','22','23','24','29','32','21','25','7') and Branches.BranchID like '05%'
group by branches.branchid,DATEpart(YEAR  ,trackvisit.Datestamp),DATENAME (MONTH ,trackvisit.Datestamp),trackvisit.Staffid,fs .StaffName,fs.Designation,datepart (MONTH ,
trackvisit.Datestamp) 
order by trackvisit.Staffid ,DATEpart(YEAR  ,trackvisit.Datestamp),datepart (MONTH ,trackvisit.Datestamp)



select Location_id,Staffid,(select staffname from FieldStaff where staffid=trackvisit.Staffid ) 'StaffNAME', 
(select designationname from designationmaster with (nolock) where designationid in (select designation from fieldstaff where staffid=trackvisit.Staffid )) Position,
cast (Datestamp as date) Datestamp from trackvisit 
where left (Location_id,2) in ('10')  and LEN(Location_id) = 5 
and cast (Datestamp as date) >=  '2025-01-01'   and 
Staffid in  (select staffid from fieldstaff where staffid=trackvisit.Staffid and designation in ('30','31','22','23','24','21','25','7','43')  
and left (branchid,2) in ('10'))

