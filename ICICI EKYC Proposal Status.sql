--Appcashpor

Select Zone,DistrictName RegioName,b.BranchID,BranchName,CenterID,CenterName,Clp.ClientiD,Clp.TargetName,Clp.LoanProposalID,
isnull(LoanAmountBM,clp.ClientrequestedAmount),
Case When CBREnquiry in(2,3,10) then 'ProposalBAN'
       When  clp.IFSCCode='0' and clp.AccountNumber='0' then 'NEFTPendingByCM'
       When  clp.IFSCCode<>'0' and clp.AccountNumber<>'0'and clp.BMIFSCCode='0' and clp.BmAccountNumber='0' then 'NEFTDoneByCM'
       When LoanAmountApproved>0 and FinalReviewDate is not null and clp.BMIFSCCode='0' and clp.BmAccountNumber='0' 
        and clp.IFSCCode<>'0' and clp.AccountNumber<>'0' then 'ReviewedButNEFTPendingByBM'
       When LoanAmountApproved>0 and FinalReviewDate is not null and clp.BMIFSCCode<>'0' and clp.BmAccountNumber<>'0' then 'NEFTDoneByBM'
       End ProposalStatus,

Case when 
exists (Select ClientID From ekycicici e(nolock) where left(e.clientid,14)=clp.clientid and EnrollmentDate>'2022-07-31' and MemberType='C' and VerifiedDate is null)
and exists (Select ClientID From ekycicici e(nolock) where left(e.clientid,14)=clp.clientid and EnrollmentDate>'2022-07-31' and MemberType='CO'and VerifiedDate is null)
then 'EKYCDone'
when 
exists (Select ClientID From ekycicici e(nolock) where left(e.clientid,14)=clp.clientid and EnrollmentDate>'2022-07-31' and MemberType='C'and KYCMismatch='Approved' and VerifiedDate is not null)
and exists (Select ClientID From ekycicici e(nolock) where left(e.clientid,14)=clp.clientid and EnrollmentDate>'2022-07-31' and MemberType='CO'and KYCMismatch='Approved' and VerifiedDate is not null
and clp.BMIFSCCode='0' and clp.BmAccountNumber='0') then 'EKYCApprovedButNeftPendingByCM/BM'
when 
exists (Select ClientID From ekycicici e(nolock) where left(e.clientid,14)=clp.clientid and EnrollmentDate>'2022-07-31' and MemberType='C'and KYCMismatch<>'Approved' and VerifiedDate is not null)
or exists (Select ClientID From ekycicici e(nolock) where left(e.clientid,14)=clp.clientid and EnrollmentDate>'2022-07-31' and MemberType='CO'and KYCMismatch<>'Approved' and VerifiedDate is not null) then 'EKYCMismatch'

when 
exists (Select ClientID From ekycicici e(nolock) where left(e.clientid,14)=clp.clientid and EnrollmentDate>'2022-07-31' and MemberType='C'and KYCMismatch='Approved' and VerifiedDate is not null)
and exists (Select ClientID From ekycicici e(nolock) where left(e.clientid,14)=clp.clientid and EnrollmentDate>'2022-07-31' and MemberType='CO'and KYCMismatch='Approved' and VerifiedDate is not null)
and LoanAmountApproved>0 and FinalReviewDate is not null and clp.BMIFSCCode<>'0' and clp.BmAccountNumber<>'0' then 'ReadyForPrint'
  
  else 'EKYCNotDone' end EKYCStatus
       
From ClientLoanProposal Clp(Nolock)
inner join Clients c(nolock) on C.CLientid=clp.clientid
inner join branches b (nolock) on b.BranchiD=left(C.Clientid,5)
inner join Centers ct(nolock) on Ct.Centerid=left(C.Clientid,8)
where productID in('I8','I9') and loandisbursementdate is null and left(b.BranchID,2) in ('14')
