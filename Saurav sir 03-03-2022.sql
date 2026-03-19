--

select zone,districtname,BranchName,Ce.StaffID,F.StaffName,ClientID ,a.LoanProposalID,b.customername,b.LoanAmountApproved ,b.StatusRecievdDate,b.StatusRecievdDate+21 as expitydate,
clientloan1productname as Remark,'ICICIBC' bcname,Case when Ce.ReportingDay=1 then 'Monday'
when Ce.ReportingDay=2 then 'Tuesday'
when Ce.ReportingDay=3 then 'Wednesday'
when Ce.ReportingDay=4 then 'Thursday'
when Ce.ReportingDay=5 then 'Friday'
when Ce.ReportingDay=6 then 'Saturday' end as CenterMeetingDay from dicds2 a (nolock) inner join ICICIReview b (nolock) on a.LoanProposalID =b.Loanproposalid
inner join Branches c (nolock) on c.branchid=left(a.clientid,5)
inner join centers ce on ce.centerid=a.CenterID
inner join Fieldstaff f on f.StaffId=Ce.staffid  where  Approved in (1) and a.clientloan1id='0'
union all
select zone,districtname as RegionName,BranchName,Ce.StaffID,F.StaffName,ClientID ,a.LoanProposalID,b.customername,b.LoanAmountApproved ,b.StatusRecievdDate,b.StatusRecievdDate+59 as expitydate,
clientloan1productname as Remark,'SIDBIBC' bcname,Case when Ce.ReportingDay=1 then 'Monday'
when Ce.ReportingDay=2 then 'Tuesday'
when Ce.ReportingDay=3 then 'Wednesday'
when Ce.ReportingDay=4 then 'Thursday'
when Ce.ReportingDay=5 then 'Friday'
when Ce.ReportingDay=6 then 'Saturday' end as CenterMeetingDay from dicds2 a (nolock) inner join SIDBIREVIEW b (nolock) on a.LoanProposalID =b.Loanproposalid
inner join Branches c (nolock) on c.branchid=left(a.clientid,5)
inner join centers ce on ce.centerid=a.CenterID
inner join Fieldstaff f on f.StaffId=Ce.staffid  where  Approved in (1) and a.clientloan1id='0' and Link_Date  is not null
union all
select zone,districtname,BranchName,Ce.StaffID,F.StaffName,a.ClientID ,a.LoanProposalID,b.customername,b.LoanAmountApproved ,d.SanctionDate,d.SanctionDate+56 as expitydate,
clientloan1productname as Remark,'IDBIBC' bcname,Case when Ce.ReportingDay=1 then 'Monday'
when Ce.ReportingDay=2 then 'Tuesday'
when Ce.ReportingDay=3 then 'Wednesday'
when Ce.ReportingDay=4 then 'Thursday'
when Ce.ReportingDay=5 then 'Friday'
when Ce.ReportingDay=6 then 'Saturday' end as CenterMeetingDay from dicds2 a (nolock) inner join IDBIReview b (nolock) on a.LoanProposalID =b.Loanproposalid
Inner Join BCLoanFundReleased d on b.Loanproposalid=d.LoanProposalID
inner join Branches c (nolock) on c.branchid=left(a.clientid,5)
inner join centers ce on ce.centerid=a.CenterID
inner join Fieldstaff f on f.StaffId=Ce.staffid  where  Approved in (1) and a.clientloan1id='0'
