---------------------------------------------------------------------------------------------------------------
declare @cid varchar(14)='05:21:ZX:01:19'
Select Eligible_Flexi_Amount,EligibleForFL,Loancycle,EligibleLoanAmount,Comments,* From Clients with (NoLock) 
where ClientID=@CID
Select Clientid, ProductCategory, DateStamp, * from CreditWorthinesstrn with (nolock) where clientid=@CID
Select Clientid,Datestamp,Coborrower,CoborrowerRelation, * from KYC with (nolock) where clientid=@CID
--in(Select  trnloanid from CreditWorthinesstrn with (nolock) where clientid=@CID) 
Select * from LoanAppraisal_ClientDetail with (nolock) where clientid=@CID
Select * from LoanAppraisal_ClientDetailNext with (nolock) where clientid=@CID
Select * from LoanAppraisal_ClientHusbandIncome with (nolock) where clientid=@CID
Select * from LoanAppraisal_ChildrenStaywith1 with (nolock) where clientid=@CID
Select * from LoanAppraisal_ChildrenStaywith2 with (nolock) where clientid=@CID
Select * from LoanAppraisal_ChildrenNotStaywith with (nolock) where clientid=@CID
Select * from LoanAppraisal_CCRDetail1 with (nolock) where clientid=@CID
Select * from LoanAppraisal_CCRDetail1Next with (nolock) where clientid=@CID
Select * from LoanAppraisal_CCRDetail2 with (nolock) where clientid=@CID
Select * from LoanAppraisal_CHIPPIDetail with (nolock) where clientid=@CID
Select * from LoanAppraisal_InsuranceDetail with (nolock) where clientid=@CID
Select * from CreditNeedAssessmenttrn with (nolock) where clientid=@CID
select * from EnqueryStatus with (nolock) where clientid=@CID
select 'Kyc_conf' as Kyc_conf,* from kyc_conf where clientid=@CID
select StatusRemark,* from KycVerificationTRN where clientid=@CID
select 'IndusInddocument' as IndusInddocument,* from IndusInddocument where clientid=@CID
select CBREnquiry,ApprovalRemarks, TRNLoanid, BMID, LoanAmountBM, LoanAmountApproved, FinalreviewDate, principaloutstanding, * from ClientLoanproposal with (Nolock)
where Clientid=@CID and PrincipalOutstanding='1'
select CBREnquiry, TRNLoanid, BMID, LoanAmountBM, LoanAmountApproved, FinalreviewDate, principaloutstanding, * from ClientLoanproposal with (Nolock)
where Clientid=@CID and PrincipalOutstanding>'1'
select CBREnquiry, TRNLoanid, BMID, LoanAmountBM, LoanAmountApproved, FinalreviewDate, principaloutstanding, * from ClientLoanproposal with (Nolock)
where Clientid=@CID and PrincipalOutstanding='0'
Select ClientLoan2UpFrontFee,ClientLoan1UpFrontFee,ClientLoan2InstallmentNumber,ClientLoan1TotalCollected,ClientLoan1AmtDueDisbursed,ClientLoan1AmountDisbursed,* 
From cds2 With (NoLock) Where ClientID=@CID
Select * from CDS3 With (NoLock) Where ClientID = @CID

update clientloanproposal set BmNeftReviewDate = NULL where LoanProposalID = ''

Select BranchID,StaffID,StaffName From FieldStaff With (NoLock) where Designation = '16' And exitdate is null And BranchID like '16%' order by branchid
Select BranchID,StaffID,StaffName From FieldStaff With (NoLock) where Designation = '27' And exitdate is null And BranchID like '16%' order by branchid

--update clientloanproposal set PrincipalOutstanding='49502',LoanDisbursementDate='2023-09-04 00:00:00',LoanAmountDisbursed='50000' where  loanproposalid in ('16:09:38669')
--------------------
--update clientloanProposal set FinalreviewDate = '2023-06-16 00:00:00',LoanAmountBM = '30000' where LoanproposalID = ''
--update clientloanProposal set principaloutstanding='0' where LoanproposalID = ''
--update cds2 set ClientLoan1AmtDueDisbursed = '' Where ClientLoan1ID Like '%'

select * from ATFieldStaff where DateofUpdation>='2022-01-16' and branchid like '16%' and UpdatedRecords<>'' and ExitDate is null
order by DateofUpdation

Select BorrowerType,RequestAmount,OVERDUE_OTH,OVERDUE_OTH,CBRRemark,CBRStatus,OTHER_CURRENTBALANCE,OWN_CURRENTBALANCE,RETAIL_CURRENTBALANCE,
* From CCRMFISUMMARY With (NoLock) Where REFERENCENUMBER in ('14:21:U5:01:50') And CBRRemark LIKE '%BAN%' order by REFERENCENUMBER

Select BorrowerType,RequestAmount,OVERDUE_OTH,OVERDUE_OTH,CBRRemark,CBRStatus,OTHER_CURRENTBALANCE,OWN_CURRENTBALANCE,RETAIL_CURRENTBALANCE,
* From CCRMFISUMMARY With (NoLock) Where REFERENCENUMBER like '05:06:L9%' And CBRRemark LIKE '%BAN%' order by REFERENCENUMBER

Select * From CCRMFILoanDetails  where clientID in ('10:17:44:01:21') and AccountStatus = 'ACTIVE'


SELECT Datestamp,Centerid,* FROM Clientadhar with(nolock) where Adharid IN ('HFEPK0091F')
SELECT * FROM Husbandadhar with(nolock) where Adharid in ('HFEPK0091F')
Select Datestamp,CenterID,ClientID,* from KYC with (nolock) where ClientPrimaryKycmember in ('HFEPK0091F')
Select Datestamp,CenterID,ClientID,* from KYC with (nolock) where HusbandPrimaryKycid in ('HFEPK0091F')
Select Datestamp,CenterID,ClientID,* from KYC with (nolock) where children1PrimaryKycid in ('HFEPK0091F')
Select Datestamp,CenterID,ClientID,* from KYC with (nolock) where children2PrimaryKycid in ('HFEPK0091F')
Select Datestamp,CenterID,ClientID,* from KYC with (nolock) where children3PrimaryKycid in ('HFEPK0091F')
Select Datestamp,CenterID,ClientID,* from KYC with (nolock) where ClientSecondaryKycid in ('HFEPK0091F')

Select * From TargetWithAdhar Where ClientAdharId = '100002551292'

select * from RegionShortName where RID = '11'

Select BorrowerType,RequestAmount,OVERDUE_OTH,OVERDUE_OTH,CBRRemark,CBRStatus,OTHER_CURRENTBALANCE,OWN_CURRENTBALANCE,
* From [43.242.214.235].appcashpor.dbo.CCRMFISUMMARY With (NoLock) Where CustRefField  like '100006159244%' And CBRRemark LIKE '%BAN%' order by REFERENCENUMBER--TrnLoanid

select * from EnqueryStatus with (nolock) where TRNLoanID = '100003099117'

Select Datestamp,CenterID,ClientID,* from KYC with (nolock) where TrnLoanid in ('100001581874')
Select Datestamp,CenterID,ClientID,* from KYC with (nolock) where Datestamp = '2023-01-16'

select Remark,* from KycVerificationTRN where ClientID like '16:29:C5:03:42' --and cast(VarifiedDate as Date) >= '2023-12-16' and Remark = 'Approved'
select * from KycVerificationTRN where ClientID like '16:04:X2:01:41%' and cast(VarifiedDate as Date) >= '2023-10-38' and Remark not like '%%Approved%%'

select * from  EnqueryStatus with (nolock) where left(clientid,5)='35:06' and cast(Datestamp as date) = '2023-04-04'

select * from  EnqueryStatus with (nolock) where TRNLoanID = ''

Select * From Clients With (NoLock) Where ClientID IN ()

Select * From IFSCODE Where IFSC IN  ()

Select PrincipalOutstanding,* From ClientLoanProposal With (NoLock) Where ClientID IN ('16:21:U1:01:39') 
And PrincipalOutstanding = '1' 

Select PrincipalOutstanding,* From ClientLoanProposal With (NoLock) Where ClientID IN ('14:27:50:01:45') And PrincipalOutstanding = '1' 

select * from ClientLoanProposal where LoanProposalID in ('05:19:54561')

select * from ClientLoanProposalHelp where LoanProposalID in ('14:04:46520')

Select * From ClientLoanProposal With (NoLock) Where LoanProposalID Like '05:22:62936%' And PrincipalOutstanding = '1'

Select Intimationsettledate,Intimationdoneby,Intimationdonedt,PrincipalOutstanding,* From ClientLoanProposal With (NoLock) Where LoanProposalID IN ('16:10:16884')

Select * From ClientLoanProposal With (NoLock) Where LoanProposalID IN ('05:18:63691')

Select Bankname,BankBranchname,AccountNumber,IFSCCode,BmAccountNumber,BmIfsccode,FinalAccountNumber,FinalIfsccode From 
ClientLoanProposal With (NoLock) Where LoanProposalID IN ('16:24:45111')

--update ClientLoanProposal Set PrincipalOutstanding = '0' Where LoanProposalID IN ('05:03:49643')

Select ClientLoan1AmtDueDisbursed,ClientLoan1AmountDisbursed,* From cds2 With (NoLock) 
Where Clientid Like '%' and ClientLoan1AmtDueDisbursed>'0' AND ClientLoan1AmountDisbursed > '0'--and SUBSTRING(ClientLoan1ID,16,2) = 'w6' 

Select Sum(ClientLoan1AmountDisbursed) From cds2 With (NoLock) 
Where Clientid Like '%' and ClientLoan1AmtDueDisbursed>'0' AND ClientLoan1AmountDisbursed > '0'

Select * From MinsureSurvey Where CollDate = '2023-02-20' And BranchID Like '31:03%'

Select * From EKYCICICI With (NoLock) Where ClientID Like '%' And KYCMismatch Like '%Approved%'--ekyc print11640093-723464216941

Select * From EKYCICICI With (NoLock) Where ClientID in ()
Select ClientID,* From Ekycdetail With (NoLock) Where ClientID  like '14:11:HN:01:82%'
Select ClientID,* From Ekycdata With (NoLock) Where ClientID like '14:11:HN:01:82%'

Select ClientID,* From Ekycdetail With (NoLock) Where uid  = 'HFEPK0091F'
Select ClientID,* From Ekycdata With (NoLock) Where uid = 'HFEPK0091F'

Select ClientID , * From Ekycdetail With (NoLock) Where ClientID like '16%' and cast(Datestamp as date) = '2024-10-22' order by Datestamp desc

Select ClientID , * From Ekycdata With (NoLock) Where ClientID like '16%' and cast(Datestamp as date) = '2024-04-16' order by Datestamp desc

Select ClientID , * From Ekycdetail With (NoLock) Where cast(Datestamp as date) = '2024-01-31' order by Datestamp desc

Select ClientID,* From Ekycdetail With (NoLock) Where cast(Datestamp as date) = '2024-08-28' and clientid like '16%' order by Datestamp desc

update Ekycdetail set Pincode = 'jasau' Where ClientID in ('16:01:A7:01:24') and ID = '744112'

Select * From Ekycdetail where Datestamp >= '2024-09-06' and Centerid = Clientid and clientid like '05%' order by Datestamp desc

Select * From [43.242.214.235].appcashpor.dbo.kyc where Cast(Datestamp as Date) >= '2026-02-18' and Centerid = Clientid and clientid like '05%' order by Datestamp desc
Select * From [43.242.214.235].appcashpor.dbo.kyc where Cast(Datestamp as Date) >= '2026-02-18' and Centerid = LEFT(Clientid,8) and clientid like '05%' order by Datestamp desc

Select * From Ekycdetail With (NoLock) Where UID in ()

Select * from Nominee_Relation_Master

Select * From cds2 With (NoLock) Where ClientID in () And ClientLoan1Balance = '0'

Select Intimationsettledate,Intimationdoneby,Intimationdonedt,PrincipalOutstanding,LoanAmountApproved,* From ClientLoanProposal With (Nolock) 
where clientId in () And ProductID in (Select productId From products where Loan_category ='0') order by ClientID

Select productId,* From products where Loan_category ='0'

Select CenterID,ClientID,* from KYC with (nolock) where ClientPrimaryKycmember in ('435411814013')
Select  * from [43.242.214.235].appcashpor.dbo.KYC with (nolock) where ClientID = '14:19:47:01:63'
Select * from [43.242.214.235].appcashpor.dbo.KYC with (nolock) where  ClientID Like '05%' and cast(Datestamp as date) = '2026-02-17' ORDER BY Datestamp Desc

Select  Staffid,Datestamp,CenterID,ClientID,* from [43.242.214.235].appcashpor.dbo.KYC with (nolock) where  ClientID Like '14%' and  ClientPrimaryNameasperkyc like '%%Miniya%%' and 
ClientPrimaryKYCMember like '%6718'
Select  Staffid,Datestamp,CenterID,ClientID,* from [43.242.214.235].appcashpor.dbo.KYC with (nolock) where  ClientID Like '14%' and  HusbandPrimaryNameasperkyc like '%%Bhusan%%' and 
HusbandPrimaryKycid like '%8340'
Select  Staffid,Datestamp,CenterID,ClientID,* from [43.242.214.235].appcashpor.dbo.KYC with (nolock) where  ClientID Like '14%' and  children1PrimaryNameasperkyc like '%%Bhusan%%' and 
children1PrimaryKycid like '%8340'
Select  Staffid,Datestamp,CenterID,ClientID,* from [43.242.214.235].appcashpor.dbo.KYC with (nolock) where  ClientID Like '14%' and  children2PrimaryNameasperkyc like '%%Bhusan%%' and 
children2PrimaryKycid like '%8340'
Select  Staffid,Datestamp,CenterID,ClientID,* from [43.242.214.235].appcashpor.dbo.KYC with (nolock) where  ClientID Like '14%' and  children3PrimaryNameasperkyc like '%%Bhusan%%' and 
children3PrimaryKycid like '%8340'
Select  Staffid,Datestamp,CenterID,ClientID,* from [43.242.214.235].appcashpor.dbo.KYC with (nolock) where  ClientID Like '14%' and  children2PrimaryNameasperkyc like '%%Bhusan%%' and 
children2PrimaryKycid like '%8340'

select * from KYC where ClientSecondaryKycid in ('ijh2972701')

SELECT  * FROM [43.242.214.235].appcashpor.dbo.KYC with(nolock)where ClientPrimaryKycmember like '%8321' and ClientPrimaryNameAsPerKYC like '%%Rinku%%' 
and ClientID like '14%'

SELECT  * FROM [43.242.214.235].appcashpor.dbo.Clientadhar with(nolock)where Adharid like '%8321' and ClientName like '%%Rinku%%' and ClientID like '14%'

Select  * from [43.242.214.235].appcashpor.dbo.ClientAdhar with (nolock) where Clientname like '%%Mansha%%' and AdharId like '%4715' and ClientID like '05%'
Select  Staffid,Datestamp,CenterID,ClientID,* from ClientAdhar with (nolock) where  ClientID Like '10:13:63%' and Clientname like '%%kAUSHLAY%%'
select * from [43.242.214.235].appcashpor.dbo.KYC where clientID in ('14:19:02:03:21')
select * from [43.242.214.235].appcashpor.dbo.ClientAdhar where clientID in ('14:29:A6:01:17')
select * from [43.242.214.235].appcashpor.dbo.KYC where ClientPrimaryKycmember in ('6200706671')
select * from [43.242.214.235].appcashpor.dbo.KYC where ClientPrimaryMobileNumber in ('6200706671')
select * from [43.242.214.235].appcashpor.dbo.KYC where HusbandPrimaryKycid in ('HFEPK0091F')
Select * from [43.242.214.235].appcashpor.dbo.KYC_Conf where clientID in ('05:19:C3:01:15')
select * from [43.242.214.235].appcashpor.dbo.KYC where Kyctranid in ('100001874648')
select * from [43.242.214.235].appcashpor.dbo.KYC where ClientSecondaryKycid in ('800763903260')
select * from [43.242.214.235].appcashpor.dbo.KYC where ClientPrimaryKycmember like '%********7371%' and clientid like '10:02:G3:01%'

Select Intimationsettledate,Intimationdoneby,Intimationdonedt,PrincipalOutstanding,* From ClientLoanProposal with(nolock) 
Where ClientID in ('31:38:96:01:18')--Proposal Check

Select  * from KYC with (nolock) where TrnLoanID = '35:38:38:01'

Select * From CCRMFILOANDETAILS
--CCRMFILOANDETAILS

--After Delition Check 
Select * From ATDeleteCLP With (NoLock) Where ClientId IN () and 
cast(DateStamp as date) >= '2023-12-09' order by DateStamp


Select * From KYC_CONF With (NoLock) Where ClientId like '16%'
 
Select * From ProposalDeactivation With (NoLock) Where ClientId like '05:11:P8:01:15%'
Select * from LoanProposalDeletion Where ClientID = '28:19:90:01:26'
 
Select * From ATDeleteCLP With (NoLock) Where ClientId like '14:15:42:01:63%' and cast(DateStamp as date) = '2023-12-16' order by DateStamp desc

Select * From ATDeleteKYCClientAadhaar With (NoLock) Where ClientId like '05:19:AM:01:11%' and cast(DateStamp as date) = '2023-12-16' order by DateStamp desc
Select * from [43.242.214.235].appcashpor.dbo.KYC_Backup

Select * From ATDeleteNEFTCLP With (NoLock) Where ClientId like '14:13:84:01:48%' and cast(DateStamp as date) > '2023-03-31' order by clientID

Select * From ATDeleteKYCHusbandAadhaar With (NoLock) Where ClientId like '16%' and cast(DateStamp as date) > '2023-03-31'

--

----Akshat
Select Eligible_Flexi_Amount,EligibleForFL,Loancycle,EligibleLoanAmount,Comments,* From Clients with (NoLock) where ClientID='10:12:34:01:71'
Select  AppMode,ReviewedBy,ReviewedDate,loanamountappliedbyclient,loanamount,* from CreditWorthinesstrn with (nolock) Where  ClientID='10:12:34:01:71'
Select * from KYC with (nolock) where  trnloanid in( Select  trnloanid from CreditWorthinesstrn with (nolock) where ClientID='10:12:34:01:71')
Select * from KYC with (nolock) Where ClientID='10:12:34:01:71'
Select  AppMode,ReviewedBy,ReviewedDate,* from LoanAppraisal_ClientDetail with (nolock) Where ClientID='10:12:34:01:71'  
Select  AppMode,ReviewedBy,ReviewedDate,* from LoanAppraisal_ClientDetailNext with (nolock) Where ClientID='10:12:34:01:71'  
Select  AppMode,ReviewedBy,ReviewedDate,* from LoanAppraisal_ClientHusbandIncome with (nolock) Where ClientID='10:12:34:01:71'   
Select  AppMode,ReviewedBy,ReviewedDate,* from LoanAppraisal_ChildrenStaywith1 with (nolock) Where ClientID='10:12:34:01:71'   
Select  AppMode,ReviewedBy,ReviewedDate,* from LoanAppraisal_ChildrenStaywith2 with (nolock) Where ClientID='10:12:34:01:71'
Select  AppMode,ReviewedBy,ReviewedDate,* from LoanAppraisal_ChildrenNotStaywith with (nolock) Where ClientID='10:12:34:01:71'
Select  AppMode,ReviewedBy,ReviewedDate,* from LoanAppraisal_CCRDetail1 with (nolock) Where ClientID='10:12:34:01:71'
Select  AppMode,ReviewedBy,ReviewedDate,* from LoanAppraisal_CCRDetail1Next with (nolock) Where ClientID='10:12:34:01:71'   
Select  AppMode,ReviewedBy,ReviewedDate,* from LoanAppraisal_CCRDetail2 with (nolock) Where ClientID='10:12:34:01:71'
Select  AppMode,ReviewedBy,ReviewedDate,* from LoanAppraisal_InsuranceDetail with (nolock) Where ClientID='10:12:34:01:71'
Select  AppMode,ReviewedBy,ReviewedDate,* from LoanAppraisal_CHIPPIDetail with (nolock) Where ClientID='10:12:34:01:71'  
Select  AppMode,ReviewedBy,ReviewedDate,* from CreditNeedAssessmenttrn with (nolock) Where ClientID='10:12:34:01:71'
Select  * from enquerystatus with (nolock) Where ClientID='10:12:34:01:71'  
select CBREnquiry, TRNLoanid, BMID, LoanAmountBM, LoanAmountApproved, FinalreviewDate, principaloutstanding, * from ClientLoanproposal with (Nolock)
where Clientid='10:12:34:01:71'

--Akshat
 --select finalreviewdate,cbrenquiry,approvalRemarks,* from clientloanproposal (nolock) where clientid='10:12:34:01:71' and ProposalDate>='2022-16-23' --and principaloutstanding>2
select trnloanid,finalreviewdate,BmNeftReviewDate,KYCNo,principaloutstanding,productcategory,loanproposalid,intimationsettledate,cbrenquiry,disbursementmode,clientid,approvalremarks,* from ClientLoanProposal with (nolock)
where ClientID='10:12:34:01:71' and ProposalDate>='2022-16-23'

Select trnloanid, ProductCategory, DateStamp, * from CreditWorthinesstrn with (nolock) where trnloanid=11801680
Select  * from KYC with (nolock) where trnloanid
in(Select  trnloanid from CreditWorthinesstrn with (nolock) where trnloanid=11801680) 
Select  * from LoanAppraisal_ClientDetail with (nolock) where trnloanid=11801680
Select  * from LoanAppraisal_ClientDetailNext with (nolock) where trnloanid=11801680
Select  * from LoanAppraisal_ClientHusbandIncome with (nolock) where trnloanid=11801680
Select  * from LoanAppraisal_ChildrenStaywith1 with (nolock) where trnloanid=11801680
Select  * from LoanAppraisal_ChildrenStaywith2 with (nolock) where trnloanid=11801680
Select  * from LoanAppraisal_ChildrenNotStaywith with (nolock) where trnloanid=11801680
Select  * from LoanAppraisal_CCRDetail1 with (nolock) where trnloanid=11801680
Select  * from LoanAppraisal_CCRDetail1Next with (nolock) where trnloanid=11801680
Select  * from LoanAppraisal_CCRDetail2 with (nolock) where trnloanid=11801680
Select  * from LoanAppraisal_CHIPPIDetail with (nolock) where trnloanid=11801680
Select  * from LoanAppraisal_InsuranceDetail with (nolock) where trnloanid=11801680
Select  * from CreditNeedAssessmenttrn with (nolock) where trnloanid=11801680
select CBREnquiry, TRNLoanid, BMID, LoanAmountBM, LoanAmountApproved, FinalreviewDate, * from ClientLoanproposal with (Nolock)
where trnloanid=11801680 and PrincipalOutstanding='1'

--Flexi 
declare @CID varchar(16) ='21:23:36:01:30'
select 'clients',* from clients where clientid =@CID
select 'CreditWorthinesstrn',*  from CreditWorthinesstrn  with (nolock) where clientid=@CID
  select 'CreditWorthinesstrnFlexi',*  from CreditWorthinesstrnFlexi  with (nolock) where clientid=@CID    ---- for FLEXI
Select '1kYC', * from KYC with (nolock) where ClientID  =@CID
--Select 'kYC', * from KYC with (nolock) where ClientPrimaryKycmember ='972174497161'
--Select 'kYC', * from KYC with (nolock) where ClientPrimaryKycmember ='260488816206'
Select 'kYC', * from KYC with (nolock) where trnloanid 
 in(Select  trnloanid from CreditWorthinesstrn with (nolock) where clientid=@CID)
select 'LoanAppraisal_ClientDetail',*  from LoanAppraisal_ClientDetail  with (nolock) where clientid=@CID
select 'LoanAppraisal_ClientDetailflaxy',*  from LoanAppraisal_ClientDetail  with (nolock) where clientid=@CID
select 'LoanAppraisal_ClientDetailNext',*  from LoanAppraisal_ClientDetailNext with (nolock) where clientid= @CID
select 'LoanAppraisal_ClientHusbandIncome',*  from LoanAppraisal_ClientHusbandIncome with (nolock) where clientid= @CID
select 'LoanAppraisal_ChildrenStaywith1',*  from  LoanAppraisal_ChildrenStaywith1 with (nolock) where clientid=@CID
select 'LoanAppraisal_ChildrenStaywith2',*  from LoanAppraisal_ChildrenStaywith2  with (nolock) where clientid=@CID
select 'LoanAppraisal_ChildrenNotStaywith',*  from LoanAppraisal_ChildrenNotStaywith  with (nolock) where clientid=@CID
select 'LoanAppraisal_CCRDetail1',*  from LoanAppraisal_CCRDetail1  with (nolock) where clientid=@CID
select 'LoanAppraisal_CCRDetail1Next',*  from LoanAppraisal_CCRDetail1Next  with (nolock) where clientid=@CID
select 'LoanAppraisal_CCRDetail2',*  from  LoanAppraisal_CCRDetail2  with (nolock) where clientid=@CID
select 'LoanAppraisal_CHIPPIDetail',*  from LoanAppraisal_CHIPPIDetail  with (nolock) where clientid=@CID
select 'LoanAppraisal_InsuranceDetail',*  from  LoanAppraisal_InsuranceDetail  with (nolock) where clientid=@CID
select 'CreditNeedAssessmenttrn',*  from  CreditNeedAssessmenttrn  with (nolock) where clientid=@CID
SELECT  'ClientLoanProposal',CBREnquiry,ApprovalRemarks,BMID,LoanAmountBM,FinalReviewDate,BmNeftReviewDate,Bmrecommenddate, * FROM
ClientLoanProposal WITH(NOLOCK) WHERE CLIENTID=@CID  --and ProposalDate > '2022-16-01'


--declare @CID varchar(16) ='22:16:18:01:17'
--delete  from CreditWorthinesstrn   where clientid=@CID
--delete from KYC   where trnloanid ='10900672'
--in(Select  trnloanid from CreditWorthinesstrn   where clientid=@CID) 
--delete from LoanAppraisal_ClientDetail   where clientid=@CID
--delete from LoanAppraisal_ClientDetailNext   where clientid=@CID
--delete from LoanAppraisal_ClientHusbandIncome   where clientid=@CID
--delete from LoanAppraisal_ChildrenStaywith1   where clientid=@CID
--delete from LoanAppraisal_ChildrenStaywith2 where clientid=@CID
--delete from LoanAppraisal_ChildrenNotStaywith   where clientid=@CID
--delete from LoanAppraisal_CCRDetail1     where clientid=@CID
--delete from LoanAppraisal_CCRDetail1Next   where clientid=@CID
--delete from LoanAppraisal_CCRDetail2   where clientid=@CID
--delete from LoanAppraisal_CHIPPIDetail   where clientid=@CID
--delete from LoanAppraisal_InsuranceDetail   where clientid=@CID
--delete from  EnqueryStatus   where clientid=@CID
--delete from CreditNeedAssessmenttrn where clientid=@CID

--delete from ClientLoanProposal where Clientid='16:10:bb:01:54' and TRNLoanid='10016751'

--select * from TrackVisit where Location_id like '31:38%' and LocationType='c' and cast(Datestamp as date)>='2023-02-20' ---For CEC Track Visit---


select left(a.clientid,2) as Region_id,Count(a.ClientID) as No_Of_Proposal,cast(a.datestamp as date) as Date from CreditWorthinesstrn a inner join KYC b on a.trnloanid=b.trnloanid 
inner join LoanAppraisal_ClientDetail c on a.trnloanid=c.trnloanid and a.Clientid=c.clientid
inner join LoanAppraisal_ClientHusbandIncome e on a.trnloanid=e.trnloanid and a.Clientid=e.clientid
inner join LoanAppraisal_ChildrenStaywith1 f on a.trnloanid=f.trnloanid and a.Clientid=f.clientid
inner join LoanAppraisal_ChildrenStaywith2 g on a.trnloanid=g.trnloanid and a.Clientid=g.clientid
inner join LoanAppraisal_ChildrenNotStaywith h on a.trnloanid=h.trnloanid and a.Clientid=h.clientid
inner join LoanAppraisal_CCRDetail1 i on a.trnloanid=i.trnloanid and a.Clientid=i.clientid
inner join LoanAppraisal_CCRDetail1Next j on a.trnloanid=j.trnloanid and a.Clientid=j.clientid
inner join LoanAppraisal_CCRDetail2 k on a.trnloanid=k.trnloanid and a.Clientid=k.clientid
inner join LoanAppraisal_CHIPPIDetail l on a.trnloanid=l.trnloanid and a.Clientid=l.clientid
inner join LoanAppraisal_InsuranceDetail m on a.trnloanid=m.trnloanid and a.Clientid=m.clientid
inner join CreditNeedAssessmenttrn n on a.trnloanid=n.trnloanid and a.Clientid=n.clientid
where 
left(a.ClientID,2) in('35','10','16','22','21','16')  and 
cast(a.datestamp as date)='2022-16-27'
group by left(a.clientid,2),cast(a.datestamp as date)
order by left(a.clientid,2),cast(a.datestamp as date)


select * from CreditWorthinesstrn a inner join KYC b on a.trnloanid=b.trnloanid 
inner join LoanAppraisal_ClientDetail c on a.trnloanid=c.trnloanid and a.Clientid=c.clientid
inner join LoanAppraisal_ClientDetailNext d on a.trnloanid=d.trnloanid and a.Clientid=d.clientid
inner join LoanAppraisal_ClientHusbandIncome e on a.trnloanid=e.trnloanid and a.Clientid=e.clientid
inner join LoanAppraisal_ChildrenStaywith1 f on a.trnloanid=f.trnloanid and a.Clientid=f.clientid
inner join LoanAppraisal_ChildrenStaywith2 g on a.trnloanid=g.trnloanid and a.Clientid=g.clientid
inner join LoanAppraisal_ChildrenNotStaywith h on a.trnloanid=h.trnloanid and a.Clientid=h.clientid
inner join LoanAppraisal_CCRDetail1 i on a.trnloanid=i.trnloanid and a.Clientid=i.clientid
inner join LoanAppraisal_CCRDetail1Next j on a.trnloanid=j.trnloanid and a.Clientid=j.clientid
inner join LoanAppraisal_CCRDetail2 k on a.trnloanid=k.trnloanid and a.Clientid=k.clientid
inner join LoanAppraisal_CHIPPIDetail l on a.trnloanid=l.trnloanid and a.Clientid=l.clientid
inner join LoanAppraisal_InsuranceDetail m on a.trnloanid=m.trnloanid and a.Clientid=m.clientid
inner join CreditNeedAssessmenttrn n on a.trnloanid=n.trnloanid and a.Clientid=n.clientid
where left(a.ClientID,5) in('16:06')  and cast(a.datestamp as date)='2022-16-26'
--group by left(a.clientid,2),cast(a.datestamp as date)
--order by left(a.clientid,2),cast(a.datestamp as date)

select * from LoanAppraisal_InsuranceDetail where CoborrowerName=KYCNomineeName and KYCNomineeRelation<>0 and Clientid like '10%'

select * from ClientLoanProposal where ClientID like '16:16:zd:01:52%' And proposaldate >= '2022-06-23'

--update CreditWorthinesstrn set EntryBY='16111' where ClientID='16:29:60:01:06' and trnloanid='10123863'

--update CreditWorthinesstrn set AppMode='0', ReviewedBy=NULL, ReviewedDate=NULL, LoanAmtAppliedByClientBM='0', LoanAmtApprovedByCenterBM='0' where Clientid='35:11:02:01:22' and Trnloanid='10163844'

--update ClientLoanProposal set PrincipalOutstanding='0' where PrincipalOutstanding>'1' and ClientID='16:25:17:01:10'

--update CreditNeedAssessmenttrn set Appmode='0', ReviewedBy=NULL, ReviewedDate=NULL where Clientid='16:03:77:01:04' and TRNLoanid='10004161'

--do the worthiness first ---

--update ClientLoanProposal set BMID=NULL, LoanAmountBM='0', LoanAmountApproved='0', FinalReviewDate=NULL 
where ClientID='10:16:ZT:01:55' and TRNLoanid='10122856'

---------------staff Wise------------
select cast(a.datestamp as date) as Date,br.Zone,br.DistrictName, br.BranchID,br.BranchName, fs.staffid,fs.StaffName,
count(n.ClientID) as totalnoofProposalentryindb  from CreditWorthinesstrn a inner join KYC b on a.trnloanid=b.trnloanid 
inner join LoanAppraisal_ClientDetail c on a.trnloanid=c.trnloanid and a.Clientid=c.clientid
inner join LoanAppraisal_ClientDetailNext d on a.trnloanid=d.trnloanid and a.Clientid=d.clientid
inner join LoanAppraisal_ClientHusbandIncome e on a.trnloanid=e.trnloanid and a.Clientid=e.clientid
inner join LoanAppraisal_ChildrenStaywith1 f on a.trnloanid=f.trnloanid and a.Clientid=f.clientid
inner join LoanAppraisal_ChildrenStaywith2 g on a.trnloanid=g.trnloanid and a.Clientid=g.clientid
inner join LoanAppraisal_ChildrenNotStaywith h on a.trnloanid=h.trnloanid and a.Clientid=h.clientid
inner join LoanAppraisal_CCRDetail1 i on a.trnloanid=i.trnloanid and a.Clientid=i.clientid
inner join LoanAppraisal_CCRDetail1Next j on a.trnloanid=j.trnloanid and a.Clientid=j.clientid
inner join LoanAppraisal_CCRDetail2 k on a.trnloanid=k.trnloanid and a.Clientid=k.clientid
inner join LoanAppraisal_CHIPPIDetail l on a.trnloanid=l.trnloanid and a.Clientid=l.clientid
inner join LoanAppraisal_InsuranceDetail m on a.trnloanid=m.trnloanid and a.Clientid=m.clientid
inner join CreditNeedAssessmenttrn n on a.trnloanid=n.trnloanid and a.Clientid=n.clientid
inner join FieldStaff fs with (nolock) on fs.StaffID=n.StaffID
inner join Branches br with (nolock) on br.BranchID=fs.BranchID
where fs.ExitDate is null and br.dissolveddate is null
and left(a.ClientID,2) in ('21') and a.datestamp>='2022-16-26'
group by fs.staffid,fs.StaffName,br.Zone,br.DistrictName, br.BranchID,br.BranchName,a.datestamp
order by a.datestamp
----------------------Client Wise Detail-----
select cast(n.datestamp as date) as entrydate, br.Zone,br.DistrictName, br.BranchID,br.BranchName,
fs.staffid,fs.StaffName,n.ClientID,c.ClientName from CreditWorthinesstrn a inner join KYC b on a.trnloanid=b.trnloanid 
inner join LoanAppraisal_ClientDetail c on a.trnloanid=c.trnloanid and a.Clientid=c.clientid
inner join LoanAppraisal_ClientDetailNext d on a.trnloanid=d.trnloanid and a.Clientid=d.clientid
inner join LoanAppraisal_ClientHusbandIncome e on a.trnloanid=e.trnloanid and a.Clientid=e.clientid
inner join LoanAppraisal_ChildrenStaywith1 f on a.trnloanid=f.trnloanid and a.Clientid=f.clientid
inner join LoanAppraisal_ChildrenStaywith2 g on a.trnloanid=g.trnloanid and a.Clientid=g.clientid
inner join LoanAppraisal_ChildrenNotStaywith h on a.trnloanid=h.trnloanid and a.Clientid=h.clientid
inner join LoanAppraisal_CCRDetail1 i on a.trnloanid=i.trnloanid and a.Clientid=i.clientid
inner join LoanAppraisal_CCRDetail1Next j on a.trnloanid=j.trnloanid and a.Clientid=j.clientid
inner join LoanAppraisal_CCRDetail2 k on a.trnloanid=k.trnloanid and a.Clientid=k.clientid
inner join LoanAppraisal_CHIPPIDetail l on a.trnloanid=l.trnloanid and a.Clientid=l.clientid
inner join LoanAppraisal_InsuranceDetail m on a.trnloanid=m.trnloanid and a.Clientid=m.clientid
inner join CreditNeedAssessmenttrn n on a.trnloanid=n.trnloanid and a.Clientid=n.clientid
inner join FieldStaff fs with (nolock) on fs.StaffID=n.StaffID
inner join Branches br with (nolock) on br.BranchID=fs.BranchID
where fs.ExitDate is null and br.dissolveddate is null
and left(n.ClientID,5) in ('10:06') and n.datestamp>='2022-16-23'
order by br.BranchID



Select KYCMismatch,ClientID,TargetName,EnrollmentDate,VerifiedDate From EKYCICICI With (NoLock) Where ClientID IN () 
And KYCMismatch Not Like '%Approved%'--ekyc print

Select * From ClientLoanProposal With (NoLock) Where LoanProposalID IN ('21:17:22889',
'21:26:15240') And PrincipalOutstanding = '1'

Select * From cds2 With (NoLock) Where ClientID IN ()

Select * from KYC with (nolock) where ClientPrimaryKycmember  in ()

Select * From RebateFeb21NeedBank With (NoLock) Where ClientId = '22:26:02:01:27'

Select * from IFSCode With (NoLock) Where IFSC  Like 'CBIN0R10001%'


--Manual Branch Close Details
Select Sum(ClientLoan1AmountDisbursed) AS Disbursement From cds2 With (NoLock) Where ClientID LIKE '10:16%' And ClientLoan1AmtDueDisbursed > '0' 
And ClientLoan1AmountDisbursed >'0'

Select  Sum(ClientLoan1PrincipalCollected+ClientLoan1InterestCollected) As Collection,  Sum(ClientLoan1TotalCollected) As Collection
From cds2 With (NoLock) Where ClientID LIKE '10:16%' And ClientLoan1Balance > '0'

Select Sum(ClientLoan2UpFrontFee) AS Insurance From cds2 With (NoLock) Where ClientID LIKE '10:16%' AND ClientLoan1Balance > '0'

Select Sum(ClientLoan1UpFrontFee) AS Processing From cds2 With (NoLock) Where ClientID LIKE '10:16%' AND ClientLoan1Balance > '0'

select SUM(CollAmount) AS M_Insurance From MInsureSurvey with (Nolock) where clientID Like '10:16%' AND CollDate = '2023-02-16'





Select Sum(ClientLoan1TotalCollected) As CashLess 
From cds2 With (NoLock) Where ClientID Like '10:09%' And ClientLoan1Balance > '0' And ClientLoan2InstallmentNumber in ('1','7','5')

Select Sum(ClientLoan1TotalCollected) As Cash
From cds2 With (NoLock) Where ClientID Like '10:09%' And ClientLoan1Balance > '0' And ClientLoan2InstallmentNumber NOT IN ('1','7','5')


Select * From cds2 With (NoLock) Where ClientID LIKE '10:16%' And ClientLoan1AmtDueDisbursed > '0' 
And ClientLoan1AmountDisbursed >'0'--Disbursement ClientWise

Select ClientLoan2UpFrontFee,ClientLoan1UpFrontFee,ClientLoan2InstallmentNumber,ClientLoan1TotalCollected,  
* From cds2 With (NoLock) Where ClientID Like '10:16%' And ClientLoan1Balance > '0' And ClientLoan2InstallmentNumber in ('1','7','5')-- ClientWise UPI

Select CenterID,Sum(ClientLoan1PrincipalCollected+ClientLoan1InterestCollected) As Collection,  Sum(ClientLoan1TotalCollected) As Collection
From cds2 With (NoLock) Where ClientID LIKE '10:09%' And ClientLoan1Balance > '0'
Group BY CenterID
Order BY CenterID--Center Wise Collection

Select ClientLoan1UpFrontFee,* From cds2 With (NoLock) Where ClientID LIKE '10:09%' AND ClientLoan1Balance > '0' And ClientLoan1UpFrontFee > '0'--ClientWise Insurance

Select * from KYC with (nolock) where  ClientID like '16:02:83:01%'

select clp.ClientId,clp.targetname,clp.ClientLoanID,clp.proposalDate,clp.productId,clp.ProductCategory,clp.entryBy as CMID,fs.staffname as CMName,clp.Bmid as BMID,
(Select staffname from FieldStaff Where StaffId=clp.BmID) as BmName,clp.loanAmountdisbursed,clp.PrincipalOutstanding,clp.loanDisbursementDate,clp.FinalReviewDate
from ClientLoanProposal As CLP With (NoLock) 
Inner Join FieldStaff as fs on fs.staffID=clp.entryBY
Where ClientLoanId IN ('16:15:24245')


--Select * from centers Where StaffId in ('11169',
--'12020',
--'15710') and DissolvedDate is NULL

update centers set ReportingDay='1',CenterMeetingDay='1' where centerid in 
()

update [43.242.214.56].cashporone.dbo.centers set ReportingDay='1',CenterMeetingDay='1' where centerid in 
()


update centers set ReportingDay='2',CenterMeetingDay='2' where centerid in 
()

update [43.242.214.56].cashporone.dbo.centers set ReportingDay='2',CenterMeetingDay='2' where centerid in 
()