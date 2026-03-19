----Region LESS THEN 16 ALC CENTER  --- LOCAL
select  LEFT(ClientLoanID,5) as BranchID,(Select UPPER(BranchName) from Branches Where BranchID=LEFT(b.ClientLoanID,5))'BranchName',LEFT(clientloanid,8)as centerid,
(Select UPPER(CenterName) from Centers Where Centerid=LEFT(b.ClientLoanID,8))'CenterName',
(Select StaffID from Fieldstaff Where StaffID in (Select StaffID From Centers Where Centerid=LEFT(b.clientloanid,8)))'StaffID',
(Select UPPER(LEFT(StaffName,10)) from Fieldstaff Where StaffID in (Select StaffID From Centers Where Centerid=LEFT(b.clientloanid,8)))'StaffName',
COUNT(distinct LEFT(clientloanid,14))as no_of_alc 
from ClientLoanSubscription as b where ActualPaidUpDate is null and DisbursementDate is not null
group by  LEFT(clientloanid,5),LEFT(clientloanid,8)
having COUNT(distinct LEFT(clientloanid,14))<15
--and  COUNT(distinct LEFT(clientloanid,14))>= 5
order by LEFT(clientloanid,5),StaffName,LEFT(clientloanid,8)


----LESS THEN 15 ALC CENTER particular Branch  --- LOCAL
select  LEFT(ClientLoanID,5) as BranchID,(Select UPPER(BranchName) from Branches Where BranchID=LEFT(b.ClientLoanID,5))'BranchName',LEFT(clientloanid,8)as centerid,
(Select UPPER(CenterName) from Centers Where Centerid=LEFT(b.ClientLoanID,8))'CenterName',
(Select StaffID from Fieldstaff Where StaffID in (Select StaffID From Centers Where Centerid=LEFT(b.clientloanid,8)))'StaffID',
(Select UPPER(LEFT(StaffName,20)) from Fieldstaff Where StaffID in (Select StaffID From Centers Where Centerid=LEFT(b.clientloanid,8)))'StaffName',
COUNT(distinct LEFT(clientloanid,14))as no_of_alc 
from ClientLoanSubscription as b where ActualPaidUpDate is null and DisbursementDate is not null And ClientLoanID like '10:24%'
group by  LEFT(clientloanid,5),LEFT(clientloanid,8)
having COUNT (distinct LEFT(clientloanid,14))=<17
--and  COUNT(distinct LEFT(clientloanid,14))>= 5
order by LEFT(clientloanid,5),StaffName,LEFT(clientloanid,8)


