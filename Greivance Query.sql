--Local
select cls.LoanAmountDisbursed  ,sum(cls.PrincipalInstallmentAmt +cls.InterestInstallmentAmt  )as Installment
,SUM(cls.PrincipalReturnedToDate+InterestPaidToDate  )as totalpaid ,sum(ActualMoretoriumIntBal+LockdownInterestAmount) as Loacdown
,PrincipalOutstanding ,
  sum ((case when cls.InterestInArrears >0 then cls.InterestInArrears else '0'end  )+case when InterestOutstanding>0 then InterestOutstanding else '0' end) as 'InterestOutstanding' ,
SUM(PrincipalOutstanding+ActualMoretoriumIntBal+cls.InterestInArrears+LockdownInterestAmount  )as Settalamt
from clientloansubscription as cls 
  where cls.ClientLoanID  like '14:11:46:01:41%' and ActualPaidUpDate is null 
  group by cls.LoanAmountDisbursed ,ActualMoretoriumIntBal,PrincipalOutstanding,
  cls.InterestInArrears,LockdownInterestAmount,InterestOutstanding



select * from clientaadhar where adharid='741084182454'


