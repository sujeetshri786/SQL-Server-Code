--PAR,CENTER HANDLE,REPAYMENT RATE,ALC,FIND MEMBER

select * from fieldstaff where staffid='17327'

*******************Find Member*********************
select * from targets with (nolock) where StaffID='28295' and TargetID in (select TargetID from clients with (nolock) 
where ClientID in (select left(clientloanid,14) from ClientLoanSubscription with (nolock))) order by TargettingDate

************************Find ALC*************************************
select * from targets with (nolock) where StaffID='28295' and TargetID in (select TargetID from clients with (nolock) 
where  AMGRTDate is not null and GroupID in (select GroupID from Groups with (nolock))) order by TargettingDate

*/---------------------------------Repayment rate-----------------------*

  select l.StaffID,sum(PrincipalInstallmentAmt+InterestInstallmentAmt)Due,
isnull(sum(case when (principalcollected+interestcollected)>0 then 
 (PrincipalInstallmentAmt+InterestInstallmentAmt) end),0) as Duecollection
  from LoanLedger l (Nolock)
where l.StaffID='27340'
group by l.StaffID
order by l.StaffID

------Between Date Repayment rate
select StaffID,sum(PrincipalInstallmentAmt+InterestInstallmentAmt)Due,
Sum(case when PrincipalCollected+InterestCollected>0 then  PrincipalInstallmentAmt+InterestInstallmentAmt else 0 end) Collection
from LoanLedger l (nolock) where StaffID='17327'
and WeeklyTransactionDate between '2024-04-10' and '2025-07-01'
group by StaffID


---center handle


select StaffID,count(centerid) as CenterCount from centers where staffid='27340' and dissolveddate is null Group BY StaffID

select count(centerid) from centers where staffid='27340' and dissolveddate is null

********************PAR*****************************

select sum(PrincipalOutstanding) from ClientLoanSubscription with (nolock) where StaffID='17327'

select sum(PrincipalOutstanding) from ClientLoanSubscription with (nolock) where StaffID='17327'
and NumInstallmentsInArrears>4 and CurrentInstallmentPeriod<=LoanDurationInWeeks

select sum(PrincipalOutstanding) from ClientLoanSubscription with (nolock) where StaffID='17327'
and CurrentInstallmentPeriod>LoanDurationInWeeks

------Center handled by staff and LoanClients

select Staffid,NumCentersManaged,NumLoanClients from RptFieldStaff where staffid in('27340') order by StaffID
