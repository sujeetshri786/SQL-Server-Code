--local
----------- Branch Center LoanClients LoanOutstanding AmountOutstanding updated query---------------------------
Select BranchCount,CenterCount,
(Select COUNT(distinct(LEFT(clientloanid,14))) from ClientLoanSubscription where ActualPaidUpDate is null and PrincipalOutstanding>0 and regionid = '10') As LoanClients,
 LoanOutstanding,AmountOutstanding,InterestCollected from (Select Count(ClientLoanID) As LoanOutstanding,Sum((cast(PrincipalOutstanding as BigINT))) As AmountOutstanding,
(Select COUNT(CenterID)  from Centers With (Nolock) where DissolvedDate is null and FormationDate<=CONVERT(varchar(10),getdate(),23) and regionid = '10') As CenterCount,
(Select COUNT(BranchID)   from Branches With (Nolock) where DissolvedDate is null and regionid = '10') As BranchCount,
(Select SUM(InterestCollected) from LoanLedger With (Nolock) where WeeklyTransactionDate between '2024-04-01' and CONVERT(varchar(10),getdate(),23)and regionid = '10') as InterestCollected
from ClientLoanSubscription where ActualPaidUpDate is null and PrincipalOutstanding>0 and regionid = '10') as C

 ----------------------------------------

--BC ALC & Outstanding
------------------------

Select BranchCount,CenterCount,
(Select COUNT(distinct(LEFT(clientloanid,14))) from ClientLoanSubscription where ActualPaidUpDate is null and PrincipalOutstanding>0 and regionid = '10'
and SUBSTRING(ClientLoanID,16,2) in (select ProductID from Products where type like '%BC%' and regionid = '10')) As LoanClients,
LoanOutstanding,AmountOutstanding,InterestCollected from (Select Count(ClientLoanID) As LoanOutstanding,Sum((cast(PrincipalOutstanding as bigINT))) As AmountOutstanding,
(Select COUNT(CenterID)  from Centers With (Nolock) where DissolvedDate is null and FormationDate<=CONVERT(varchar(10),getdate(),23) and regionid = '10') As CenterCount,
(Select COUNT(BranchID)   from Branches With (Nolock) where DissolvedDate is null and regionid = '10') As BranchCount,
(Select SUM(InterestCollected) from LoanLedger With (Nolock) 
where WeeklyTransactionDate between '2023-04-01'  and CONVERT(varchar(10),getdate(),23) and regionid = '10'
and SUBSTRING(ClientLoanID,16,2) in (select ProductID from Products where type like '%BC%' and regionid = '10')) as InterestCollected
from ClientLoanSubscription where ActualPaidUpDate is null and PrincipalOutstanding>0 and regionid = '10'
and SUBSTRING(ClientLoanID,16,2) in (select ProductID from Products where type like '%BC%' and regionid = '10')) as C 


-------------------- Defalter MIssMatch Query ----------------------------
select count(ClientLoanID) LoanClients,sum(PrincipalOutstanding) Outstanding from ClientLoanSubscription where 
ActualPaidUpDate is null and CurrentInstallmentPeriod >LoanDurationInWeeks and regionid = '10'


-------------------- Total Death Client Match Query ----------------------------

Select SUM(deathdetails) As Clientsdeathdetails from (SELECT     BranchID, sum(NumDeathClients1InstallmentInArrears+NumDeathClients2InstallmentInArrears+NumDeathClients3InstallmentInArrears+
NumDeathClients4InstallmentInArrears+
NumDeathClients5PlusInstallmentInArrears+NumDeathClientsDefaultersInstallmentInArrears)as deathdetails
FROM RptBranches  where branchid Like '10%'
group by BranchID) AS RPT

Select SUM(Expr2) Loandeathdetails from(SELECT     LEFT(ClientLoanID, 5) AS Expr1, COUNT(LoanProposalID) AS Expr2
FROM         ClientLoanSubscription
WHERE     (NOT (DeathDate IS NULL)) AND (ActualPaidUpDate IS NULL) AND (NumInstallmentsInArrears > 0)  and CONVERT(varchar(10),DeathEntryDate,23)<=CONVERT(varchar(10),GETDATE(),23)
and RegionID = '10'
GROUP BY LEFT(ClientLoanID, 5)) as CLS



select SUM(InterestCollected) as InterestCollected from LoanLedger With (NoLock) where 
WeeklyTransactionDate between '2025-03-07' And '2025-03-12' and regionid = '10'



SELECT      COUNT(ClientLoanSubscription.ClientLoanID) AS BCALC, SUM(ClientLoanSubscription.PrincipalOutstanding) AS Outstanding
FROM         ClientLoanSubscription INNER JOIN
                      ClientLoanProposal ON ClientLoanSubscription.LoanProposalID = ClientLoanProposal.LoanProposalID INNER JOIN
                      Products ON ClientLoanProposal.ProductID = Products.ProductID
WHERE     (ClientLoanSubscription.ActualPaidUpDate IS NULL) AND (Products.Type in( 'BC KOTAK')) 
and ClientLoanSubscription.regionid = '10'
and ClientLoanProposal.regionid = '10'
HAVING      (SUM(ClientLoanSubscription.PrincipalOutstanding) > 0)

SELECT      COUNT(ClientLoanSubscription.ClientLoanID) AS BCALC, SUM(ClientLoanSubscription.PrincipalOutstanding) AS Outstanding
FROM         ClientLoanSubscription INNER JOIN
                      ClientLoanProposal ON ClientLoanSubscription.LoanProposalID = ClientLoanProposal.LoanProposalID INNER JOIN
                      Products ON ClientLoanProposal.ProductID = Products.ProductID
WHERE     (ClientLoanSubscription.ActualPaidUpDate IS NULL) AND (Products.Type in( 'BC SIDBI')) 
and ClientLoanSubscription.regionid = '10'
and ClientLoanProposal.regionid = '10'
HAVING      (SUM(ClientLoanSubscription.PrincipalOutstanding) > 0)

SELECT      COUNT(ClientLoanSubscription.ClientLoanID) AS BCALC, SUM(ClientLoanSubscription.PrincipalOutstanding) AS Outstanding
FROM         ClientLoanSubscription INNER JOIN
                      ClientLoanProposal ON ClientLoanSubscription.LoanProposalID = ClientLoanProposal.LoanProposalID INNER JOIN
                      Products ON ClientLoanProposal.ProductID = Products.ProductID
WHERE     (ClientLoanSubscription.ActualPaidUpDate IS NULL) AND (Products.Type in( 'BC ICICI')) 
and ClientLoanSubscription.regionid = '10'
and ClientLoanProposal.regionid = '10'
HAVING      (SUM(ClientLoanSubscription.PrincipalOutstanding) > 0)

SELECT      COUNT(ClientLoanSubscription.ClientLoanID) AS BCALC, SUM(ClientLoanSubscription.PrincipalOutstanding) AS Outstanding
FROM         ClientLoanSubscription INNER JOIN
                      ClientLoanProposal ON ClientLoanSubscription.LoanProposalID = ClientLoanProposal.LoanProposalID INNER JOIN
                      Products ON ClientLoanProposal.ProductID = Products.ProductID
WHERE     (ClientLoanSubscription.ActualPaidUpDate IS NULL) AND (Products.Type in( 'BC IDBI')) 
and ClientLoanSubscription.regionid = '10'
and ClientLoanProposal.regionid = '10'
HAVING      (SUM(ClientLoanSubscription.PrincipalOutstanding) > 0)



--INDUS-IND--KOTAK--IDBI--SSIDBI

---  rpt
Select COUNT(*) from RptBranches with (nolock) where ReportingDate='2025-12-24' and BranchID like '05%'
Select COUNT(*) from RptBranchesAssign with (nolock) where ReportingDate='2025-12-24' and BranchID like '05%'
Select COUNT(*) from RptBranchesNonIGL with (nolock) where ReportingDate='2025-12-24' and BranchID like '05%'
Select COUNT(*) from RptBranchesNonIGLProducts with (nolock) where ReportingDate='2025-12-24' and BranchID like '05%'
Select COUNT(*) from RptBranchesOwn with (nolock) where ReportingDate='2025-12-24' and BranchID like '05%'
Select COUNT(*) from RptBranchesBC with (nolock) where ReportingDate='2025-12-24' and BranchID like '05%'
Select COUNT(*) from RptBranchesIndusind with (nolock) where ReportingDate='2025-12-24' and BranchID like '05%'
select COUNT(*) from RptBranchesFLPurposes with (nolock) where ReportingDate='2025-12-24' and BranchID like '05%'
select COUNT(*) from RptBranchesFL with (nolock) where ReportingDate='2025-12-24' and BranchID like '05%'
select COUNT(*) from RptBranchesFLnonigl with (nolock) where ReportingDate='2025-12-24' and BranchID like '05%'



 
-- select left(ClientLoanID,5),count(ClientLoanID),sum(PrincipalOutstanding) from ClientLoanSubscription where ActualPaidUpDate is null and CurrentInstallmentPeriod >LoanDurationInWeeks
--group by  left(ClientLoanID,5)
--order by left(ClientLoanID,5)

--select BranchID,NumLoansDefaultersInstallmentInArrears,OutstandingDefaultersInstallmentInArrears from RptBranches where NumLoansDefaultersInstallmentInArrears>0  
--order by branchid 

--select * from clientloansubscription where deathdate is not null and actualpaidupdate is null   and left(clientloanid,5)in('14:06','14:14','14:18') order by clientloanid

--SELECT     SUM(deathdetails) AS Expr1, BranchID
--FROM         (SELECT     BranchID, 
--                                              SUM(NumDeathClients1InstallmentInArrears + NumDeathClients2InstallmentInArrears + NumDeathClients3InstallmentInArrears + NumDeathClients4InstallmentInArrears
--                                               + NumDeathClients5PlusInstallmentInArrears + NumDeathClientsDefaultersInstallmentInArrears) AS deathdetails
--                       FROM          RptBranches
--                       GROUP BY BranchID) AS RPT
--GROUP BY BranchID
--HAVING      (SUM(deathdetails) > 0)
--ORDER BY BranchID

--------------------------------------------------------------------------------

-------------------- BC Death Client Match Query ----------------------------
--Select SUM(deathdetails) from (
--SELECT     BranchID, sum(NumDeathClients1InstallmentInArrears+NumDeathClients2InstallmentInArrears+NumDeathClients3InstallmentInArrears+
--NumDeathClients4InstallmentInArrears+
--NumDeathClients5PlusInstallmentInArrears+NumDeathClientsDefaultersInstallmentInArrears)as deathdetails
--FROM         RptBranchesBC  group by BranchID
--having sum(NumDeathClients1InstallmentInArrears+NumDeathClients2InstallmentInArrears+NumDeathClients3InstallmentInArrears+NumDeathClients4InstallmentInArrears+NumDeathClients5PlusInstallmentInArrears+NumDeathClientsDefaultersInstallmentInArrears)>0
--)As RPTBC


--------------------intrest Collection------------

--select SUM(InterestCollected ) from LoanLedger where 
--WeeklyTransactionDate >='2022-08-26'


--Fianacialdata in Local
select  COUNT(distinct(LEFT(clientloanid,14))),sum(cast((principaloutstanding) as float))  
from bookdept (nolock)where MonthDate='2022-14-12 00:00:00' and clientloanid like '14%'


Select LEFT(ClientLoanID,5),COUNT(distinct(LEFT(clientloanid,14))) from ClientLoanSubscription where ActualPaidUpDate is null and PrincipalOutstanding>0
Group by LEFT(ClientLoanID,5)
order By LEFT(ClientLoanID,5)
Select BranchID,NumLoanClients From RptBranches Order by BranchID 

--BM Query
Select b.branchName,fs.branchID,fs.staffName,* From FieldStaff as fs
inner join Branches as b on b.branchID = fs.BranchID
where fs.BranchID Like '31%' And fs.Designation = '14' And fs.Exitdate is NULL order by b.branchID


Select * From Branches
Select * From FieldStaff


Select BranchCount,CenterCount,
(Select COUNT(distinct(LEFT(clientloanid,14))) from ClientLoanSubscription where ActualPaidUpDate is null and PrincipalOutstanding>0)As LoanClients,
(Select COUNT(distinct(LEFT(clientloanid,14))) from ClientLoanSubscription where ActualPaidUpDate is null and PrincipalOutstanding>0
and substring(ClientLoanID,14,2) in(select productid from Products where type like'%BC%')) As BCLoanClients,
LoanOutstanding,AmountOutstanding,InterestCollected from (Select Count(ClientLoanID) As LoanOutstanding,Sum(PrincipalOutstanding) As AmountOutstanding,
(Select COUNT(CenterID)  from Centers With (Nolock) where DissolvedDate is null and FormationDate<=CONVERT(varchar(10),getdate(),23)) As CenterCount,
(Select COUNT(BranchID)   from Branches With (Nolock) where DissolvedDate is null) As BranchCount,
(Select SUM(InterestCollected) from LoanLedger With (Nolock) where WeeklyTransactionDate between '2022-04-01' and CONVERT(varchar(10),getdate(),23)) as InterestCollected
from ClientLoanSubscription where ActualPaidUpDate is null and PrincipalOutstanding>0) as C 

select sum(principaloutstanding) from FinancialData..bookdept with(nolock) where BranchID like'14%' and MonthDate='2022-11-30'