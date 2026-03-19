--Local
select left(clientloanid,8) as CenterID,SUM(principalcollected+interestcollected) as Totalcollected from LoanLedger 
where WeeklyTransactionDate='2022-11-23' and clientloanid like'14%'
group by left(clientloanid,8)
order by left(clientloanid,8)
