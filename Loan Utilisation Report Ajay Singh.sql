-------------------Center Visit Not Done Report By BM Appcashpor Mei------------------

select branchid,CenterID ,CenterName ,case when ReportingDay =1 then 'Mon'
when ReportingDay =2 then 'Tus' when ReportingDay =3 then 'Wed'when ReportingDay =4 then 'Thu' when ReportingDay =5 then 'Fri'
when ReportingDay =6 then 'Sat' end as 'ReportingDay'
 from Centers where DissolvedDate is null and branchid like '32%' and CenterID not  in ( select Location_id  from TrackVisit 
where DateStamp >='2022-07-01' and StaffID in ( select StaffID from FieldStaff where Designation in('16','6')) )
order by branchid



--select *  from TrackVisit  where DateStamp >='2022-04-01' and StaffID='10676' in ( select StaffID from FieldStaff where Designation in('16') and staffid= '10676')
-------------------Center Visit Not Done Report By CHIB Appcashpor Mei------------------

select branchid,CenterID ,CenterName ,case when ReportingDay =1 then 'Mon'
when ReportingDay =2 then 'Tus' when ReportingDay =3 then 'Wed'when ReportingDay =4 then 'Thu' when ReportingDay =5 then 'Fri'
when ReportingDay =6 then 'Sat' end as 'ReportingDay'
 from Centers where DissolvedDate is null and branchid like '32%' and CenterID not  in ( select Location_id  from TrackVisit 
where DateStamp >='2022-07-01' and StaffID in ( select StaffID from FieldStaff where Designation in('30','31')) ) 
order by branchid


-------------------Center Visit Not Done Report By ARO Appcashpor Mei------------------

select branchid,CenterID ,CenterName ,case when ReportingDay =1 then 'Mon'
when ReportingDay =2 then 'Tus' when ReportingDay =3 then 'Wed'when ReportingDay =4 then 'Thu' when ReportingDay =5 then 'Fri'
when ReportingDay =6 then 'Sat' end as 'ReportingDay'
 from Centers where DissolvedDate is null and branchid like '32%' and CenterID not  in ( select Location_id  from TrackVisit 
where DateStamp >='2021-04-01' and StaffID in ( select StaffID from FieldStaff where Designation in('7')) ) 



-----------------------------YE SARA PROCEDURE NICHE DATABASE MEI RUN KARANA HAI-----------------

--------------------------NON BC NEXT DAY DUE DISBURSEMENT (BRANCH WISE)----------------------
SELECT left(clientloanproposal.clientid,5)as Branchid, Branches.BranchName,
    					count(ClientLoanProposal.clientid),SUM(ClientLoanProposal.LoanAmountApproved)
                      FROM   Branches INNER JOIN
                      ClientLoanProposal ON branches.BranchID = left(clientloanproposal.clientid,5)
                      where ClientLoanProposal.LoanAmountApproved>0 and ClientLoanProposal.LoanDisbursementDate is null 
                      and clientloanproposal.productid not in(select productid from products where type like 'BC INDUS-IND%')
                      and clientloanproposal.FinalReviewDate is not null
                      group by left(clientloanproposal.clientid,5),Branches.BranchName
                      order by left(clientloanproposal.clientid,5),Branches.BranchName                 
                  
---------------------------BC NEXT DAY DUE DISBURSEMENT (BRANCH WISE)----------------------                      
SELECT left(clientloanproposal.clientid,5)as Branchid, Branches.BranchName,
    					count(ClientLoanProposal.clientid),SUM(ClientLoanProposal.LoanAmountApproved)
                      FROM   Branches INNER JOIN
                      ClientLoanProposal ON branches.BranchID = left(clientloanproposal.clientid,5)
                      where ClientLoanProposal.LoanAmountApproved>0 and ClientLoanProposal.LoanDisbursementDate is null 
                      and clientloanproposal.productid in(select productid from products where type like 'BC INDUS-IND%')
                      and clientloanproposal.FinalReviewDate is not null
                      group by left(clientloanproposal.clientid,5),Branches.BranchName 
                      Order by left(clientloanproposal.clientid,5),Branches.BranchName 


=====================================================================================================================================================================================

----- 1st Cycle Ki Clients Jo 1st Loan Disbursed Hua K Liye Procedure Niche Database Mei -----

select * from ClientLoanProposal where LoanDisbursementDate between '2022-09-01' and '2022-09-30' 
and ClientID in (select ClientID from Clients where loancycle='1')


=====================================================================================================================================================================================

--------------ye procedure niche database mei run karana hai auto settelment clientwise k liye---------------------

Select B.DistrictName As RegionName,B.BranchID,B.BranchName,FS.StaffID,FS.StaffName,Cent.CenterID,Cent.CenterName,Case When Cent.ReportingDay=1 Then 'Monday'
	 When Cent.ReportingDay=2 Then 'Tuesday'
	 When Cent.ReportingDay=3 Then 'Wednesday'
	 When Cent.ReportingDay=4 Then 'Thursday'
	 When Cent.ReportingDay=5 Then 'Friday'
	 When Cent.ReportingDay=6 Then 'Saturday' End as MeetingDay,
	 CC.ClientID,TT.TargetName AS ClientName,TT.HusbandName,CLS.ClientLoanID,CLP.ProductCategory,
CLS.LoanAmountDisbursed,CLS.DisbursementDate,
CLS.PrincipalOutstanding,CLS.CurrentInstallmentPeriod,CLS.LoanDurationInWeeks,CLS.ExpectedPaidUpDate from ClientLoanSubscription  AS CLS WITH (NOLOCK)
inner join ClientLoanProposal  As CLP WITH (NOLOCK) ON CLS.LoanProposalID=CLP.LoanProposalID and CLS.ActualPaidUpDate is null and CLP.ProductCategory not in ('ENERGY','WATSAN','Mobile')
and CLS.ExpectedPaidUpDate between '2022-10-01' and '2022-10-31' and CLS.PrincipalOutstanding>0
Inner join Clients AS CC WITH (NOLOCK) On CLP.ClientID=CC.ClientID and CC.DropOutStatus='0'
inner join Targets AS TT WITH (NOLOCK) on CC.TargetID=TT.TargetID
inner join Centers AS Cent With (NOLOCK) on TT.CenterID=Cent.CenterID and Cent.DissolvedDate is null
inner join FieldStaff As FS With (NOLOCK) on Cent.StaffId=FS.StaffId and FS.ExitDate is null
inner join Branches AS B With (Nolock) on Cent.BranchID=B.BranchID and B.DissolvedDate is null
group by B.DistrictName,B.BranchID,B.BranchName,CC.ClientID,CLS.ClientLoanID,CLP.ProductCategory,TT.TargetName,TT.HusbandName,FS.StaffId,FS.StaffName,Cent.CenterID,Cent.CenterName,
ReportingDay,CLS.LoanAmountDisbursed,CLS.DisbursementDate,CLS.PrincipalOutstanding,CLS.CurrentInstallmentPeriod,CLS.LoanDurationInWeeks,CLS.ExpectedPaidUpDate
order by B.BranchID,FS.StaffID,Cent.CenterID,CC.ClientID

=====================================================================================================================================================================================

-----------------------------YE SARA PROCEDURE CM LOAN UTILIZATION K LIYE APPCASHPOR DATABASE MEI RUN KARANA HAI-----------------

Select B.DistrictName,B.BranchID,B.BranchName,FS.StaffID,FS.StaffName,C.CenterID,C.CenterName,LEFT(LU.ClientLoanID,14) As ClientID,T.targetName,LU.loandisbursementdate,
Case when LU.cm_reviewDate IS not null then 'Reviewed' else 'NotReviewed'   end As CmReview from Loan_Utilisation AS LU
inner join Branches AS B On LEFT(LU.targetID,5)=B.BranchID and B.DissolvedDate is null
inner join Centers As C On LEFT(LU.ClientLoanID,8)=C.CenterID and C.DissolvedDate is null
inner join FieldStaff As FS On C.StaffID=FS.StaffID and ExitDate is null
inner join Targets As T On LU.targetID=T.targetid
where LEFT(B.BranchID,2) ='05' and LU.loandisbursementdate>='2025-08-01' and LU.cm_reviewDate is null
group by B.DistrictName,B.BranchID,B.BranchName,FS.StaffID,FS.StaffName,C.CenterID,C.CenterName,LEFT(LU.ClientLoanID,14),T.targetName,LU.loandisbursementdate,LU.cm_reviewDate
order by B.BranchID,FS.StaffID,C.CenterID,LEFT(LU.ClientLoanID,14)

-----------------------------YE SARA PROCEDURE BM LOAN UTILIZATION K LIYE APPCASHPOR DATABASE MEI RUN KARANA HAI-----------------

Select B.DistrictName,B.BranchID,B.BranchName,FS.StaffID,FS.StaffName,C.CenterID,C.CenterName,LEFT(LU.ClientLoanID,14) As ClientID,T.targetName,LU.loandisbursementdate,
Case when LU.bm_reviewDate IS not null then 'Reviewed' else 'NotReviewed'   end As BMReview from Loan_Utilisation AS LU
inner join Branches AS B On LEFT(LU.targetID,5)=B.BranchID and B.DissolvedDate is null
inner join Centers As C On LEFT(LU.ClientLoanID,8)=C.CenterID and C.DissolvedDate is null
inner join FieldStaff As FS On C.StaffID=FS.StaffID and ExitDate is null
inner join Targets As T On LU.targetID=T.targetid
where LEFT(B.BranchID,2) ='05' and LU.loandisbursementdate>='2025-08-01'  and LU.bm_reviewDate is null --and fs.staffid='10676'
group by B.DistrictName,B.BranchID,B.BranchName,FS.StaffID,FS.StaffName,C.CenterID,C.CenterName,LEFT(LU.ClientLoanID,14),T.targetName,LU.loandisbursementdate,LU.bm_reviewDate
order by B.BranchID,FS.StaffID,C.CenterID,LEFT(LU.ClientLoanID,14)

-----------------------------YE SARA PROCEDURE CHIB LOAN UTILIZATION K LIYE APPCASHPOR DATABASE MEI RUN KARANA HAI-----------------

Select B.DistrictName,B.BranchID,B.BranchName,FS.StaffID,FS.StaffName,C.CenterID,C.CenterName,LEFT(LU.ClientLoanID,14) As ClientID,T.targetName,LU.loandisbursementdate,
Case when LU.Am_reviewDate IS not null then 'Reviewed' else 'NotReviewed'   end As AMReview from Loan_Utilisation AS LU
inner join Branches AS B On LEFT(LU.targetID,5)=B.BranchID and B.DissolvedDate is null
inner join Centers As C On LEFT(LU.ClientLoanID,8)=C.CenterID and C.DissolvedDate is null
inner join FieldStaff As FS On C.StaffID=FS.StaffID and ExitDate is null
inner join Targets As T On LU.targetID=T.targetid
where LEFT(B.BranchID,2) ='05' and LU.loandisbursementdate>='2025-08-01' and LU.Am_reviewDate is null
group by B.DistrictName,B.BranchID,B.BranchName,FS.StaffID,FS.StaffName,C.CenterID,C.CenterName,LEFT(LU.ClientLoanID,14),T.targetName,LU.loandisbursementdate,LU.Am_reviewDate
order by B.BranchID,FS.StaffID,C.CenterID,LEFT(LU.ClientLoanID,14)

-----------------------------YE SARA PROCEDURE ARO LOAN UTILIZATION K LIYE APPCASHPOR DATABASE MEI RUN KARANA HAI-----------------

Select B.DistrictName,B.BranchID,B.BranchName,FS.StaffID,FS.StaffName,C.CenterID,C.CenterName,LEFT(LU.ClientLoanID,14) As ClientID,T.targetName,LU.loandisbursementdate,
Case when LU.ARO_reviewDate IS not null then 'Reviewed' else 'NotReviewed'   end As AroReview from Loan_Utilisation AS LU
inner join Branches AS B On LEFT(LU.targetID,5)=B.BranchID and B.DissolvedDate is null
inner join Centers As C On LEFT(LU.ClientLoanID,8)=C.CenterID and C.DissolvedDate is null
inner join FieldStaff As FS On C.StaffID=FS.StaffID and ExitDate is null
inner join Targets As T On LU.targetID=T.targetid
where LEFT(B.BranchID,2) ='05' and LU.loandisbursementdate>='2025-08-01' and LU.ARO_reviewDate is null
group by B.DistrictName,B.BranchID,B.BranchName,FS.StaffID,FS.StaffName,C.CenterID,C.CenterName,LEFT(LU.ClientLoanID,14),T.targetName,LU.loandisbursementdate,LU.ARO_reviewDate
order by B.BranchID,FS.StaffID,C.CenterID,LEFT(LU.ClientLoanID,14)

=====================================================================================================================================================================================

-------------------Husband Aadhar Scan Not Done Report Appcashpor Mei------------------

-----Kaun si Client K Husband ki aadhar scan nahi hua hai Client Wise check karne k liye procedure (APPCASHPOR)----- 
select left(clientid,5) as BranchId,clientid,LoanAmountApproved,FinalReviewDate,ProductCategory,Targetname as clientname,HusbandName,targetage as Clientage,Nominee
from clientloanproposal where left(clientid,2) in ('32')
and FinalReviewDate is not null and CBREnquiry='1' and ApprovalRemarks not like 'Ban%'
and LoanAmountDisbursed='0' and clientid not in (select clientid from Husbandadhar)
order by clientid,finalreviewdate


-----Kaun si Client K Husband ki aadhar scan nahi hua hai Branch Wise check karne k liye procedure (APPCASHPOR)-----
select left(clientid,5),count(clientid) from clientloanproposal where left(clientid,2) in ('32')
and FinalReviewDate is not null and CBREnquiry='1' and ApprovalRemarks not like 'Ban%'
and LoanAmountDisbursed='0' and clientid not in (select clientid from Husbandadhar)
group by left(clientid,5)
order by left(clientid,5)

=====================================================================================================================================================================================

-----APPCASHPOR MEI PROPOSAL NOT REVIEW REPORT K LIYE PROCEDURE-----

select left(clientid,5)as Branchid,Clientid,LoanProposalId,Targetname,Husbandname,Nominee,Proposaldate,Productid,Productcategory,Loandescription,ClientRequestedAmount,NumberOfInstallments,LoanAmountBm,LoanamountApproved,
FinalReviewDate,LoanAmountDisbursed,LoanDisbursementDate,ApprovalRemarks
from clientloanproposal where clientid like '32%' and loandisbursementdate is null --and ProductCategory like '%igl%' 
 and cbrenquiry not in('2','3') and PrincipalOutstanding='1' and ClientLoanProposal.FinalReviewDate is null
order by clientid

=====================================================================================================================================================================================

-----NICHE REPORT DATABASE MEI FUTURE COLLECTION REPORT K LIYE PROCEDURE-----

 --------YE PROCEDURE NICHE "REPORT" MEI RUN KARANE PAR PURE BRANCH KA FUTURE COLLECTION NON BC(IGL) KA BATAYEGA-------------------
use Report
go
SELECT     b.DistrictName,b.BranchID,b.BranchName,SUM(FtlLoanLedger.PrincipalAmount) as PC, sum(FtlLoanLedger.InterestAmount) as IC, 
Sum(FtlLoanLedger.PrincipalAmount+FtlLoanLedger.InterestAmount) as TotalCollection 
FROM         FtlLoanLedger INNER JOIN
                      FTLSubscription ON FtlLoanLedger.LoanProposalID = FTLSubscription.LoanProposalID
         inner join Branches as b On b.branchID=LEFT(FTLSubscription.ClientLoanID,5)         
WHERE     (LEFT(FTLSubscription.ClientLoanID, 2) in ('32')) AND WeeklyTransactionDate between '2021-12-03' and '2021-12-31'
and  FTLSubscription.productid not in (select productid from Giridih..products with (Nolock) where type in ('BC IDBI','BC INDUS-IND'))
and b.dissolveddate is null
GROUP BY b.DistrictName,b.BranchID,b.BranchName
ORDER BY b.BranchID

--------YE PROCEDURE NICHE "REPORT" MEI RUN KARANE PAR PURE BRANCH KA FUTURE COLLECTION BC KA BATAYEGA-------------------

use Report
go
SELECT    LEFT(FTLSubscription.ClientLoanID, 5) as BranchId,SUM(FtlLoanLedger.PrincipalAmount) as PC,SUM( FtlLoanLedger.InterestAmount) AS IC,
Sum(FtlLoanLedger.PrincipalAmount+FtlLoanLedger.InterestAmount) as TotalCollection 
FROM         FtlLoanLedger INNER JOIN
                      FTLSubscription ON FtlLoanLedger.LoanProposalID = FTLSubscription.LoanProposalID
         inner join Branches as b On b.branchID=LEFT(FTLSubscription.ClientLoanID,5)         
WHERE     (LEFT(FTLSubscription.ClientLoanID, 2) in ('32')) AND WeeklyTransactionDate between '2021-12-03' and '2021-12-31'
and  FTLSubscription.productid in (select productid from Giridih..products with (Nolock) where type  in ('BC IDBI','BC INDUS-IND'))
and b.dissolveddate is null
GROUP BY  LEFT(FTLSubscription.ClientLoanID, 5)
ORDER BY BranchID
