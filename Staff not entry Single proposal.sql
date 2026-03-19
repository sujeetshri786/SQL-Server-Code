
---Staff not entry Single proposal -- its run appcashpor

select Branchid,(select Branchname from Branches b where f.Branchid=b.Branchid and branchid like'05%') as Branchname,Staffid,StaffName ,case                                     
                                         When f.Designation='12' Then 'CM'
                                         When f.Designation='13' Then 'CM'
                                         When f.Designation='14' Then 'PCM'
                                         When f.Designation='15' Then 'TCM'
                                         When f.Designation='46' Then 'CTPCM'
                                         When f.Designation='47' Then 'CTTCM'
                                         End As 'Position'

from FieldStaff f (nolock)
where f.Designation in('12','13','14','15','47','46') and exitdate is null and StaffName not like '%Dummy%' and Branchid like '05%'
 and staffid not in (select entryby from clientloanproposal (nolock) where proposaldate ='2023-07-28' and clientid like '05%')--cast(getdate()-1 as date)-->='2023-04-20'-- between '2023-07-15' and '2023-07-16'


 --select * from ClientLoanProposal where EntryBy = '20032' and proposaldate ='2023-07-17'

-----Staff not entry Single Adding -- its run appcashpor
select Branchid,(select Branchname from Branches b where f.Branchid=b.Branchid and branchid like'14%') as Branchname,Staffid,StaffName ,case                                     
                                         When f.Designation='12' Then 'CM'
                                         When f.Designation='13' Then 'CM'
                                         When f.Designation='14' Then 'PCM'
                                         When f.Designation='15' Then 'TCM'
                                         When f.Designation='46' Then 'CTPCM'
                                         When f.Designation='47' Then 'CTTCM'
                                         End As 'Position'

from FieldStaff f (nolock)
where f.Designation in('12','13','14','15','47','46') and exitdate is null and StaffName not like '%Dummy%' and Branchid like '14%'
 and staffid not in (select entryby from clients (nolock) where JoinDate>='2023-04-20'  and clientid like '14%')

 --Select * from clients with (NoLock) where entryby = '22402' and JoinDate>='2023-04-14'
