---Back date Branch Closing Details

select r.BranchID,r.BranchName,convert (varchar (10),r.DateStamp,23) as date
--,count (case when  CONVERT(varchar,r.DateStamp,8) <='14:00:00' then 1 end )as '<= 2 PM'
--,count (case when  CONVERT(varchar,r.DateStamp,8) >='14:00:01' and CONVERT(varchar,r.DateStamp,8) <='15:00:00' then 1 end )as '<= 2 to 3 PM'
--,count (case when  CONVERT(varchar,r.DateStamp,8) >='15:00:01' and CONVERT(varchar,r.DateStamp,8) <='16:00:00' then 1 end )as '<= 3 to 4 PM'
,count (case when  CONVERT(varchar,r.DateStamp,8) >='16:00:01' and CONVERT(varchar,r.DateStamp,8) <='17:00:00' then 1 end )as '<= 4 to 5 PM'
,count (case when  CONVERT(varchar,r.DateStamp,8) >='17:00:01' then 1 end )as '>5 PM'
from rptdailyclosingdtl r join Branches b on r.BranchID=b.branchid where cast(r.DateStamp as date)>='2023-09-01' --and b.chid='3984'
group by convert (varchar (10),r.DateStamp,23),r.branchid,r.BranchName
order  by r.branchid,convert (varchar (10),r.DateStamp,23)
