----Total Running Loan

with t as
(
Select left(clientloanid,14) as ClientID,LoanAmountDisbursed,ActualDisbursementDate from ClientLoanSubscription cls (nolocK) 
inner join products P(nolock) on substring(Clientloanid,16,2)=P.ProductID
where p.Loan_Category=0 and principaloutstanding>0 and clientid like '05%'
) 
Select B.Zone,b.districtname as RegionName,b.BranchName,B.BranchId,(t.ClientID),
Targetname,t.LoanAmountDisbursed,t.ActualDisbursementDate,cp.KYCNO,currentinstallmentperiod,cn.LoanCycle,cp.Productcategory from t inner join ClientLoanSubscription c(nolock) on t.clientid=left(clientloanid,14)
and actualpaidupdate is null and Principaloutstanding>0
inner join branches b on left(c.clientloanid,5)=b.branchid
inner join ClientLoanProposal cp on c.loanproposalid=cp.loanproposalid
inner join clients cn on cp.clientid=cn.ClientID
where not Exists 
(Select clp.ClientID From ClientLoanProposal clp(nolock) inner join products P1(nolock) on P1.Productid=clp.ProductID where clp.clientid=t.ClientID and clp.clientid like '05%'
and p1.Loan_Category in(7,5,3) and PrincipalOutstanding>=1) --and LoanDisbursementDate is null) 
group by t.ClientID,B.Zone,b.BranchName,B.BranchId,Targetname,t.LoanAmountDisbursed,t.ActualDisbursementDate,b.districtname,cp.KYCNO,currentinstallmentperiod,
cn.LoanCycle,cp.productcategory
having Count(c.ClientLoanID)=1
order by b.branchid,t.ClientID
