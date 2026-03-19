----Appcashpor----
select Branches.BranchName,Branches.BranchID,Branches.CHID,fieldstaff.StaffName as CHName,
(select isnull(count(distinct ClientID),0) from CDS2 with(nolock) where branches.BranchID=left(ClientLoan1ID,5) 
and ClientLoan1AmtDueDisbursed>0)as NoOfClientsDue,
(select isnull(sum(ClientLoan1AmtDueDisbursed),0) from CDS2 with(nolock) where branches.BranchID=left(ClientLoan1ID,5)
and ClientLoan1AmtDueDisbursed>0)as LoanamtDue,
(select count(distinct ClientID) from CDS2 with(nolock) where branches.BranchID=left(ClientLoan1ID,5) 
and ClientLoan1AmountDisbursed>0)as NoOfClientsDisbursed,
(select isnull(sum(ClientLoan1AmountDisbursed),0) from CDS2 with(nolock) where branches.BranchID=left(ClientLoan1ID,5) 
and ClientLoan1AmountDisbursed>0)as LoanamtDisbursed,
(select isnull(count(distinct ClientID),0) from CDS2 with(nolock) where branches.BranchID=left(ClientLoan1ID,5) 
and ClientLoan1balance>0 and (ClientLoan1principaldue+clientloan1interestdue)>0 and clientloan1totalcollected=0)as NoOfArrear,
(select isnull(sum(ClientLoan1principaldue+clientloan1interestdue),0) from CDS2 with(nolock) 
where branches.BranchID=left(ClientLoan1ID,5) and ClientLoan1balance>0 and (ClientLoan1principaldue+clientloan1interestdue)>0 
and clientloan1totalcollected=0) as ArrearAmt,

(select ISNULL(round(Cast(((select count(ClientID) from CDS2 with(nolock) where branches.BranchID=left(ClientLoan1ID,5) 
and ClientLoan1AmountDisbursed>0)*100) as decimal)/(select nullif(count(ClientID),0) from CDS2 with(nolock) 
where branches.BranchID=left(ClientLoan1ID,5) and ClientLoan1AmtDueDisbursed>0),2),0)) as PerALC,
(select ISNULL(round(Cast(((select isnull(sum(ClientLoan1AmountDisbursed),0) from CDS2 with(nolock)
where branches.BranchID=left(ClientLoan1ID,5) and ClientLoan1AmountDisbursed>0)*100) as decimal)/
(select nullif(sum(ClientLoan1AmtDueDisbursed),0) from CDS2 with(nolock) where branches.BranchID=left(ClientLoan1ID,5) 
 and ClientLoan1AmtDueDisbursed>0),2),0)) as PerAmt,
(select (case when send='1' then 'DayClose' when send='0' then 'DayClosePending' end) from DailyClosingDtl
where branches.BranchID=BranchID) as DayCloseRemark
from Branches with(nolock) inner join fieldstaff with(nolock) on branches.chid=fieldstaff.staffid 
where branches.DissolvedDate is null and branches.branchid like '14%'
order by branches.chid


--------CashporOne
--select branches.BranchName,branches.BranchID,branches.CHid,fieldstaff.Staffname as CHName,
--(select isnull(count(distinct ClientID),0) from Prevcds2 with(nolock) where branches.BranchID=left(ClientLoan1ID,5) 
--and ClientLoan1AmtDueDisbursed>0)as NoOfClientsdue,
--(select isnull(sum(ClientLoan1AmtDueDisbursed),0) from Prevcds2 with(nolock) where branches.BranchID=left(ClientLoan1ID,5)
--and ClientLoan1AmtDueDisbursed>0)as LoanamtDue,
--(select count(distinct ClientID) from Prevcds2 with(nolock) where branches.BranchID=left(ClientLoan1ID,5) 
--and ClientLoan1AmountDisbursed>0)as NoOfClientsDisbursed,
--(select isnull(sum(ClientLoan1AmountDisbursed),0) from Prevcds2 with(nolock) where branches.BranchID=left(ClientLoan1ID,5) 
--and ClientLoan1AmountDisbursed>0)as LoanamtDisbursed,
--(select isnull(count(distinct ClientID),0) from Prevcds2 with(nolock) where branches.BranchID=left(ClientLoan1ID,5) 
--and ClientLoan1balance>0 and (ClientLoan1principaldue+clientloan1interestdue)>0 and clientloan1totalcollected=0)as NoOfArrear,
--(select isnull(sum(ClientLoan1principaldue+clientloan1interestdue),0) from Prevcds2 with(nolock) 
--where branches.BranchID=left(ClientLoan1ID,5) and ClientLoan1balance>0 and (ClientLoan1principaldue+clientloan1interestdue)>0 
--and clientloan1totalcollected=0) as ArrearAmt,

--(select ISNULL(round(Cast(((select count(ClientID) from Prevcds2 with(nolock) where branches.BranchID=left(ClientLoan1ID,5) 
--and ClientLoan1AmountDisbursed>0)*100) as decimal)/(select nullif(count(ClientID),0) from Prevcds2 with(nolock) 
--where branches.BranchID=left(ClientLoan1ID,5) and ClientLoan1AmtDueDisbursed>0),2),0)) as PerALC,
--(select ISNULL(round(Cast(((select isnull(sum(ClientLoan1AmountDisbursed),0) from Prevcds2 with(nolock)
--where branches.BranchID=left(ClientLoan1ID,5) and ClientLoan1AmountDisbursed>0)*100) as decimal)/
--(select nullif(sum(ClientLoan1AmtDueDisbursed),0) from Prevcds2 with(nolock) where branches.BranchID=left(ClientLoan1ID,5) 
-- and ClientLoan1AmtDueDisbursed>0),2),0)) as PerAmt,
--(select (case when send='1' then 'DayClose' when send='0' then 'DayClosePending' end) from DailyClosingDtl
--where branches.BranchID=BranchID) as DayCloseRemark
--from Branches with(nolock) inner join fieldstaff with(nolock) on branches.chid=fieldstaff.staffid 
--where branches.DissolvedDate is null and branches.branchid like '14%'
--order by branches.chid

----IP Query
select branches.BranchName,branches.BranchID,branches.CHid,fieldstaff.Staffname as CHName,
(select isnull(count(distinct ClientID),0) from [43.242.214.235].appcashpor.dbo.cds2 with(nolock) where branches.BranchID=left(ClientLoan1ID,5) 
and ClientLoan1AmtDueDisbursed>0)as NoOfClientsdue,
(select isnull(sum(ClientLoan1AmtDueDisbursed),0) from [43.242.214.235].appcashpor.dbo.cds2 with(nolock) where branches.BranchID=left(ClientLoan1ID,5)
and ClientLoan1AmtDueDisbursed>0)as LoanamtDue,
(select count(distinct ClientID) from [43.242.214.235].appcashpor.dbo.cds2 with(nolock) where branches.BranchID=left(ClientLoan1ID,5) 
and ClientLoan1AmountDisbursed>0)as NoOfClientsDisbursed,
(select isnull(sum(ClientLoan1AmountDisbursed),0) from [43.242.214.235].appcashpor.dbo.cds2 with(nolock) where branches.BranchID=left(ClientLoan1ID,5) 
and ClientLoan1AmountDisbursed>0)as LoanamtDisbursed,
(select isnull(count(distinct ClientID),0) from [43.242.214.235].appcashpor.dbo.cds2 with(nolock) where branches.BranchID=left(ClientLoan1ID,5) 
and ClientLoan1balance>0 and (ClientLoan1principaldue+clientloan1interestdue)>0 and clientloan1totalcollected=0)as NoOfArrear,
(select isnull(sum(ClientLoan1principaldue+clientloan1interestdue),0) from [43.242.214.235].appcashpor.dbo.cds2 with(nolock) 
where branches.BranchID=left(ClientLoan1ID,5) and ClientLoan1balance>0 and (ClientLoan1principaldue+clientloan1interestdue)>0 
and clientloan1totalcollected=0) as ArrearAmt,

(select ISNULL(round(Cast(((select count(ClientID) from [43.242.214.235].appcashpor.dbo.cds2 with(nolock) where branches.BranchID=left(ClientLoan1ID,5) 
and ClientLoan1AmountDisbursed>0)*100) as decimal)/(select nullif(count(ClientID),0) from [43.242.214.235].appcashpor.dbo.cds2 with(nolock) 
where branches.BranchID=left(ClientLoan1ID,5) and ClientLoan1AmtDueDisbursed>0),2),0)) as PerALC,
(select ISNULL(round(Cast(((select isnull(sum(ClientLoan1AmountDisbursed),0) from [43.242.214.235].appcashpor.dbo.cds2 with(nolock)
where branches.BranchID=left(ClientLoan1ID,5) and ClientLoan1AmountDisbursed>0)*100) as decimal)/
(select nullif(sum(ClientLoan1AmtDueDisbursed),0) from [43.242.214.235].appcashpor.dbo.cds2 with(nolock) where branches.BranchID=left(ClientLoan1ID,5) 
 and ClientLoan1AmtDueDisbursed>0),2),0)) as PerAmt,
(select (case when send='1' then 'DayClose' when send='0' then 'DayClosePending' end) from [43.242.214.235].appcashpor.dbo.DailyClosingDtl
where branches.BranchID=BranchID) as DayCloseRemark
from [43.242.214.235].appcashpor.dbo.Branches with(nolock) inner join [43.242.214.235].appcashpor.dbo.fieldstaff with(nolock) on branches.chid=fieldstaff.staffid 
where branches.DissolvedDate is null and branches.branchid like'05%' 
order by branches.chid
