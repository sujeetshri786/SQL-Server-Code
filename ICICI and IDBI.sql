---client list who not take any idbi loan from idbi bc branch
select distinct cls.ClientID,B.Zone,B.DistrictName as RegionName,B.BranchID,B.BranchName,B.BranchBC,ct.CenterID,ct.CenterName,cls.ClientID,t.TargetName as ClientName,
t.TargetAge As ClientAge,Case When t.KYCName like '%%AADH%%' Then '********'+Right(KYCNo,4) Else KYCNo End KYCNumber,t.KYCName,c.JoinDate,c.LoanCycle,c.EligibleLoanAmount
from ClientLoanSubscription as cls with (NolOck) 
inner join products as p on p.ProductID = cls.ProductID
inner join clients as c on c.ClientID = cls.ClientID
inner join branches as b on b.BranchID=cls.BranchID --left(c.clientID,5)
inner join centers as ct on ct.CenterID=cls.CenterID
inner join Targets as t on t.TargetID=c.TargetID
where cls.clientID like '14%' and c.DropOutStatus = '0' and c.LoanCycle > '1' and b.BranchBC = 'BC IDBI' and 
cls.clientid  not in (select CustomerId from IDBIReview)
order by cls.ClientID


--Select AccountNo,IFSCCode,* From ClientLoanSubscriptionClosed With (NoLock) Where ClientLoanId Like '14:02:H4:01:87%'

--('D2','D3','H2')


------------List of ICICI Branch clients loan cycle >= 3
select b.Zone,b.DistrictName as RegionName,B.BranchID,B.BranchName,B.BranchBC,ct.CenterID,ct.CenterName,c.ClientID,t.TargetName as ClientName,t.TargetAge As ClientAge,
Case When t.KYCName like '%%AADH%%' Then '********'+Right(KYCNo,4) Else KYCNo End KYCNumber,t.KYCName,c.JoinDate,c.LoanCycle,c.EligibleLoanAmount
from clients as c with (NoLock) 
inner join branches as b on b.BranchID=c.BranchID --left(c.clientID,5)
inner join centers as ct on ct.CenterID=c.CenterID
inner join Targets as t on t.TargetID=c.TargetID
where c.clientid like '14%' and c.LoanCycle >= '3' and c.DropOutStatus = '0' and b.BranchBC = 'BC ICICI' and 
b.DissolvedDate is null and ct.DissolvedDate  is null
order by c.ClientID


--select * from clients
--select * from Targets
--select * from branches
--select * from Centers
--select * from clientloansubscription where productid in ('D2','D3','H2')
--select * from products Where Type ='BC IDBI'
--select * from IDBIReview

