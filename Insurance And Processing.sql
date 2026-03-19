--Insurance And Processing
select LEFT(cls.ClientLoanID,14) as ClientID,cls.ClientLoanID,clp.Targetname as ClientName,cls.RiskFund as Insurance,cls.upfrontfee as ProcessingFee,
case When cls.NumPersonInsured = '1' then ('Half')
	When cls.NumPersonInsured = '2' then ('Full')
	When cls.NumPersonInsured = '0' then ('Not Insured')
	End AS InsuranceStatus
from ClientLoanSubscription as cls with(NoLock)
inner join ClientLoanProposal as clp with(NoLock) on clp.LoanProposalID=cls.LoanProposalID
where cls.ClientLoanID like '31:04%' and cls.ActualPaidUpDate is NULL and cls.DisbursementDate between
'2022-11-04' and '2022-11-04'
order by ClientID


--Insurance And Processing particular Date
select LEFT(cls.ClientLoanID,14) as ClientID,cls.ClientLoanID,clp.Targetname as ClientName,cls.RiskFund as Insurance,cls.upfrontfee as ProcessingFee,
case When cls.NumPersonInsured = '1' then ('Half')
	When cls.NumPersonInsured = '2' then ('Full')
	When cls.NumPersonInsured = '0' then ('Not Insured')
	End AS InsuranceStatus
from ClientLoanSubscription as cls with(NoLock)
inner join ClientLoanProposal as clp with(NoLock) on clp.LoanProposalID=cls.LoanProposalID
where cls.ClientLoanID like '14:03%' and cls.ActualPaidUpDate is NULL and (cls.RiskFundDate = '2022-11-18' OR cls.UpFrontFeeDate = '2022-11-18')
order by ClientID