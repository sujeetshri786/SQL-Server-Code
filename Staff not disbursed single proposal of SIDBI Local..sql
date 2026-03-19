--Staff not disbursed single proposal of SIDBI Local.
Select fs.BranchID,b.BranchName,StaffID,fs.StaffName,D.DesignationName from FieldStaff fs with (nolock) 
inner join branches as b on b.BranchID=fs.BranchID
inner join DesignationMaster as d on d.DesignationID=fs.Designation
where fs.Designation in ('12','13','14','15','46','47') and fs.ExitDate IS NULL
and staffid not in (select cls.entryby from ClientLoanSubscription cls with (nolock) join products p on p.ProductID=SUBSTRING(cls.ClientLoanID,16,2) 
where DisbursementDate >= '2023-04-01' and
p.type like '%%BC Sidbi%%' and ActualPaidUpDate is NULL) and StaffName not like '%%Dummy%%'
order by BranchID