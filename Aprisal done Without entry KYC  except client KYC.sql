select B.Zone,b.Districtname,b.Branchid,b.BranchName,K.ClientID,k.ClientPrimaryNameasperkyc
 from kyc k (nolock) inner join LoanAppraisal_ClientDetail l with (nolock) on k.trnloanid=l.trnloanid
inner join Branches b (nolock) on left(k.centerid,5)=b.Branchid
 where left(k.centerid,2) in('16' )and cast(k.datestamp as date)>='2023-04-19'  and  k.HusbandKyctype is null and k.children1Kyctype is null and k.children2Kyctype is null
and k.children3Kyctype is null and k.trnloanid  in(select trnloanid  from kyc_conf with (nolock))
order by  K.ClientID