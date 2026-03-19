--Proposal Entry Report Loacal

select clp.ProposalDate, left(clp.clientid, 5) as BranchID, clp.ClientID, clp.TargetName as ClientName, clp.LoanProposalID, 
clp.ProductID, clp.ProductCategory, clp.PurposeId, clp.LoanDescription, clp.LoanAmountBM, clp.LoanAmountApproved, 
clp.PrincipalOutstanding, clp.EntryBy, fs1.StaffName, dm1.DesignationName, clp.BMID, fs.StaffName as BMName, 
dm.DesignationName, clp.FinalReviewDate from clientloanproposal as clp with(nolock)
inner join MasterActivity..branches as b on left(clp.ClientID, 5) = b.branchid
inner join fieldstaff as fs on clp.BMID = fs.StaffID
inner join DesignationMaster as dm on fs.Designation = dm.DesignationID
inner join fieldstaff as fs1 on clp.EntryBy = fs1.StaffID
inner join DesignationMaster as dm1 on fs1.Designation = dm1.DesignationID
where clp.ProposalDate >= '2023-05-01' and clp.PrincipalOutstanding > '1' --and clp.loandisbursementdate is null
