--Center wise ALC, Arear, Par, and Default from BOOKDEPT

select  ZoneName,DistrictName,BranchID,BranchName,   


CenterID,CenterName,count (distinct left(ClientLoanID,14)) as NoofALC,

( select ISNULL (SUM(PrincipalOutstanding),0) from bookdept with(nolock) where a.Cenetrstaffid=Cenetrstaffid
and LEFT(clientloanid,8)=a.CenterID  and  ActualPaidUpDate is null and  MonthDate='2025-04-30' )as 'Out',


( select ISNULL (count (distinct left(ClientLoanID,14)),0) from bookdept with(nolock) where a.Cenetrstaffid=Cenetrstaffid
and LEFT(clientloanid,8)=a.CenterID  and  ActualPaidUpDate is null and NumInstallmentsInArrears between 1 and 4
and CurrentInstallmentPeriod <=LoanDurationInWeeks and  MonthDate='2025-04-30'  )as 'Num_Arrear',

( select ISNULL (SUM(PrincipalOutstanding),0) from bookdept with(nolock) where a.Cenetrstaffid=Cenetrstaffid
and LEFT(clientloanid,8)=a.CenterID  and  ActualPaidUpDate is null and NumInstallmentsInArrears between 1 and 4
and CurrentInstallmentPeriod <=LoanDurationInWeeks and  MonthDate='2025-04-30'  )as 'Arrear',


( select ISNULL (count (distinct left(ClientLoanID,14)),0) from bookdept with(nolock) where a.Cenetrstaffid=Cenetrstaffid
and LEFT(clientloanid,8)=a.CenterID  and  ActualPaidUpDate is null and NumInstallmentsInArrears >4
and CurrentInstallmentPeriod <=LoanDurationInWeeks and  MonthDate='2025-04-30'  )as 'Num_PAR',

( select ISNULL (SUM(PrincipalOutstanding),0) from bookdept with(nolock) where a.Cenetrstaffid=Cenetrstaffid
and LEFT(clientloanid,8)=a.CenterID  and  ActualPaidUpDate is null and NumInstallmentsInArrears >4
and CurrentInstallmentPeriod <=LoanDurationInWeeks and  MonthDate='2025-04-30'  )as 'PAR',

( select ISNULL (count (distinct left(ClientLoanID,14)),0) from bookdept with(nolock) where a.Cenetrstaffid=Cenetrstaffid   
and LEFT(clientloanid,8)=a.CenterID and ActualPaidUpDate is null 
and CurrentInstallmentPeriod >LoanDurationInWeeks  and  MonthDate='2025-04-30' )as 'Num_def',

( select ISNULL (SUM(PrincipalOutstanding),0) from bookdept with(nolock) where a.Cenetrstaffid=Cenetrstaffid   
and LEFT(clientloanid,8)=a.CenterID and ActualPaidUpDate is null 
and CurrentInstallmentPeriod >LoanDurationInWeeks  and  MonthDate='2025-04-30' )as 'def'

from bookdept as a with (nolock) where  convert(varchar(10),monthdate,23)='2025-04-30' 
and  centerid  like  '28%'
group by  ZoneName,DistrictName,BranchID,BranchName,CenterID,CenterName,Cenetrstaffid

