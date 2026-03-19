--Center wise ALC and Arear PAR Default

SELECT   Branches.BranchID,BranchName,FieldStaff.Staffid,FieldStaff.Staffname,              
case when FieldStaff.designation='15' then 'TCM'                                           
                                 when FieldStaff.designation='14' then 'PCM'                                                     
								 when FieldStaff.designation='13' then 'CM'
                                 when FieldStaff.designation='12' then 'SCM'
                                 when FieldStaff.designation='46' then 'CTPCM'
                                 when FieldStaff.designation='47' then 'CTTCM' 
                                 when FieldStaff.designation='27' then 'ABM' end as 'Fs.Designation',
                                                                                                                   
Centers.Centerid,Centers.CenterName,centers.CenterMeetingTime,                              
                                                                                                                   
                                                                                                                   
                                                                                                                   
Case When centers.ReportingDay=1 Then 'Monday'                                                     
       When centers.ReportingDay=2 Then 'Tuesday'                                                         
       When centers.ReportingDay=3 Then 'Wednesday'                                   
       When centers.ReportingDay=4 Then 'Thursday'                                                        
       When centers.ReportingDay=5 Then 'Friday'                                               
       When centers.ReportingDay=6 Then 'Saturday' End as MeetingDay,                 
                                                                                                                   
count(distinct left(clientloanid,14))ALC,sum(PrincipalOutstanding) Outstanding,              
                                                                                                                   
count(distinct case when NumInstallmentsInArrears                                    
between '1' and '4' and currentinstallmentperiod<=loandurationinweeks               
  then left(clientloanid,14) end) 'TOTAL Arrear',                                                  
isnull(sum( case when NumInstallmentsInArrears                                                        
between '1' and '4' and currentinstallmentperiod<=loandurationinweeks               
  then (principalinarrears+interestinarrears) end),0) 'TOTAL_Arrear_Amount',         
                                                                                                                   
count(distinct case when NumInstallmentsInArrears >4                              
 and currentinstallmentperiod<=loandurationinweeks                                  
  then left(clientloanid,14) end) PAR,                                                                      
  isnull(sum( case when NumInstallmentsInArrears >4                                 
   and currentinstallmentperiod<=loandurationinweeks                                
   then (PrincipalOutstanding) end),0) PAR_Amount,                                                      
                                                                                                                   
count(distinct case when   currentinstallmentperiod>loandurationinweeks   
  then left(clientloanid,14) end) Defaulter,                                                           
   isnull(sum( case when currentinstallmentperiod>loandurationinweeks   
   then (PrincipalOutstanding) end),0) Defaulter_Amount                             
                                                                                                                   
from ClientLoanSubscription (Nolock)                                                                 
inner join Centers (Nolock) on centers.centerid=left(clientloanid,8)                          
inner join Branches (Nolock) on branches.BranchID=centers.BranchID                      
inner join FieldStaff  (Nolock)on fieldstaff.StaffID=centers.StaffID                             
where ActualPaidUpDate is null  and  left(clientloanid,2)in ('28')                          
group by Branches.BranchID,BranchName,centers.ReportingDay,Centers.centerid,Centers.CenterName,centers.CenterMeetingTime,
FieldStaff.Staffid,FieldStaff.Staffname,FieldStaff.Designation                                 
order by Branches.BranchID,fieldstaff.staffid,centers.ReportingDay         
