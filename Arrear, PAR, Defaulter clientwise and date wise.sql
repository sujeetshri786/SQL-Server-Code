
;With Shuklaji as(Select 
row_number() over(partition by Cls.LoanproposalID order by TransactionDate ) d,
TransactionDate,Cls.ClientloaniD,Cls.LoanproposalID from MasterActivity..NewRisk nr(nolock) inner join
ClientLoanSubscription cls(nolock) on nr.LoanProposalID=cls.LoanProposalID and cls.PrincipalOutstanding>0 and cls.ActualPaidUpDate is null
and left(cls.branchid,2) in ('28'))Select * into #SKS1 from shuklaji where d=1


Select isnull(B.TransactionDate,A.NPA_Date)NPADate, A.ClientName,A.MobileNumber,A.Husbandname,A.ARO_ID,  A.ARO_NAME,A.chid, A.CH_NAME,A.Staffid,A.Staffname,A.MeetingDay,A.CenterID,
A.Centername,A.loanamountdisbursed,A.disbursementdate,A.WeeklyInstallmentAmt,A.PrincipalOutstanding,A.NumInstallmentsInArrears,
A.interestinarrears,A.PrincipalInArrears,A.Remarks
from(
SELECT  clientloansubscription.NPA_Date,   clientloansubscription.LoanProposalID,clientloansubscription.ClientLoanID +'/'+Targets.TargetName as ClientName,clientloanproposal.MobileNumber,clientloanproposal.Husbandname,

Branches.AMID ARO_ID,  (select STAFFNAME from fieldstaff With (NoLock)  where staffid=Branches.AMID) ARO_NAME,
Branches.chid, (select STAFFNAME from fieldstaff With (NoLock) where staffid=Branches.chid) CH_NAME   ,

fs.Staffid,fs.Staffname,Case When centers.ReportingDay=1 Then 'Monday'
       When centers.ReportingDay=2 Then 'Tuesday'
       When centers.ReportingDay=3 Then 'Wednesday'
       When centers.ReportingDay=4 Then 'Thursday'
       When centers.ReportingDay=5 Then 'Friday'
       When centers.ReportingDay=6 Then 'Saturday' End as MeetingDay,
                   centers.CenterID,centers.Centername,   
               ClientLoanSubscription.loanamountdisbursed,ClientLoanSubscription.disbursementdate,ClientLoanSubscription.WeeklyInstallmentAmt,
                       ClientLoanSubscription.PrincipalOutstanding,clientloansubscription.NumInstallmentsInArrears,
                      clientloansubscription.interestinarrears,clientloansubscription.PrincipalInArrears,
                                    Case when  (ClientLoanSubscription.CurrentInstallmentPeriod > ClientLoanSubscription.LoanDurationInWeeks)
                                    then 'Defaulter' Else 'Risk' End Remarks
FROM         Centers INNER JOIN
                      Branches With (NoLock) ON Centers.BranchID = Branches.BranchID INNER JOIN
                      Groups With (NoLock) ON Centers.CenterID = Groups.CenterID INNER JOIN
                      Clients With (NoLock) ON Groups.GroupID = Clients.GroupID INNER JOIN
                      ClientLoanProposal With (NoLock) ON Clients.ClientID = ClientLoanProposal.ClientID INNER JOIN
                      ClientLoanSubscription (NoLock) On
                     ClientLoanProposal.LoanProposalID = ClientLoanSubscription.LoanProposalID INNER JOIN
                      Targets ON Clients.TargetID = Targets.TargetID
                                    inner join fieldstaff as fs With (NoLock)  on fs.staffid=centers.staffid
                                                              WHERE     (ClientLoanSubscription.ActualPaidUpDate IS NULL) AND 
                      ((ClientLoanSubscription.CurrentInstallmentPeriod <= ClientLoanSubscription.LoanDurationInWeeks) AND 
                      (ClientLoanSubscription.NumInstallmentsInArrears >4) or  
                                    (ClientLoanSubscription.CurrentInstallmentPeriod > ClientLoanSubscription.LoanDurationInWeeks))
                                  and left(ClientLoanSubscription.branchid,2) in ('28')
) A
Left Join
(Select LoanProposalID,TransactionDate from #SKS1)B on B.LoanProposalID=A.LoanProposalID                                                    
