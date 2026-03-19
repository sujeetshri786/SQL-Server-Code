--FLEXI elgible list branch wise in local


Select left(ClientID,5) as BranchID,Br.BranchBC,br.BranchName,cl.ClientID,tr.TargetName From Clients as cl With (NoLock) 
Inner Join Branches as br With (NoLock) on br.BranchID=left(cl.ClientID,5)
inner join Targets as tr With (NoLock) on tr.TargetID=cl.TargetID
Where EligibleForFL = '1' and DropOutStatus = '0' and HotListDate is NULL and 
ClientID like '14%' And ClientID Not IN (Select ClientID From ClientLoanProposal With (NoLock) Where PrincipalOutstanding>'1' And ProductCategory Like '%Flexi%'
and ClientID like '14%') order by br.BranchID

--WCTL elgible list branch wise in local
Select left(cl.ClientID,5) as BranchID,Br.BranchBC,br.BranchName,cl.ClientID,tr.TargetName as ClientName,clp.ProposalDate,clp.LoanProposalId,clp.LoanAmountDisbursed,
clp.FinalReviewDate,clp.ProductCategory,clp.PrincipalOutstanding From Clients as cl With (NoLock) 
Inner Join Branches as br With (NoLock) on br.BranchID=left(cl.ClientID,5)
inner join Targets as tr With (NoLock) on tr.TargetID=cl.TargetID
inner join ClientLoanProposal as clp With (NoLock) on clp.clientid=cl.clientid
Where cl.EligibleForFL = '1' and cl.DropOutStatus = '0' and cl.HotListDate is NULL and clp.productcategory like 'SIDBI' and CLP.PrincipalOutstanding > '1' and 
cl.ClientID like '05%' And cl.ClientID Not IN (Select ClientID From ClientLoanProposal With (NoLock) Where PrincipalOutstanding>'1' And ProductCategory Like '%SIDBI WCTL%'
and ClientID like '05%') order by br.BranchID



