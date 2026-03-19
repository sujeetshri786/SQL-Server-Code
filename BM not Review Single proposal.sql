 ---BM not Review Single proposal -- its run appcashpor
 select Branchid,(select Branchname from Branches b where f.Branchid=b.Branchid and branchid like'14%') as Branchname,Staffid,StaffName ,case                                     
                                         When f.Designation='16' Then 'BM'
                                                                                End As 'Position'

from FieldStaff f (nolock)
where f.Designation in('16') and exitdate is null and StaffName not like '%Dummy%' and Branchid like '14%'
 and staffid not in (select BMID from clientloanproposal (nolock) where proposaldate>= cast(getdate()-1 as date) and clientid like '14%')
