select Left(REFERENCENUMBER,5) as BranchId,REFERENCENUMBER ClientId,ClientPrimaryKycmember,ClientPrimaryNameasperkyc,BorrowerType,RequestAmount,DateofIssue,CBRRemark from KYC k
inner join CCRMFISUMMARY c on k.trnloanid=CustRefField where c.REFERENCENUMBER like'10%' and CBRRemark like'%Ban%' and dateofissue>='2022-10-01'
and k.trnloanid not in(select trnloanid from clientloanproposal where Principaloutstanding>1 and loandisbursementdate>='2022-05-01')
order by DATEOFISSUE,REFERENCENUMBER
