---- target allocation Appcashpor
select b.BranchID  ,BranchName ,isnull(OwnalcforMonth,0) as OwnalcforMonth ,isnull (OwnoutstandingMonth,0) as OwnoutstandingMonth
,isnull(Bcoutstandingmonth,0) as Bcoutstandingmonth ,
isnull(b.FlexialcfortheMonth,0) as FlexialcfortheMonth  ,isnull (FlexiosfortheMonth,0)as FlexiosfortheMonth ,
(select isnull (sum(t.OwnALCfortheMonth ),0) from tmptargetallocation t where b.BranchID =t.BranchId and DateStamp >='2022-04-01') as 'Target ALC',
(select isnull (sum(t.OwnOutstandingfortheMonth ),0) from tmptargetallocation t where b.BranchID =t.BranchId and DateStamp >='2022-04-01') as 'Target Own Outs',
(select isnull (sum(t.BCOutstadningfortheMonth ),0) from tmptargetallocation t where b.BranchID =t.BranchId and DateStamp >='2022-04-01') as 'Target Bc Out',
(select isnull (sum(t.FlexiALCfortheMonth ),0) from tmptargetallocation t where b.BranchID =t.BranchId and DateStamp >='2022-04-01') as 'Target ALC FL',
(select isnull (sum(t.FlexiOutstandingfortheMonth ),0) from tmptargetallocation t where b.BranchID =t.BranchId and DateStamp >='2022-04-01') as 'Target Flexi Out',
(select count(staffid) from fieldstaff where b.branchid=branchid and staffname not like 'Dummy%' and Designation in ('12','13','14','15','46','47') and exitdate is null) as 'Noof Staff',
(select isnull (count(t.StaffId  ),0) from tmptargetallocation t where b.BranchID =t.BranchId and DateStamp >='2022-04-01') as 'Targetallocation Noof Staff',
case when isnull(OwnalcforMonth,0)= (select isnull (sum(t.OwnALCfortheMonth ),0) from tmptargetallocation t where b.BranchID =t.BranchId and DateStamp >='2022-04-01') then 'YES' else 'NO' end  as 'Target ALC'
,case when isnull (OwnoutstandingMonth,0)=  (select isnull (sum(t.OwnOutstandingfortheMonth ),0) from tmptargetallocation t where b.BranchID =t.BranchId and DateStamp >='2022-04-01') then 'YES' else 'NO' end as 'Target Own Outs'
,case when isnull(Bcoutstandingmonth,0)=  (select isnull (sum(t.BCOutstadningfortheMonth ),0) from tmptargetallocation t where b.BranchID =t.BranchId and DateStamp >='2022-04-01') then 'YES' else 'NO' end as 'Target BC Outs'
,case when isnull(b.FlexialcfortheMonth,0)=  (select isnull (sum(t.FlexiALCfortheMonth ),0) from tmptargetallocation t where b.BranchID =t.BranchId and DateStamp >='2022-04-01') then 'YES' else 'NO' end as 'Target FL ALC'
,case when isnull (FlexiosfortheMonth,0)=  (select isnull (sum(t.FlexiOutstandingfortheMonth ),0) from tmptargetallocation t where b.BranchID =t.BranchId and DateStamp >='2022-04-01') then 'YES' else 'NO' end as 'Target FL Outs'
,case when (select count(staffid) from fieldstaff where b.branchid=branchid and staffname not like 'Dummy%' and Designation in ('12','13','14','15','46','47') and exitdate is null)=
(select isnull (count(t.StaffId  ),0) from tmptargetallocation t where b.BranchID =t.BranchId and DateStamp >='2022-04-01') then 'YES' else 'NO'end as 'No Of Staff'
from BranchesTarget b
  where b.BranchID  like '35%' and b.dissolveddate is null
  group by  b.BranchID ,BranchName ,OwnalcforMonth ,OwnoutstandingMonth ,Bcoutstandingmonth ,
b.FlexialcfortheMonth ,FlexiosfortheMonth 
  order by BranchId
