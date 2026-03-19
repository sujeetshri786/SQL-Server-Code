Select left(cls.ClientLoanid,5) as BranchID,b.BranchName,
Sum(cls.riskfund) as Insurance1Amount,
--cls.RiskFundDate as Insurance1EntryDate,
Sum(cls.RiskFund_2) as Insurance2Amount,
--cls.RiskFundDate_2 as Insurance2EntryDate,
SUM(cls.UpFrontFee) as ProcessingFee
--cls.UpFrontFeeDate as ProcessingEntryDate
from ClientLoanSubscription as cls With (NoLock) 
inner join branches as b on left(b.BranchID,5)=left(cls.ClientLoanid,5)
Where ClientLoanID like '14%' and 
(cast(cls.RiskFundDate as date) between '2023-11-01' and '2023-11-30' or 
cast(cls.RiskFundDate_2 as date) between '2023-11-01' and '2023-11-30' or 
cast(cls.UpFrontFeeDate as date) between '2023-11-01' and '2023-11-30') and cls.RegionID = '14'
group by left(cls.ClientLoanid,5),b.BranchName--,cls.RiskFundDate,cls.RiskFundDate_2,cls.UpFrontFeeDate
order by left(cls.ClientLoanid,5)



--select * from Branches

--select * from ClientLoanSubscription