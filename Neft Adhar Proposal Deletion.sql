------------Neft Delete Appcashpor
--Select Bankname,BankBranchname,AccountNumber,IFSCCode,BmAccountNumber,BmIfsccode,FinalAccountNumber,FinalIfsccode From [43.242.214.235].appcashpor.dbo.ClientLoanProposal With (NoLock) 
--where ClientID in () and LoanDisbursementDate is null 

--Select * From cds2 With (Nolock) where ClientID in () 
--And ClientLoan1AmtDueDisbursed> '0' And ClientLoan1Balance = '0' And  ClientLoan1AmountDisbursed='0'

--Select ClientLoan1AmtDueDisbursed,ClientLoan1AmountDisbursed, * From [43.242.214.235].appcashpor.dbo.cds2 With (NoLock) where ClientID in () 
--And ClientLoan1AmtDueDisbursed > '0' And ClientLoan1Balance = '0' And  ClientLoan1AmountDisbursed>'0'

--Update cds2 SET ClientLoan1AmtDueDisbursed = '0'  where ClientLoan1ID in ('10:03:P2:01:51:2E:01') 

--update cds2 Set ClientLoan1AmtDueDisbursed='0' where ClientLoan1ID in () 
--And ClientLoan1AmtDueDisbursed > '0' And ClientLoan1Balance = '0' And  ClientLoan1AmountDisbursed='0'


--select * from ClientAdhar where Clientid in ()

--Select * From Husbandadhar With (NoLock) where Adharid in ()

------------------Proposal Delete
--select ClientID,targetname as ClientName,Proposaldate,LoanProposalID,ProductCategory,LoanAmountApproved,FinalReviewDate 
--from clientloanproposal with (NoLock) where PrincipalOutstanding = '1' and clientid in () order by ProposalDate desc


--------------Proposal Delete
--select clp.ClientID,clp.targetname as ClientName,clp.Proposaldate
--,clp.LoanProposalID,clp.ProductCategory,clp.LoanAmountApproved,clp.FinalReviewDate,cds2.ClientLoan1AmtDueDisbursed 
--as DueAmount from ClientLoanProposal as clp With (NoLock) inner join cds2 on cds2.LoanProposalid=clp.LoanProposalid where clp.ClientID in 
--() and clp.LoanAmountDisbursed='0' and clp.PrincipalOutstanding = '1' order by clp.proposaldate


--delete from cds2 where ClientID in () and ClientLoan1AmtDueDisbursed > '0' and ClientLoan1Balance='0'

--Select * from cds2 where ClientID in () and ClientLoan1AmtDueDisbursed > '0' And  ClientLoan1AmountDisbursed='0' And ClientLoan1Balance='0'

--Select * from  CDS2 With (NoLock) Where ClientLoanID In ()

--Select  * from CreditWorthinesstrn with (nolock) where clientid in () and ReviewedDate is null

--Select * From CLientLoanProposal With (NoLock) Where ClientId like '22%' And ProposalDate = '2022-10-09' And ProductID in 
--(Select productID From Products Where type Like '%OWN%')

--Select * From Product_Category Where ProductCategory Like '%Flexi%' And LoanAmount > '14000'

--Select CustomerId,Loanproposalid,CustomerName,LoanAmountApproved,Approved,VerifyDate,* 
--From IDBIReview With (NoLock) Where LoanProposalID in ()
--Select CustomerId,LoanProposalID,customername,LoanamountApproved,Approved,VerifyDate,* 
--From SidbiReview With (NoLock) Where LoanproposalID IN ()
--Select CustomerId,LoanProposalID,customername,LoanamountApproved,Approved,VerifyDate,* 
--From KotakReview With (NoLock) Where LoanproposalID IN ()
--Select CustomerId,LoanProposalID,customername,LoanamountApproved,Approved,VerifyDate,* 
--From ICICIREVIEW With (NoLock) Where Loanproposalid in ()
--Select Approved,Remark,* From KotakReview With (NoLock) Where Loanproposalid in ()


--------------Neft deletion
--select clp.clientID,clp.targetname as ClientName,clp.proposaldate
--,clp.LoanProposalID,clp.ProductCategory,clp.LoanAmountApproved,clp.FinalReviewDate,cds2.ClientLoan1AmtDueDisbursed 
--as DueAmount,clp.Bankname,clp.BankBranchname,clp.AccountNumber,clp.IFSCCode  from ClientLoanProposal as clp With (NoLock) 
--inner join cds2 on cds2.LoanProposalid=clp.LoanProposalid where clp.ClientID in 
--() and clp.LoanDisbursementDate is null and clp.BankName Not in ('0')
