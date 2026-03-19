--daily not documentation report local
--main Query			
--------Own IGL Query--------------			
Select row_number() over(partition by Branchid order by BranchJoinDate desc) RowNumber,			
* into #BMRecord from  Fieldstaff dd(nolock) where exitdate is null and StatusAct=1 and Designation=16 			
			
Select Circle,Zone,Regionname,BranchID,BranchName,BMName,BMMobNumber,CMName,CMMobNumber,a.ClientID,a.ClientName,HusbandName,A.LoanProposalID,a.Productname,DueAmount			
,DocumentedAmt,MobileNumber,BCName,a.MeetingDay,CurrentDueDate,ProposalDate,FinalReviewDate,b.Sanctiondate,FirstDueDate,isnull(PrevIGLOutstanding,0) CurrentIGlOutstanding,			
 Address,LoanPurposes,loanCycle			
From(			
select b.circle,b.zone,b.districtname RegionName,b.branchid,b.branchname,f.StaffName CMName,TelePhone CMMobNumber,c3.clientid,c3.clientname,C2.LoanProposalID,			
case when c.ReportingDay=1 Then 'Monday'  when c.ReportingDay=2 Then 'TuesDay'when c.ReportingDay=3 Then 'Wednesday' 			
	 when c.ReportingDay=4 Then 'Thursday'when c.ReportingDay=5 Then 'Friday' else 'Saturday' End MeetingDay,		
	 C1.MeetingDate CurrentDueDate,c2.clientloan1productname productname,ClientLoan1AmtDueDisbursed DueAmount ,		
clientloan1amountdisbursed DocumentedAmt,clp.MobileNumber clpMobileNumber,			
Case When p.BCIDNO=0 then 'Own' When p.BCIDNO=1 then 'IndusInd' When p.BCIDNO=2 then 'ICICI' When P.BCIDNO=3 then 'IDBI'			
     When p.BCIDNO=4 then 'Kotak' else 'SIDBI' End BCName ,clp.FinalReviewDate ,Proposaldate,clp.HusbandName,			
	 Clp.LoanDescription LoanPurposes,Cs.loanCycle,K.ClientPrimaryAddressasperKyc Address		
from prevcds2 c2 (nolock)			
inner join prevcds1 c1 (nolock) on c1.GroupID=c2.GroupID			
inner join prevcds3 c3 (nolock) on c3.ClientID=c2.ClientID			
inner join clientloanproposal clp (nolock) on clp.loanproposalid=c2.loanproposalid			
inner join Products p (nolock) on p.productid=substring(clientloan1id,16,2)			
inner join branches b (nolock) on b.branchid=left(c3.clientid,5)			
inner join centers c (nolock) on c.centerid=c1.centerid			
inner join Clients cs(nolock) on Cs.ClientID=c2.ClientID			
inner join kyc k(nolock) on isnull(K.enrolltrnloanid,k.Trnloanid)=Clp.trnloanid			
inner join Fieldstaff f(nolock) on f.StaffID=C.StaffID			
where clientloan1amtduedisbursed>0 and ClientLoan1AmountDisbursed=0 and Loan_Category in(0) and bcidno=0			
) a			
left join			
(			
Select ExternalLoanNo LoanProposalID,Sanctiondate  from LoanFundReleased (nolock)			
Union All			
Select LoanProposalID,Sanctiondate from BCLoanFundReleased lf(nolock)			
Union All			
Select LoanProposalID,Sanctiondate from BCLoanFundReleasedICICI lf(nolock)			
Union All			
Select LoanProposalID,Sanctiondate from BCLoanFundReleasedSIDBI lf(nolock)			
)b on a.loanProposalID=b.LoanProposalID			
left join			
(			
Select Distinct dd.LoanProposalID			
, Case when dd.MobileNumber in('888888888','999999999') then vp.Mobno else dd.MobileNumber end MobileNumber			
  from Prevcds2 pc(nolock)			
inner join ClientLoanProposal dd(nolock) on dd.LoanProposalID=pc.LoanProposalID			
left join Cashpor..verifiedotp vp(nolock) on vp.clientid=dd.clientid and otp<>'0000'			
)d on d.LoanProposalID=A.LoanProposalID			
left join 			
(select ps.LoanProposalID LoanProposalID,s.PrincipalOutstanding PrevIGLOutstanding from 			
 ClientLoanSubscription s(nolock) inner join clientloanproposal p(nolock) on s.LoanProposalID=p.LoanProposalID			
inner join ProductS Pd(nolock) on P.ProductID=pd.ProductID			
inner join Prevcds2 ps(nolock) on ps.ClientID=p.ClientID and ps.ClientLoan1AmtDueDisbursed>0 and ps.ClientLoan1AmountDisbursed=0			
where s.principaloutstanding>0 and pd.Loan_category=0			
)e on e.loanproposalID=a.LoanProposalID			
left join			
(			
Select pc.LoanProposalID,CLientLoan1ID,min(DisbursementDate) FirstDueDate from Prevcds2 pc(nolock)			
inner join Siwan..DailyDisbursementDetail dd(nolock) on dd.ClientLoanID=pc.ClientLoan1ID			
group by pc.LoanProposalID,CLientLoan1ID			
)C on c.LoanProposalID=A.LoanProposalID			
left join			
(			
Select  pc.LoanProposalID,DD.StaffName BMName,DD.TelePhone BMMobNumber from Prevcds2 pc(nolock)			
inner join Fieldstaff dd(nolock) on dd.BranchID=left(pc.ClientLoan1ID,5)			
inner join #bmRecord t(nolock) on t.staffid=dd.staffid			
where dd.exitdate is null and dd.StatusAct=1 and dd.Designation=16 and clientloan1amtduedisbursed>0 			
and ClientLoan1AmountDisbursed=0 and t.rownumber=1			
)F on f.LoanProposalID=A.LoanProposalID			
drop table #BMRecord			


--------Own IGL Query--------------			
--------BC IGL Query---------			
Select row_number() over(partition by Branchid order by BranchJoinDate desc) RowNumber,			
* into #BMRecord from  Fieldstaff dd(nolock) where exitdate is null and StatusAct=1 and Designation=16 			
			
Select Circle,Zone,Regionname,BranchID,BranchName,BMName,BMMobNumber,CMName,CMMobNumber,a.ClientID,a.ClientName,HusbandName,A.LoanProposalID,a.Productname,DueAmount			
,DocumentedAmt,MobileNumber,BCName,a.MeetingDay,CurrentDueDate,ProposalDate,FinalReviewDate,b.Sanctiondate,FirstDueDate,isnull(PrevIGLOutstanding,0) CurrentIGlOutstanding,			
 Address,LoanPurposes,loanCycle			
From(			
select b.circle,b.zone,b.districtname RegionName,b.branchid,b.branchname,f.StaffName CMName,TelePhone CMMobNumber,c3.clientid,c3.clientname,C2.LoanProposalID,			
case when c.ReportingDay=1 Then 'Monday'  when c.ReportingDay=2 Then 'TuesDay'when c.ReportingDay=3 Then 'Wednesday' 			
	 when c.ReportingDay=4 Then 'Thursday'when c.ReportingDay=5 Then 'Friday' else 'Saturday' End MeetingDay,		
	 C1.MeetingDate CurrentDueDate,c2.clientloan1productname productname,ClientLoan1AmtDueDisbursed DueAmount ,		
clientloan1amountdisbursed DocumentedAmt,clp.MobileNumber clpMobileNumber,			
Case When p.BCIDNO=0 then 'Own' When p.BCIDNO=1 then 'IndusInd' When p.BCIDNO=2 then 'ICICI' When P.BCIDNO=3 then 'IDBI'			
     When p.BCIDNO=4 then 'Kotak' else 'SIDBI' End BCName ,clp.FinalReviewDate ,Proposaldate,clp.HusbandName,			
	 Clp.LoanDescription LoanPurposes,Cs.loanCycle,K.ClientPrimaryAddressasperKyc Address		
from prevcds2 c2 (nolock)			
inner join prevcds1 c1 (nolock) on c1.GroupID=c2.GroupID			
inner join prevcds3 c3 (nolock) on c3.ClientID=c2.ClientID			
inner join clientloanproposal clp (nolock) on clp.loanproposalid=c2.loanproposalid			
inner join Products p (nolock) on p.productid=substring(clientloan1id,16,2)			
inner join branches b (nolock) on b.branchid=left(c3.clientid,5)			
inner join centers c (nolock) on c.centerid=c1.centerid			
inner join Clients cs(nolock) on Cs.ClientID=c2.ClientID			
inner join kyc k(nolock) on isnull(K.enrolltrnloanid,k.Trnloanid)=Clp.trnloanid			
inner join Fieldstaff f(nolock) on f.StaffID=C.StaffID			
where clientloan1amtduedisbursed>0 and ClientLoan1AmountDisbursed=0 and Loan_Category in(0) and bcidno<>0			
) a			
left join			
(			
Select ExternalLoanNo LoanProposalID,Sanctiondate  from LoanFundReleased (nolock)			
Union All			
Select LoanProposalID,Sanctiondate from BCLoanFundReleased lf(nolock)			
Union All			
Select LoanProposalID,Sanctiondate from BCLoanFundReleasedICICI lf(nolock)			
Union All			
Select LoanProposalID,Sanctiondate from BCLoanFundReleasedSIDBI lf(nolock)			
)b on a.loanProposalID=b.LoanProposalID			
left join			
(			
Select Distinct dd.LoanProposalID			
, Case when dd.MobileNumber in('888888888','999999999') then vp.Mobno else dd.MobileNumber end MobileNumber			
  from Prevcds2 pc(nolock)			
inner join ClientLoanProposal dd(nolock) on dd.LoanProposalID=pc.LoanProposalID			
left join Cashpor..verifiedotp vp(nolock) on vp.clientid=dd.clientid and otp<>'0000'			
)d on d.LoanProposalID=A.LoanProposalID			
left join 			
(select ps.LoanProposalID LoanProposalID,s.PrincipalOutstanding PrevIGLOutstanding from 			
 ClientLoanSubscription s(nolock) inner join clientloanproposal p(nolock) on s.LoanProposalID=p.LoanProposalID			
inner join ProductS Pd(nolock) on P.ProductID=pd.ProductID			
inner join Prevcds2 ps(nolock) on ps.ClientID=p.ClientID and ps.ClientLoan1AmtDueDisbursed>0 and ps.ClientLoan1AmountDisbursed=0			
where s.principaloutstanding>0 and pd.Loan_category=0			
)e on e.loanproposalID=a.LoanProposalID			
left join			
(			
Select pc.LoanProposalID,CLientLoan1ID,min(DisbursementDate) FirstDueDate from Prevcds2 pc(nolock)			
inner join Siwan..DailyDisbursementDetail dd(nolock) on dd.ClientLoanID=pc.ClientLoan1ID			
group by pc.LoanProposalID,CLientLoan1ID			
)C on c.LoanProposalID=A.LoanProposalID			
left join			
(			
Select  pc.LoanProposalID,DD.StaffName BMName,DD.TelePhone BMMobNumber from Prevcds2 pc(nolock)			
inner join Fieldstaff dd(nolock) on dd.BranchID=left(pc.ClientLoan1ID,5)			
inner join #bmRecord t(nolock) on t.staffid=dd.staffid			
where dd.exitdate is null and dd.StatusAct=1 and dd.Designation=16 and clientloan1amtduedisbursed>0 			
and ClientLoan1AmountDisbursed=0 and t.rownumber=1			
)F on f.LoanProposalID=A.LoanProposalID			
drop table #BMRecord	

--------BC IGL Query---------			
--------Own Flexi Query---------			
Select row_number() over(partition by Branchid order by BranchJoinDate desc) RowNumber,			
* into #BMRecord from  Fieldstaff dd(nolock) where exitdate is null and StatusAct=1 and Designation=16 			
			
Select Circle,Zone,Regionname,BranchID,BranchName,BMName,BMMobNumber,CMName,CMMobNumber,a.ClientID,a.ClientName,HusbandName,A.LoanProposalID,a.Productname,DueAmount			
,DocumentedAmt,MobileNumber,BCName,a.MeetingDay,CurrentDueDate,ProposalDate,FinalReviewDate,b.Sanctiondate,FirstDueDate,isnull(PrevIGLOutstanding,0) CurrentIGlOutstanding,			
 Address,LoanPurposes,loanCycle			
From(			
select b.circle,b.zone,b.districtname RegionName,b.branchid,b.branchname,f.StaffName CMName,TelePhone CMMobNumber,c3.clientid,c3.clientname,C2.LoanProposalID,			
case when c.ReportingDay=1 Then 'Monday'  when c.ReportingDay=2 Then 'TuesDay'when c.ReportingDay=3 Then 'Wednesday' 			
	 when c.ReportingDay=4 Then 'Thursday'when c.ReportingDay=5 Then 'Friday' else 'Saturday' End MeetingDay,		
	 C1.MeetingDate CurrentDueDate,c2.clientloan1productname productname,ClientLoan1AmtDueDisbursed DueAmount ,		
clientloan1amountdisbursed DocumentedAmt,clp.MobileNumber clpMobileNumber,			
Case When p.BCIDNO=0 then 'Own' When p.BCIDNO=1 then 'IndusInd' When p.BCIDNO=2 then 'ICICI' When P.BCIDNO=3 then 'IDBI'			
     When p.BCIDNO=4 then 'Kotak' else 'SIDBI' End BCName ,clp.FinalReviewDate ,Proposaldate,clp.HusbandName,			
	 Clp.LoanDescription LoanPurposes,Cs.loanCycle,K.ClientPrimaryAddressasperKyc Address		
from prevcds2 c2 (nolock)			
inner join prevcds1 c1 (nolock) on c1.GroupID=c2.GroupID			
inner join prevcds3 c3 (nolock) on c3.ClientID=c2.ClientID			
inner join clientloanproposal clp (nolock) on clp.loanproposalid=c2.loanproposalid			
inner join Products p (nolock) on p.productid=substring(clientloan1id,16,2)			
inner join branches b (nolock) on b.branchid=left(c3.clientid,5)			
inner join centers c (nolock) on c.centerid=c1.centerid			
inner join Clients cs(nolock) on Cs.ClientID=c2.ClientID			
inner join kyc k(nolock) on isnull(K.enrolltrnloanid,k.Trnloanid)=Clp.trnloanid			
inner join Fieldstaff f(nolock) on f.StaffID=C.StaffID			
where clientloan1amtduedisbursed>0 and ClientLoan1AmountDisbursed=0 and Loan_Category in(5,7) and bcidno=0			
) a			
left join			
(			
Select ExternalLoanNo LoanProposalID,Sanctiondate  from LoanFundReleased (nolock)			
Union All			
Select LoanProposalID,Sanctiondate from BCLoanFundReleased lf(nolock)			
Union All			
Select LoanProposalID,Sanctiondate from BCLoanFundReleasedICICI lf(nolock)			
Union All			
Select LoanProposalID,Sanctiondate from BCLoanFundReleasedSIDBI lf(nolock)			
)b on a.loanProposalID=b.LoanProposalID			
left join			
(			
Select Distinct dd.LoanProposalID			
, Case when dd.MobileNumber in('888888888','999999999') then vp.Mobno else dd.MobileNumber end MobileNumber			
  from Prevcds2 pc(nolock)			
inner join ClientLoanProposal dd(nolock) on dd.LoanProposalID=pc.LoanProposalID			
left join Cashpor..verifiedotp vp(nolock) on vp.clientid=dd.clientid and otp<>'0000'			
)d on d.LoanProposalID=A.LoanProposalID			
left join 			
(select ps.LoanProposalID LoanProposalID,s.PrincipalOutstanding PrevIGLOutstanding from 			
 ClientLoanSubscription s(nolock) inner join clientloanproposal p(nolock) on s.LoanProposalID=p.LoanProposalID			
inner join ProductS Pd(nolock) on P.ProductID=pd.ProductID			
inner join Prevcds2 ps(nolock) on ps.ClientID=p.ClientID and ps.ClientLoan1AmtDueDisbursed>0 and ps.ClientLoan1AmountDisbursed=0			
where s.principaloutstanding>0 and pd.Loan_category=0			
)e on e.loanproposalID=a.LoanProposalID			
left join			
(			
Select pc.LoanProposalID,CLientLoan1ID,min(DisbursementDate) FirstDueDate from Prevcds2 pc(nolock)			
inner join Siwan..DailyDisbursementDetail dd(nolock) on dd.ClientLoanID=pc.ClientLoan1ID			
group by pc.LoanProposalID,CLientLoan1ID			
)C on c.LoanProposalID=A.LoanProposalID			
left join			
(			
Select  pc.LoanProposalID,DD.StaffName BMName,DD.TelePhone BMMobNumber from Prevcds2 pc(nolock)			
inner join Fieldstaff dd(nolock) on dd.BranchID=left(pc.ClientLoan1ID,5)			
inner join #bmRecord t(nolock) on t.staffid=dd.staffid			
where dd.exitdate is null and dd.StatusAct=1 and dd.Designation=16 and clientloan1amtduedisbursed>0 			
and ClientLoan1AmountDisbursed=0 and t.rownumber=1			
)F on f.LoanProposalID=A.LoanProposalID			
drop table #BMRecord	


	--------Own Flexi Query---------			
	--------BC Flexi Query---------			
	Select row_number() over(partition by Branchid order by BranchJoinDate desc) RowNumber,			
	* into #BMRecord from  Fieldstaff dd(nolock) where exitdate is null and StatusAct=1 and Designation=16 			
			
	Select Circle,Zone,Regionname,BranchID,BranchName,BMName,BMMobNumber,CMName,CMMobNumber,a.ClientID,a.ClientName,HusbandName,A.LoanProposalID,a.Productname,DueAmount			
	,DocumentedAmt,MobileNumber,BCName,a.MeetingDay,CurrentDueDate,ProposalDate,FinalReviewDate,b.Sanctiondate,FirstDueDate,isnull(PrevIGLOutstanding,0) CurrentIGlOutstanding,			
	 Address,LoanPurposes,loanCycle			
	From(			
	select b.circle,b.zone,b.districtname RegionName,b.branchid,b.branchname,f.StaffName CMName,TelePhone CMMobNumber,c3.clientid,c3.clientname,C2.LoanProposalID,			
	case when c.ReportingDay=1 Then 'Monday'  when c.ReportingDay=2 Then 'TuesDay'when c.ReportingDay=3 Then 'Wednesday' 			
		 when c.ReportingDay=4 Then 'Thursday'when c.ReportingDay=5 Then 'Friday' else 'Saturday' End MeetingDay,		
		 C1.MeetingDate CurrentDueDate,c2.clientloan1productname productname,ClientLoan1AmtDueDisbursed DueAmount ,		
	clientloan1amountdisbursed DocumentedAmt,clp.MobileNumber clpMobileNumber,			
	Case When p.BCIDNO=0 then 'Own' When p.BCIDNO=1 then 'IndusInd' When p.BCIDNO=2 then 'ICICI' When P.BCIDNO=3 then 'IDBI'			
		 When p.BCIDNO=4 then 'Kotak' else 'SIDBI' End BCName ,clp.FinalReviewDate ,Proposaldate,clp.HusbandName,			
		 Clp.LoanDescription LoanPurposes,Cs.loanCycle,K.ClientPrimaryAddressasperKyc Address		
	from prevcds2 c2 (nolock)			
	inner join prevcds1 c1 (nolock) on c1.GroupID=c2.GroupID			
	inner join prevcds3 c3 (nolock) on c3.ClientID=c2.ClientID			
	inner join clientloanproposal clp (nolock) on clp.loanproposalid=c2.loanproposalid			
	inner join Products p (nolock) on p.productid=substring(clientloan1id,16,2)			
	inner join branches b (nolock) on b.branchid=left(c3.clientid,5)			
	inner join centers c (nolock) on c.centerid=c1.centerid			
	inner join Clients cs(nolock) on Cs.ClientID=c2.ClientID			
	inner join kyc k(nolock) on isnull(K.enrolltrnloanid,k.Trnloanid)=Clp.trnloanid			
	inner join Fieldstaff f(nolock) on f.StaffID=C.StaffID			
	where clientloan1amtduedisbursed>0 and ClientLoan1AmountDisbursed=0 and Loan_Category in(5,7) and bcidno<>0			
	) a			
	left join			
	(			
	Select ExternalLoanNo LoanProposalID,Sanctiondate  from LoanFundReleased (nolock)			
	Union All			
	Select LoanProposalID,Sanctiondate from BCLoanFundReleased lf(nolock)			
	Union All			
	Select LoanProposalID,Sanctiondate from BCLoanFundReleasedICICI lf(nolock)			
	Union All			
	Select LoanProposalID,Sanctiondate from BCLoanFundReleasedSIDBI lf(nolock)			
	)b on a.loanProposalID=b.LoanProposalID			
	left join			
	(			
	Select Distinct dd.LoanProposalID			
	, Case when dd.MobileNumber in('888888888','999999999') then vp.Mobno else dd.MobileNumber end MobileNumber			
	  from Prevcds2 pc(nolock)			
	inner join ClientLoanProposal dd(nolock) on dd.LoanProposalID=pc.LoanProposalID			
	left join Cashpor..verifiedotp vp(nolock) on vp.clientid=dd.clientid and otp<>'0000'			
	)d on d.LoanProposalID=A.LoanProposalID			
	left join 			
	(select ps.LoanProposalID LoanProposalID,s.PrincipalOutstanding PrevIGLOutstanding from 			
	 ClientLoanSubscription s(nolock) inner join clientloanproposal p(nolock) on s.LoanProposalID=p.LoanProposalID			
	inner join ProductS Pd(nolock) on P.ProductID=pd.ProductID			
	inner join Prevcds2 ps(nolock) on ps.ClientID=p.ClientID and ps.ClientLoan1AmtDueDisbursed>0 and ps.ClientLoan1AmountDisbursed=0			
	where s.principaloutstanding>0 and pd.Loan_category=0			
	)e on e.loanproposalID=a.LoanProposalID			
	left join			
	(			
	Select pc.LoanProposalID,CLientLoan1ID,min(DisbursementDate) FirstDueDate from Prevcds2 pc(nolock)			
	inner join Siwan..DailyDisbursementDetail dd(nolock) on dd.ClientLoanID=pc.ClientLoan1ID			
	group by pc.LoanProposalID,CLientLoan1ID			
	)C on c.LoanProposalID=A.LoanProposalID			
	left join			
	(			
	Select  pc.LoanProposalID,DD.StaffName BMName,DD.TelePhone BMMobNumber from Prevcds2 pc(nolock)			
	inner join Fieldstaff dd(nolock) on dd.BranchID=left(pc.ClientLoan1ID,5)			
	inner join #bmRecord t(nolock) on t.staffid=dd.staffid			
	where dd.exitdate is null and dd.StatusAct=1 and dd.Designation=16 and clientloan1amtduedisbursed>0 			
	and ClientLoan1AmountDisbursed=0 and t.rownumber=1			
	)F on f.LoanProposalID=A.LoanProposalID			
	drop table #BMRecord			
