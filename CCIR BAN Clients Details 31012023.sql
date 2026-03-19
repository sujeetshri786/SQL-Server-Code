--CCIR BAN Clients Details 31-01-2023


select Left(ClientId,5) as BranchId, ClientId,ClientPrimaryKycmember,ClientPrimaryNameasperkyc,TrnLoanid,
(select CBRRemark from CCRMFISUMMARY with(nolock) where k.TrnLoanid=CustRefField) as CBRRemark from KYC k with(nolock)
where centerid like'14:02%' and TrnLoanid in(select CustRefField from CCRMFISUMMARY with(nolock) where CBRStatus='2' and dateofissue between '2023-01-16' and '2023-01-31')
and k.datestamp between '2023-01-16' and '2023-01-31' and k.trnloanid not in(select TrnLoanid from CreditNeedAssessmenttrn with(nolock))
and k.ClientID not in(select ClientID from clientloanproposal with(nolock) where Principaloutstanding=1)
order by BranchId