-----------------------------------------Local
  select  FieldStaff.BranchID,FieldStaff.staffid,FieldStaff.StaffName,FieldStaff.Designation,
  case 
                                         When FieldStaff.Designation='16' Then 'BM'
                                         When FieldStaff.Designation='28' Then 'CRO'
                                         When FieldStaff.Designation='26' Then 'ZRO'
                                         When FieldStaff.Designation='22' Then 'ADO'
                                         When FieldStaff.Designation='21' Then 'DDO'
                                         When FieldStaff.Designation='23' Then 'RM'
                                         When FieldStaff.Designation='24' Then 'DRM'
                                         When FieldStaff.Designation='25' Then 'DRO'
                                         When FieldStaff.Designation='30' Then 'SCH'
                                         When FieldStaff.Designation='31' Then 'CH'
                                         When FieldStaff.Designation='6' Then 'SBM'
                                         When FieldStaff.Designation='7' Then 'ARO'
                                         When FieldStaff.Designation='12' Then 'SCM'
                                         When FieldStaff.Designation='13' Then 'CM'
                                         When FieldStaff.Designation='14' Then 'PCM'
                                         When FieldStaff.Designation='15' Then 'TCM'
                                         When FieldStaff.Designation='27' Then 'ABM' 
                                         When FieldStaff.Designation='33' Then 'RAA' 
                                         When FieldStaff.Designation='32' Then 'RAM'
                                         When FieldStaff.Designation='29' Then 'FC' 
                                         When FieldStaff.Designation='46' Then 'CTPCM' 
                                         When FieldStaff.Designation='47' Then 'CTTCM' End As 'Position'
                                         
from FieldStaff where Designation in('6','12','13','13','14','15','16','23','24','7','25','30','31','28','22','21','26','27','33','32','29','46','47')  
and ExitDate is null and BranchID like'10%' and RegionID='10' order by StaffID



----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Nikhil Sir


select BranchID,StaffID,StaffName,
  case 
                                         When f.Designation='16' Then 'BM'
                                         When f.Designation='28' Then 'CRO'
                                         When f.Designation='26' Then 'ZRO'
                                         When f.Designation='22' Then 'ADO'
                                         When f.Designation='21' Then 'DDO'
                                         When f.Designation='23' Then 'RM'
                                         When f.Designation='24' Then 'DRM'
                                         When f.Designation='25' Then 'DRO'
                                         When f.Designation='30' Then 'SCH'
                                         When f.Designation='31' Then 'CH'
                                         When f.Designation='6' Then 'SBM'
                                         When f.Designation='7' Then 'ARO'
                                         When f.Designation='12' Then 'SCM'
                                         When f.Designation='13' Then 'CM'
                                         When f.Designation='14' Then 'PCM'
                                         When f.Designation='15' Then 'TCM'
                                         When f.Designation='29' Then 'FC'
                                         When f.Designation='32' Then 'RAM'
                                         When f.Designation='33' Then 'RAA'
                                         when f.Designation='47' Then 'CTTCM'
                                         When f.Designation='46' Then 'CTPCM' 
                                         When f.Designation='27' Then 'ABM' 
                                         End As 'Position'
from FieldStaff f  with (nolock) where exitdate is null and branchid like '10%' and
Designation in('16','28','26','22','21','23','24','25','30','31','6','7','12','13','14','15','29','32','33','47','46','27')and StaffName NOT LIKE  '%Dummy%' and StaffID <> '88888'
order by BranchID,StaffID
