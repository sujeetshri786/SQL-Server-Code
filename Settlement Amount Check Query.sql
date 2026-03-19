------------------Settlement Amount Check Query-----------------------------------

 select cls.ClientLoanID ,cls.LoanAmountDisbursed  ,sum(cls.PrincipalInstallmentAmt +cls.InterestInstallmentAmt  )as Installment
,SUM(cls.PrincipalReturnedToDate+InterestPaidToDate  )as totalpaid ,sum(ActualMoretoriumIntBal+LockdownInterestAmount) as Loacdown
,PrincipalOutstanding ,
  sum ((case when cls.InterestInArrears >0 then cls.InterestInArrears else '0'end  )+case when InterestOutstanding>0 then InterestOutstanding else '0' end) as 'InterestOutstanding' ,

SUM(PrincipalOutstanding+ActualMoretoriumIntBal+
(case when cls.InterestInArrears >0 then cls.InterestInArrears else '0'end)
+LockdownInterestAmount+round((PrincipalOutstanding*p.InterestRate /100*7/365),0)  )as SettleAmt
from clientloansubscription as cls inner join Products as p on p.ProductID =SUBSTRING (ClientLoanID ,16,2)
  where cls.ClientLoanID IN ('05:08:B3:01:74:R1:01') and ActualPaidUpDate is null 
  group by cls.LoanAmountDisbursed ,ActualMoretoriumIntBal,PrincipalOutstanding,cls.ClientLoanID,p.InterestRate ,
  cls.InterestInArrears,LockdownInterestAmount,InterestOutstanding



  ----Settlement Amount 

  select cls.ClientLoanID ,cls.LoanAmountDisbursed  ,sum(cls.PrincipalInstallmentAmt +cls.InterestInstallmentAmt  )as Installment
,SUM(cls.PrincipalReturnedToDate+InterestPaidToDate  )as totalpaid ,sum(ActualMoretoriumIntBal+LockdownInterestAmount) as Loacdown
,PrincipalOutstanding ,
  sum ((case when cls.InterestInArrears >0 then cls.InterestInArrears else '0'end  )+case when InterestOutstanding>0 then InterestOutstanding else '0' end) as 'InterestOutstanding' ,
SUM(PrincipalOutstanding+ActualMoretoriumIntBal+
(case when cls.InterestInArrears >0 then cls.InterestInArrears else '0'end)
+LockdownInterestAmount+round((PrincipalOutstanding*p.InterestRate /100*7/365),0)  )as SettleAmt
from clientloansubscription as cls inner join Products as p on p.ProductID =SUBSTRING (ClientLoanID ,16,2)
  where cls.ClientLoanID  like '05:08:B3:01:74:R1:01%' and ActualPaidUpDate is null 
  group by cls.LoanAmountDisbursed ,ActualMoretoriumIntBal,PrincipalOutstanding,cls.ClientLoanID,p.InterestRate ,
  cls.InterestInArrears,LockdownInterestAmount,InterestOutstanding