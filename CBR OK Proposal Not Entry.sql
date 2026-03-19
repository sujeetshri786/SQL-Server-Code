--CBR OK Proposal Not Entry

Select  b.Districtname as Region,b.Branchid,B.Branchname,Branchbc,a.Clientid,targets.TargetName AS ClientName,HusbandName,Trnloanid,a.Loancycle,
LoanamountappliedbyClient,Loanamount,ProductCategory,a.DateStamp,
LoanAmtApprovedByCenterBM from CreditWorthinesstrn a  with (nolock) 
inner join branches b (nolock) on b.branchid=left(a.clientid,5)
Inner Join clients (nolock) on clients.clientid=a.clientid
Join Targets (nolock) on targets.targetid=clients.targetid
--Join LoanAppraisal_ClientDetail c on c.
where 
  trnloanid not in(select trnloanid from clientloanproposal with (nolock) where trnloanid is not null )
and  trnloanid in(select custreffield from CCRMFISUMMARY(nolock) where cbrremark='ok')
--and  AppMode=0 and  ReviewedBy is null and  ReviewedDate is null
and Clients.DropOutDate is null and DropOutStatus=0 and riskfund=0 and left(clients.clientid,2)in('14') 
--and a.clientid not in(Select clientid from clientloanproposal with (nolock) where principaloutstanding>1 and loandisbursementdate>='2022-04-01')
order by left(a.clientid,5),a.Clientid
