-----------------           proposal details          ---------------------------------

select left(Clientid,5) as BranchID, b.branchname as BranchName, COUNT(clp.loanproposalid) as NumberofProposals, sum(clp.ClientRequestedAmount) as TotalProposalAmount, COUNT(clp.FinalReviewDate) as ReviewedbyBM
from ClientLoanProposal as clp
inner join branches as b on b.branchid=left(clp.Clientid,5)
where ClientID like '28%' and ProposalDate =(convert(nvarchar(10),getdate()-1,23))
group by b.BranchID, left(Clientid,5), b.branchname
Order by b.BranchID, left(Clientid,5)


----------------M Insurance Collection Detail Branch Wise-----Back date
select b.Zone,b.DistrictName As Regionname,b.Branchid,b.Branchname,count(m.clientid) as NO_ALC,sum(collamount) as Amount,PaymentMode 
from    minsuresurvey m inner join branches b  on m.branchid=b.branchid 
 where   cast(m.entrydate as date)= (convert(nvarchar(10),getdate()-1,23))   and b.DistrictName like '%%Siwan%%' 
  and PaymentMode='By self' and rejecteddate is null
group by b.HandleBy,b.Zone,b.DistrictName,b.Branchid,b.Branchname,PaymentMode
order by b.HandleBy,b.Zone,b.DistrictName,b.branchid


----------------Loan_Utilisation details-----



  select B.branchId,B.BranchName,
(select top 1 staffid from fieldstaff with(nolock) where designation='16' and exitdate is null and Branchid=b.Branchid) as BMId,
(select top 1 StaffName from fieldstaff with(nolock) where designation='16' and exitdate is null and Branchid=b.Branchid) as BMName,

(select count(ClientLoanID) from loan_utilisation with(nolock) where left(ClientLoanID,5)=b.branchid  and
cm_reviewDate= (convert(nvarchar(10),getdate()-1,23))) as NOOfCMReview,

(select count(ClientLoanID) from loan_utilisation with(nolock) where left(ClientLoanID,5)=b.branchid  and
BM_reviewDate= (convert(nvarchar(10),getdate()-1,23))) as NOOfBMReview,

(select count(ClientLoanID) from loan_utilisation with(nolock) where left(ClientLoanID,5)=b.branchid  and
Am_reviewDate= (convert(nvarchar(10),getdate()-1,23))) as NOOfCHIBReview

from branches b where dissolveddate is null and left(b.branchid,2) in('10')
order by b.branchid


----------------M Insurance Collection Detail Branch Wise-----betwwen date
select b.Zone,b.DistrictName As Regionname,b.Branchid,b.Branchname,count(m.clientid) as NO_ALC,sum(collamount) as Amount,PaymentMode 
from    minsuresurvey m inner join branches b  on m.branchid=b.branchid 
 where   
 cast(m.entrydate as date)>='2025-11-19'
 --(convert(nvarchar(10),getdate()-1,23))   
 and b.DistrictName like '%%Siwan%%' 
  and PaymentMode='By self' and rejecteddate is null
group by b.HandleBy,b.Zone,b.DistrictName,b.Branchid,b.Branchname,PaymentMode
order by b.HandleBy,b.Zone,b.DistrictName,b.branchid


----------------M Insurance Collection Detail Branch Wise-----Back date
select b.Zone,b.DistrictName As Regionname,b.Branchid,b.Branchname,count(m.clientid) as NO_ALC,sum(collamount) as Amount,PaymentMode 
from    minsuresurvey m inner join branches b  on m.branchid=b.branchid 
 where   cast(m.CollDate as date)>= '2022-04-01'   and b.DistrictName like '%%Sitamarhi%%' 
  and PaymentMode='By self' and rejecteddate is null
group by b.HandleBy,b.Zone,b.DistrictName,b.Branchid,b.Branchname,PaymentMode
order by b.HandleBy,b.Zone,b.DistrictName,b.branchid


----------------Hospicash Details-----

select b.DistrictName ,b.branchid,b.branchname,c.ClientID ,cls.ClientLoanID,cls.LoanProposalID ,t.TargetName ,t.HusbandName  ,cls.LoanAmountDisbursed ,cls.DisbursementDate 
,cls.HealthInsurance ,cls.HealthInsuranceSpouse ,cls.HealthInsuranceDate 
 from clientloansubscription as cls inner join Clients as c on c.clientid=left(cls.clientloanid,14)
inner join targets as t on t.targetid=c.targetid 
inner join Branches  as b on b.branchid=t.branchid
where ActualDisbursementDate = (convert(nvarchar(10),getdate()-1,23)) and 
(HealthInsurance>0 or HealthInsuranceSpouse>0)
order by cls.ClientLoanID

-----------------           proposal details          ---------------------------------

select left(Clientid,5) as BranchID, b.branchname as BranchName, COUNT(clp.loanproposalid) as NumberofProposals, sum(clp.ClientRequestedAmount) as TotalProposalAmount, COUNT(clp.FinalReviewDate) as ReviewedbyBM
from ClientLoanProposal as clp
inner join branches as b on b.branchid=left(clp.Clientid,5)
where ClientID like '14:13%' and ProposalDate = '2023-05-05'
group by b.BranchID, left(Clientid,5), b.branchname
Order by b.BranchID, left(Clientid,5)


----------------M Insurance Collection Detail Branch Wise-----Back date
select b.Zone,b.DistrictName As Regionname,b.Branchid,b.Branchname,count(m.clientid) as NO_ALC,sum(collamount) as Amount,PaymentMode 
from    minsuresurvey m inner join branches b  on m.branchid=b.branchid 
 where   cast(m.entrydate as date)>= '2023-01-01'   and b.DistrictName like '%%SARAN%%' 
  and PaymentMode='By self' and rejecteddate is null
group by b.HandleBy,b.Zone,b.DistrictName,b.Branchid,b.Branchname,PaymentMode
order by b.HandleBy,b.Zone,b.DistrictName,b.branchid


----------------Loan_Utilisation details-----



  select B.branchId,B.BranchName,
(select top 1 staffid from fieldstaff with(nolock) where designation='16' and exitdate is null and Branchid=b.Branchid) as BMId,
(select top 1 StaffName from fieldstaff with(nolock) where designation='16' and exitdate is null and Branchid=b.Branchid) as BMName,

(select count(ClientLoanID) from loan_utilisation with(nolock) where left(ClientLoanID,5)=b.branchid  and
cm_reviewDate= '2023-04-12') as NOOfCMReview,

(select count(ClientLoanID) from loan_utilisation with(nolock) where left(ClientLoanID,5)=b.branchid  and
BM_reviewDate= '2023-04-12') as NOOfBMReview,

(select count(ClientLoanID) from loan_utilisation with(nolock) where left(ClientLoanID,5)=b.branchid  and
Am_reviewDate= '2023-04-12') as NOOfCHIBReview

from branches b where dissolveddate is null and left(b.branchid,2) in('21')
order by b.branchid

