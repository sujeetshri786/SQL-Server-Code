select clientid from cds2 with (nolock) where clientid like '10%' and clientloan1balance>1  and clientid not in
(select clientid from cds3  with (nolock) where  clientid like '10%'  )
 ---------zone log file date

  select (select top 1 zone from branches where   dissolveddate is null and regionid=left( logfile.branchid,2)  ) zone,
left(branchid,2) REGION, count(*) logfile ,endprocdate  from logfile with ( nolock) 
where endprocdate=cast (getdate() as date) and WorkEndDT is not null  and 
left(branchid,2) IN ('28','34','37','21','22','10','01','02','12','15')
 GROUP BY  left(branchid,2),endprocdate
 ORDER BY  zone, left(branchid,2)


-------yashpal sir day clos Disbursement chk query 
Select * From neftdisbtransaction with(nolock) where loanproposalid in(
select loanproposalid from clientloansubscription with(nolock) where actualdisbursementdate<=(convert(nvarchar(28),getdate()-1,23)) and disbursementdate is null
and RegionID IN ('28','34','37','21','22','10','01','02','12','15') 
 ) order by LoanProposalID

 ------GAURAV sir day clos Disbursement chk query 
select actualdisbursementdate,*  from clientloansubscription with(nolock) where actualdisbursementdate<=(convert(nvarchar(28),getdate()-1,23)) 
and RegionID IN ('28','34','37','21','22','10','01','02','12','15')
and disbursementdate is null
and loanproposalid in (select loanproposalid from Cashpor..APBSNEFTDisbursement with(nolock) )

-----  cash disb date chk qq

	
select * from clientloansubscription with (nolock) where RegionID IN ('28','34','37','21','22','10','01','02','12','15')  and 
actualdisbursementdate=(convert(nvarchar(28),getdate(),23)) and disbursementdate is  null and disbursementmode='0'


--------------------------------- (no record)
Select * from ClientLoanSubscription  With (Nolock) where  RegionID IN ('28','34','37','21','22','10','01','02','12','15') 
and (PrincipalOutstanding<0 or PrincipalOutstanding is null  or CurrentInstallmentPeriod is null  OR CurrentInstallmentPeriod is null)

 --------------------------------- (no record)
Select clientloansubscription.ClientLoanID,PrincipalOutstanding,clientloansubscription.PrincipalInArrears,LastTransactionDate,
PrincipalOutstanding-clientloansubscription.PrincipalInArrears as morearreas ,
loanledger.PrincipalInstallmentAmt as LLPInstallment,LoanLedger.PrincipalInArrears as LLPArrears,
WeeklyTransactionDate,(LoanLedger.PrincipalInstallmentAmt+PrincipalOutstanding-clientloansubscription.PrincipalInArrears)-PrincipalCollected as ProposedPArrearLL
from ClientLoanSubscription (nolock)
inner join LoanLedger (nolock) on loanledger.clientloanid=clientloansubscription.ClientLoanID and LastTransactionDate=WeeklyTransactionDate
where PrincipalOutstanding>0 and CurrentInstallmentPeriod>LoanDurationInWeeks and PrincipalOutstanding<clientloansubscription.PrincipalInArrears
and clientloansubscription.RegionID IN ('28','34','37','21','22','10','01','02','12','15')


----- no record
Select clientloansubscription.ClientLoanID,PrincipalOutstanding,clientloansubscription.PrincipalInArrears,LastTransactionDate,PrincipalOutstanding-clientloansubscription.PrincipalInArrears as lessarrears ,
loanledger.PrincipalInstallmentAmt,LoanLedger.PrincipalInArrears,WeeklyTransactionDate,(LoanLedger.PrincipalInstallmentAmt+PrincipalOutstanding-clientloansubscription.PrincipalInArrears)-PrincipalCollected as ProposedPArrearLL
from ClientLoanSubscription with(Nolock) 
inner join LoanLedger with(Nolock) on loanledger.clientloanid=clientloansubscription.ClientLoanID and LastTransactionDate=WeeklyTransactionDate
where PrincipalOutstanding>0 and CurrentInstallmentPeriod>LoanDurationInWeeks and PrincipalOutstanding>clientloansubscription.PrincipalInArrears
and clientloansubscription.RegionID IN ('28','34','37','21','22','10','01','02','12','15')

----- no record  db and dcr disb  match
select b.BranchID, b.TotalDisbursementHO as TotalDisbursementHO_DTL,a.TotalDisbursementHO
from (select left(ClientLoanID,5) as BranchID, SUM(LoanAmountDisbursed) as TotalDisbursementHO 
from ClientLoanSubscription with(nolock) 
where DisbursementDate=cast(GETDATE() as date) and disbursementmode in (2,4)
group by left(ClientLoanID,5)) a 
join TempDailyClosingDtl b with(nolock) on a.BranchID=b.BranchID
and b.RegionID IN ('28','34','37','21','22','10','01','02','12','15')
where b.TotalDisbursementHO>0 and b.TotalDisbursementHO<>a.TotalDisbursementHO


-------- (no record)
 
----- stamp record
select clientloansubscription.BRANCHID, branches.BranchName as BRANCH_NAME, count(clientloanid) as NUM_LOANCLIENT_CLS, 
SUM(LoanAmountDisbursed) as DISBURSED_AMT_CLS, 
COUNT(clientloanid)*200 as STAMPAMOUNT_CLS,
(select ISNULL(sum(StampPeperColl),0) from DailyClosingDtl with(Nolock) where BranchID=clientloansubscription.BRANCHID) as 'STAMP_AMOUNT_DCR',
case when COUNT(clientloanid)*200=(select ISNULL(sum(StampPeperColl),0) from DailyClosingDtl  with(Nolock)
where BranchID=clientloansubscription.BRANCHID) then 'True' else 'False' End as 'STAMP_MATCH_CLS_DCR STATUS'
from clientloansubscription with(Nolock) inner join Branches with(Nolock) on Branches.BranchID=clientloansubscription.BRANCHID
where ActualDisbursementDate>=CONVERT(varchar(28), GETDATE() ,23) and SUBSTRING(clientloanid,16,2) in ('W6','5X') AND clientloansubscription.REGIONID IN 
('28','34','37','21','22','10','01','02','12','15')
group by clientloansubscription.BRANCHID, branches.BranchName


--------



	SELECT ClientLoanid FROM ClientLoanSubscription  c  WITH (NOLOCK) WHERE c.ActualDisbursementDate=c.ActualPaidUpDate and 
	 c.REGIONID IN 
('28','34','37','21','22','10','01','02','12','15')



--SELECT * FROM ClientLoanSubscription WITH (NOLOCK) WHERE ActualDisbursementDate=ActualPaidUpDate  and  regionid IN ('28','34','37','21','22','10','01','02','12','15')


-------- DAILY INSURANCE CHK SAMAR SIR QQ

Select DistrictName,Br.BranchID,BranchName,Cls.ClientLoanID,cls.LoanProposalID,Targetname,Targetage,
CoBorrowerName,CoBorrowerAge,cls.InsuranceCompanyName,DisbursementDate,ActualDisbursementDate,
cls.LoanAmountDisbursed,CurrentInstallmentPeriod,LoanDurationInWeeks,cls.UpFrontFee,cls.RiskFund 
,  cls.riskfunddate,cls.upfrontfeedate from ClientLoanSubscription cls (nolock) 
Join Products p (nolock) on p.ProductID=SUBSTRING(cls.clientloanid,16,2)
join clientloanproposal clp (nolock) on clp.loanproposalid=cls.loanproposalid
Join Branches Br (nolock) on Br.branchid=left(cls.clientloanid,5)
where cls.RiskFund=0     and Targetage<60 and  DISBURSEMENTDATE>='2024-04-01'
and ((p.Loan_Category in(0,7)) or(p.BCIDNO<>0 and p.Loan_Category=5)) and CLS.PrincipalOutstanding>0
and  cls.regionid IN ('28','34','37','21','22','10','01','02','12','15')
order by cls.BranchID




------day ini


  select (select top 1 zone from branches where   dissolveddate is null and regionid=left( logfile.branchid,2)  ) zone,
left(branchid,2) REGION, count(*) logfile ,iniprocdate  from logfile with ( nolock) 
where iniprocdate>=cast (getdate()+1 as date)  and 
left(branchid,2) IN ('28','34','37','21','22','10','01','02','12','15')
 GROUP BY  left(branchid,2),iniprocdate
 ORDER BY  zone, left(branchid,2)

 select   count(branchid)   from logfile  with ( nolock) where endprocdate =cast (getdate() as date)
 union all
 select count(branchid) from logfile with ( nolock)  where iniprocdate >=cast (getdate()+1 as date)
union all
select count (distinct branchid) from dicds1 with ( nolock) where actualmeetingdate>=cast (getdate()+1 as date)
union all
select count (distinct branchid) from [43.242.214.235].appcashpor.dbo.cds1 with ( nolock) where actualmeetingdate>=cast (getdate()+1 as date)


/*



Select DistrictName,Br.BranchID,BranchName,Cls.ClientLoanID,cls.LoanProposalID,Targetname,Targetage,
CoBorrowerName,CoBorrowerAge,cls.InsuranceCompanyName,DisbursementDate,ActualDisbursementDate,
cls.LoanAmountDisbursed,CurrentInstallmentPeriod,LoanDurationInWeeks,cls.UpFrontFee,cls.RiskFund 
,  cls.riskfunddate,cls.upfrontfeedate from ClientLoanSubscription cls (nolock) 
Join Products p (nolock) on p.ProductID=SUBSTRING(cls.clientloanid,16,2)
join clientloanproposal clp (nolock) on clp.loanproposalid=cls.loanproposalid
Join Branches Br (nolock) on Br.branchid=left(cls.clientloanid,5)
where ( cls.RiskFund=0  OR cls.RiskFundDATE IS NULL )   and Targetage<60 and  DISBURSEMENTDATE>='2024-04-01'
and ((p.Loan_Category in(0,7)) or(p.BCIDNO<>0 and p.Loan_Category=5)) and CLS.PrincipalOutstanding>0
and  cls.regionid IN ('28','34','37','21','22','10','01','02','12','15')
order by cls.BranchID

*/

/*


Select Cls.ClientLoanID from ClientLoanSubscription cls WITH (NOLOCK)
Join Products p WITH (NOLOCK) on p.ProductID=SUBSTRING(cls.clientloanid,16,2)
join clientloanproposal clp WITH (NOLOCK) on clp.loanproposalid=cls.loanproposalid
Join Branches Br WITH (NOLOCK) on Br.branchid=left(cls.clientloanid,5)
where ActualDisbursementDate >='2023-10-01' and cls.RiskFund=0   and Targetage<60 
and ((p.Loan_Category in(0,7)) or(p.BCIDNO<>0 and p.Loan_Category=5)) and actualpaidupdate is null  
order by cls.BranchID






Select DistrictName,Br.BranchID,BranchName,Cls.ClientLoanID,cls.LoanProposalID,Targetname,Targetage,CoBorrowerName,CoBorrowerAge,cls.InsuranceCompanyName,DisbursementDate,ActualDisbursementDate,
cls.LoanAmountDisbursed,CurrentInstallmentPeriod,LoanDurationInWeeks,cls.UpFrontFee,cls.RiskFund , cls.actualpaidupdate, cls.riskfunddate,cls.upfrontfeedate from ClientLoanSubscription cls (nolock) 
Join Products p (nolock) on p.ProductID=SUBSTRING(cls.clientloanid,16,2)
join clientloanproposal clp (nolock) on clp.loanproposalid=cls.loanproposalid
Join Branches Br (nolock) on Br.branchid=left(cls.clientloanid,5)
where ActualDisbursementDate >='2023-10-01' and cls.RiskFund=0   and Targetage<60 
and ((p.Loan_Category in(0,7)) or(p.BCIDNO<>0 and p.Loan_Category=5)) and actualpaidupdate is null  and  cls.regionid IN ('28','34','37','21','22','10','01','02','12','15')
order by cls.BranchID


*/



------ for arrear report chk day close status
select * from logfile with (nolock) where  left(branchid,2) IN ('28','34','37','21','22','10') and endprocdate=cast (getdate() as date) 
order by 	WorkEndDT desc

select * from logfile with (nolock) where  left(branchid,2) IN ('28','34','37','21','22','10') and iniprocdate=cast (getdate()+1 as date) 
order by 	WorkEndDT desc



-------FOR DCR CHK and log file


 SELECT regionid, COUNT(*) local_dtl FROM TEMPDailyClosingDTL  with ( nolock ) WHERE  
SEND=1 and regionid IN ('28','34','37','21','22','10','01','02','12','15')
 and cast(datestamp as date )=CONVERT(varchar(10),getdate(),23)
 group by regionid
 order  by regionid

 select left(branchid,2) REGION, count(*) logfile  from logfile with ( nolock) where endprocdate=cast (getdate() as date) and WorkEndDT is not null  and left(branchid,2) IN ('28','34','37','21','22','10','01','02','12','15')
 GROUP BY left(branchid,2)
 ORDER BY left(branchid,2)

 ----ALL THREE RECORD R SAME (REGION ID SINGLE RAHEGI)

Select counT(*),sum(Loanamountdisbursed) from ClientLoanProposal with(nolock) 
where LoanDisbursementDate=cast (getdate() as date) and FinalIfsccode<>'0' and FinalAccountNumber<>'0' and DisbursementMode in('4','2') 
and FinalAccountNumber is not null and  regionid IN ('28','34','37','21','22','10','01','02','12','15')

Select counT(*),sum(Loanamountdisbursed) from ClientLoanSubscription with(nolock) 
where ActualDisbursementDate=cast (getdate() as date)  and DisbursementMode in('4','2') 
and DisbursementDate is  null and  regionid IN ('28','34','37','21','22','10','01','02','12','15')

Select counT(*),sum(LoanAmount) from AadharDisbursement 
with(nolock) where DocumentationDate=cast (getdate() as date)  
and DisbursementMode in('4','2') and LoanDisbursementDate is  null and  regionid IN ('28','34','37','21','22','10','01','02','12','15')


	
	
	
----------dc
 /*
 
 select left(branchid,2) REGION, count(*) logfile ,endprocdate  from logfile with ( nolock) 
where endprocdate=cast (getdate() as date) and WorkEndDT is not null  and 
left(branchid,2) IN ('28','34','37','21','22','10','01','02','12','15')
 GROUP BY left(branchid,2),endprocdate
 ORDER BY left(branchid,2)




 Select DISTINCT top 30 BRANCHID  From neftdisbtransaction with(nolock) where loanproposalid in(
select loanproposalid from clientloansubscription with(nolock) where actualdisbursementdate<=(convert(nvarchar(28),getdate()-1,23)) and disbursementdate is null
 )  ORDER BY BRANCHID 




 Select branchid,StaffID,SUM(InterestCollected),WeeklyTransactionDate  as InterestCollected from LoanLedger With (Nolock) 
where WeeklyTransactionDate between '2025-01-16' and '2025-01-16' 
And RegionID IN ('28','34','37','21','22','10','01','02','12','15') AND StaffID='0507'
Group by branchid,StaffID,WeeklyTransactionDate
ORDER  by branchid,StaffID,WeeklyTransactionDate


 */


