-- Shubham Local
SELECT SUM(PrincipalOutStanding) AS OutStanding,
SUM (CASE WHEN RiskFunddate = '2023-08-19' THEN Riskfund END) AS Insurance,
SUm (CASE WHEN UpFrontFeeDate = '2023-08-19' THEN UpFronTFee END) AS Processing,
SUM (CASE WHEN DisburseMentDate = '2023-08-19' THEN LoanAmountDisbursed END) AS TodayDisb_CLS,
sum(CASE WHEN DisbursementDate IS NULL and ActualDisbursementDate ='2023-08-19' and DisbursementMode In('2') THEN LoanAmountDisbursed END)AS TodayNEFTDisb_CLS,
sum(CASE WHEN DisbursementDate <>ActualDisbursementDate and DisbursementDate ='2023-08-19' and DisbursementMode In('2')
THEN LoanAmountDisbursed END)AS LastNEFTDisb_CLS,
(SELECT SUM(PrincipalCollected) FROM LoanLedger AS ll WHERE ll.ClientLoanID=ClientLoanID
and WeeklyTransactionDate='2023-08-19') AS 'P_Collection',
(SELECT SUM(InterestCollected) FROM LoanLedger AS ll WHERE ll.ClientLoanID=ClientLoanID
and WeeklyTransactionDate='2023-08-19') AS 'Int_Collection'
FROM ClientLoanSubscription
WHERE ActualPaidUpDate is null


--Ashwani
declare @date date='2023-08-18'
select sum(cast(PrincipalOutstanding as bigint)) as AmountOutstanding  from clientloansubscription (nolock)where ActualPaidUpDate is null
select sum(riskfund) as InsuranceFee from clientloansubscription (nolock)where riskfunddate=@date
select sum(upfrontfee) as ProcessingFee from clientloansubscription (nolock)where upfrontfeedate=@date
select sum(LoanAmountDisbursed) as DisbursementAmount from clientloansubscription (nolock)where DisbursementDate=@date
select sum(PrincipalCollected)as PrincipalCollected,sum(InterestCollected)as InterestCollected from loanledger (nolock)where WeeklyTransactionDate=@date


--Ravi Sir
select count(left(clientloanid,14)) as ALC,sum(principaloutstanding) as TotalOuts from clientloansubscription where  
  principaloutstanding>0

  select  sum(LoanAmountDisbursed) as Num_LOan_Disb   from clientloansubscription where  DisbursementDate='2023-08-19'


select sum(riskfund) as Insurance from clientloansubscription where  riskfunddate='2023-08-19'
and riskfund>0

select sum(UpFrontFee) as Processingfee from clientloansubscription where  UpFrontFeeDate='2023-08-19'
and UpFrontFee>0
