--local
----------- Branch Center LoanClients LoanOutstanding AmountOutstanding updated query---------------------------

Select BranchCount,CenterCount,
(Select COUNT(distinct(LEFT(clientloanid,14))) from ClientLoanSubscription where PrincipalOutstanding>0 and regionid = '05') As LoanClients,
 LoanOutstanding,AmountOutstanding,InterestCollected from (Select Count(ClientLoanID) As LoanOutstanding,Sum((cast(PrincipalOutstanding as BigINT))) As AmountOutstanding,
(Select COUNT(CenterID)  from Centers With (Nolock) where DissolvedDate is null and FormationDate<=CONVERT(varchar(10),getdate(),23) and regionid = '05') As CenterCount,
(Select COUNT(BranchID)   from Branches With (Nolock) where DissolvedDate is null and regionid = '05') As BranchCount,
(Select SUM(InterestCollected) from LoanLedger With (Nolock) where WeeklyTransactionDate between '2024-04-01' and CONVERT(varchar(10),getdate(),23)and regionid = '05') as InterestCollected
from ClientLoanSubscription where PrincipalOutstanding>0 and regionid = '05') as C

 ----------------------------------------

--BC ALC & Outstanding
------------------------

Select BranchCount,CenterCount,
(Select COUNT(distinct(LEFT(clientloanid,14))) from ClientLoanSubscription where PrincipalOutstanding>0 and regionid = '05'
and SUBSTRING(ClientLoanID,16,2) in (select ProductID from Products where type like '%BC%' and regionid = '05')) As LoanClients,
LoanOutstanding,AmountOutstanding,InterestCollected from (Select Count(ClientLoanID) As LoanOutstanding,Sum((cast(PrincipalOutstanding as bigINT))) As AmountOutstanding,
(Select COUNT(CenterID)  from Centers With (Nolock) where DissolvedDate is null and FormationDate<=CONVERT(varchar(10),getdate(),23) and regionid = '05') As CenterCount,
(Select COUNT(BranchID)   from Branches With (Nolock) where DissolvedDate is null and regionid = '05') As BranchCount,
(Select SUM(InterestCollected) from LoanLedger With (Nolock) 
where WeeklyTransactionDate between '2023-04-01'  and CONVERT(varchar(10),getdate(),23) and regionid = '05'
and SUBSTRING(ClientLoanID,16,2) in (select ProductID from Products where type like '%BC%' and regionid = '05')) as InterestCollected
from ClientLoanSubscription where PrincipalOutstanding>0 and regionid = '05'
and SUBSTRING(ClientLoanID,16,2) in (select ProductID from Products where type like '%BC%' and regionid = '05')) as C 


-------------------- Defalter MIssMatch Query ----------------------------
select count(ClientLoanID) LoanClients,sum(PrincipalOutstanding) Outstanding from ClientLoanSubscription where 
PrincipalOutstanding>0 and CurrentInstallmentPeriod >LoanDurationInWeeks and regionid = '05'


-------------------- Total Death Client Match Query ----------------------------

Select SUM(deathdetails) As Clientsdeathdetails from (SELECT     BranchID, sum(NumDeathClients1InstallmentInArrears+NumDeathClients2InstallmentInArrears+NumDeathClients3InstallmentInArrears+
NumDeathClients4InstallmentInArrears+
NumDeathClients5PlusInstallmentInArrears+NumDeathClientsDefaultersInstallmentInArrears)as deathdetails
FROM RptBranches  where branchid Like '05%'
group by BranchID) AS RPT

Select SUM(Expr2) Loandeathdetails from(SELECT     LEFT(ClientLoanID, 5) AS Expr1, COUNT(LoanProposalID) AS Expr2
FROM         ClientLoanSubscription
WHERE     (NOT (DeathDate IS NULL)) AND (PrincipalOutstanding>0) AND (NumInstallmentsInArrears > 0)  and CONVERT(varchar(10),DeathEntryDate,23)<=CONVERT(varchar(10),GETDATE(),23)
and RegionID = '05'
GROUP BY LEFT(ClientLoanID, 5)) as CLS



select SUM(InterestCollected) as InterestCollected from LoanLedger With (NoLock) where 
WeeklyTransactionDate between '2024-10-11' And '2024-10-17' and regionid = '05'



SELECT      COUNT(ClientLoanSubscription.ClientLoanID) AS BCALC, SUM(ClientLoanSubscription.PrincipalOutstanding) AS Outstanding
FROM         ClientLoanSubscription INNER JOIN
                      ClientLoanProposal ON ClientLoanSubscription.LoanProposalID = ClientLoanProposal.LoanProposalID INNER JOIN
                      Products ON ClientLoanProposal.ProductID = Products.ProductID
WHERE     (ClientLoanSubscription.PrincipalOutstanding>0) AND (Products.Type in( 'BC KOTAK')) 
and ClientLoanSubscription.regionid = '05'
and ClientLoanProposal.regionid = '05'
HAVING      (SUM(ClientLoanSubscription.PrincipalOutstanding) > 0)

SELECT      COUNT(ClientLoanSubscription.ClientLoanID) AS BCALC, SUM(ClientLoanSubscription.PrincipalOutstanding) AS Outstanding
FROM         ClientLoanSubscription INNER JOIN
                      ClientLoanProposal ON ClientLoanSubscription.LoanProposalID = ClientLoanProposal.LoanProposalID INNER JOIN
                      Products ON ClientLoanProposal.ProductID = Products.ProductID
WHERE     (ClientLoanSubscription.PrincipalOutstanding>0) AND (Products.Type in( 'BC SIDBI')) 
and ClientLoanSubscription.regionid = '05'
and ClientLoanProposal.regionid = '05'
HAVING      (SUM(ClientLoanSubscription.PrincipalOutstanding) > 0)

SELECT      COUNT(ClientLoanSubscription.ClientLoanID) AS BCALC, SUM(ClientLoanSubscription.PrincipalOutstanding) AS Outstanding
FROM         ClientLoanSubscription INNER JOIN
                      ClientLoanProposal ON ClientLoanSubscription.LoanProposalID = ClientLoanProposal.LoanProposalID INNER JOIN
                      Products ON ClientLoanProposal.ProductID = Products.ProductID
WHERE     (ClientLoanSubscription.PrincipalOutstanding>0) AND (Products.Type in( 'BC ICICI')) 
and ClientLoanSubscription.regionid = '05'
and ClientLoanProposal.regionid = '05'
HAVING      (SUM(ClientLoanSubscription.PrincipalOutstanding) > 0)

SELECT      COUNT(ClientLoanSubscription.ClientLoanID) AS BCALC, SUM(ClientLoanSubscription.PrincipalOutstanding) AS Outstanding
FROM         ClientLoanSubscription INNER JOIN
                      ClientLoanProposal ON ClientLoanSubscription.LoanProposalID = ClientLoanProposal.LoanProposalID INNER JOIN
                      Products ON ClientLoanProposal.ProductID = Products.ProductID
WHERE     (ClientLoanSubscription.PrincipalOutstanding>0) AND (Products.Type in( 'BC IDBI')) 
and ClientLoanSubscription.regionid = '05'
and ClientLoanProposal.regionid = '05'
HAVING      (SUM(ClientLoanSubscription.PrincipalOutstanding) > 0)