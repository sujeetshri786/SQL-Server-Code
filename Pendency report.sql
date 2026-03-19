--Appcashpor
-----------------Pending Proposal Detail------------------
 select left(clientid,5) as Branchid,Clientid,Proposaldate,Productid,Clientrequestedamount,
 ProductCategory,Amreviewdate,Finalreviewdate,ApprovalRemarks from ClientLoanProposal 
where loanamountdisbursed=0 and finalreviewdate is null 
and left(clientid,5) in('31:06') 
--and productid in('o0','o1','o2','o3','o4','o6','h2','d2','o7','i0','i1','o7','i3','i4','i5','i6','i7') 
and ApprovalRemarks is null
order by clientid

 ----------------------HusbandKYC not SCan--------------
select b.Districtname,b.BranchID,b.BranchName,clp.ClientID,clp.Targetname,clp.HusbandName,clp.Nominee,clp.ProposalDate,Case When cn.ReportingDay=1 Then 'Monday'
                When cn.ReportingDay=2 Then 'Tuesday'
                When cn.ReportingDay=3 Then 'Wednesday'
                When cn.ReportingDay=4 Then 'Thursday'
                When cn.ReportingDay=5 Then 'Friday'
                When cn.ReportingDay=6 Then 'Saturday' End as MeetingDay from ClientLoanProposal 
as clp inner join Clients as c on clp.clientid=c.ClientID
inner join targets as t on t.targetid=c.targetid
inner join centers as cn on cn.centerid=t.CenterID 
inner join Branches as b on b.BranchID=cn.BranchID 
 where clp.clientid not in(select clientid from husbandadhar)
  and left(clp.clientid,2)in('21') and clp.PrincipalOutstanding='1' and clp.ApprovalRemarks not like'%ban%' and clp.ProductID in
  (select productid from Products where name not like'%en%' and name not like'%em%') and clp.LoanDisbursementDate is null  order by clp.ClientID  
---------------------------------------------pending ADDING-----------------
select branches.Districtname,Branches.BranchID,branches.BranchName,clients.ClientID,targets.TargetName,targets.HusbandName,
targets.CenterID,Centers.CenterName,Case When Centers.ReportingDay=1 Then 'Monday'
	 When Centers.ReportingDay=2 Then 'Tuesday'
	 When Centers.ReportingDay=3 Then 'Wednesday'
	 When Centers.ReportingDay=4 Then 'Thursday'
	 When Centers.ReportingDay=5 Then 'Friday'
	 When Centers.ReportingDay=6 Then 'Saturday' End as MeetingDay,
clients.JoinDate,targets.entryby,fs.StaffName,clients.Amid as BMID,clients.Amgrtdate as BMGRtDate 
from clients inner join targets on clients.TargetID=targets.TargetID
inner join Branches on branches.BranchID=targets.BranchID
inner join centers on centers.CenterID=targets.CenterID
inner join FieldStaff as fs on fs.staffid=centers.StaffID
where cast(clients.JoinDate as date)>='2021-04-01'
and left(branches.BranchID,2)in ('21')
--and branches.amid='1254'
and clients.amgrtdate is  null
--and clientid in (select clientid from totalcreditneedsassessment where remarks like 'worth%')
and clientid in (select clientid from clientloanproposal where principaloutstanding='1' and finalreviewdate is null)
order by Branches.districtname


----------------------Branch wise Proposal detail---------only for Sitmarhi

 select BranchName,LEFT(ClientID,5) as Branchid,count(Loanproposalid) NoOfProposals,sum(ClientRequestedAmount) Amt from ClientLoanProposal
	 inner join branches as cc on LEFT(ClientLoanProposal.ClientID,5)=cc.Branchid
where LoanDisbursementDate is null and cast(ProposalDate as date) = '2022-03-28'--Date one Day Before
 and PrincipalOutstanding=1 and clientid like '31%'
 group by LEFT(ClientID,5),BranchName
order by LEFT(ClientID,5)