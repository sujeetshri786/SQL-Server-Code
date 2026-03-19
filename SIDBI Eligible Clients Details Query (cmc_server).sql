------------------SIDBI Eligible Clients Details Query (cmc_server)------------------------

select branchbc,A.BranchID,A.BranchName,A.clientid,A.TargetName,A.TargetAge,A.HusbandName,A.EligibleLoanAmount,cc.AdharID,ccc.LoanCycle,
isnull((select  sum(principaloutstanding) from ClientLoanSubscription where principaloutstanding>0 and actualpaidupdate is null and left(clientloanid,14)=a.ClientID),0) as Outstanding,
(select top 1 mobilenumber from clientloanproposal where clientid=a.ClientID and mobilenumber<>'0' and mobilenumber is not null) MobileNumber from

(select b.BranchID,B.BranchName,clientid,T.TargetName,T.TargetAge,T.HusbandName,EligibleLoanAmount,
case when branchbc like '%BC%' and eligibleloanamount>100000 then 'YES'
when branchbc like '%BC%' and eligibleloanamount<=100000 then 'NO'
when branchbc  not like '%BC%' and eligibleloanamount>50000 then 'YES' 
when branchbc  not like '%BC%' and eligibleloanamount<=50000 then 'NO' end as 'Eligible'

from clients as c inner join branches as b on b.branchid=left(clientid,5)
inner join targets as t on t.targetid=c.targetid where DropOutStatus='0' and c.RiskFund='0'
and left(B.branchid,2)='05' 
and c.EligibleLoanAmount>50000) a

inner join branches on branches.branchid=a.branchid
full join clientaadhar as cc on cc.clientid=a.clientid
inner join clients ccc on ccc.clientid=a.clientid
where a.eligible='YES'

order by A.BranchID,A.ClientId
