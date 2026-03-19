Declare @sdt date
Declare @edt date

Set @sdt='2024-05-23'
Set @edt='2024-05-31'

if object_id(N'tempdb..#branchesm', N'U') is not null 
 begin
drop table #branchesm
end
  
 SELECT * INTO #branchesm
FROM report..FTLLoanLedger with(Nolock) where WeeklyTransactionDate between @sdt and @edt and left(ClientLoanID,2) in('05') 
 
  select b.branchid,b.branchname,
  (select isnull(SUM(PrincipalAmount),0)from #branchesm with(Nolock) where   SUBSTRING(ClientLoanID,16,2)
  in (Select ProductID From Products with(Nolock) where Type like '%Own%' and name not like'%flexi%')  and b.BranchID=left(ClientLoanID,5)) 'OwnDuecollection',
   (select isnull(SUM(PrincipalAmount),0)from #branchesm with(Nolock) where   SUBSTRING(ClientLoanID,16,2)
  in (Select ProductID From Products with(Nolock) where Type like '%IDBI%')  and b.BranchID=left(ClientLoanID,5)) 'IDBIDuecollection',
     (select isnull(SUM(PrincipalAmount),0)from #branchesm with(Nolock) where   SUBSTRING(ClientLoanID,16,2)
  in (Select ProductID From Products with(Nolock) where Type like '%ICICI%')  and b.BranchID=left(ClientLoanID,5)) 'ICICIDuecollection',
   (select isnull(SUM(PrincipalAmount),0)from #branchesm with(Nolock) where   SUBSTRING(ClientLoanID,16,2)
  in (Select ProductID From Products with(Nolock) where Type like '%Sidbi%')  and b.BranchID=left(ClientLoanID,5)) 'SIDBIDuecollection',
     (select isnull(SUM(PrincipalAmount),0)from #branchesm with(Nolock) where   SUBSTRING(ClientLoanID,16,2)
  in (Select ProductID From Products with(Nolock) where Name like '%Flexi%')  and b.BranchID=left(ClientLoanID,5)) 'FlexiDuecollection'
   from Branches as b where dissolveddate is null



   ------------------------------   Future Collection Details --------------------


select b.BranchName,b.BranchId,f.StaffID,f.StaffName,
(select isnull(sum(WeeklyInstallmentAmount),0) from report..FtlLoanLedger ff
inner join Centers cc on LEFT(ff.clientloanid,8)=cc.centerid 
where cc.staffid=f.staffid and ff.WeeklyTransactionDate between '2026-03-02' and '2026-03-03') as 'TotalCollAmt',
(select isnull(sum(WeeklyInstallmentAmount),0) from report..FtlLoanLedger ff
inner join Centers cc on LEFT(ff.clientloanid,8)=cc.centerid 
where cc.staffid=f.staffid and ff.WeeklyTransactionDate between '2026-03-02' and '2026-03-03'
and substring(clientloanid,16,2) in(select productid from products where type like'%Own%' and name not like'%Flexi%')) as 'OwnCollAmt',
(select isnull(sum(WeeklyInstallmentAmount),0) from report..FtlLoanLedger ff
inner join Centers cc on LEFT(ff.clientloanid,8)=cc.centerid 
where cc.staffid=f.staffid and ff.WeeklyTransactionDate between '2026-03-02' and '2026-03-03'
and substring(clientloanid,16,2) in(select productid from products where type like'%BC%' and name not like'%Flexi%')) as 'BCCollAmt',
(select isnull(sum(WeeklyInstallmentAmount),0) from report..FtlLoanLedger ff
inner join Centers cc on LEFT(ff.clientloanid,8)=cc.centerid 
where cc.staffid=f.staffid and ff.WeeklyTransactionDate between '2026-03-02' and '2026-03-03'
and substring(clientloanid,16,2) in(select productid from products where Name like'%Flexi%')) as 'FlexiCollAmt'
from FieldStaff f
inner join branches b on f.branchid=b.BranchID where exitdate is null 
and staffname not like'Dummy%' and designation in('12','13','14','15','46','47')
order by b.branchid
