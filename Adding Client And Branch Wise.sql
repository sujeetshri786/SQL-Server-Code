--adding of lient
-------Client wise-----------
select  b.BranchID ,b.BranchName ,c.ClientID ,t.TargetName ,AMGRTDate ,
case when c.ClientID IN (select LEFT(clientloanid,14) from ClientLoanSubscription)
then 'Disbursement Done' else 'Disbursement not Done' end Status, f.StaffID ,StaffName  
 from Clients c inner join targets t on
c.targetid=t.targetid
inner join branches b 
on b.branchid=left(c.clientid,5)
inner join FieldStaff f 
on f.StaffID =t.StaffID 
 where cast(AMGRTDate as date) between '2026-01-01' and '2026-01-31' and dropoutstatus='0' and ClientID like '14%'
order by b.BranchID

--------Branch wise-----------
select  b.BranchID ,b.BranchName ,count(c.ClientID) NoOfAdding   
 from Clients c inner join targets t on
c.targetid=t.targetid
inner join branches b 
on b.branchid=left(c.clientid,5)
inner join FieldStaff f 
on f.StaffID =t.StaffID 
 where cast(AMGRTDate as date) between '2026-02-01' and '2026-02-28' and dropoutstatus='0' and ClientID like '05%'
group by b.BranchID ,b.BranchName
order by b.BranchID


--Adding With Bm ID And BmName
select  b.BranchID ,b.BranchName ,c.ClientID ,t.TargetName ,AMGRTDate ,
case when c.ClientID IN (select LEFT(clientloanid,14) from ClientLoanSubscription)
then 'Disbursement Done' else 'Disbursement not Done' end Status, f.StaffID ,StaffName,c.AMID AS BMID,
(Select StaffName From FieldStaff Where c.AMID = StaffID) AS BmName 
 from Clients c inner join targets t on
c.targetid=t.targetid
inner join branches b 
on b.branchid=left(c.clientid,5)
inner join FieldStaff f 
on f.StaffID =t.StaffID 
 where cast(AMGRTDate as date) between '2023-08-01' and '2023-08-31' and dropoutstatus='0' and ClientID like '07%'
order by b.BranchID

--not completed
--SELECT b.BranchID,b.BranchName,c.ClientID,t.TargetName AS ClientName,* FROM Clients AS c WITH (NOLOCK) 
--Inner Join Targets AS t on t.TargetID = c.TargetID
--Inner Join Branches AS b on b.BranchID = left(c.clientID,5)
--Inner Join FieldStaff AS fs on fs.BranchID = left(c.clientID,5)
--WHERE c.ClientID Like '14%' AND c.DropOutStatus = '0' AND cast(c.JoinDate AS DATE) Between '2022-04-01' AND '2023-01-06' 
--and c.ClientID NOT IN 
--(SELECT ClientID FROM ClientLoanProposal)


--BM ABM Adding
select  b.BranchID ,b.BranchName ,c.ClientID ,t.TargetName ,AMGRTDate ,
case when c.ClientID IN (select LEFT(clientloanid,14) from ClientLoanSubscription)
then 'Disbursement Done' else 'Disbursement not Done' end Status, f.StaffID ,StaffName, c.AMID, 
(Select staffname from FieldStaff Where StaffId=C.Amid) as BMName,
(Select Designation From FieldStaff Where StaffId = C.Amid) as Designation
 from Clients c inner join targets t on
c.targetid=t.targetid
inner join branches b 
on b.branchid=left(c.clientid,5)
inner join FieldStaff f 
on f.StaffID =t.StaffID 
 where cast(AMGRTDate as date) between '2023-08-01' and '2023-08-31' and dropoutstatus='0' and ClientID like '07%'
order by b.BranchID

-- adding entry details appcashpor

select b.BranchID,b.BranchName,clients.ClientID,targets.TargetName,targets.HusbandName,
targets.CenterID,cc.CenterName,Case When CC.ReportingDay=1 Then 'Monday'
                When CC.ReportingDay=2 Then 'Tuesday'
                When CC.ReportingDay=3 Then 'Wednesday'
                When CC.ReportingDay=4 Then 'Thursday'
                When CC.ReportingDay=5 Then 'Friday'
                When CC.ReportingDay=6 Then 'Saturday' End as MeetingDay,
clients.JoinDate,targets.entryby,fs.StaffName,clients.Amid as BMID,clients.Amgrtdate as BMGRtDate from clients 
inner join targets on targets.TargetID =clients.TargetID 
inner join Branches as b on b.BranchID=targets.BranchID
inner join centers as cc on cc.CenterID=targets.CenterID
inner join FieldStaff as fs on fs.staffid=cc.StaffID
where joindate between '2023-08-01' and '2023-08-31' and left(clientid,2) in ('07') --like '02%' and Amgrtdate is null
and DropOutStatus='0'
order by b.BranchID,b.BranchName
