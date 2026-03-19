----------Daily Disbursement Ratio

select 	
	b.CGID as Cluster, FieldStaff.StaffName as CHName, 
	(select BranchName from Branches b with(nolock) where b.BranchID = left(cds2.ClientID,5)) 'BranchName',

	isnull(sum(case when clp.ProductCategory not like '%BC%' and clp.ProductCategory not like '%SIDBI%' then cds2.ClientLoan1AmtDueDisbursed end), 0) as 'Own_DueAmt',
	isnull(sum(case when clp.ProductCategory not like '%BC%' and clp.ProductCategory not like '%SIDBI%' then cds2.ClientLoan1AmountDisbursed end), 0) as 'Own_DisbAmt',
	isnull(count(case when clp.ProductCategory not like '%BC%' and clp.ProductCategory not like '%SIDBI%' and cds2.ClientLoan1AmtDueDisbursed>0 then 1 end), 0) as 'Own_DueALC',
	isnull(count(case when clp.ProductCategory not like '%BC%' and clp.ProductCategory not like '%SIDBI%' and (cds2.ClientLoan1AmtDueDisbursed>0 and cds2.ClientLoan1AmountDisbursed>0) then 1 end), 0) as 'Own_DisbALC',
	
	isnull(sum(case when clp.ProductCategory like '%BC%' then cds2.ClientLoan1AmtDueDisbursed end), 0) as 'BC_DueAmt',
	isnull(sum(case when clp.ProductCategory like '%BC%' then cds2.ClientLoan1AmountDisbursed end), 0) as 'BC_DisbAmt',
	isnull(count(case when clp.ProductCategory like '%BC%' and cds2.ClientLoan1AmtDueDisbursed>0 then 1 end), 0) as 'BC_DueALC',
	isnull(count(case when clp.ProductCategory like '%BC%' and (cds2.ClientLoan1AmtDueDisbursed>0 and cds2.ClientLoan1AmountDisbursed>0) then 1 end), 0) as 'BC_DisbALC',
	
	isnull(sum(case when clp.ProductCategory like '%SIDBI%' then cds2.ClientLoan1AmtDueDisbursed end), 0) as 'SIDBI_DueAmt',
	isnull(sum(case when clp.ProductCategory like '%SIDBI%' then cds2.ClientLoan1AmountDisbursed end), 0) as 'SIDBI_DisbAmt',
	isnull(count(case when clp.ProductCategory like 'SIDBI' and cds2.ClientLoan1AmtDueDisbursed>0 then 1 end), 0) as 'SIDBI_DueALC',
	isnull(count(case when clp.ProductCategory like '%SIDBI%' and (cds2.ClientLoan1AmtDueDisbursed>0 and cds2.ClientLoan1AmountDisbursed>0) then 1 end), 0) as 'SIDBI_DisbALC',
	
	isnull(sum(cds2.ClientLoan1AmtDueDisbursed), 0) as 'Total_DueAmt',
	isnull(sum(cds2.ClientLoan1AmountDisbursed), 0) as 'DisbursedAmt',
	isnull(count(case when cds2.ClientLoan1AmtDueDisbursed>0 then 1 end), 0) as 'Total_DueALC',
	isnull(count(case when cds2.ClientLoan1AmtDueDisbursed>0 and cds2.ClientLoan1AmountDisbursed>0 then 1 end), 0) as 'Total_DisbALC',

	isnull(isnull(sum(cds2.ClientLoan1AmountDisbursed), 0) * 100 / nullif(sum(cds2.ClientLoan1AmtDueDisbursed), 0), 0) as '%AmountDisb',
	isnull(isnull(count(case when cds2.ClientLoan1AmtDueDisbursed>0 and cds2.ClientLoan1AmountDisbursed>0 then 1 end), 0)*100/
	nullif(count(case when cds2.ClientLoan1AmtDueDisbursed>0 then 1 end), 0), 0) as '%ALCDisb',
	

	ISNULL(case when LEFT(cds2.ClientID, 5) in (select BranchID from DailyClosingDtl with(nolock) where send='1') then 'Day Closed'
	else 'Pending Branch Report' end,0) as 'DayCloseStatus'
	
From 	
	cds2 inner join ClientLoanProposal clp with(nolock) on clp.LoanProposalID = cds2.LoanProposalID
	inner join Branches b with(nolock) on b.BranchID = left(cds2.ClientID,5)
	inner join fieldstaff with(nolock) on b.chid=fieldstaff.staffid
where 	
	left(cds2.clientid,2) = '10'
group by 	
	b.CGID, FieldStaff.StaffName, left(cds2.ClientID, 5)
order by	
	b.CGID, FieldStaff.StaffName, left(cds2.ClientID, 5)

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------

select 	
	b.CGID as Cluster, FieldStaff.StaffName as CHName, 
	(select BranchName from Branches b with(nolock) where b.BranchID = left(cds2.ClientID,5)) 'BranchName',

	isnull(sum(case when clp.ProductCategory not like '%BC%' and clp.ProductCategory not like '%SIDBI%' then cds2.ClientLoan1AmtDueDisbursed end), 0) as 'Own_DueAmt',
	isnull(sum(case when clp.ProductCategory not like '%BC%' and clp.ProductCategory not like '%SIDBI%' then cds2.ClientLoan1AmountDisbursed end), 0) as 'Own_DisbAmt',
	isnull(count(case when clp.ProductCategory not like '%BC%' and clp.ProductCategory not like '%SIDBI%' and cds2.ClientLoan1AmtDueDisbursed>0 then 1 end), 0) as 'Own_DueALC',
	isnull(count(case when clp.ProductCategory not like '%BC%' and clp.ProductCategory not like '%SIDBI%' and (cds2.ClientLoan1AmtDueDisbursed>0 and cds2.ClientLoan1AmountDisbursed>0) then 1 end), 0) as 'Own_DisbALC',
	
	isnull(sum(case when clp.ProductCategory like '%BC%' then cds2.ClientLoan1AmtDueDisbursed end), 0) as 'BC_DueAmt',
	isnull(sum(case when clp.ProductCategory like '%BC%' then cds2.ClientLoan1AmountDisbursed end), 0) as 'BC_DisbAmt',
	isnull(count(case when clp.ProductCategory like '%BC%' and cds2.ClientLoan1AmtDueDisbursed>0 then 1 end), 0) as 'BC_DueALC',
	isnull(count(case when clp.ProductCategory like '%BC%' and (cds2.ClientLoan1AmtDueDisbursed>0 and cds2.ClientLoan1AmountDisbursed>0) then 1 end), 0) as 'BC_DisbALC',
	
	isnull(sum(case when clp.ProductCategory like '%SIDBI%' then cds2.ClientLoan1AmtDueDisbursed end), 0) as 'SIDBI_DueAmt',
	isnull(sum(case when clp.ProductCategory like '%SIDBI%' then cds2.ClientLoan1AmountDisbursed end), 0) as 'SIDBI_DisbAmt',
	isnull(count(case when clp.ProductCategory like 'SIDBI' and cds2.ClientLoan1AmtDueDisbursed>0 then 1 end), 0) as 'SIDBI_DueALC',
	isnull(count(case when clp.ProductCategory like '%SIDBI%' and (cds2.ClientLoan1AmtDueDisbursed>0 and cds2.ClientLoan1AmountDisbursed>0) then 1 end), 0) as 'SIDBI_DisbALC',
	
	isnull(sum(cds2.ClientLoan1AmtDueDisbursed), 0) as 'Total_DueAmt',
	isnull(sum(cds2.ClientLoan1AmountDisbursed), 0) as 'DisbursedAmt',
	isnull(count(case when cds2.ClientLoan1AmtDueDisbursed>0 then 1 end), 0) as 'Total_DueALC',
	isnull(count(case when cds2.ClientLoan1AmtDueDisbursed>0 and cds2.ClientLoan1AmountDisbursed>0 then 1 end), 0) as 'Total_DisbALC',

	isnull(isnull(sum(cds2.ClientLoan1AmountDisbursed), 0) * 100 / nullif(sum(cds2.ClientLoan1AmtDueDisbursed), 0), 0) as '%AmountDisb',
	isnull(isnull(count(case when cds2.ClientLoan1AmtDueDisbursed>0 and cds2.ClientLoan1AmountDisbursed>0 then 1 end), 0)*100/
	nullif(count(case when cds2.ClientLoan1AmtDueDisbursed>0 then 1 end), 0), 0) as '%ALCDisb',
	

	ISNULL(case when LEFT(cds2.ClientID, 5) in (select BranchID from [43.242.214.235].appcashpor.dbo.DailyClosingDtl with(nolock) where send='1') then 'Day Closed'
	else 'Pending Branch Report' end,0) as 'DayCloseStatus'
	
From 	
	[43.242.214.235].appcashpor.dbo.cds2 inner join ClientLoanProposal clp with(nolock) on clp.LoanProposalID = cds2.LoanProposalID
	inner join [43.242.214.235].appcashpor.dbo.Branches b with(nolock) on b.BranchID = left(cds2.ClientID,5)
	inner join [43.242.214.235].appcashpor.dbo.fieldstaff with(nolock) on b.chid=fieldstaff.staffid
where 	
	left(cds2.clientid,2) = '14'
group by 	
	b.CGID, FieldStaff.StaffName, left(cds2.ClientID, 5)
order by	
	b.CGID, FieldStaff.StaffName, left(cds2.ClientID, 5)


------Zone Disbursement report
	select  Branches.zone,branches.Districtname as Region_Name ,sum(CAST(clientloan1amtduedisbursed AS FLOAT))as TotalDue_Amount,          
COUNT(case when ClientLoan1AmtDueDisbursed>0 then 1 end) as TotaDue_ALC,         
isnull(count (distinct (case when clientloan1balance>0 and clientloan1principaldue>0           
 then (left(clientLoan1id,14))end)),0) as 'TODAY COLL ALC',         
sum(case when ClientLoan1Balance>0 and ClientLoan1PrincipalDue>0 then ClientLoan1TotalCollected end) as TOTALCOLL_Amount,      
sum(CAST(ClientLoan1AmountDisbursed AS FLOAT)) as DisbursedAmt,             
COUNT(case when ClientLoan1AmtDueDisbursed>0 and ClientLoan1AmountDisbursed>0 then 1 end) as 'Disb ALC',        
sum(clientloan1amtduedisbursed)-sum(CAST(ClientLoan1AmountDisbursed AS FLOAT)) as NotDisbursed,        
sum(CAST(ClientLoan1AmountDisbursed AS FLOAT))*100/sum(clientloan1amtduedisbursed) as 'Disb Amount %',        
COUNT(case when ClientLoan1AmtDueDisbursed>0 and ClientLoan1AmountDisbursed>0 then 1 end)*100/        
COUNT(case when ClientLoan1AmtDueDisbursed>0 then 1 end) as 'Disb ALC %',        
isnull(count (distinct (case when clientloan1balance>0 and clientloan1principaldue>0 and clientloan1PrincipalCollected='0'       
and clientloan1interestcollected='0' then (left(clientLoan1id,14))end)),0) as 'TODAY ARREAR ALC',             
isnull(sum(case when clientloan1balance>0 and clientloan1principaldue>0 and clientloan1PrincipalCollected='0'       
and clientloan1interestcollected='0' then (clientloan1Principaldue+ClientLoan1InterestDUE)end),0) as 'TODAY ARREAR Amount'           
from [43.242.214.235].appcashpor.dbo.cds2 inner join [43.242.214.235].appcashpor.dbo.Branches on branches.branchid=left(clientid,5) where left(clientid,2) in
 ('05','14','16')      
group by branches.zone,branches.districtname,left(branches.Branchid,2)       
order by  left(branches.Branchid,2),branches.districtname             
