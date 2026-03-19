--BM ABM Staff Mapped Details appcashpor

SELECT BranchID,
(select branchname from branches where branchid=BMABMStaffDetails.BranchID) 'branchname'
,BMABMID,BMABMName,
(select Designation from fieldstaff where staffid=BMABMStaffDetails.BMABMID ) 'BMABM_POSITION'
,StaffID,

(select StaffName from fieldstaff where staffid=BMABMStaffDetails.StaffID ) 'MappedStaff'
,
(select Designation from fieldstaff where staffid=BMABMStaffDetails.StaffID ) 'STAFFPOSITION'

FROM BMABMStaffDetails  where BranchID like '14:10%'

order by BranchID,BMABMID

update fieldstaff set StatusAct = '1' where StaffID = '13352'

--update FieldStaff set Designation = '27'  where  StaffID = ''


Select * from BMABMStaffDetails With (NoLock) Where BranchID like '05:22%' order by BranchID

Select * from BMABMStaffDetails With (NoLock) Where StaffID = '12240' order by BranchID
Select * from BMABMStaffDetails With (NoLock) Where BMABMID = '14902' order by BranchID

--Select * From FieldStaff With (NoLock) where Designation = '31' and exitdate is null And BranchID like '05%'order by branchid-- And StatusAct = '1' 
Select * From FieldStaff With (NoLock) where  exitdate is null And BranchID like '14:24%' order by branchid

select  (select DistrictName from branches where branchid=f.BranchID) 'Region',BranchID,
(select branchname from branches where branchid=f.BranchID) 'Branch',StaffID,
UPPER(StaffName) as ABM_NAME ,
(case when designation='16' THEN 'BM'  when designation='27' THEN 'ABM' END ) BM_ABM  
 ,'' MappedStaff,'' StaffPosition,'' StaffID
from fieldstaff f with (nolock) where exitdate is null and designation in  ('16','27') and
left (branchid , 2) in ('14') and StatusAct=1
order by Region ,BranchID ,BM_ABM DESC


