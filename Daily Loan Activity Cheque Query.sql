---Run in local (Daily Loan Activity) 

------------check principle Outstanding-----(local DB)---------------------------------------------------------------------
select * from clientloansubscription With (Nolock)where principaloutstanding<0
                                
select ClientLoanSubscription.ClientLoanID,ClientLoanSubscription.DisbursementDate,ClientLoanSubscription.LoanAmountDisbursed,
ClientLoanSubscription.PrincipalReturnedToDate,ClientLoanSubscription.PrincipalOutstanding,SUM(loanledger.PrincipalCollected)
as principalcollection,ClientLoanSubscription.ActualPaidUpDate from ClientLoanSubscription With (Nolock)inner join
LoanLedger on ClientLoanSubscription.ClientLoanID=LoanLedger.ClientLoanID
group by ClientLoanSubscription.ClientLoanID,ClientLoanSubscription.DisbursementDate,ClientLoanSubscription.ActualPaidUpDate,
ClientLoanSubscription.PrincipalReturnedToDate,ClientLoanSubscription.PrincipalOutstanding,
ClientLoanSubscription.LoanAmountDisbursed
Having ClientLoanSubscription.PrincipalReturnedToDate<> SUM(loanledger.PrincipalCollected)

--------------------------------------------------------Disbursement date check—(local DB)-------------------------------------------------------------
select * from ClientLoanSubscription with (nolock)where ActualDisbursementDate=(convert(nvarchar(10),getdate()-1,23)) and ActualPaidUpDate=(convert(nvarchar(10),getdate()-1,23))  --and ActualDisbursementDate>='2020-06-23'

select ActualDisbursementDate,* from clientloansubscription with (nolock)where actualdisbursementdate<=(convert(nvarchar(10),getdate()-2,23)) and disbursementdate is null order by clientloanid

--------------------------------------------------------Collection Disbursement Insurance Processing Amount check—(local DB)-----------------------------------
 Declare @Date Date='2023-04-09'
 select sum(PrincipalCollected)as PrincipalCollected,sum(InterestCollected)as InterestCollected from loanledger (nolock)where WeeklyTransactionDate=@Date
 select sum(LoanAmountDisbursed) as DisbursementAmount from clientloansubscription (nolock)where DisbursementDate=@Date
 select sum(riskfund) as InsuranceFee from clientloansubscription (nolock)where riskfunddate=@Date
 select sum(upfrontfee) as ProcessingFee from clientloansubscription (nolock)where upfrontfeedate=@Date
 select sum(PrincipalOutstanding) as AmountOutstanding from clientloansubscription (nolock)where ActualPaidUpDate is null
 

 /*select sum(PrincipalCollected)as PrincipalCollected,sum(InterestCollected)as InterestCollected from loanledger (nolock)where WeeklyTransactionDate=CONVERT(varchar(10),GETDATE()-1,23)
 select sum(LoanAmountDisbursed) as DisbursementAmount from clientloansubscription (nolock)where DisbursementDate=CONVERT(varchar(10),GETDATE()-1,23)
 select sum(riskfund) as InsuranceFee from clientloansubscription (nolock)where riskfunddate=CONVERT(varchar(10),GETDATE()-1,23)
 select sum(upfrontfee) as ProcessingFee from clientloansubscription (nolock)where upfrontfeedate=CONVERT(varchar(10),GETDATE()-1,23)*/
 
 /*select sum(PrincipalCollected)as PrincipalCollected,sum(InterestCollected)as InterestCollected from loanledger (nolock)where WeeklyTransactionDate='2022-04-13'
 select sum(LoanAmountDisbursed) as DisbursementAmount from clientloansubscription (nolock)where DisbursementDate='2022-04-13'
 select sum(riskfund) as InsuranceFee from clientloansubscription (nolock)where riskfunddate='2022-04-13'
 select sum(upfrontfee) as ProcessingFee from clientloansubscription (nolock)where upfrontfeedate='2022-04-13'*/