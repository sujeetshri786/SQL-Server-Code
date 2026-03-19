Center Correction 
--------------------------

select  B.Zone, B.Districtname, B.Branchid,B.BranchName,CT.CenterID,CT.CenterName,CT.DissolvedDate,C.DissolvedDate AT_DissolvedDate, Dateofupdation AT_Dateofupdation
,updatedby AT_updatedby,updatedRecords AT_updatedRecords,c.Tran_ID
from ATcenters c (nolock)  inner join Branches b (nolock) on B.Branchid=c.Branchid
inner join centers ct (nolock) on ct.CenterID=c.CenterID
where cast(dateofupdation as date) between '2025-05-01' and '2025-05-31' and updatedby  IN ('19918','22330','20311')
order by B.Zone, B.Districtname,CT.DissolvedDate, B.Branchid,B.BranchName,CT.CenterID


Branches Correction 
---------------------------

select  B.Zone,b.DistrictName, B.BranchID,B.BranchName,B.AMID Current_ARO,
       B.CHID Current_CHID,b.CGID Current_CGID, AB.AMID Previous_ARO,       ab.CHID Previous_CHIB, ab.CGID Previous_CGID, Modificationdate,AB.UpdatedBY,UpdatedRecords,Tran_ID
       from  atBranches AB (nolock)  inner join Branches b (nolock) on ab.Branchid=b.Branchid
       where cast(modificationdate as date) between '2025-05-01' and '2025-05-31'  and updatedby  IN ('19918','22330','20311')
       order by  B.BranchID,modificationdate 


CLS Correction
------------------------
select    c.RegionID,C.ClientLoanid,  C.LoanProposalID,    C.DisbursementDate,       C.LoanAmountDisbursed,c.DeathPerson Current_DeathPerson,c.DeathDate Current_DeathDate,
ct.DeathPerson Previous_DeathPerson,ct.DeathDate Previous_DeathDate, CT.UpdatedBy AT_UpdatedBy,
       UpdatedRecords AT_UpdatedRecords, Dateofupdation AT_Dateofupdation,Tran_ID
from atclientloansubscription Ct with (nolock) inner join ClientLoanSubscription C (nolock)
on ct.LoanProposalID=c.LoanProposalID
where dateofupdation between '2025-05-01' and '2025-05-31'    and modofUpdation='M' and updatedby  IN ('19918','22330','20311')
order by c.RegionID,C.ClientLoanid


Staff Travel
---------------------
select  B.Zone, B.Districtname,B.Branchid,B.BranchName,F.StaffID,f.StaffName,f.designation,F.Exitdate,f.EntryBy,f.DateStamp,
At.BranchID AT_BranchID,AT.Designation AT_Designation,at.dateofupdation AT_Dateofupdation,
AT.updatedBy AT_UpdatedBy,AT.updatedRecords AT_UpdatedRecords,At.Tran_ID
From AtfieldStaff at(nolock) inner join fieldstaff f (Nolock) on f.Staffid=At.StaffID
inner join Branches b (nolock) on b.Branchid=f.Branchid
where  at.dateofupdation between '2025-05-01' and '2025-05-31'  and updatedby  IN ('20311')



Ledger Correction
---------------------
       select  l.RegionID,L.clientloanID,L.Weeklytransactiondate,L.Principalinstallmentamt, L.Principalcollected, l.interestinstallmentamt , L.Interestcollected,
AT.Principalinstallmentamt AT_Principalinstallmentamt,AT.Principalcollected AT_Principalcollected, AT.interestinstallmentamt AT_interestinstallmentamt  ,AT.Interestcollected AT_Interestcollected
,Dateofupdation,AT.UpdatedBY,Updatedrecords,Tran_ID
from
ATLoanLedger at (nolock) inner join Loanledger l (nolock) on l.clientloanID=AT.clientloanid
and At.Weeklytransactiondate=l.Weeklytransactiondate
where cast(dateofupdation as date) between '2025-05-01' and '2025-05-31'  and updatedby  IN ('19918','22330','20311')
order by l.RegionID,L.clientloanID

