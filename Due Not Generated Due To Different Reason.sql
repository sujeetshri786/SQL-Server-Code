--Due Not Generated Due To Different Reason Appcashpor


select left(a.clientid,5) as BranchID, br.BranchName, a.ClientID, b.ClientName, clp.ClientRequestedamount as ProposalAmount, a.ClientLoan1ProductName,
Case when d.ReportingDay=1 then 'Monday'
when d.ReportingDay=2 then 'Tuesday'
when d.ReportingDay=3 then 'Wednesday'
when d.ReportingDay=4 then 'Thursday'
when d.ReportingDay=5 then 'Friday'
when d.ReportingDay=6 then 'Saturday' end as CenterMeetingDay
from CDS2 as a
inner join cds3 as b on b.ClientID=a.ClientID
inner join branches as br on br.branchid=left(a.clientid,5)
inner join ClientLoanproposal as clp on clp.Loanproposalid=a.loanproposalid
inner join centers as d on d.centerid=left(a.clientid,8)
where a.Clientid like '22%' and a.ClientLoan1id ='0' and a.ClientLoan1Productname <>'0'
order by left(a.clientid,5)
