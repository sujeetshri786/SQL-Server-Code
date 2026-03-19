--Cashless coleection staff wise local database
select LEFT(ClientLoanID,5) BranchID,b.BranchName ,l.EntryBy,f.StaffName,count(ClientLoanID) NoOfLoans,
SUM(PrincipalCollected +InterestCollected)
TransactionAmount  from LoanLedger l inner join FieldStaff f
on f.StaffID =l.EntryBy 
inner join Branches b
on b.BranchID =f.BranchID  
where WeeklyTransactionDate between'2022-03-01' and '2022-03-31' and CollectionMode in('4','5','6','7')
group by l.EntryBy ,LEFT(ClientLoanID,5),f.StaffName,b.BranchName
order by  LEFT(ClientLoanID,5)
