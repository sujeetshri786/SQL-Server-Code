Select Eligible_Flexi_Amount,EligibleForFL,Loancycle,EligibleLoanAmount,Comments,* From Clients with (NoLock) 
where ClientID='14:25:AZ:01:27'
Select Clientid, ProductCategory, DateStamp, * from CreditWorthinesstrn with (nolock) where clientid='14:25:AZ:01:27'
Select Clientid,Datestamp,Coborrower,CoborrowerRelation, * from KYC with (nolock) where clientid='14:25:AZ:01:27'
Select * from LoanAppraisal_ClientDetail with (nolock) where clientid='14:25:AZ:01:27'
Select * from LoanAppraisal_ClientDetailNext with (nolock) where clientid='14:25:AZ:01:27'
Select * from LoanAppraisal_ClientHusbandIncome with (nolock) where clientid='14:25:AZ:01:27'
Select * from LoanAppraisal_ChildrenStaywith1 with (nolock) where clientid='14:25:AZ:01:27'
Select * from LoanAppraisal_ChildrenStaywith2 with (nolock) where clientid='14:25:AZ:01:27'
Select * from LoanAppraisal_ChildrenNotStaywith with (nolock) where clientid='14:25:AZ:01:27'
Select * from LoanAppraisal_CCRDetail1 with (nolock) where clientid='14:25:AZ:01:27'
Select * from LoanAppraisal_CCRDetail1Next with (nolock) where clientid='14:25:AZ:01:27'
Select * from LoanAppraisal_CCRDetail2 with (nolock) where clientid='14:25:AZ:01:27'
Select * from LoanAppraisal_CHIPPIDetail with (nolock) where clientid='14:25:AZ:01:27'
Select * from LoanAppraisal_InsuranceDetail with (nolock) where clientid='14:25:AZ:01:27'
Select * from CreditNeedAssessmenttrn with (nolock) where clientid='14:25:AZ:01:27'
select * from EnqueryStatus with (nolock) where clientid='14:25:AZ:01:27'
select 'Kyc_conf' as Kyc_conf,* from kyc_conf where clientid='14:25:AZ:01:27'
select 'IndusInddocument' as IndusInddocument,* from IndusInddocument where clientid='14:25:AZ:01:27'
select StatusRemark,* from KycVerificationTRN where clientid='14:25:AZ:01:27'
select CBREnquiry,ApprovalRemarks, TRNLoanid, BMID, LoanAmountBM, LoanAmountApproved, FinalreviewDate, principaloutstanding, * from ClientLoanproposal with (Nolock)
where Clientid='14:25:AZ:01:27' and PrincipalOutstanding='1'
select CBREnquiry, TRNLoanid, BMID, LoanAmountBM, LoanAmountApproved, FinalreviewDate, principaloutstanding, * from ClientLoanproposal with (Nolock)
where Clientid='14:25:AZ:01:27' and PrincipalOutstanding>'1'
select CBREnquiry, TRNLoanid, BMID, LoanAmountBM, LoanAmountApproved, FinalreviewDate, principaloutstanding, * from ClientLoanproposal with (Nolock)
where Clientid='14:25:AZ:01:27' and PrincipalOutstanding='0'
Select ClientLoan2UpFrontFee,ClientLoan1UpFrontFee,ClientLoan2InstallmentNumber,ClientLoan1TotalCollected,ClientLoan1AmtDueDisbursed,ClientLoan1AmountDisbursed,* 
From cds2 With (NoLock) Where ClientID='14:25:AZ:01:27'
Select * from CDS3 With (NoLock) Where ClientID = '14:25:AZ:01:27'