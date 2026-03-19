--center Visit and NGSQC Appcashpor
declare @rid varchar(2)='07'
declare @sdate date='2024-03-01'
declare @edate date='2024-03-18'

select branches.branchid,trackvisit.Staffid,fs.StaffName,
case when fs.Designation  ='16' then 'BM' when Designation ='31' then 'CHIB' when Designation ='32' then 'DRO'
when Designation ='30' then 'SCHIB' when Designation ='7' then 'ARO'
when Designation ='21' then 'DDO'when Designation ='22' then 'ADO'when Designation ='23' then 'RM'when Designation ='24' then 'DRM'
when Designation ='25' then 'DRO' 
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
  and fs .Designation in ('31','30','7') --and TrackVisit.Staffid ='0086'
   group by branches.branchid,DATEpart(YEAR  ,trackvisit.Datestamp   ),DATENAME (MONTH ,trackvisit.Datestamp ),trackvisit.Staffid,fs .StaffName,fs.Designation,datepart (MONTH ,trackvisit.Datestamp ) 
 order by trackvisit.Staffid ,DATEpart(YEAR  ,trackvisit.Datestamp   ),datepart (MONTH ,trackvisit.Datestamp )


 --LUC
select LEFT(ClientLoanID,5)as BID,
(select branchname from Branches b where b.branchid=LEFT(ClientLoanID,5))as BranchName
,COUNT(ClientLoanID ) as TotalDisb, --ISNULL(sum(case when cm_reviewDate is not null then 1 end ),0)as CMReview,
--ISNULL(sum(case when bm_reviewDate  is not null then 1 end ),0)as BMReview,
ISNULL(sum(case when Am_reviewDate  is not null then 1 end ),0)as CHIBReview,
ISNULL(sum(case when aro_reviewdate  is not null then 1 end ),0)as AROReview,
--(ISNULL(sum(case when CM_reviewDate  is not null then 1 end ),0)*100/COUNT(ClientLoanID )) as CMPercent,
--(ISNULL(sum(case when bm_reviewDate  is not null then 1 end ),0)*100/COUNT(ClientLoanID )) as BMPercent,
(ISNULL(sum(case when Am_reviewDate  is not null then 1 end ),0)*100/COUNT(ClientLoanID )) as CHIBPercent,
(ISNULL(sum(case when aro_reviewdate  is not null then 1 end ),0)*100/COUNT(ClientLoanID )) as AROPercent
from Loan_Utilisation where 
--CONVERT(varchar (10),loandisbursementdate ,23)<= CONVERT(varchar(10),GETDATE()-15,23) and 
 ClientLoanID in ( select ClientLoanID  from ClientLoanProposal where PrincipalOutstanding >1)
  and loandisbursementdate between '2024-09-01' and '2024-09-30'
  and LEFT(clientloanid,2)='05'
   --and substring(clientloanid,16,2) IN(select productid from products where type  like'%SIDBI%')
group by LEFT(ClientLoanID,5)
order by LEFT(ClientLoanID,5)
