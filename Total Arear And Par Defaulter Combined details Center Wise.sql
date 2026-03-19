------------Toal Arear Par and Defaulter Combined Details Center Wise

SELECT   Branches.BranchID,BranchName,centers.StaffID,StaffName,
count(distinct left(clientloanid,14))ALC,sum(PrincipalOutstanding) Outstanding,centers.centerid,centers.centername,

count(distinct case when NumInstallmentsInArrears='1'and currentinstallmentperiod<=loandurationinweeks
  then left(clientloanid,14) end) '1st Week Arrear',
isnull(sum( case when NumInstallmentsInArrears='1'
  and currentinstallmentperiod<=loandurationinweeks
  then (principalinarrears+interestinarrears) end),0) '1st Week_Arrear_Amount',

  count(distinct case when NumInstallmentsInArrears='2' 
  and currentinstallmentperiod<=loandurationinweeks
  then left(clientloanid,14) end) '2nd Week Arrear',
isnull(sum( case when NumInstallmentsInArrears='2'
  and currentinstallmentperiod<=loandurationinweeks
  then (principalinarrears+interestinarrears) end),0) '2nd Week_Arrear_Amount',

  count(distinct case when NumInstallmentsInArrears='3'
   and currentinstallmentperiod<=loandurationinweeks
  then left(clientloanid,14) end) '3rd Week Arrear',
isnull(sum( case when NumInstallmentsInArrears='3'
  and currentinstallmentperiod<=loandurationinweeks
  then (principalinarrears+interestinarrears) end),0) '3rd Week Arrear_Amount',

  count(distinct case when NumInstallmentsInArrears='4' and currentinstallmentperiod<=loandurationinweeks
  then left(clientloanid,14) end) '4th Week Arrear',
isnull(sum( case when NumInstallmentsInArrears='4' and currentinstallmentperiod<=loandurationinweeks
  then (principalinarrears+interestinarrears) end),0) '4th Week Arrear_Amount',


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

from ClientLoanSubscription with (nolock)  
inner join Centers with (nolock)  on centers.centerid=left(clientloanid,8)
inner join Branches  with (nolock)  on branches.BranchID=centers.BranchID
inner join FieldStaff  with (nolock)  on fieldstaff.StaffID=centers.StaffID
where ActualPaidUpDate is null  and ClientLoanSubscription.regionid in ('14')

group by Branches.BranchID,BranchName,centers.StaffID,StaffName,centers.centerid,centers.centername

order by Branches.BranchID,BranchName,centers.StaffID,StaffName
