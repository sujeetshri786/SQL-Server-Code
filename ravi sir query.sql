select Left(ClientLoanID,5) as Branchid,Sum(LoanAmountDisbursed) from clientloansubscription where disbursementdate='2022-12-01'  
group by Left(ClientLoanID,5)
order by Left(ClientLoanID,5)


select Branchid,TotalDisbursementho from rptdailyclosingdtl where cast(MeetingDate as date)='2022-12-01'
group by Branchid,TotalDisbursementho 
order by Branchid,TotalDisbursementho 



delete   from  MasterActivity..cashpor where left(txtfield1,2) in ('10')

insert into MasterActivity..cashpor(txtField1,txtField2,txtField3,txtField4)
select BranchID,ProductID,Name,BranchName  from Products cross join branches where left(BranchID,2) in ('10')


select * from  MasterActivity..cashpor  where txtField2='p8' and txtField1 like '05:20%'
