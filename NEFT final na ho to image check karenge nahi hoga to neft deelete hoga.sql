--NEFT final na ho to image check karenge nahi hoga to neft deelete hoga-----LOCAL
set transaction isolation level read uncommitted
select ClientID,LoanProposalID ,Targetname ,Husbandname ,KYCNo ,
case when ApprovalRemarks like '%Ban%' then 'Ban Client' else 'OK' end 'Ban Detail',
case when AccountNumber  ='0' then 'CM NEFT not Entry' else 'OK' end as 'CM NEFT',
case when AccountNumber  !='0' and BmAccountNumber ='0' then 'BM NEFT not Entry' else 'OK' end as 'BM NEFT',
case when BmAccountNumber <>'0' and FinalAccountNumber ='0' and ClientID not IN ( select ClientID 
from ClientAadhar )then 'ID not Exist in CA' else 'OK' end as 'ClientAdhar',
case when KYCNo IN (select adharid from ClientAadhar with (nolock) where ClientID <> clp.ClientID )then 'ClientID Missmatch in CA-CLP'
else 'OK' end as 'CA_adharid CLP_KYC',
case when LoanProposalID not in (select LoanProposalID from AadharDisbursement with (nolock) ) then 'LP_Id not in Adhar Disb' else 
'OK' end as 'CLP_LPId-AdharDisb_LPID',
case when ClientID not IN (select ClientID from cashpor..verifiedotp with (nolock)) then 'Client id not in Verify OTP' else 
'OK' end as 'Verify OTP',
case when ClientID not IN (select ClientID from cashpor..clientpassbookimages with (nolock) where LEN(ClientID )='14') and 
ClientID not IN (select ClientID from cashpor..clientpassbookimages1 with (nolock) where LEN(ClientID )='14') then 'Image Not Found'
else 'OK' end 'clientpassbookimages'
from ClientLoanProposal as clp with (nolock) where PrincipalOutstanding =1 and LoanAmountDisbursed =0 and DisbursementMode ='2'
--and FinalAccountNumber ='0' and BmAccountNumber <>'0'
   and ClientID in ('14:11:10:01:32')