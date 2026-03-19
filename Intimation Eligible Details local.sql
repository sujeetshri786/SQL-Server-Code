--Intimation Eligible Details local


select b.DistrictName,b.branchName,b.branchid,clp.ClientID,clp.Targetname,clp.Husbandname,LoanCycle,cls.clientloanid,cls.LoanAmountDisbursed,cls.PrincipalOutStanding,case 
when cls.principaloutstanding<=cls.LoanAmountDisbursed*20/100 and cls.LoanAmountDisbursed>50000 then 'Yes'
when cls.principaloutstanding<=10000 and cls.LoanAmountDisbursed<=50000  then 'Yes' else 'No' end as IntimationStatus,CC.StaffId,f.StaffName  from ClientLoanSubscription cls with(nolock)
inner join ClientLoanProposal clp with(nolock) on cls.LoanProposalID=clp.LoanProposalID
inner join branches b with(nolock) on LEFT(clp.ClientID,5)=b.branchid
inner join clients c with(nolock) on clp.clientid=c.clientid
inner join centers cc with(nolock) on left(c.clientid,8)=cc.centerid
inner join fieldstaff f with(nolock) on cc.staffId=f.Staffid where actualpaidupdate is null and
clp.ClientID not in(select ClientID from 
ClientLoanProposal with(nolock) where PrincipalOutstanding=1 and LoanDisbursementDate is null)
and cls.disbursementdate is not null and substring(cls.clientloanid,16,2) in(select productid from Products where loan_category=0) and c.riskfund not in('2')
and ((cls.principaloutstanding<=cls.LoanAmountDisbursed*20/100 and cls.LoanAmountDisbursed>50000) or (cls.principaloutstanding<=10000 and cls.LoanAmountDisbursed<=50000)) 
order by b.branchid
