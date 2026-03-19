---------------------------Daily Arear report After Dayclose

select B.BranchName,Left(p.Clientid,5) as Branchid,P.ClientID,clp.TargetName,(PrincipalInArrears+InterestInArrears) ArrearAmt,NumInstallmentsInArrears,Cls.PrincipalOutstanding,
CurrentInstallmentPeriod,cls.LoanDurationInWeeks,Case when DeathDate is not null then 'DeathArrear'
else 'ActualArrear' end as ArrearRemark from prevCDS2 p with(nolock)
join Clientloansubscription cls on cls.Loanproposalid=p.loanproposalid
join clientloanproposal clp on clp.loanproposalid=cls.loanproposalid
join branches b on b.branchid=Left(clp.Clientid,5) where ClientLoan1balance>0 
and (ClientLoan1principaldue+clientloan1interestdue)>0 and clientloan1totalcollected=0 and p.RegionID in('05')
and ((NumInstallmentsInArrears in('1','5') and CurrentInstallmentPeriod<cls.LoanDurationInWeeks) or
(CurrentInstallmentPeriod=(cls.LoanDurationInWeeks+1) and CurrentInstallmentPeriod>cls.LoanDurationInWeeks))
order by Left(p.Clientid,5),ClientId,NumInstallmentsInArrears


--Create Trigger Tr_DataBaseScopeTrigger
--ON Database
--FOR CREATE_TABLE, ALTER_TABLE, DROP_TABLE
--AS 
--BEGIN
--	ROLLBACK
--	PRINT 'You cannot create, alteror drop a table'
--END

---With StaffName


select B.BranchName,Left(p.Clientid,5) as Branchid,p1.CenterID,p1.CenterName,p3.ClientID,p3.ClientName,p1.StaffID as CMID,p1.StaffName as CMName,p1.MeetingDate,
(PrincipalInArrears+InterestInArrears) ArrearAmt,NumInstallmentsInArrears,Cls.PrincipalOutstanding,
CurrentInstallmentPeriod,cls.LoanDurationInWeeks,Case when DeathDate is not null then 'DeathArrear'
else 'ActualArrear' end as ArrearRemark from prevCDS2 p with(nolock)
join Clientloansubscription cls on cls.Loanproposalid=p.loanproposalid
join PrevCDS1 p1 on p1.GroupID=p.GroupID
join PrevCDS3 p3 on p3.ClientID=p.ClientID
join branches b on b.branchid=Left(p.Clientid,5) 
where ClientLoan1balance>0 
and (ClientLoan1principaldue+clientloan1interestdue)>0 and clientloan1totalcollected=0 and p.RegionID in('14')
and ((NumInstallmentsInArrears in('1','5') and CurrentInstallmentPeriod<cls.LoanDurationInWeeks) or
(CurrentInstallmentPeriod=(cls.LoanDurationInWeeks+1) and CurrentInstallmentPeriod>cls.LoanDurationInWeeks))
order by Left(p.Clientid,5),p3.ClientId,NumInstallmentsInArrears


--Select  top (1) * from PrevCDS2 Where BranchID like '14%'


