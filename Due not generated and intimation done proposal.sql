--Due Not Generated in Reason Appcashpor
Select left(a.GroupID,5) as BranchID,br.BranchName,a.ClientID,c.ClientName,a.ClientLoan1ProductName
From Cds2 as a With (NoLock)
inner join cds3 as c on c.ClientID=a.ClientID
inner join branches as br on br.BranchID=left(a.ClientID,5)
where a.ClientID Like '14%' and a.ClientLoan1ID = '0' and a.ClientLoan1ProductName <> '0'
order by BranchID


--Total Intimation done Proposal With OutStanding Appcashpor
Select Left(clp.ClientID,5) as BranchID,b.BranchName,clp.ClientID,clp.Targetname as ClientName,clp.ProductID,clp.productCategory,
clp.PrincipalOutstanding From ClientLoanProposal as clp With (NoLock) 
inner Join Branches as b on b.BranchID=Left(clp.ClientID,5)
where Intimationdonedt is not null and Intimationdonedt >= '2022-04-01' and PrincipalOutstanding > '1'
and ClientID in (Select ClientID from ClientLoanProposal Where LoanDisbursementDate is null and PrincipalOutstanding = '1')
and clientID like '14%'
order by ClientID




