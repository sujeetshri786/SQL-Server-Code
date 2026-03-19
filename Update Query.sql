--- To Active Client ---
--update clients set dropoutstatus=0,insurance=0,riskfund=0,suspenddate=Null,hotlistremark=Null,hotlistdate=Null,DropOutDate=NULL
--where clientid in ('31:07:46:01:16')

----- Loan Eligibility ------
--exec Proc_EligibleLoanAmount '22:27'
--exec Proc_EligibleLoanAmount '31:02'

--Update Clients set RiskFund='3', insurance='16' where Clientid ='14:11:Zd:01:53'

--------- When CBR are not done in local --------------
--update ClientLoanProposal set CBREnquiry ='1' where ClientID = '35:16:42:01:19'

--update Clients set EligibleLoanAmount='50000' where clientId  like '31:07:46:01:16'

--select * from KYC where ClientID='21:01:60:01:20'

----delete from KYC where ClientPrimaryKycmember='365050941610'

--select * from kyc where ClientPrimaryKycmember in ('725653641548')

--select * from Clients where ClientID='21:01:60:01:20'

-------------When Due created and wanna delete the neft ----------
--Begin Tran
--Update CDS2 set ClientLoan1AmtDueDisbursed='0' where LoanProposalID in ('10:24:25962','10:24:25694')
--RollBack Tran


-----------When Due created and wanna delete the neft ----------
--Delete from cds2 where ClientID in ('10:12:g7:01:15') and ClientLoan1Balance=0


------------ Set Verified - 4 by adhar ------------
--update clientadhar set verified=4 where  adharid in('410834172295')


------------- Update in Daily Closing Dtl ------------
--update DailyClosingdtl set Minsurance='400' where Branchid ='10:17'


------------Update Eligibility in Local----------

--exec_ProcEligibalLoanamount'10:25'



---------- Delete HusbandAdhar --------------
--Delete from husbandadhar where adharid='349669824171'


---update cds3 set ClientCRFDue='' where Clientid=''


--update ClientAdhar set VTC='Muzaffarpur' where Adharid='800682920184'



--Update MInsureSurvey set CollAmount='0', CollDate='NULL' where Branchid like '35:08' and cast(CollDate as date) ='2022-03-27'


--------------IF Insurance Not showing -------------


--update CDS2 set RiskFundDate='2022-03-29' where Loanproposalid ='35:01:00854'

--Update CDS2 set ClientLoan2Upfrontfee='750' where Loanproposalid ='35:01:00854'

--Begin Tran
--update ClientLoanSubscription set Riskfund='750' where LoanProposalID ='35:01:00854'
--RollBack Tran

--select * from Branch_Report With (NoLock) Where branchId = '10:26'
--select * from Dailyclosingdtl With (NoLock) Where branchId = '14:05'
--select * from logfile with (NoLock) where IniProcDate='2022-11-29' And WorkEndDT IS NULL
--select * From cashpor..APBSNEFTDisbursement With (NoLock) Where FinalAccountNumber='79968100000670'--Disbursement date na pade to check Karana hai


--Select * From ClientLoanProposal Where LoanProposalID In ('05:19:51626')

--Update ClientLoanProposal Set BmAccountNumber=0,BmIfsccode=0,FinalAccountNumber=0,FinalIfsccode=0,Neftconsent='1' 
--Where LoanProposalID In ('16:25:42056')

--Update ClientLoanProposal Set Neftconsent='1' Where LoanProposalID In ('05:19:51718')

--Update ClientLoanProposal Set Bankname=NULL,BankBranchname=0,AccountNumber=0,IFSCCode=0,
--BmAccountNumber=0,BmIfsccode=0,FinalAccountNumber=0,FinalIfsccode=0,Neftconsent='1' 
--Where LoanProposalID In ('05:06:68738')

--Update ClientLoanProposal Set LoanAmountBM='',FinalReviewDate='',PrincipalOutstanding=''
--Where LoanProposalID In ('')

--update cds2 Set ClientLoan1AmtDueDisbursed='0' where ClientLoan1ID in ('14:13:E8:01:74:R0:01') 
--And ClientLoan1AmtDueDisbursed > '0' And ClientLoan1Balance = '0' And  ClientLoan1AmountDisbursed='0'

--Select * from Branch_Report With (NoLock) Where branchId like '05:31%'

--Update Branch_Report Set Minsurecollection = '100' Where branchId like '05:31%'

--UPDATE Loan_Utilisation SET BM_PurposeName = NULL Where ClientLoanID Like '%'

--Select * from centers Where StaffID = 'BA18' And centerid like '05:18%' 
--Begin tran
--Update centers Set StaffID = 'BA18' where centerid like '05:18%' and StaffID = '12022'
--Rollback tran

--Select * From CDS1 WITH (NoLock) Where StaffID = 'BA18' and CenterId Like '05:18%'
--Begin Tran
--Update CDS1 SET StaffID = 'BA18' Where StaffID = '12022' and CenterId Like '05:18%'
--Rollback tran

--update clientLoanProposal Set BMID='9650',LoanAmountBM='100000',LoanAmountApproved='100000',FinalReviewDate='2023-06-01 00:00:00',Bmrecommenddate =
--'2023-06-01 15:51:13.413' Where loanProposalId= '14:15:30395'
--Bankname='0',BankBranchname='0',AccountNumber='0',IFSCCode='0' Where loanProposalId= '14:15:30162'

--Select BmAccountNumber,BmIfsccode,FinalAccountNumber,FinalIfsccode, * From ClientLoanProposal With (NoLock) Where LoanProposalID IN ('14:15:30162') 
--And PrincipalOutstanding = '1'


--Select * From ClientLoanProposal With (NoLock) Where ClientLoanID like '14%' and PrincipalOutstanding = '1' and BankName='0'