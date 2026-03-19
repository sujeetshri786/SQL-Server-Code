----Staff Negative Performance

Select DistrictName,Br.Branchid,BranchName,
Fs.StaffID,StaffName,dm.DesignationName,(case when fs.StatusAct=1 then 'Active' else 'In-Active' end)Staff_Status,fs.BranchJoinDate,
sum(PrincipalCollected) PrincipalCollected,
(Select isnull(sum(LoanamountDisbursed),0) from clientloansubscription with(nolock) where disbursementdate between '2023-04-01' and '2023-09-27'
and staffid=fs.StaffID and ActualPaidUpDate is null) LoanamountDisbursed
from fieldstaff fs with(nolock)
Join Branches br with(nolock) on br.branchid=fs.branchid
Join loanledger ll with(nolock) on  fs.StaffID=ll.StaffID
Join DesignationMaster dm with(nolock) on dm.DesignationID=fs.Designation
where weeklytransactiondate between '2023-04-01' and '2023-09-27' 
Group by DistrictName,Br.Branchid,BranchName,
Fs.StaffID,StaffName,dm.DesignationName,fs.BranchJoinDate,fs.StatusAct
order by DistrictName,Br.Branchid,Fs.StaffID

----------------------------------------------------------------------------------------

Select DistrictName,Br.Branchid,BranchName,
Fs.StaffID,StaffName,dm.DesignationName,(case when fs.StatusAct=1 then 'Active' else 'In-Active' end)Staff_Status,fs.BranchJoinDate,
sum(PrincipalCollected) PrincipalCollected,
(Select isnull(sum(LoanamountDisbursed),0) from clientloansubscription with(nolock) where disbursementdate between '2023-03-10' and '2023-10-07' 
and staffid=fs.StaffID and ActualPaidUpDate is null) LoanamountDisbursed
from fieldstaff fs with(nolock)
Join Branches br with(nolock) on br.branchid=fs.branchid
Join loanledger ll with(nolock) on  fs.StaffID=ll.StaffID
Join DesignationMaster dm with(nolock) on dm.DesignationID=fs.Designation
where weeklytransactiondate between '2024-08-22' and '2024-09-02' --and fs.StaffID IN ()
Group by DistrictName,Br.Branchid,BranchName,
Fs.StaffID,StaffName,dm.DesignationName,fs.BranchJoinDate,fs.StatusAct
order by DistrictName,Br.Branchid,Fs.StaffID


--staff performance local sourabh sir
select B.BranchName,f.BranchID,Staffid,StaffName,
(select count(cls.LoanProposalId) from ClientLoanSubscription as cls with(nolock)
where cls.entryby=f.StaffId and cls.DisbursementDate between '2024-04-24' and '2024-07-18' and ActualPaidUpDate is null) as 'NoOfDisbursed',
(select isnull(sum(cls.LoanAmountDisbursed),0) from ClientLoanSubscription as cls with(nolock)
where cls.entryby=f.StaffId and cls.DisbursementDate between '2024-04-24' and '2024-07-18' and ActualPaidUpDate is null) as 'DisAmount',
(select isnull(sum(PrincipalCollected+InterestCollected),0) from loanledger as l with(nolock)
where l.entryby=f.StaffId and l.WeeklyTransactionDate between '2024-04-24' and '2024-07-18') as 'CollAmount'

from fieldstaff f with(nolock) join branches b with(nolock) on f.Branchid=B.branchid 
 where exitdate is null and Designation in('12','13','14','15','46','47') and staffname not like'%dummy%' and 
 f.BranchID like'39%' order by f.BranchID