with t as
(
Select left(clientloanid,14) as ClientID,LoanAmountDisbursed,ActualDisbursementDate from ClientLoanSubscription cls (nolocK) 
inner join products P(nolock) on substring(Clientloanid,16,2)=P.ProductID
where currentinstallmentperiod>10 and 
Loan_Category=0 and principaloutstanding>0
) 
Select B.Zone,b.districtname as RegionName,b.BranchName,B.BranchId,(t.ClientID),
Targetname,t.LoanAmountDisbursed,t.ActualDisbursementDate,cp.KYCNO,currentinstallmentperiod from t inner join ClientLoanSubscription c(nolock) on t.clientid=left(clientloanid,14)
and actualpaidupdate is null and Principaloutstanding>0
inner join branches b on left(c.clientloanid,5)=b.branchid
inner join ClientLoanProposal cp on c.loanproposalid=cp.loanproposalid
where not Exists 
(Select clp.ClientID From ClientLoanProposal clp(nolock) inner join products P1(nolock) on P1.Productid=clp.ProductID where clp.clientid=t.ClientID 
and Loan_Category in(5,7) and PrincipalOutstanding>=1) --and LoanDisbursementDate is null) 
group by t.ClientID,B.Zone,b.BranchName,B.BranchId,Targetname,t.LoanAmountDisbursed,t.ActualDisbursementDate,b.districtname,cp.KYCNO,currentinstallmentperiod
having Count(c.ClientLoanID)=1
order by b.branchid,t.ClientID
