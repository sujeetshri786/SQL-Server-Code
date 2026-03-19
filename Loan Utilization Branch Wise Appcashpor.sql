--Loan Utilization Branch Wise Appcashpor Sourabh Sir

select LEFT(ClientLoanID,5)as BID,
(select branchname from Branches b where b.branchid=LEFT(ClientLoanID,5))as BranchName,c.StaffId,F.StaffName,
COUNT(ClientLoanID ) as TotalDisb, sum(case when cm_reviewDate IS Not NULL then 1 else 0 end )as CMNotReview,
sum(case when bm_reviewDate IS Not NULL then 1 else 0 end )as BMNotReview,
sum(case when Am_reviewDate IS Not NULL then 1 else 0 end )as CHIBNotReview,
sum(case when aro_reviewdate IS Not NULL then 1 else 0 end )as ARONotReview
from Loan_Utilisation
inner join centers c on left(Loan_Utilisation.ClientLoanID,8)=c.CenterID
inner join FieldStaff f on c.StaffID=f.StaffID where 
/*--CONVERT(varchar (10),loandisbursementdate ,23)<= CONVERT(varchar(10),GETDATE()-15,23) and*/
 ClientLoanID in ( select ClientLoanID  from ClientLoanProposal where PrincipalOutstanding >1)
  and loandisbursementdate between '2024-07-01' and '2024-07-31'
  and LEFT(clientloanid,2)='05'
/*--and LEFT(ProductCategory ,2) not IN('EM','EN','WA','FL'))*/
group by LEFT(ClientLoanID,5),c.StaffId,F.StaffName
order by LEFT(ClientLoanID,5)


---MANISH SIR
select LEFT(ClientLoanID ,5) as BID,(select BranchName  from Branches with(nolock) 
where BranchID =LEFT(ClientLoanID ,5)) as 'BranchName',DATEPART (YEAR ,loandisbursementdate )as Year ,
DATENAME (MONTH ,loandisbursementdate )as Month,COUNT(ClientLoanID )as TotalDisb,
ISNULL( sum ( case when cm_reviewDate IS not null then 1 end  ),0) as CmReview,
ISNULL( sum ( case when bm_reviewDate  IS not null then 1 end  ),0) as BMReview,
isnull(sum ( case when Am_reviewDate  IS not null then 1 end  ),0) as CHIBReview,
isnull(sum ( case when Aro_ReviewDate  IS not null then 1 end  ),0) as AROReview
from Loan_Utilisation where loandisbursementdate between '2025-08-01' and '2025-11-30' and ClientLoanID like '05%'
group by LEFT(ClientLoanID ,5) ,DATEPART (YEAR ,loandisbursementdate ), DATENAME (MONTH ,loandisbursementdate ),DATEPART (MONTH  ,loandisbursementdate )
order by LEFT(ClientLoanID ,5),DATEPART (YEAR ,loandisbursementdate ),DATEPART (MONTH  ,loandisbursementdate )


-- Branch wise
  select B.branchId,B.BranchName,
(select top 1 staffid from fieldstaff with(nolock) where designation='16' and exitdate is null and Branchid=b.Branchid) as BMId,
(select top 1 StaffName from fieldstaff with(nolock) where designation='16' and exitdate is null and Branchid=b.Branchid) as BMName,

(select count(ClientLoanID) from loan_utilisation with(nolock) where left(ClientLoanID,5)=b.branchid  and
cm_reviewDate='2022-10-20') as NOOfCMReview,

(select count(ClientLoanID) from loan_utilisation with(nolock) where left(ClientLoanID,5)=b.branchid  and
BM_reviewDate='2022-10-20') as NOOfBMReview,

(select count(ClientLoanID) from loan_utilisation with(nolock) where left(ClientLoanID,5)=b.branchid  and
Am_reviewDate='2022-10-20') as NOOfCHIBReview

from branches b where dissolveddate is null and left(b.branchid,2) in('31')
order by b.branchid
