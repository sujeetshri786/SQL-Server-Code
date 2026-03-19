
------Staff wise Repayment
-----------------------------------------------
select l.StaffID,sum(PrincipalInstallmentAmt+InterestInstallmentAmt)Due,
isnull(sum(case when 
 (principalcollected+interestcollected)>0 then 
 (PrincipalInstallmentAmt+InterestInstallmentAmt) end),0) as Duecollection
  from LoanLedger l (Nolock)
where l.StaffID IN ('25831')
group by l.StaffID
order by l.StaffID



