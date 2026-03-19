----Minsure Pending Nikhil Sir


select Branches.zone,Branches.districtname,  Branches.Branchid,staffname,staffid, branches.Branchname,
  ClientID,Loanproposalid,targetname as ClientName,Husbandname,Proposaldate,Loandescription,
clientrequestedamount,Productcategory

  from clientloanproposal with (nolock)
  inner join branches  with (nolock) on left(clientloanproposal.clientid,5)=branches.branchid
  inner join fieldstaff with (nolock) on clientloanproposal.entryby=fieldstaff.staffid
where   left(clientid,2) in ( '14') and principaloutstanding>'1' 

and clientid not in 
 ( select clientid
from MInsureSurvey a inner join Branches b on b.BranchID=a.BranchID Inner join centers c on c.centerID=a.CenterID Inner Join FieldStaff f on f.staffID=c.staffID 
where left (clientid,2 ) in (  '14' ) and WriteoffDate is NULL and RejectedBy is NULL   and cast(a.ServiceExpiryDate as date)>cast (getdate() as date) 
 )
