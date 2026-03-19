--Staff Not Entry Single Proposal Previous Day

select b.branchid as BranchId,b.BranchName,f.StaffID,f.staffname as StaffName from FieldStaff as f
inner join branches as b on b.branchid=f.BranchID
where f.branchid like '14%' and f.ExitDate is null and f.Designation in ('12','13','14','15','46','47') 
and f.StaffID not in (select entryby from ClientLoanProposal where ProposalDate between '2023-07-15' and '2023-07-16')
order by b.branchid,b.BranchName,f.StaffID,f.staffname

--Select * from clientloanproposal where ProposalDate between '2023-07-15' and '2023-07-15' and clientid like '14%' and Entryby = '12667'