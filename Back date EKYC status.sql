select (select UPPER(CHName) from Branches 
where Branchid=left(k.centerid,5)) ChibName,
left(k.centerid,5) BranchID,
(select UPPER(Branchname) from Branches where Branchid=left(k.centerid,5)) BranchName,
clientid, UPPER(ClientPrimaryNameasperkyc) as ClientName,
(case when ClientPrimaryKyctype='Aadhar' then ('********'+right(ClientPrimaryKycmember,4)) else ClientPrimaryKycmember end)KYCNO, 
--ClientPrimaryKycmember as Client_KYC_ID,
CAST(k.Datestamp as Date) as Datestamp,
F.StaffID,UPPER(f.Staffname) as Staffname,
(select CBRRemark from CCRMFISUMMARY where CustRefField=k.TrnLoanID) as Cbrremark,
(case when k.TrnLoanID in(select CustRefField from CCRMFISUMMARY (nolock) where cbrremark like '%BAN%') then 'BAN' else 'NOT_BAN' end )
BANStatus,
(case when k.EnrollTrnLoanID in(select trnloanid from clientloanproposal (nolock) ) then 'ProposalEntrybyCM' else 'Proposal_not_EntrybyCM' end )
Proposal_Status,
(case when k.EnrollTrnLoanID in(select trnloanid from clientloanproposal (nolock) where finalReviewdate is not null ) then 'Proposal_Reviewby_BM'
else 'Proposal_NOT_Reviewby_BM' end )Proposal_Review_Status
from kyc k (nolock)
inner join centers c (nolock) on c.centerid=k.centerid 
 inner join fieldstaff f (nolock) on f.Staffid=c.Staffid
where k.centerid like '05%' and k.clientprimarymobilenumber='8888888888' and 
--CAST(k.Datestamp as Date)=CAST(getdate()-1 as date)
CAST(k.Datestamp as Date) = '2023-12-13'
--CAST(k.Datestamp as Date) between '2023-12-09' and '2023-12-11'
order by ChibName desc,Branchid
