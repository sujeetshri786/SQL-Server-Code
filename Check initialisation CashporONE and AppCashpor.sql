----------Check initialisation AppCashpor
select b.branchid,branchname,sum(ClientLoan1AmtDueDisbursed) TodayDue,
SUM(ClientLoan1PrincipalDue+ClientLoan1InterestDue) TodayCollection from CDS2 c inner join Branches b 
on left(c.clientid,5)=b.branchid where b.DissolvedDate  is null
group by b.branchid,branchname
order by b.BranchID 



----------Check initialisation CashporONE
select b.branchid,branchname,sum(ClientLoan1AmtDueDisbursed) TodayDue,
SUM(ClientLoan1PrincipalDue+ClientLoan1InterestDue) TodayCollection from DICDS2 c inner join Branches b 
on left(c.clientid,5)=b.branchid where b.DissolvedDate  is null
group by b.branchid,branchname
order by b.BranchID 

select * from cds1 where  ActualMeetingDate = '2024-01-27' and BranchID like '14:13%'
select * from cds2 where clientid like '14:13%'
select * from cds3 where clientid like '14:13%'


select * from dicds1 where  ActualMeetingDate = '2024-01-27' and BranchID like '39:22%'
select * from dicds2 where clientid like '39:22%'
select * from dicds3 where clientid like '39:22%'


-------------------appcashpor
select count(distinct(Branchid))from CDS1 where ActualMeetingDate = '2024-01-27'

select count(distinct(left(ClientID,5))) as BranchID from CDS2

select count(distinct(left(ClientID,5))) as BranchID from CDS3


-------------------Local
select count(distinct(Branchid)) from CDS1 where ActualMeetingDate = '2024-01-27'
select count(distinct(Branchid)) from CDS2
select count(distinct(Branchid)) from CDS3

select count(distinct(Branchid)) from DICDS1 where ActualMeetingDate = '2024-01-27'
select count(distinct(Branchid)) from DICDS2
select count(distinct(Branchid)) from DICDS3






--------center local
select * from cds1 where  ActualMeetingDate = '2024-01-27' and CenterID like '33:19:23%'
select * from cds2 where clientid like '33:19:23%'
select * from cds3 where clientid like '33:19:23%'


select * from dicds1 where  ActualMeetingDate = '2024-01-27' and CenterID like '33:19:23%'
select * from dicds2 where clientid like '33:19:23%'
select * from dicds3 where clientid like '33:19:23%'

------center Appcashor
select * from cds1 where  ActualMeetingDate = '2024-01-27' and CenterID like '33:19:23%'
select * from cds2 where clientid like '33:19:23%'
select * from cds3 where clientid like '33:19:23%'


--Select * from centers where centerid in ('33:19:23','33:19:23','33:19:23') and DissolvedDate is null
--Select * from cds1 where centerid in ('33:19:23','33:19:23','33:19:23')

--Select left(GroupID,8) as centerID,* from cds2 where centerid in ('33:19:23','33:19:23','33:19:23')

--Select * from centers where BranchID like '33:44%' and DissolvedDate is null

--Select Downloading,* from Branches where BranchID like '33:19%' and DissolvedDate is null


--update Branches set Downloading = '1' where BranchID like '33:19%' and DissolvedDate is null