--Local NEW ALC Details
select EntryBy,count(distinct(clientid)) as ALC from clients where dropoutstatus='0' and 
entryby in ('28295')
and clientid in (select left(clientloanid,14) from ClientLoanSubscription)
group by entryby
order by entryby

--Select Eligible_Flexi_Amount,EligibleForFL,Loancycle,EligibleLoanAmount,Comments,* From Clients with (NoLock) 
--where EntryBy='21188' and AMGRTDate is not null

----Find ALC (Adding)----
select C.ClientID,targets.targetName as ClientName from targets with (nolock) 
inner join clients as c on c.targetId=targets.targetID
where StaffID='28295' and targets.targetID in (select TargetID from clients with (nolock) 
where  AMGRTDate is not null and GroupID in (select GroupID from Groups with (nolock))) order by TargettingDate


select C.ClientID,targets.targetName as ClientName  from targets with (nolock) 
inner join clients as c on c.targetId=targets.targetID
where StaffID='28295' and targets.targetID in (select TargetID from clients with (nolock) 
where ClientID in (select left(clientloanid,14) from ClientLoanSubscription with (nolock))) order by TargettingDate
