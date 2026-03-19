----------TOP Sheet BM Adding Pending------------------------------
select Branches.BranchID,branches.BranchName,count(clients.ClientID) as PendingAdding_BM
from clients with(nolock) inner join targets with(nolock) on clients.TargetID=targets.TargetID and clients.DropOutStatus='0'
inner join Branches with(nolock) on branches.BranchID=targets.BranchID
inner join centers with(nolock) on centers.CenterID=targets.CenterID
inner join FieldStaff as fs  with(nolock) on fs.staffid=centers.StaffID
where cast(clients.JoinDate as date) >='2021-01-01'
and branches.BranchID like '22%'
--and branches.amid='1254'
and clients.amgrtdate is  null
and clientid in (select clientid from CreditNeedAccessment where remarks like 'asse%')
and clientid in (select clientid from clientloanproposal where principaloutstanding='1' and finalreviewdate is null)
group by  Branches.BranchID,branches.BranchName
order by  Branches.BranchID,branches.BranchName

-------------Client Wise Adding Pending Detail by Branch Managar-------------------------
select Branches.BranchID,branches.BranchName,clients.ClientID,targets.TargetName,targets.HusbandName,
targets.CenterID,Centers.CenterName,Case When Centers.ReportingDay=1 Then 'Monday'
       When Centers.ReportingDay=2 Then 'Tuesday'
       When Centers.ReportingDay=3 Then 'Wednesday'
       When Centers.ReportingDay=4 Then 'Thursday'
       When Centers.ReportingDay=5 Then 'Friday'
       When Centers.ReportingDay=6 Then 'Saturday' End as MeetingDay,
clients.JoinDate,targets.entryby,fs.StaffName,clients.Amid as BMID,clients.Amgrtdate as BMGRtDate 
from clients with(nolock) inner join targets with(nolock) on clients.TargetID=targets.TargetID and clients.DropOutStatus='0'
inner join Branches with(nolock) on branches.BranchID=targets.BranchID
inner join centers with(nolock) on centers.CenterID=targets.CenterID
inner join FieldStaff as fs with(nolock) on fs.staffid=centers.StaffID
where cast(clients.JoinDate as date) >='2021-01-01'
and branches.BranchID like '22%'
--and branches.amid='1254'
and clients.amgrtdate is  null
and clientid in (select clientid from CreditNeedAccessment where remarks like 'asse%')
and clientid in (select clientid from clientloanproposal where principaloutstanding='1' and finalreviewdate is null)
order by Branches.BranchID

-----------CM Adding Pendency----------------

select Branches.BranchID,branches.BranchName,clients.ClientID,targets.TargetName,targets.HusbandName,
targets.CenterID,Centers.CenterName,Case When Centers.ReportingDay=1 Then 'Monday'
       When Centers.ReportingDay=2 Then 'Tuesday'
       When Centers.ReportingDay=3 Then 'Wednesday'
       When Centers.ReportingDay=4 Then 'Thursday'
       When Centers.ReportingDay=5 Then 'Friday'
       When Centers.ReportingDay=6 Then 'Saturday' End as MeetingDay,
clients.JoinDate,targets.entryby,fs.StaffName,clients.Amid as BMID,clients.Amgrtdate as BMGRtDate 
from clients  with(nolock) inner join targets  with(nolock) on clients.TargetID=targets.TargetID and clients.DropOutStatus='0'
inner join Branches  with(nolock) on branches.BranchID=targets.BranchID
inner join centers  with(nolock) on centers.CenterID=targets.CenterID
inner join FieldStaff as fs  with(nolock) on fs.staffid=centers.StaffID
where cast(clients.JoinDate as date) >='2021-01-01'
and branches.BranchID like '22%'
--and branches.amid='1254'
and clients.amgrtdate is  null
and clientid in (select clientid from CreditNeedAccessment  with(nolock) where remarks like 'asse%')
and clientid not in (select clientid from clientloanproposal  with(nolock) where principaloutstanding='1' and finalreviewdate is null)
order by Branches.BranchID

-----------Husband KYC pendency-------------



select branches.BranchID,branches.BranchName,clp.ClientID,clp.Targetname,
clp.HusbandName,clp.Nominee,Centers.CenterId,Fs.StaffName,case when centers.ReportingDay='1' then 'Monday'
when centers.ReportingDay='2' then 'Tuesday'
when centers.ReportingDay='3' then 'Wednesday'
when centers.ReportingDay='4' then 'Thursday'
when centers.ReportingDay='5' then 'Friday'
when centers.ReportingDay='6' then 'Saturday'

end as 'MeetingDay',clp.ClientRequestedAmount,
cast(clp.proposaldate as date) ProposalDate,clp.ProductCategory,clp.LoanAmountApproved
from clientloanproposal as clp inner join branches on branches.branchid=left(clp.clientid,5)
inner join centers on centers.centerid=left(clp.clientid,8)
inner join fieldstaff as fs on fs.staffid=centers.staffid
where principaloutstanding='1' and clientid like '22%' and loanamountdisbursed='0'
and approvalremarks not like '%Ban%'
--and  NomineeRelation='1'
 and clientid not in (select clientid from Husbandadhar where clientid like '22%' and len(clientid)='14')
 --and clientid in (select clientid from clientloanproposal where principaloutstanding='1'
 --and productid='H8')
 --and clientid in (select clientid from clientloanproposal where finalreviewdate is null)
 --and branches.amid='1254'
order by clientid

--select * from Husbandadhar 
--where Clientid  in 
--(select ClientID from clientloanproposal where LoanAmountDisbursed='0'
-- and ApprovalRemarks not like 'Ban%' and LEFT(ClientID,2)='10')
--and Clientid like '22%'


---------------Pending Proposal for Review----------------------------

select b.BranchID,b.BranchName,B.BranchBC,b.CHID,b.CHName,c.ClientID,clp.Loanproposalid,t.TargetName,t.HusbandName,
cc.CenterID,cast(clp.ProposalDate as date) as ProposalDate,clp.entryby,fs.staffName,
clp.ClientRequestedAmount,cast(clp.FinalReviewDate as date) as Finalreviewdate,clp.productcategory,
case when  LoanAmountBM IS not null 
then 'Not Review Pending by CHIB' else 'Not Review by BM' end as ReviewStatus,
case when c.Loancycle='0' and c.URNID=c.URNNumber and c.Amgrtdate IS not null
--and c.clientid in (select clientid from totalcreditneedsassessment with(nolock)
-- where remarks like 'worth%' and loanproposalid is null) 
then 'NEW CLIENT'
when c.Loancycle='0' and c.URNID=c.URNNumber and c.Amgrtdate IS null
--and c.clientid in (select clientid from totalcreditneedsassessment with(nolock)
-- where remarks like 'worth%' and loanproposalid is null) 
then 'NEW CLIENT'
 else 'OLD CLIENT' end as ClientTYPE,clp.ApprovalRemarks,t.status,clp.productcategory
from ClientLoanProposal  as clp with(nolock) inner join clients as c on 
clp.ClientID=c.ClientID
inner join targets as t on t.TargetID=c.TargetID
inner join Branches as b on b.BranchID=t.BranchID
inner join centers as cc on t.CenterID=cc.centerid
inner join fieldstaff as fs on fs.staffid=clp.entryby
where  clp.ClientID like '14%' and PrincipalOutstanding='1' 
and LoanDisbursementDate is null and FinalReviewDate is null 
--and left(c.clientid,5) in (select branchid from branches where branchbc like '%BC%')
and c.DropOutStatus='0' 
--and clp.productid in ('O0','O1')
order by B.Branchid,clp.clientid

--SIDBI Proposal Pendency report
select b.BranchID,b.BranchName,B.BranchBC,b.CHID,b.CHName,c.ClientID,clp.Loanproposalid,Clp.LoanProposalID,t.TargetName,t.HusbandName,
cc.CenterID,cast(clp.ProposalDate as date) as ProposalDate,clp.entryby,fs.staffName,
clp.ClientRequestedAmount,cast(clp.FinalReviewDate as date) as Finalreviewdate,clp.productcategory,
case when  LoanAmountBM IS not null 
then 'Not Review Pending by CHIB' else 'Not Review by BM' end as ReviewStatus,
case when c.Loancycle='0' and c.URNID=c.URNNumber and c.Amgrtdate IS not null
--and c.clientid in (select clientid from totalcreditneedsassessment with(nolock)
-- where remarks like 'worth%' and loanproposalid is null) 
then 'NEW CLIENT'
when c.Loancycle='0' and c.URNID=c.URNNumber and c.Amgrtdate IS null
--and c.clientid in (select clientid from totalcreditneedsassessment with(nolock)
-- where remarks like 'worth%' and loanproposalid is null) 
then 'NEW CLIENT'
 else 'OLD CLIENT' end as ClientTYPE,clp.ApprovalRemarks,t.status,clp.productcategory
from ClientLoanProposal  as clp with(nolock) inner join clients as c on 
clp.ClientID=c.ClientID
inner join targets as t on t.TargetID=c.TargetID
inner join Branches as b on b.BranchID=t.BranchID
inner join centers as cc on t.CenterID=cc.centerid
inner join fieldstaff as fs on fs.staffid=clp.entryby
where  clp.ClientID like '21%' and PrincipalOutstanding='1' 
and LoanDisbursementDate is null and FinalReviewDate is null 
--and left(c.clientid,5) in (select branchid from branches where branchbc like '%BC%')
and c.DropOutStatus='0' 
and clp.productid in ('W6')
order by B.Branchid,clp.clientid
---------NotDigitizedICICI-----------


select LEFT(ClientID,5) as Branchid,ClientID,LoanProposalid,Targetname,Targetage,Husbandname,ProposalDate,LoanDescription,ClientRequestedAmount,LoanAmountApproved,NumberOfInstallments,
FinalReviewDate,ProductCategory,ProductID,Case When CC.ReportingDay=1 Then 'Monday'
	 When CC.ReportingDay=2 Then 'Tuesday'
	 When CC.ReportingDay=3 Then 'Wednesday'
	 When CC.ReportingDay=4 Then 'Thursday'
	 When CC.ReportingDay=5 Then 'Friday'
	 When CC.ReportingDay=6 Then 'Saturday' End as MeetingDay,cc.StaffID,f.StaffName from ClientLoanProposal
	 inner join Centers as cc on LEFT(ClientLoanProposal.ClientID,8)=cc.CenterID
	 inner join FieldStaff as f on cc.StaffID=f.StaffID where LoanDisbursementDate is null and ApprovalRemarks not like'%Ban%'
 and PrincipalOutstanding=1 and ProductID in(select ProductID from Products where type like'%ICICI%') and clientid like'22%'
 and loanproposalid not in(select LoanProposalID from ICICIReview)
order by ProposalDate

--------------NotDigitizedidbi--------


select LEFT(ClientID,5) as Branchid,ClientID,LoanProposalid,Targetname,Targetage,Husbandname,ProposalDate,LoanDescription,ClientRequestedAmount,LoanAmountApproved,NumberOfInstallments,
FinalReviewDate,ProductCategory,ProductID,Case When CC.ReportingDay=1 Then 'Monday'
	 When CC.ReportingDay=2 Then 'Tuesday'
	 When CC.ReportingDay=3 Then 'Wednesday'
	 When CC.ReportingDay=4 Then 'Thursday'
	 When CC.ReportingDay=5 Then 'Friday'
	 When CC.ReportingDay=6 Then 'Saturday' End as MeetingDay,cc.StaffID,f.StaffName from ClientLoanProposal
	 inner join Centers as cc on LEFT(ClientLoanProposal.ClientID,8)=cc.CenterID
	 inner join FieldStaff as f on cc.StaffID=f.StaffID where LoanDisbursementDate is null and ApprovalRemarks not like'%Ban%'
 and PrincipalOutstanding=1 and ProductID in(select ProductID from Products where type like'%BC IDBI%') and clientid like'22%'
 and loanproposalid not in(select LoanProposalID from IDBIReview)
order by ProposalDate

------------------SIDBI-----------

select LEFT(ClientID,5) as Branchid,ClientID,LoanProposalid,Targetname,Targetage,Husbandname,ProposalDate,LoanDescription,ClientRequestedAmount,LoanAmountApproved,NumberOfInstallments,
FinalReviewDate,ProductCategory,ProductID,Case When CC.ReportingDay=1 Then 'Monday'
	 When CC.ReportingDay=2 Then 'Tuesday'
	 When CC.ReportingDay=3 Then 'Wednesday'
	 When CC.ReportingDay=4 Then 'Thursday'
	 When CC.ReportingDay=5 Then 'Friday'
	 When CC.ReportingDay=6 Then 'Saturday' End as MeetingDay,cc.StaffID,f.StaffName from ClientLoanProposal
	 inner join Centers as cc on LEFT(ClientLoanProposal.ClientID,8)=cc.CenterID
	 inner join FieldStaff as f on cc.StaffID=f.StaffID where LoanDisbursementDate is null and ApprovalRemarks not like'%Ban%'
 and PrincipalOutstanding=1 and ProductID in(select ProductID from Products where type like'%SIDBI%') and clientid like'22%'
 and loanproposalid not in(select LoanProposalID from SIDBIReview)
order by ProposalDate

----------UPI Pending Proposals-----------


Declare @id varchar(2)
Set @id ='22'

if object_id(N'tempdb..#upi', N'U') is not null 
begin
drop table #upi
end
               
SELECT clientid,replace(clientid,':','')as clientidupi INTO #upi
FROM Clientairtelupi with(nolock) where left(clientid,2)=@id


if object_id(N'tempdb..#clp', N'U') is not null 
begin
drop table #clp
end
               
SELECT clientid,replace(clientid,':','')as clientid1,TargetName,ClientRequestedAmount,FinalReviewDate INTO #clp
FROM  ClientLoanProposal where principaloutstanding ='1' 
and clientrequestedamount>='70000' and left(clientid,2) =@id
and finalreviewdate is not null and loandisbursementdate is null

select Left(clientid,5)as BranchID,
(select branchname from branches where branchid=left(clientid,5))as BranchName,
ClientID,TargetName,ClientRequestedAmount,FinalReviewDate from #clp where clientid1 not in(select clientidupi from #upi)
order by clientid

----------Wrong NEFT entry------------

select B.BranchID,B.BranchName,ClientID,TargetName,LoanamountApproved,FinalReviewDate,ProductCategory,
ClientLoanproposal.BankName,BankBranchName,AccountNumber,ClientLoanproposal.IFSCCode
from clientloanproposal Inner Join branches as b on b.branchid=left(Clientid,5)
where PrincipalOutstanding='1' 
and Approvalremarks not like 'ban%' and Loanamountdisbursed='0'
and clientloanproposal.bankname in ('Allahabad Bank',
'Syndicate Bank',
'Dena Bank',
'Andhra Bank',
'Oriental Bank of Commerce',
'Corporation Bank',
'Vijya Bank') and left(Clientid,2)='22'
--and loanproposalid in (select Loanproposalid from cds2 where  clientloan1amtduedisbursed=0)
Order by B.BranchID,B.BranchName,ClientID

---------Wrong Husband KYC------------------

select b.branchid,b.branchname,c.clientid,c.adharid as ClientAadharNo,c.clientname,c.co as HusbandName
from clientadhar as c inner join branches as b on left(c.Centerid,5)=b.branchid
where adharid in (select adharid from husbandadhar)
and Centerid like '22%'
order by clientid

------------daily Adding and Proposal detail------------

select BranchID,Staffid,StaffName,
(select count(clientid) from clients
inner join targets on targets.TargetID=Clients.TargetID where DropOutStatus=0 and cast(AMGRTDate as date)='2022-01-14' and FieldStaff.StaffID=targets.StaffID) as 'NoOfAddings',
(select COUNT(LoanProposalID) from ClientLoanProposal
where LoanDisbursementDate is null 
 and PrincipalOutstanding=1  and FieldStaff.StaffID=EntryBy and CAST(ProposalDate as date) = '2022-01-14') as 'NoOfProposals',
 (select ISNULL(sum(clientrequestedamount),0)  from ClientLoanProposal
where LoanDisbursementDate is null 
 and PrincipalOutstanding=1  and FieldStaff.StaffID=EntryBy and CAST(ProposalDate as date) = '2022-01-14') as 'Amount'
 from fieldstaff where exitdate is null and Designation in('12','13','14','15','46','47') and StaffName not like 'Dummy%' and branchid like'22%' order by BranchID

 ----------------------Branch wise Proposal detail---------

 select BranchName,LEFT(ClientID,5) as Branchid,count(Loanproposalid) NoOfProposals,sum(ClientRequestedAmount) Amt from ClientLoanProposal
	 inner join branches as cc on LEFT(ClientLoanProposal.ClientID,5)=cc.Branchid
where LoanDisbursementDate is null and cast(ProposalDate as date)='2021-11-25'
 and PrincipalOutstanding=1 and clientid like'31%'
 group by LEFT(ClientID,5),BranchName
order by LEFT(ClientID,5)

--------BC Due not show-----------



select LEFT(d2.clientid,5) BranchId,d2.ClientId,d3.ClientName,clp.ProposalDate,LoanAmountApproved,clp.LoanDisbursementDate,d2.ClientLoan1ProductName,clp.ProductId from cds2 d2
inner join cds3 d3 on d2.clientid=d3.clientid
inner join clientloanproposal clp on clp.loanproposalid=d2.loanproposalid where clientloan1productname in('Invalid Flexi DurationWeek',
'Flexi Outstanding + Approved Amount > 30000',
'Flexi due + IGL Outstanding >100000 in greater than 2nd loan cycle',
'Flexi Outstanding + Approved Amount > 30000',
'Invalid Flexi DurationWeek',
'Information incompleted for digital disbursement,',
'Cancelled by ROE/ICT or Saving Department',
'Not allowed to Disbursed in mentioned bank.',
'Prev. IGL/BC Loan is already running.',
'Invalid Flexi DurationWeek',
'Prev. IGL/BC Loan is already running.',
'Information incompleted for digital disbursement,',
'Invalid Flexi DurationWeek',
'Flexi due + IGL Outstanding >100000 in greater than 2nd loan cycle',
'Information incompleted for digital disbursement,',
'Client not in Cashpor..AtNeftClientBankDetail',
'Invalid Flexi DurationWeek',
'Cancelled by ROE/ICT or Saving Department',
'Invalid Flexi DurationWeek',
'Not allowed to Disbursed in this IFSC Code [UBIN0RRBKGS] bank.',
'Information incompleted for digital disbursement,',
'Cancelled by ROE/ICT or Saving Department',
'Invalid Flexi DurationWeek',
'Client aadhar exists in Husband aadhar',
'Invalid Flexi DurationWeek',
'Flexi Outstanding + Approved Amount > 30000',
'CreditNeedsAssessment not done',
'Record Not In Client Aadhar',
'Client not in Cashpor..AtNeftClientBankDetail',
'Client Outstanding is greater than 100000.',
'Information incompleted for digital disbursement,',
'Not allowed to Disbursed in this IFSC Code [UBIN0RRBKGS] bank.',
'Information incompleted for digital disbursement,',
'UPI detail not found.',
'Hold by Center Monitoring') and d2.clientid like'22%' 