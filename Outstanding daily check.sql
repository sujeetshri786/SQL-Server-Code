--Outstanding daily check


select SUM(PrincipalOutstanding) as Outstanding  ,
sum(case when  RiskFundDate ='2022-11-10'  then RiskFund  end)as Insurance,
sum(case when  UpFrontFeeDate ='2022-11-10'  then UpFrontFee   end)as processing,
sum(case when DisbursementDate='2022-11-10'   then LoanAmountDisbursed end)as TodayDisb_CLS,
sum(case when DisbursementDate IS  null and  ActualDisbursementDate ='2022-11-10' 
and DisbursementMode In('2','4') then LoanAmountDisbursed end)as TodayAPBSDisb_CLS
,sum(case when DisbursementDate <>ActualDisbursementDate  and DisbursementDate ='2022-11-10'  and DisbursementMode In('2','4')
then LoanAmountDisbursed end)as LastAPBSDisb_CLS,
(select sum (principalcollected) from LoanLedger  where 
weeklytransactiondate ='2022-11-10' ) as 'PrincipalColl',
(select sum (InterestCollected) from LoanLedger  with(nolock)  where 
weeklytransactiondate ='2022-11-10' ) as 'InterestColl'
from ClientLoanSubscription with(nolock)
