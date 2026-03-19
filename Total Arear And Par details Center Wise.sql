------------Total Arear And Par details Center Wise

Select b.BranchID,b.BranchName,f.StaffID+' / '+f.StaffName as StaffIDStaffName,c.CenterID,c.CenterName,
(Select COUNT(distinct(LEFT(ClientLoanID,14))) From ClientLoanSubscription With (Nolock) where LEFT(ClientLoanID,8)=c.CenterID and ActualPaidUpDate is null and
 PrincipalOutstanding>0 and PrincipalOutstanding>0) as NumALC,
(Select COUNT(distinct(LEFT(ClientLoanID,14))) From ClientLoanSubscription With (Nolock) where LEFT(ClientLoanID,8)=c.CenterID and ActualPaidUpDate is null and 
(ClientLoanSubscription.CurrentInstallmentPeriod <= ClientLoanSubscription.LoanDurationInWeeks) and PrincipalOutstanding>0 and NumInstallmentsInArrears in (1,4)) as NumArrearALC, 
(Select COUNT(distinct(LEFT(ClientLoanID,14))) From ClientLoanSubscription With (Nolock) where LEFT(ClientLoanID,8)=c.CenterID and ActualPaidUpDate is null and 
 (ClientLoanSubscription.CurrentInstallmentPeriod <= ClientLoanSubscription.LoanDurationInWeeks) and PrincipalOutstanding>0 and NumInstallmentsInArrears>4) as NumPARALC,
(Select ISNULL(SUM(PrincipalInArrears+InterestInArrears),0) From ClientLoanSubscription With (Nolock) where LEFT(ClientLoanID,8)=c.CenterID and ActualPaidUpDate is null and
 (ClientLoanSubscription.CurrentInstallmentPeriod <= ClientLoanSubscription.LoanDurationInWeeks) and PrincipalOutstanding>0 and NumInstallmentsInArrears>4) as PARAmount,
(Select ISNULL(SUM(PrincipalOutstanding),0) From ClientLoanSubscription With (Nolock) where LEFT(ClientLoanID,8)=c.CenterID and ActualPaidUpDate is null and 
PrincipalOutstanding>0 ) as OutsAmount
From Branches as b With (Nolock) inner join 
FieldStaff as f With (Nolock) on b.BranchID=f.BranchID
inner join Centers as c With (Nolock) on f.BranchID=c.BranchID
and f.StaffID=c.StaffID
where b.DissolvedDate is null
and f.ExitDate is null and c.DissolvedDate is null and  c.centerid like '14%'-- in()
order by b.BranchID,f.StaffID,c.CenterID
