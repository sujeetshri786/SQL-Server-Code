----------------- To Active Client 
--update clients set dropoutstatus=0,insurance=0,riskfund=0,suspenddate=Null,hotlistremark=Null,hotlistdate=Null,DropOutDate=NULL
--where clientid in ('14:04:A1:01:51')

------- Loan Eligibility ------

--Update Branch_Report set send = '0' Where BranchID = '22:22'

--exec Proc_EligibleLoanAmount '14:11'
--exec Proc_EligibleLoanAmount '22:34'
--exec Proc_EligibleLoanAmount '14:29'
--update clients set LoanCycle = '1' where clientid = '05:06:CY:01:75'

--exec uspnewactivityproc '2023-07-10','2023-07-10','16'
--exec uspnewactivityproc '2023-07-10','2023-07-10','05'
--exec uspnewactivityproc '2023-07-10','2023-07-10','14'

--update cds2 set ClientLoan1AmtDueDisbursed='0' where ClientLoan1ID in ('31:09:49:01:02:R1:01')

--select * from cds2


--Neft Delete Appcashpor
--Select * From ClientLoanProposal With (NoLock) where ClientID in () 
--and LoanDisbursementDate is null and BankName Not in ('0')--proposaldate<particular date

--Select * From cds2 With (NoLock) where ClientID in () And ClientLoan1AmtDueDisbursed > '0' And ClientLoan1Balance = '0'

------Aadhar Delete
--select * from ClientAdhar where adharid in ()

--select * from ClientAdhar where Clientid in ()

--Select * From Husbandadhar With (NoLock) where Adharid in ()


------Proposal Delete
--select * from ClientLoanProposal With (NoLock) where ClientID in () and LoanAmountDisbursed='0' and PrincipalOutstanding = '1' order by proposaldate

--delete from cds2 where ClientID in () and ClientLoan1AmtDueDisbursed > '0' and ClientLoan1Balance='0'

--Select * from cds2 where ClientID in () and  ClientLoan1AmtDueDisbursed > '0' And ClientLoan1Balance = '0'


--Select  * from CreditWorthinesstrn with (nolock) where clientid in () and ReviewedDate is null

--Select * From CLientLoanProposal With (NoLock) Where ClientId like '21%' And ProposalDate = '2022-10-09' And ProductID in 
--(Select productID From Products Where type Like '%OWN%')

--Select * From Product_Category Where ProductCategory Like '%Flexi%' And LoanAmount > '14000'

--delete cds2 where ClientID in () and  ClientLoan1AmtDueDisbursed > '0' And ClientLoan1Balance = '0'

--Proposal Delete
--select * from ClientLoanProposal With (NoLock) where ClientID in () and LoanAmountDisbursed='0' and PrincipalOutstanding = '1' order by proposaldate

--update clientloanproposal set  Bankname=0,BankBranchname=0,AccountNumber=0,IFSCCode=0,BmAccountNumber=0,BmIfsccode=0,
--FinalAccountNumber=0,FinalIfsccode=0,PrincipalOutstanding=1,bmneftreviewdate=Null,disbursementmode='5',LoanAmountBM=NULL,FinalreviewDate=NULL
--where  loanproposalid in('05:07:78771')

-------Recall
--update clientloanproposal set  Bankname=0,BankBranchname=0,AccountNumber=0,IFSCCode=0,BmAccountNumber=0,BmIfsccode=0,
--FinalAccountNumber=0,FinalIfsccode=0,PrincipalOutstanding=1,bmneftreviewdate=Null,disbursementmode='2',
--LoanDisbursementDate=Null,LoanAmountDisbursed=0 where  loanproposalid in ('14:02:47213')


--update clientloanproposal set BmAccountNumber=0,BmIfsccode=0,
--FinalAccountNumber=0,FinalIfsccode=0,PrincipalOutstanding=1,bmneftreviewdate=Null,disbursementmode='2',
--LoanDisbursementDate=Null,LoanAmountDisbursed=0 where  loanproposalid in('21:02:22948')

--update ClientLoanProposal set Bankname=0,BankBranchname=0,AccountNumber=0,IFSCCode=0,
--BmAccountNumber=0,BmIfsccode=0,FinalAccountNumber=0,FinalIfsccode=0,bmneftreviewdate=NULL,Neftconsent='1'
--where loanproposalid='05:22:60502'

--update clientloanproposal set Bankname=0,BankBranchname=0,AccountNumber=0,IFSCCode=0,BmAccountNumber=0, BmIfsccode=0 ,BmNeftReviewDate=NULL, Neftconsent='1', 
--FinalAccountNumber=0,FinalIfsccode=0
--where  loanproposalid in ('24:31:01322')

--update clientloanproposal set  Neftconsent='1', FinalAccountNumber=0,FinalIfsccode=0
--where  loanproposalid = ''

--Delete Cashpor..ATNeftClientBankDetail Where AccountNumber = '1564001700001270'

--update Branch_report set Minsurecollection='400' Where BranchID='22:32'

--exec proc_smstextapbs_dayclose '10:12'
--exec uspnewactivityproc '2023-01-31','2023-01-31','14'

--update Branch_Report Set send = '0'  Where BranchID = '05:11'
--update DailyClosingDtl Set send = '0'  Where BranchID = '14:25'

--select * From Branch_Report With (NoLock) Where BranchID = '31:21'
--Select * From DailyClosingDTL With (NoLock)Where BranchID = '35:22'
--Select * From DailyClosingDTL With (NoLock)Where BranchID = '16:02'

--update Branch_report set Totalcollection='294881' Where BranchID='31:21'
--update Branch_report set Minsurecollection='100' Where BranchID='05:11'
--update Branch_report set DisbursementNeft='610000' Where Branchid = '31:21'


--update DailyClosingDtl set DateStamp = '2023-02-22 00:00:00',MeetingDate = '2023-02-22 00:00:00' where BranchID = '10:14'

--update DailyClosingDtl set TotalCollection = '33301',InsuranceCollection='10459',ProcessingFees='1239' where BranchID = '22:07'
--update DailyClosingDtl set TotalCollection = '333011',UPI_Collection='590',MInsuranceCollection='100' where BranchID = '22:07'
--update DailyClosingDtl set MInsuranceCollection='900' where BranchID = '14:01'

--update DailyClosingDTL Set TotalDisbursementHO='180000' Where BranchID = '22:11'

--update dailyClosingDtl set MInsuranceCollection = '2200' where branchID = '14:28'

--update clients set LoanCycle = '1' where clientid = '10:18:G7:04:28'

--update Branch_report set Minsurecollection='400' Where BranchID='22:31'

--exec updatecls '07:14'

--delete ClientLoanProposal Where LoanProposalID='21:13:16090'

--Delete ClientLoanProposal Where LoanProposalID='14:02:41694'

--update Branch_Report set insurance='2070'  Where BranchID = '14:04'

--exec DayClose '14:01','2022-11-15'

--update Branch_Report Set send = '0'  Where BranchID = '05:11'

--select * from logfile where EndProcDate='2022-11-16' order by workenddt desc

--select * from report..databasename where rid='10'

--exec uspNewActivityProc '2023-01-14','2023-01-14','14'

--update Branch_Report set Totalcollection='157001' Where BranchID = '22:32'


--select * from LogFile with(nolock) where EndProcDate is null and IniProcDate='2022-11-30' order by branchid
--select * from Branch_Report where send=0 order by Branchid
----select * from fieldstaff where staffid in('12030')
--select * from report..DataBaseName  with(nolock) where DayCloseStatus=1 
--select * from report..DataBaseName with(nolock) where DayIniStatus=1

--select * from LogFile with(nolock) where EndProcDate is null and IniProcDate='2022-12-07' order by branchid
--select * from Branch_Report where send=0 order by Branchid
----select * from fieldstaff where staffid in('12030')
--select * from report..DataBaseName  with(nolock) where DayCloseStatus=1 
--select * from report..DataBaseName with(nolock) where DayIniStatus=1
--exec dayclose '15:14','2022-11-28'

--select * from cashpor..mobilelogin with (nolock)where branchid='21:18'

--update cashpor..mobilelogin set disttid = '21', disttname = 'MUZAFFARPUR', bmstaffid = '21899', 
--bmpassword = '111111'  where branchID = '21:18'

--update Branch_Report Set Send = '0' where branchId='14:22'

--update cashpor..mobilelogin Set BmStaffid = '12295', Bmpassword = '222222' where BranchID = '14:24'

--update clientloanproposal set BmAccountNumber='0', BmIfsccode='0' ,BmNeftReviewDate=NULL, Neftconsent='1', FinalAccountNumber=0,FinalIfsccode=0
--where  loanproposalid = '14:22:45641'

--update LoanLedger set InterestInstallmentAmt='0',InterestCollected='0' where WeeklyTransactionDate='2022-12-23'

--update cashpor..mobilelogin set BmStaffid='9355',Bmpassword = '111111' where BranchID = '31:10'

--update Targets set maritialstatus = '2' Where TargetID IN ('14:13:04795')

--Delete CDS1  Where GroupID Like '35:22%'
--Delete CDS2  Where GroupID Like '35:22%'
--Delete CDS3  Where GroupID Like '35:22%'

--Select * From CashporBC..EKYCDATA Where ClientID Like '14:15:A9:01:10'

--delete cds2 where ClientLoan1ID in ()

--Select sum(PrincipalCollected+InterestCollected) as Collection  From LoanLedger With (noLock) 
--Where WeeklyTransactionDate = '2023-04-28' 
--and ClientLoanID like '05:07%'
--Select * From DailyClosingDTL With (NoLock) Where BranchID = '14:05'
--Select * From BackDateBranch_report With (NoLock) Where BranchID = '05:07' And cast(ReportingDate as date) = '2023-04-28'