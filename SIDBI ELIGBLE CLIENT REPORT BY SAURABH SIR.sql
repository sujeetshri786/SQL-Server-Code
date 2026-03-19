select 
--(select Zone from branches where branchid=LEFT(clp.ClientID,5))	ZONE_NAME,

--(select CHName from branches where branchid=LEFT(clp.ClientID,5))	CHIB_NAME,
branchbc,A.BranchID,A.BranchName,A.clientid,A.TargetName,A.TargetAge,A.HusbandName,A.EligibleLoanAmount,ccc.LoanCycle from

(select b.BranchID,B.BranchName,clientid,T.TargetName,T.TargetAge,T.HusbandName,EligibleLoanAmount,
case when branchbc like '%BC%' and eligibleloanamount>100000 then 'YES'
when branchbc like '%BC%' and eligibleloanamount<=100000 then 'NO'
when branchbc  not like '%BC%' and eligibleloanamount>50000 then 'YES' 
when branchbc  not like '%BC%' and eligibleloanamount<=50000 then 'NO' end as 'Eligible'

from clients as c inner join branches as b on b.branchid=left(clientid,5)
inner join targets as t on t.targetid=c.targetid where DropOutStatus='0' and RiskFund='0'
and left(B.branchid,2)IN ('24')
and c.EligibleLoanAmount>50000) a

inner join branches on branches.branchid=a.branchid
full join clientadhar as cc on cc.clientid=a.clientid
inner join clients ccc on ccc.clientid=a.clientid
where a.eligible='YES'

order by A.BranchID,A.ClientId


--select * from Product_Category where ProductCategory like 'sidbi%' and RID like '28%' order by LoanAmount 

