--1: PROPOSAL ENTRY REPORT (Cloude) not Change
select A.BranchID,UPPER(A.BranchName) as BranchName,
isnull(sum(b.EKYC),0) EKYC,
isnull(sum(c.BAN),0)as KYC_BAN,
isnull(sum(a.Proposal_Entryby_CM),0) Proposal_CM,
isnull(sum(a.Amt_Entryby_CM),0) AMT_CM,
isnull(sum(a.Proposal_Reviewby_BM),0) LoanReview_BM,
isnull(sum(a.AMT_Reviewby_BM),0) AmtReviewby_BM,
isnull(sum(SIDBI_Proposal_Entryby_CM),0) SIDBI_Proposal_CM,
isnull(sum(SIDBI_Amt_Entryby_CM),0) SIDBI_AMT_CM,
isnull(sum(SIDBI_Proposal_Reviewby_BM),0) SIDBI_LoanReview_BM,
isnull(sum(SIDBI_AMT_Reviewby_BM),0) SIDBI_AmtReviewby_BM
from 
 (select b.BranchID,b.BranchName, 
isnull(count(loanProposalid),0) as Proposal_Entryby_CM,
isnull(sum(clientRequestedAmount),0) as Amt_Entryby_CM,
isnull(count(case when finalReviewdate is not null then loanProposalid end ),0) Proposal_Reviewby_BM,
isnull(sum(case when finalReviewdate is not null then LoanAmountApproved end ),0) AMT_Reviewby_BM
from  ClientLoanProposal c  (nolock) 
inner join Branches b (nolock) on b.Branchid=left(c.clientid,5)
where left(b.Branchid,2)in('14') 
and proposaldate=cast(getdate()-1 as date)
 and ApprovalRemarks not like '%BAN%'
and ProductCategory like '%BC%' group by b.BranchID,b.BranchName ) a 
left join 
(select left(e.clientid,5) as Branchid,count(distinct(e.clientid))as EKYC from ekycdetail e with (nolock) 
inner join kyc k (nolock) on k.clientid=e.clientid
 where cast(k.datestamp as date)=cast(getdate()-1 as date) and left(k.clientid,2)in('14')
group by left(e.clientid,5) ) b on b.Branchid=a.Branchid left join (
select left(e.clientid,5) as Branchid,count(distinct(e.clientid))as BAN
       from ekycdetail e with (nolock) inner join kyc k (nolock) on k.clientid=e.clientid
       inner join CCRMFISUMMARY  c with (nolock) on c.CustRefField=k.trnloanid
       where cast(k.datestamp as date)=cast(getdate()-1 as date) and left(k.clientid,2)in('14') and c.cbrremark like '%BAN%'
       group by left(e.clientid,5)
) c on c.Branchid=A.Branchid left join

(select b.BranchID,
isnull(count(loanProposalid),0) as SIDBI_Proposal_Entryby_CM,isnull(sum(clientRequestedAmount),0) as SIDBI_Amt_Entryby_CM,
isnull(count(case when finalReviewdate is not null then loanProposalid end ),0) SIDBI_Proposal_Reviewby_BM,
isnull(sum(case when finalReviewdate is not null then LoanAmountApproved end ),0) SIDBI_AMT_Reviewby_BM
from  ClientLoanProposal c  (nolock) inner join Branches b (nolock) on b.Branchid=left(c.clientid,5)
where left(b.Branchid,2)in('14') 
and proposaldate=cast(getdate()-1 as date) 
and ApprovalRemarks not like '%BAN%'
and ProductCategory like '%SIDBI%'
group by b.BranchID ) d on d.BranchID=a.BranchID group by a.BranchID,a.BranchName order by a.BranchID,a.BranchName

--2-----LOAN SANCTION BY BANK BUT PREVIOUS LOAN NOT SETTLE-(LOCAL) not Change

--with temp as(						
						
--Select DistrictName as RegionName,B.BranchID,b.BranchName,StaffID,StaffName ,ExternalLoanNo LoanID,producTID,    						
--RecommendedLoan SanctionAmt,SanctionDate ,ExternalCustomerID ClientID,ClientName,HusbandName    						
--,case when clientloan1balance=ClientLoan1PrincipalCollected then '0' else clientloan1balance end PrincipalBalance     						
--,case when clientloan1balance=ClientLoan1PrincipalCollected then 'Settled' else 'NotSettled' end SettledStatus 						
--,ActualMeetingDate MeetingDate,FORMAT(ActualMeetingDate, 'dddd') as Meetingday 			
--from LoanFundReleased l(nolock)   						
--inner join Prevcds2 p(nolock) on p.ClientID=l.ExternalCustomerID     						
--inner join products pd (nolock) on pd.productid=substring(ClientLoan1ID,16,2)     						
--inner join PrevCDS1 pc(nolock) on pc.groupid=p.GroupID 						
--inner join PrevCDS3 pc1(nolock) on pc1.ClientID=p.ClientID    						
--inner join branches b(nolock) on b.Branchid=pc.branchid       						
--where sanctiondate>'2022-12-19' and sanctiondate< cast(getdate() as date) and p.clientloan1balance>0       						
--and RecommendedLoan<>clientloan1balance and Loan_Category=0 						
--and Exists(Select LoanProposalID from clientloanproposal clp(Nolock) inner join products p(nolock)on P.ProductID=clp.ProductID						
--where PrincipalOutstanding=1 and LoanDisbursementDate is null and Loan_Category='0' and clp.LoanProposalID=l.ExternalLoanNo) 						
----and p.ClientID='25:02:89:01:08'						
--) Select t.*,Disbursementdate from temp t(nolock) inner join CLientLoanSubscription ps(nolock )						
--on  left(ps.clientloanid,14)=t.ClientID and DisbursementDate<SanctionDate						
--and Principaloutstanding>0  						
-- inner join products pd (nolock) on pd.productid=substring(ClientLoanID,16,2)     and Loan_Category=0						
--order by t.clientid						

-----by yashpal sir
select left(c.ClientLoanID,5) Branchid,(select Branchname from Branches where Branchid= left(c.ClientLoanID,5) ) Branchname,c.clientloanid,Targetname,husbandname,
cn.Staffid,(select Staffname from fieldstaff where Staffid=cn.StaffID ) CM_Name,c.PrincipalOutstanding,cls.productcategory,
case when cn.ReportingDay=1 then 'Monday'
  when cn.ReportingDay=2 then 'Tuesday'
  when cn.ReportingDay=3 then 'Wednesday'
  when cn.ReportingDay=4 then 'Thursday'
  when cn.ReportingDay=5 then 'Friday'
  when cn.ReportingDay=6 then 'Saturday' end as 'Meetingday'
from ClientLoanSubscription c (nolock) 
inner join clientloanproposal cls (nolock) on c.loanproposalid=cls.LoanProposalID
inner join centers cn (nolock) on cn.centerid=left(cls.clientid,8)
where c.ActualPaidUpDate is null and c.PrincipalOutstanding>0 and cn.ReportingDay=6
and cls.clientid in(select Clientid from clientloanproposal cf (nolock) inner join products p (nolock) on cf.productid=p.productid
where loandisbursementdate is null and Loan_Category=0  and
  loanproposalid in(select ExternalLoanNo from LoanFundReleased (nolock) ))
  order by c.clientloanid


--3-----------Ekyc Detail Back Date (appcashpor)

select (select UPPER(CHName) from Branches 
where Branchid=left(k.centerid,5)) ChibName,
left(k.centerid,5) BranchID,
(select UPPER(Branchname) from Branches where Branchid=left(k.centerid,5)) BranchName,
clientid, UPPER(ClientPrimaryNameasperkyc) as ClientName, 
ClientPrimaryKycmember as Client_KYC_ID,
CAST(k.Datestamp as Date) as Datestamp,
F.StaffID,UPPER(f.Staffname) as Staffname,
(case when k.trnloanid in(select CustRefField from CCRMFISUMMARY (nolock) where cbrremark like '%BAN%') then 'BAN' else 'NOT_BAN' end )
BANStatus,
(case when k.trnloanid in(select trnloanid from clientloanproposal (nolock) ) then 'ProposalEntrybyCM' else 'Proposal_not_EntrybyCM' end )
Proposal_Status,
(case when k.trnloanid in(select trnloanid from clientloanproposal (nolock) where finalReviewdate is not null ) then 'Proposal_Reviewby_BM'
 else 'Proposal_NOT_Reviewby_BM' end )Proposal_Review_Status
from kyc k (nolock)
 inner join centers c (nolock) on c.centerid=k.centerid 
 inner join fieldstaff f (nolock) on f.Staffid=c.Staffid
where k.centerid like '05%' and k.clientprimarymobilenumber='9999999999' and 
CAST(k.Datestamp as Date)='2023-05-04'
order by ChibName desc,Branchid
-----------------------------------------------------------------------------------------------------------------------------------------
---4----
 --Staff not disbursed Single loan--  local
 select Branchid,(select Branchname from Branches b where f.Branchid=b.Branchid and branchid like'16%') as Branchname,Staffid,StaffName ,case                                     
When f.Designation='12' Then 'CM'
When f.Designation='13' Then 'CM'
When f.Designation='14' Then 'PCM'
When f.Designation='15' Then 'TCM'
When f.Designation='46' Then 'CTPCM'
When f.Designation='47' Then 'CTTCM'
End As 'Position'
from FieldStaff f (nolock)
where f.Designation in('12','13','14','15','47','46') and exitdate is null and StaffName not like 'Dummy%' and Branchid like '16%'
 and staffid not in (select StaffID from ClientLoanSubscription (nolock) where ActualDisbursementDate>='2023-05-04' and ClientLoanID like '16%')

 --5----Staff not entry single proposal
 select Branchid,(select Branchname from Branches b where f.Branchid=b.Branchid and branchid like'16%') as Branchname,Staffid,StaffName ,
case                                     
When f.Designation='12' Then 'CM'
When f.Designation='13' Then 'CM'
When f.Designation='14' Then 'PCM'
When f.Designation='15' Then 'TCM'
When f.Designation='46' Then 'CTPCM'
When f.Designation='47' Then 'CTTCM'
End As 'Position'
from FieldStaff f (nolock)
where f.Designation in('12','13','14','15','47','46') and exitdate is null and StaffName not like 'Dummy%' and Branchid like '16%'
and staffid not in (select entryby from clientloanproposal (nolock) where proposaldate>='2023-05-04' and clientid like '16%')
order by BranchID





