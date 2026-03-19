--SIDBI
Select left(clientLoanid,5) as BranchID,DisbursementDate,Sum(LoanAmountDisbursed) as SIDBIDisbursedAmount
from ClientLoansubscription With (Nolock) Where Clientloanid like '07%' and DisbursementDate = '2023-08-18' and 
SUBSTRING(clientLoanID,16,2) in ('5X','6X','H6','H8','W6')
group by left(clientLoanid,5),DisbursementDate
order by left(clientLoanid,5),DisbursementDate

--INDUS-IND
Select left(cls.clientLoanid,5) as BranchID,cls.DisbursementDate,Sum(cls.LoanAmountDisbursed) as BCDisbursedAmount from ClientLoansubscription as cls  With (Nolock) 
inner join clientloanProposal as clp on clp.LoanProposalID=cls.LoanProposalID
inner join products as p on p.ProductID=clp.ProductID
Where cls.DisbursementDate = '2023-08-18' and p.type = 'BC INDUS-IND'
group by left(cls.clientLoanid,5),cls.DisbursementDate
order by left(cls.clientLoanid,5),cls.DisbursementDate

--OWN
Select left(cls.clientLoanid,5) as BranchID,cls.DisbursementDate,Sum(cls.LoanAmountDisbursed) as OWNDisbursedAmount from ClientLoansubscription as cls  With (Nolock) 
inner join clientloanProposal as clp on clp.LoanProposalID=cls.LoanProposalID
inner join products as p on p.ProductID=clp.ProductID
Where cls.DisbursementDate = '2023-08-18' and p.type = 'OWN'
group by left(cls.clientLoanid,5),cls.DisbursementDate
order by left(cls.clientLoanid,5),cls.DisbursementDate

--SIDBI
Select left(cls.clientLoanid,5) as BranchID,cls.DisbursementDate,Sum(cls.LoanAmountDisbursed) as BCDisbursedAmount from ClientLoansubscription as cls  With (Nolock) 
inner join clientloanProposal as clp on clp.LoanProposalID=cls.LoanProposalID
inner join products as p on p.ProductID=clp.ProductID
Where cls.DisbursementDate = '2023-08-18' and p.type = 'BC SIDBI'
group by left(cls.clientLoanid,5),cls.DisbursementDate
order by left(cls.clientLoanid,5),cls.DisbursementDate


