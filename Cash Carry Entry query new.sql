-------------------  Cash Carry  ------------------------Appcashpor

-----------Zone Wise----------------------------------
select Zone,DistrictName,left(centerid,2) as RId,
case when Handleby='0096' then 'ADO' else 'DDO' end as HandleBy,Count(centerid) as Requested,
count(case when Bmrecommendationdate is null and ActualDiscontinueDate is null then 'Pending by BM' end ) as 'BM Pending',
count(case when Chibrecommendationdate is null  and ActualDiscontinueDate is null then 'Pending by CHIB' end ) as 'CHIB Pending',
count(case when DDOapprovaldate  is null and ActualDiscontinueDate is null then 'Pending by RM' end ) as 'RM Pending',
count(case when  ActualDiscontinueDate is  not null then 'Discontinue' end ) as 'Discontinue',
count(case when  ActualDiscontinueDate is null then 'Pending Discontinue' end ) as 'Pending Discontinue'
from Centercashcarry as ca 
inner join branches as b on b.BranchId=left(centerid,5) and b.Zone='HOT-North east Zone'
where  CAST(Cmrequestdate as date)>='2025-04-01' 
Group by  Zone,Handleby,DistrictName,left(centerid,2)
order by  Zone,Handleby,DistrictName,left(centerid,2)


--------------------Region Wise------------
select branches.zone,districtname,branches.BranchID,branchname,centercashcarry.CenterId,CenterName,CMid,Cmrequestdate,
case when centercashcarry.Reason ='0' 
then 'Center problem Due to Overdue' 
when centercashcarry.Reason ='1' then 'Distance Issues' 
when centercashcarry.Reason ='2' then 'Administrative issues' 
when centercashcarry.Reason ='3' then 'Transpotation Problems'  
 when centercashcarry.Reason ='4' then 'Less than 10 Clients' 
  when centercashcarry.Reason ='5' then 'Flood/Drought/Fire'
   when centercashcarry.Reason ='6' then 'Other' end as 'Reason',Bmid,Bmrecommendationdate,Chibid,Chibrecommendationdate,
   DDOid AS RMID,DDOapprovaldate as RMrecommendationdate from Centercashcarry 
inner join centers on centers.CenterID=centercashcarry.CenterId
inner join Branches on branches.BranchID=LEFT(centers.CenterID,5)
where ActualDiscontinueDate is null and Cmrequestdate>='2025-04-01' and branches.BranchID like '14%' order by Cmrequestdate



--Cash Carry More than 30000
select left(clp.clientid,5) BID, b.BranchName, left(clp.clientid,8) CenterID, c.CenterName, ClientID, TargetName, LoanAmountDisbursed from clientloanproposal clp
inner join branches b on b.branchid=left(clp.clientid,5)
inner join centers c on c.centerid=left(clp.clientid,8)
where loanamountdisbursed>30000 and 
left(clientid,8) in (select centerid from centercashcarry where centerid like '14%') and 
proposaldate>='2025-04-01' and  clientid like '14%'

--Select * from Centercashcarry


------------2025-03-19
select B.Zone,B.DistrictName, B.BranchID,B.BranchName,Cl.CenterID,Cl.CenterName,c.Cmrequestdate,c.Bmrecommendationdate,c.Chibrecommendationdate,c.DDOapprovaldate
from centercashcarry c (nolock)
inner join centers cl (nolock) on cl.centerid=c.centerid
inner join Branches b (nolock) on b.BranchID=cl.BranchID
where ActualDiscontinueDate='2026-03-31'


select B.Zone,B.DistrictName, B.BranchID,B.BranchName,Cl.CenterID,Cl.CenterName,c.Cmrequestdate,c.Bmrecommendationdate,c.Chibrecommendationdate,c.DDOapprovaldate
from centercashcarry c (nolock)
inner join centers cl (nolock) on cl.centerid=c.centerid
inner join Branches b (nolock) on b.BranchID=cl.BranchID
where ActualDiscontinueDate='2026-03-31' and left(b.branchid,2) in ('32','30','25')


----Cash carry Akash 2025-11-25
select branches.zone,districtname,branches.BranchID,branchname,centercashcarry.CenterId,CenterName,CMid,Cmrequestdate,case when centercashcarry.Reason ='0' 
then 'Center problem Due to Overdue' 
when centercashcarry.Reason ='1' then 'Distance Issues' 
when centercashcarry.Reason ='2' then 'Administrative issues' 
when centercashcarry.Reason ='3' then 'Transpotation Problems'  
 when centercashcarry.Reason ='4' then 'Less than 10 Clients' 
  when centercashcarry.Reason ='5' then 'Flood/Drought/Fire'
   when centercashcarry.Reason ='6' then 'Other' end as 'Reason',Bmid,Bmrecommendationdate,Chibid,Chibrecommendationdate,DDOid AS RMID,DDOapprovaldate as RMrecommendationdate from Centercashcarry 
inner join centers on centers.CenterID=centercashcarry.CenterId
inner join Branches on branches.BranchID=LEFT(centers.CenterID,5)
where Cmrequestdate>='2025-04-01' and branches.BranchID like '05%' order by Cmrequestdate


----Sachin

select branches.zone,districtname,branches.BranchID,branchname,centercashcarry.CenterId,CenterName,CMid,Cmrequestdate,case when centercashcarry.Reason ='0' 
then 'Center problem Due to Overdue' 
when centercashcarry.Reason ='1' then 'Distance Issues' 
when centercashcarry.Reason ='2' then 'Administrative issues' 
when centercashcarry.Reason ='3' then 'Transpotation Problems'  
 when centercashcarry.Reason ='4' then 'Less than 10 Clients' 
  when centercashcarry.Reason ='5' then 'Flood/Drought/Fire'
   when centercashcarry.Reason ='6' then 'Other' end as 'Reason',Bmid,Bmrecommendationdate,Chibid,Chibrecommendationdate,DDOid AS RMID,DDOapprovaldate as RMrecommendationdate from Centercashcarry 
inner join centers on centers.CenterID=centercashcarry.CenterId
inner join Branches on branches.BranchID=LEFT(centers.CenterID,5)
where ActualDiscontinueDate is null and Cmrequestdate>='2025-04-01' and branches.BranchID like '05%' order by Cmrequestdate

--Sachin Total Cash Carry
select B.Zone,B.DistrictName, B.BranchID,B.BranchName,Cl.CenterID,Cl.CenterName,c.Cmrequestdate,c.Bmrecommendationdate,c.Chibrecommendationdate,c.DDOapprovaldate
from centercashcarry c (nolock)
inner join centers cl (nolock) on cl.centerid=c.centerid
inner join Branches b (nolock) on b.BranchID=cl.BranchID
where ActualDiscontinueDate='2026-03-31' and cl.centerid like '19%'

----Cash carry  Query (Apcashpor) Shubhendu

select B.Zone,B.DistrictName, B.BranchID,B.BranchName,Cl.CenterID,Cl.CenterName,c.Cmrequestdate,c.Bmrecommendationdate,c.Chibrecommendationdate,c.DDOapprovaldate
from centercashcarry c (nolock)
inner join centers cl (nolock) on cl.centerid=c.centerid
inner join Branches b (nolock) on b.BranchID=cl.BranchID
where ActualDiscontinueDate='2026-03-31' and left(b.branchid,2) in ('32','30','25')


----Center Cash Carry Query Anup Pandet 2026-01-06
select B.Zone,B.DistrictName, B.BranchID,B.BranchName,Cl.CenterID,Cl.CenterName,c.Cmrequestdate,BMID,c.Bmrecommendationdate,CHIBID,c.Chibrecommendationdate,
ddoid RMID,c.DDOapprovaldate RMApprovalDate from centercashcarry c (nolock)
inner join centers cl (nolock) on cl.centerid=c.centerid
inner join Branches b (nolock) on b.BranchID=cl.BranchID
where c.ActualDiscontinueDate is null and c.ddoapprovaldate is not null and cast(c.expecteddiscontinuedate as date) >='2025-04-01' and c.centerid like '14%' or c.centerid like '14%' or c.centerid like '14%'



