------Dear Team ICT

------Please get the query for cashier appointment module

Select * from [43.242.214.235].appcashpor.dbo.CashCollector where branch_id 
in ('12:03','12:38','02:01','02:24','11:05','11:12','13:09','13:10')  and createddate>='2025-11-17' order by branch_id

Select * from [43.242.214.235].appcashpor.dbo.Todays_Collection where
left(center_id,5) in ('12:03','12:38','02:01','02:24','11:05','11:12','13:09','13:10') and ClientID is not null

Select * from [43.242.214.235].appcashpor.dbo.CashierAppointment_AT where branchid 
 in ('12:03','12:38','02:01','02:24','11:05','11:12','13:09','13:10')

Select * from [43.242.214.235].appcashpor.dbo.CashierAppointment_AT_Log where
branchid  in ('12:03','12:38','02:01','02:24','11:05','11:12','13:09','13:10')

select * From [43.242.214.235].appcashpor.dbo.Cashier_AdministrativeSanction
select * From [43.242.214.235].appcashpor.dbo.Cashier_ArreareCollection
select * From [43.242.214.235].appcashpor.dbo.Cashier_cashcolleted
select * from [43.242.214.235].appcashpor.dbo.Cashier_CollectionSettlment
select * from [43.242.214.235].appcashpor.dbo.Cashier_Hospicash
select * from [43.242.214.235].appcashpor.dbo.Cashier_MInsure
select * from [43.242.214.235].appcashpor.dbo.Cashier_PassbookReplacement
Select * from [43.242.214.235].appcashpor.dbo.Cashier_SIDBI_Stampduty
Select * from [43.242.214.235].appcashpor.dbo.Cashier_Writeoff
select * from [43.242.214.235].appcashpor.dbo.DueDocumentation
Select * from [43.242.214.235].appcashpor.dbo.BMReasonChangesDueDocumentationMaster


---BM OTP and Login Password check query (Cashporone)

SELECT     S.*,      LM.*
FROM     [43.242.214.235].appcashpor.dbo.staffotp AS s
JOIN     [43.242.214.235].appcashpor.dbo.Login_Master1 AS LM    ON s.staffid = LM.employee_id
WHERE    s.staffid = '0000';             ------OWN ke Branch ke BM Staff ID



------center bifurcation

select b.Zone,B.DistrictName RegionName,B.BranchID,B.BranchName, c.ClientID,t.Targetname Clientname, max(c.NumInstallmentsInArrears) 'No. of Weeks in Arrear',
Case when max(c.NumInstallmentsInArrears)=0 then 'Regular' else 'IRregular' end Status from ClientLoanSubscription c (nolock)
inner join Clients clp (nolock) on c.ClientID=clp.ClientID
inner join targets T (nolock) on t.TargetID=clp.TargetID
inner join Branches B (nolock) on b.BranchID=clp.BranchID
inner join centers R (nolock) on r.centerid=c.CenterID
where ActualPaidUpDate is null and c.RegionID in('18')  and r.centerid in(select Distinct Centerid  from ClientLoanSubscription c (nolock) where ActualPaidUpDate is null and RegionID in('18') and NumInstallmentsInArrears>0)
group by b.Zone,B.DistrictName ,B.BranchID,B.BranchName, c.ClientID,t.Targetname
order by c.clientid



