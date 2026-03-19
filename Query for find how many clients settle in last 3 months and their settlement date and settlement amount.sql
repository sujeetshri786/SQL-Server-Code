--Query for find how many clients settle in last 3 months and their settlement date and settlement amount---


select cls.clientid,cls.actualdisbursementdate,cls.currentinstallmentperiod,cls.loandurationinweeks,loanledger.principalcollected,loanledger.interestcollected,cls.actualpaidupdate  
from clientloansubscription (nolock) cls
inner join loanledger (nolock)
on cls.clientloanid = loanledger.clientloanid
where actualpaidupdate=loanledger.weeklytransactiondate and cls.actualpaidupdate between '2025-01-01' and '2025-03-19'
and loanledger.principalinstallmentamt <loanledger.principalcollected and cls.branchid = '26:04'
