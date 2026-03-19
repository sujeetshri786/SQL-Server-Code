---------To Active Client---
--update clients set dropoutstatus=0,insurance=0,riskfund=0,suspenddate=Null,hotlistremark=Null,hotlistdate=Null,DropOutDate=NULL
--where clientid in ('14:05:18:01:76')

--- Loan Eligibility ------
	
--exec Proc_EligibleLoanAmount '14:05'

--Update Clients set RiskFund='3',insurance='16' where Clientid in ('31:11:44:01:15')

--Update ClientsDropout set RiskFund='3', insurance='16' where Clientid ='22:18:18:01:09'

--update clients set DropOutDate = NULL where clientid = '14:21:T1:01:25'

--update clients set DropOutStatus = '2' where clientid = '35:08:11:01:29'

--update clients set LoanCycle = '1' where clientid = '14:15:K7:01:38'

--update Loan_Utilisation set BM_PurposeName=NULL Where ClientLoanID = '22:31:42:01:25:O1:01'
--update Loan_Utilisation set CM_PurposeName=NULL Where ClientLoanID = '14:14:56:01:58:O1:01'

--- When CBR are not done in local --------------
--update ClientLoanProposal set CBREnquiry ='1' where ClientID = '35:16:42:01:19'

--update Clients set EligibleLoanAmount='100000' where clientId  like '21:13:54:01:37'

--select * from KYC where ClientID='21:01:60:01:20'

--delete from KYC where ClientPrimaryKycmember in ('983193270818')

--select * From Branch_Report  Where BranchID = '14:13'

--update Branch_Report set Totalcollection='157001' Where BranchID = '22:32'


--Update Branch_Report set send = '0' Where BranchID = '22:22'
  
--select * from kyc where ClientPrimaryKycmember in ('725653641548')

--select * from Clients where ClientID='21:01:60:01:20'

---When Due created and wanna delete the neft ----------
--Begin Tran
--Update CDS2 set ClientLoan1AmtDueDisbursed='0' where LoanProposalID in ('10:24:25962','10:24:25694')
--RollBack Tran


---When Due created and wanna delete the neft ----------
--Delete from cds2 where ClientID in ('10:12:g7:01:15') and ClientLoan1Balance=0


-- Set Verified - 4 by adhar ------------
--update clientadhar set verified=4 where  adharid in('410834172295')


--- Update in Daily Closing Dtl ------------
--update DailyClosingdtl set Minsurance='400' where Branchid ='10:17'


--Update Eligibility in Local----------

--exec_ProcEligibalLoanamount'10:25'



-- Delete HusbandAdhar --------------
--Delete from husbandadhar where adharid='349669824171'


---update cds3 set ClientCRFDue='' where Clientid=''


--update ClientAdhar set VTC='Muzaffarpur' where Adharid='800682920184'



--Update MInsureSurvey set CollAmount='0', CollDate='NULL' where Branchid like '35:08' and cast(CollDate as date) ='2022-03-27'


--IF Insurance Not showing -------------


--update CDS2 set RiskFundDate='2022-03-29' where Loanproposalid ='35:01:00854'

--Update CDS2 set ClientLoan2Upfrontfee='750' where Loanproposalid ='35:01:00854'

--Begin Tran
--update ClientLoanSubscription set Riskfund='750' where LoanProposalID ='35:01:00854'
--RollBack Tran

--Select * From Branch_report  Where Branchid = '10:03'

--update Branch_report set Totalcollection ='294881' Where BranchID='31:21'
--update Branch_report set insurance='10230' Where BranchID='22:11'

--update Branch_report set Minsurecollection='100' Where BranchID='14:15'
--update Branch_report set PFRDACollection='0' Where BranchID='22:31'

--update Branch_report set DisbursementNeft='610000' Where Branchid = '31:21'

--Exec updatecls '14:08'--principal outstanding minus

--Select * From DailyClosingDTL Where BranchID = '31:16'

--exec proc_smstextapbs_dayclose '14:08'

--update DailyClosingDtl set DateStamp = '2022-10-11 06:45:00',MeetingDate = '2022-10-11 00:00:00' where BranchID = '22:07'


--update dailyClosingDtl set MInsuranceCollection = '600' where branchID = '05:01'

--update cds2 Set AccidentalInsuranceSpouse = '0' Where ClientLoan1id = '31:01:91:01:16:I9:01'

--Delete cds2 where ClientID in () And ClientLoan1AmtDueDisbursed > '0' And ClientLoan1Balance = '0'


--select * from report..databasename Where rid in ('10','14','21','22','31','35')


--declare @output nvarchar(150)
--exec ProposalInsertion '10895545',@output output
--print @output



--update ClientLoanProposal set Intimationsettledate = NULL,Intimationdonedt=NULL,Intimationdoneby= NULL WHERE LoanProposalID='31:15:01394'


--update Clients set Amgrtdate='2019-07-18 00:00:00',Amid='5498' where ClientID = '21:18:89:01:38'

--Select * From Branch_Report Where BranchID = '31:21'

--update Branch_Report set insurance='3000'  Where BranchID = '31:17'

--update Branch_Report set PFRDACollection = '0' Where BranchID = '14:04'

--update Branch_Report Set send = '0'  Where BranchID = '14:01'
--update Branch_Report Set send = '0'  Where BranchID = '05:22'

--Delete Cashpor..ATNeftClientBankDetail  Where AccountNumber = '52470100004974'--Roe Neft Entry Time
 
 
-- select * From Employee_Serial Where Employee_id = '21761'


--Delete Employee_Serial Where Employee_id = '15077'

--Select * from Cashpor..ATNeftClientBankDetail  Where AccountNumber = '37096018616'--Roe Neft Entry Time

--Delete Cashpor..ATNeftClientBankDetail Where AccountNumber = '36485315296'

--Select  * from CreditWorthinesstrn  where Trnloanid='10564843'

--update CreditWorthinesstrn set  EntryBy= '15991'  where Trnloanid='10141923'

--update kyc set StaffID= '19894'  where Trnloanid='11019421'

--exec proc_smstextapbs_dayclose '31:02'

--exec uspnewactivityproc '2022-10-06','2022-10-06','10' -- For Activity

--update ClientLoanProposal set Intimationsettledate=NULL,Intimationdoneby=NULL,Intimationdonedt=NULL Where LoanProposalID = '14:22:37026'

--update ClientLoanProposal set Bankname=0,BankBranchname=0,AccountNumber=0,IFSCCode=0,
--BmAccountNumber=0,BmIfsccode=0,FinalAccountNumber=0,FinalIfsccode=0,bmneftreviewdate=NULL
--where loanproposalid='24:06:16284'

--update ClientLoanProposal set
--BmAccountNumber=0,BmIfsccode=0,FinalAccountNumber=0,FinalIfsccode=0,bmneftreviewdate=NULL,Neftconsent='1'
-- where loanproposalid='05:12:50673'

--update clientloanproposal set  Bankname=0,BankBranchname=0,AccountNumber=0,IFSCCode=0,BmAccountNumber=0,BmIfsccode=0,
--FinalAccountNumber=0,FinalIfsccode=0,PrincipalOutstanding=1,bmneftreviewdate=Null,disbursementmode='2' 
--where LoanProposalID In ()

--update FieldStaff set appversion = '1.4',staffappversion = '1.4' where Staffid in ('DSI22')

------------Neft Cancel
--update clientloanproposal set  Bankname=0,BankBranchname=0,AccountNumber=0,IFSCCode=0,BmAccountNumber=0,BmIfsccode=0,
--FinalAccountNumber=0,FinalIfsccode=0,PrincipalOutstanding=1,bmneftreviewdate=Null,disbursementmode='2',
--LoanDisbursementDate=Null,LoanAmountDisbursed=0 where  loanproposalid in ()

--update  CreditNeedAssessmenttrn set ReviewedBy='8868',ReviewedDate='2022-12-14 15:46:46.270',appmode='2' where trnloanid='11441316'

--update clientloanproposal set Neftconsent='1' where  loanproposalid in('05:07:78529')

--update cds2 set ClientLoan1AmtDueDisbursed='0' where ClientLoan1ID in ('14:28:A6:01:18:W6:01')

--delete cds2 where ClientLoan1ID in ()


--Select * from cds2 where ClientID in (35:08:24:01:03:R1:01) and  ClientLoan1AmtDueDisbursed > '0' And ClientLoan1Balance = '0'

--Select * from cds2 where ClientLoan1ID in ('35:08:24:01:03:R1:01') 

----Neft Delete Appcashpor
----Select * From ClientLoanProposal  where ClientID in () 
--and LoanDisbursementDate is null and BankName Not in ('0')--proposaldate<particular date

--Select * From Employee_Serial where Employee_id = '3895'
--Delete Employee_Serial where Employee_id = 'SM10'

--Select * From UPICollectionLog Where RRN='302500080217'
--update UPICollectionLog Set  Where RRN='302700292978'
--Delete UPICollectionLog Where RRN='302700292978'

--Select * From UPICollectionLog Where ClientLoanID = '31:19:21:01:05:O7:01'

--update Clientsdropout set HotListRemark = 'suspendwitholdcondition'
--WHERE CLIENTID LIKE '14:14:92:01:06%'

--delete from CreditWorthinesstrn  where trnloanid in('11823343')
--delete from Kyc  where trnloanid in('11823343')

--Update CreditWorthinesstrn set EntryBY ='12994' where TrnLoanID='11201045'
--Update KYC set Staffid ='12994'  where trnloanid='11201045'
--Update LoanAppraisal_ClientDetail set EntryBY ='12994' where TrnLoanID='11201045'
--Update LoanAppraisal_ClientDetailNext set EntryBY ='12994' where TrnLoanID='11201045'
--Update LoanAppraisal_ClientHusbandIncome set EntryBY ='12994' where TrnLoanID='11201045'
--Update LoanAppraisal_ChildrenStaywith1 set EntryBY ='12994' where TrnLoanID='11201045'
--Update LoanAppraisal_ChildrenStaywith2 set EntryBY ='12994' Where TrnLoanID='11201045'
--Update LoanAppraisal_ChildrenNotStaywith set EntryBY ='12994' where TrnLoanID='11201045'
--Update LoanAppraisal_CCRDetail1 set EntryBY ='12994' where TrnLoanID='11201045'
--Update LoanAppraisal_CCRDetail1Next set EntryBY ='12994' where TrnLoanID='11201045'
--Update LoanAppraisal_CCRDetail2 set EntryBY ='12994'  where TrnLoanID='11201045'
--Update LoanAppraisal_CHIPPIDetail set EntryBY ='12994'  where TrnLoanID='11201045'
--Update LoanAppraisal_InsuranceDetail set EntryBY ='12994'  where TrnLoanID='11201045'
--Update CreditNeedAssessmenttrn set Staffid ='12994' where TrnLoanID='11201045'

--Update KYC set StaffID ='12994' where EnrollTrnLoanID='11201045'

--Select * From Ekycdetail With (NoLock) Where ClientID in ('14:04:L3:01:75')

--update Ekycdetail Set Gender = 'F'  Where ClientID in ('14:04:L3:01:75')

--Select * From CDS1 With (NoLock) Where GroupID Like '35:17%'
--Select * From CDS2 With (NoLock) Where GroupID Like '35:17%'
--Select * from CDS3 With (NoLock) Where GroupID Like '35:17%'

--update CDS2 set ClientLoan2ID = '2' where clientLoan1Id = '14:14:19:01:67:I9:01'

--update ClientLoanProposal set BmNeftReviewDate=NULL,BmAccountNumber='0',BmIfsccode='0' Where LoanProposalID = '22:11:19062' 
 
 --update KYC Set HusbandPrimaryNameasperkyc='Munna' where trnloanid = '11026631'

--DELETE MInsureSurvey where TranID IN ('1120142')

--update cds2 set ClientLoan2ID = '2' where ClientLoan1ID = '14:19:G3:04:25:R4:01'

--update ClientLoanProposal set DisbursementMode = '2' where loanProposalId = '14:13:34659'
--update ClientLoanProposal set CHIBID = NULL where loanProposalId = '22:11:19695'

--update Loan_Utilisation set  BM_PurposeName = NULL Where ClientLoanID='31:07:AL:01:01:I8:01'


--Delete CDS1  Where GroupID Like '35:22%'
--Delete CDS2  Where GroupID Like '35:22%'
--Delete CDS3  Where GroupID Like '35:22%'

--update UPICollectionLog set TranDate = '2023-02-18' where ClientLoanID Like '14:12:W2:01:27:O1:01'
--update UPICollectionLog set TranDate = '2023-02-18' where ClientLoanID Like '14:12:W2:01:27:O7:01'

--select * from UserRegion where staffid = '7018'

--update UserRegion set RegionId = '14' where staffid = '13094'

--update Loan_Utilisation set CM_PurposeName=NULL Where ClientLoanID = ''
--update Ekycdetail set Pincode = '' Where ID='' and Uid=''
--update Ekycdata set Pincode = '' Where ID='' and Uid=''

--update CDS2 Set ClientLoan2UpFrontFee='0',ClientLoan1UpFrontFee ='354',RiskFundDate=NULL,UpFrontFeeDate='2023-06-20 00:00:00'
--Where ClientLoan1ID Like '%'