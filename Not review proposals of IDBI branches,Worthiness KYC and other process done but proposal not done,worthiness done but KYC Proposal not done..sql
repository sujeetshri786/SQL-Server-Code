------------Not review proposals of IDBI branches-------------
select LEFT(clp.ClientID,5) as Branchid,clp.ClientID,Targetname,Targetage,Husbandname,ProposalDate,LoanDescription,ClientRequestedAmount,LoanAmountApproved,NumberOfInstallments,
FinalReviewDate,ProductCategory,ProductID,Case When CC.ReportingDay=1 Then 'Monday'
	 When CC.ReportingDay=2 Then 'Tuesday'
	 When CC.ReportingDay=3 Then 'Wednesday'
	 When CC.ReportingDay=4 Then 'Thursday'
	 When CC.ReportingDay=5 Then 'Friday'
	 When CC.ReportingDay=6 Then 'Saturday' End as MeetingDay,cc.StaffID,f.StaffName from ClientLoanProposal clp
	 inner join Centers as cc on LEFT(clp.ClientID,8)=cc.CenterID
	 inner join FieldStaff as f on cc.StaffID=f.StaffID
	 inner join Branches as b on LEFT(clp.ClientID,5)=B.branchid where LoanDisbursementDate is null and FinalReviewDate is null
 and PrincipalOutstanding=1 and ProductID in(select ProductID from Products where type like'%Own%') and clp.clientid like'14%' and b.branchbc ='BC IDBI'
 --and cast(ProposalDate as date) between '2021-03-13' and '2021-03-14'
order by LEFT(clp.ClientID,5)

-------------------Worthiness KYC and other process done but proposal not done----------

select b.BranchName,B.BranchId,cc.ClientId,t.TargetName,c.DateStamp,cc.JoinDate,case when  cc.joindate>'2022-05-01' then 'NewClient'
else 'OldClient' end as ClientType from CreditWorthinesstrn c with(nolock)
left join kyc k with(nolock) on c.trnloanid=k.trnloanid
inner join Clients cc with(nolock) on c.clientid=cc.clientid
inner join targets t with(nolock) on cc.targetid=t.targetid
inner join branches b with(nolock) on t.branchid=b.branchid where c.ClientID like'14%' and c.Clientid not in
(select clientid from ClientLoanProposal where (loandisbursementdate is null or loandisbursementdate>='2022-05-01'))   
and b.BranchBC in('BC IDBI')
order by b.BranchId

------------- worthiness done but KYC Proposal not done-----------

select b.BranchName,B.BranchId,cc.ClientId,t.TargetName,c.DateStamp,cc.JoinDate,case when  cc.joindate>'2022-05-01' then 'NewClient'
else 'OldClient' end as ClientType,c.ProductCategory from CreditWorthinesstrn c with(nolock)
inner join Clients cc with(nolock) on c.clientid=cc.clientid
inner join targets t with(nolock) on cc.targetid=t.targetid
inner join branches b with(nolock) on t.branchid=b.branchid where c.ClientID like'14%' and c.Clientid not in
(select clientid from ClientLoanProposal where (loandisbursementdate is null or loandisbursementdate>='2022-05-01'))   
and b.BranchBC in('BC IDBI') and productcategory like'%IGL%' and c.trnloanid not in(select trnloanid from kyc) and joindate<'2022-03-31'
order by b.BranchId


------------- worthiness done but KYC Proposal not done-----------
select b.BranchName,B.BranchId,cc.ClientId,t.TargetName,c.DateStamp,cc.JoinDate,c.ProductCategory from CreditWorthinesstrn c with(nolock)
inner join Clients cc with(nolock) on c.clientid=cc.clientid
inner join targets t with(nolock) on cc.targetid=t.targetid
inner join branches b with(nolock) on t.branchid=b.branchid where c.ClientID like'10%' and c.Clientid not in
(select clientid from ClientLoanProposal where (loandisbursementdate is null or loandisbursementdate>='2022-05-01'))   
and (c.trnloanid not in(select trnloanid from kyc) or c.trnloanid not in(select EnrollTrnLoanID from kyc))
order by b.BranchId
