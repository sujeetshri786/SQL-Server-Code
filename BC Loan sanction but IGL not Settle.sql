-------by yashpal sir local
--select left(c.ClientLoanID,5) Branchid,(select Branchname from Branches where Branchid= left(c.ClientLoanID,5) ) Branchname,c.Clientloanid,
--Targetname as ClientName,Husbandname,cn.Staffid,(select Staffname from fieldstaff where Staffid=cn.StaffID ) CM_Name,c.PrincipalOutstanding,cls.productcategory,
--case when cn.ReportingDay=1 then 'Monday'
--  when cn.ReportingDay=2 then 'Tuesday'
--  when cn.ReportingDay=3 then 'Wednesday'
--  when cn.ReportingDay=4 then 'Thursday'
--  when cn.ReportingDay=5 then 'Friday'
--  when cn.ReportingDay=6 then 'Saturday' end as 'Meetingday'
--from ClientLoanSubscription c (nolock) 
--inner join clientloanproposal cls (nolock) on c.loanproposalid=cls.LoanProposalID
--inner join centers cn (nolock) on cn.centerid=left(cls.clientid,8)
--where c.ActualPaidUpDate is null and c.PrincipalOutstanding>0 and cn.ReportingDay in ('5')
--and cls.clientid in(select Clientid from clientloanproposal cf (nolock) inner join products p (nolock) on cf.productid=p.productid
--where loandisbursementdate is null and Loan_Category=0 and cls.productCategory NOt Like '%%Bridge%%' and
--  loanproposalid in(select loanproposalid from bcLoanFundReleasedkotak (nolock) where ExpiryDate>GETDATE()+3 ))
--  order by c.clientloanid


-----by yashpal sir local CashporONE
select c.BranchID Branchid,(select Branchname from Branches where Branchid= c.BranchID ) Branchname,c.Clientloanid,
Targetname as ClientName,Husbandname,cn.Staffid,(select Staffname from fieldstaff where Staffid=cn.StaffID ) CM_Name,c.PrincipalOutstanding,cls.productcategory,
case when cn.ReportingDay=1 then 'Monday'
  when cn.ReportingDay=2 then 'Tuesday'
  when cn.ReportingDay=3 then 'Wednesday'
  when cn.ReportingDay=4 then 'Thursday'
  when cn.ReportingDay=5 then 'Friday'
  when cn.ReportingDay=6 then 'Saturday' end as 'Meetingday'
from ClientLoanSubscription c (nolock) 
inner join clientloanproposal cls (nolock) on c.loanproposalid=cls.LoanProposalID
inner join centers cn (nolock) on cn.centerid=cls.CenterID
where c.ActualPaidUpDate is null and c.PrincipalOutstanding>0 --and cn.ReportingDay in ('6')
and cls.clientid in(select Clientid from clientloanproposal cf (nolock) inner join products p (nolock) on cf.productid=p.productid
where loandisbursementdate is null and p.Loan_Category=0 and cls.productCategory NOt Like '%%Bridge%%' and cls.productCategory NOt Like '%%mahila%%' and
  loanproposalid in(select loanproposalid from bcLoanFundReleasedkotak (nolock) where ExpiryDate>GETDATE()+3 )) and c.regionid = '05' 
  order by c.clientloanid


----new SIIDBI -- Ballia

select left(c.ClientLoanID,5) Branchid,(select Branchname from Branches where Branchid= left(c.ClientLoanID,5) ) Branchname,c.clientloanid,Targetname as ClientName,husbandname,
cn.Staffid,(select Staffname from fieldstaff where Staffid=cn.StaffID ) CM_Name,c.PrincipalOutstanding,
cls.productcategory,
case when cn.ReportingDay=1 then 'Monday'
  when cn.ReportingDay=2 then 'Tuesday'
  when cn.ReportingDay=3 then 'Wednesday'
  when cn.ReportingDay=4 then 'Thursday'
  when cn.ReportingDay=5 then 'Friday'
  when cn.ReportingDay=6 then 'Saturday' end as 'Meetingday'
from ClientLoanSubscription c (nolock) 
inner join clientloanproposal cls (nolock) on c.loanproposalid=cls.LoanProposalID
inner join centers cn (nolock) on cn.centerid=left(cls.clientid,8)
where c.ActualPaidUpDate is null and c.PrincipalOutstanding>0 --and cn.ReportingDay in ('6') 
and cls.clientid in(select Clientid from clientloanproposal cf (nolock) inner join products p (nolock) on cf.productid=p.productid
where loandisbursementdate is null and p.Loan_Category in ('0','8') and cls.ProductID in ('5X','6X','H6','H8','Q0','Q1','Q2','Q3','Q4','Q5','Q6','W6') and c.regionid = '05' and
  loanproposalid in
  (select LoanProposalID from BCLoanFundReleasedSIDBI (nolock)))
    order by c.clientloanid

------Loan is approved in OWN but previous IGL not settled
--select left(c.ClientLoanID,5) Branchid,(select Branchname from Branches where Branchid= left(c.ClientLoanID,5) ) Branchname,c.clientloanid,Targetname as ClientName,husbandname,
--cn.Staffid,(select Staffname from fieldstaff where Staffid=cn.StaffID ) CM_Name,c.PrincipalOutstanding,
--cls.productcategory,
--case when cn.ReportingDay=1 then 'Monday'
--  when cn.ReportingDay=2 then 'Tuesday'
--  when cn.ReportingDay=3 then 'Wednesday'
--  when cn.ReportingDay=4 then 'Thursday'
--  when cn.ReportingDay=5 then 'Friday'
--  when cn.ReportingDay=6 then 'Saturday' end as 'Meetingday'
--from ClientLoanSubscription c (nolock) 
--inner join clientloanproposal cls (nolock) on c.loanproposalid=cls.LoanProposalID
--inner join products p (nolock) on cls.productid=p.productid
--inner join centers cn (nolock) on cn.centerid=left(cls.clientid,8)
--where c.ActualPaidUpDate is null and c.PrincipalOutstanding>0 and p.Loan_Category = '0' and c.clientID in --and cn.ReportingDay in ('1') 
--(Select Clientid from clientloanproposal as clp inner join products p (nolock) on clp.productid=p.productid where LoanDisbursementDate is null and 
--p.type like '%OWN%' and p.Loan_Category = '0') and c.RegionID = '14'







--Select * from ClientLoanSubscription
--Select * from clientloanproposal
--Select * from centers
--Select * from products Where Type like '%%SIDBI%%'
--Select * from BCLoanFundReleasedSIDBI
--Select * from bcLoanFundReleasedkotak