------Death Entry Check Query (Region[cmc_server])----------
------------Check for Client case (Adding/Existing)------

use CASHPORONE

declare @cid varchar(14) = '14:02:38:01:09'

select c.AMID, c.AMGRTDate, c.Loancycle, c.JoinDate, c.EligibleLoanAmount,c.EligibleForFL, c.Eligible_Flexi_Amount, 
c.ClientID, t.targetname, t.TargetAge, t.HusbandName, t.HusbandAge, c.DropOutStatus, c.DropOutDate, 
c.CommentedBy, c.SuspendDate,c.HotlistRemark, c.HotlistDate, *from clients as c
left join Targets as t on c.TargetID = t.TargetID
where c.ClientID = @cid
order by c.ClientID


select (select ProductCategory from ClientLoanProposal clp with(nolock) where clp.LoanProposalID = cls.LoanProposalID)'ProductCategory', ClientLoanID, DeathPerson, 
(case when DeathPerson = '0' then 'None' 
 when DeathPerson = '1' then 'Client' 
 when DeathPerson = '2' then 'Husband'
 when DeathPerson = '6' then 'Mother-in-Law'

 end
) as DeathPerson, DeathDate, DeathEntryDate, EntryBy, DateStamp, OutsatndingOnDeathTime, *from clientloansubscription cls with(nolock) 
where clientloanid like @cid + '%' --and ActualPaidUpDate is null

--select *From [43.242.214.235].[appcashpor].[dbo].ClientLoanProposal with(nolock) where LoanProposalID in ('26:09:06707', '26:09:05996')


--select *From LoanLedger with(nolock) where ClientLoanID='18:21:20:01:36:V4:01'

--select DateOfUpdation, UpdatedRecords, *From ATClientLoanSubscription with(nolock) where ClientLoanID = '33:01:85:01:03:R1:01'

