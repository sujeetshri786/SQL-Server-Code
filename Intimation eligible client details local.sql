---------------Intimation eligible client details CashporOne


select b.DistrictName,b.branchName,b.branchid,clp.ClientID,clp.Targetname,clp.Husbandname,LoanCycle,cls.clientloanid,cls.LoanAmountDisbursed,cls.PrincipalOutStanding,case 
when cls.principaloutstanding<='30000' and cls.LoanAmountDisbursed>='70000' then 'Yes'
when cls.principaloutstanding<='15000' and cls.LoanAmountDisbursed<'70000'  then 'Yes' else 'No' end as IntimationStatus,CC.StaffId,f.StaffName,hotlistdate,hotlistremark  from ClientLoanSubscription cls with(nolock)
inner join ClientLoanProposal clp with(nolock) on cls.LoanProposalID=clp.LoanProposalID
inner join branches b with(nolock) on LEFT(clp.ClientID,5)=b.branchid
inner join clients c with(nolock) on clp.clientid=c.clientid
inner join centers cc with(nolock) on left(c.clientid,8)=cc.centerid
inner join fieldstaff f with(nolock) on cc.staffId=f.Staffid where actualpaidupdate is null and
clp.ClientID not in(select ClientID from [43.242.214.235].appcashpor.dbo.ClientLoanProposal with(nolock) where PrincipalOutstanding=1 and LoanDisbursementDate is null)
and cls.disbursementdate is not null and substring(cls.clientloanid,16,2) in(select productid from Products where loan_category=0) and c.riskfund not in('2')
and ((cls.principaloutstanding<='30000' and cls.LoanAmountDisbursed>='70000') or (cls.principaloutstanding<='15000' and cls.LoanAmountDisbursed<'70000')) 
and cls.regionid in('14') and dropoutstatus='0' and hotlistdate is null
order by b.branchid

