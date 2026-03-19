--KYC Status appcashpor


Select left(clientid,2)RID,k.TrnLoanid,(select distinct(upper(districtname)) from Branches where left(Branchid,2)=left(clientid,2)) RegionName, 
left(k.ClientID,5) BranchID,(select Branchname from Branches where Branchid=left(k.clientid,5)) BranchName,Clientid ,
(case when ClientPrimaryKyctype='Aadhar' then ('********'+right(ClientPrimaryKycmember,4)) else ClientPrimaryKycmember end)KYCNO
,ClientPrimaryKyctype,ClientPrimaryNameasperkyc,k.Datestamp,

(case 

when clientid in
  (Select clientid from Kyc kk(nolock) where k.TrnLoanid=kk.TrnLoanid and Cast(datestamp as date)>='2024-02-01'
and exists (Select CustrefField from CCRmFISummary t(Nolock) where t.CustrefField=kk.trnloanid and cbrstatus<1 
and len(REFERENCENUMBER)=8) and kk.Kyctranid=kk.trnloanid and kk.clientid=kk.centerid) then 'AddingBANOnKYC'

when  clientid in
  (Select clientid from Kyc kk(nolock) where k.TrnLoanid=kk.TrnLoanid and Cast(datestamp as date)>='2024-02-01'
and exists (Select CustrefField from CCRmFISummary t(Nolock) where t.CustrefField=kk.trnloanid and cbrstatus=1 
and len(REFERENCENUMBER)=8) and kk.Kyctranid=kk.trnloanid and kk.CenterID=kk.ClientID) then 'EnrollmentNotDone' 


when  clientid in
(Select clientid from Kyc kk(nolock) where k.clientid=kk.clientid and Cast(datestamp as date)>='2024-02-01'
and Not Exists(Select ClientID from Kyc_conf(nolock) where Kyc_conf.ClientID=kk.ClientID  ) and len(kk.ClientID)=14) then 'ConsentNotDone'


when  clientid in

(Select clientid from Kyc kk(nolock) where k.clientid=kk.clientid and Cast(datestamp as date)>='2024-02-01'
and Exists(Select ClientID from Kyc_conf(nolock) where Kyc_conf.ClientID=kk.ClientID  )
and exists (Select CustrefField from CCRmFISummary t(Nolock) where t.CustrefField=kk.trnloanid and cbrstatus=1)) then 'NOTBAN'

when clientid in

  (Select clientid from Kyc kk(nolock) where k.clientid=kk.clientid and Cast(datestamp as date)>='2024-02-01'
and Exists(Select ClientID from Kyc_conf(nolock) where Kyc_conf.ClientID=kk.ClientID  )
and exists (Select CustrefField from CCRmFISummary t(Nolock) where t.CustrefField=kk.trnloanid and cbrstatus<1)) then 'BAN'
else 'Not in process' end) 'Status'

from KYC k(nolock) where Cast(datestamp as date)>='2024-02-01'  and left(clientid,2) in ('14')
group by clientid,ClientPrimaryKycmember ,ClientPrimaryKyctype,ClientPrimaryNameasperkyc,k.TrnLoanid,k.Datestamp
order by clientid

