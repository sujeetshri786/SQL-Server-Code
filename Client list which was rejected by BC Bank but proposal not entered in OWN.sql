----Client list which was rejected by BC Bank but proposal not entered in OWN

Select b.Zone,B.DistrictName RegionName,B.BranchID,b.BranchName, 
case 
	when BCIDNo='1' then 'INDUSIND BC'
	when BCIDNo='2' then 'ICICI BC'
	when BCIDNo='3' then 'IDBI BC'
	when BCIDNo='4' then 'KOTAK BC' 
	when BCIDNo='5' then 'SIDBI BC' 
	when BCIDNo='6' Then 'IDFC BC' end as BCBankName,
	ClientID,LoanProposalID,
case 
	when RejectionRemarks IS NULL then 'Loan Reject by BC BANK' else RejectionRemarks end RejectionRemarks,
cast(AttemptDate as date) As RejectionDate,'Waiting To Take Proposal In Own Loan' As SolutionRemark 
from [43.242.214.235].AppCashpor.dbo.Proposal_Rejected_By_BCBank R (nolock)
inner join Branches b (nolock) on b.BranchID=left(ClientID,5)
where cast(AttemptDate as date)>= cast(getdate()-7 as date) and left(LoanProposalID,2)='10' and  not Exists (
Select ClientID from [43.242.214.235].AppCashpor.dbo.ClientLoanProposal p (nolock) where p.clientid=r.clientid and proposaldate>=cast(AttemptDate as date)
and p.principaloutstanding<>1
) Order by BCIDNo
