--QR Code UPI Manage


select * from [43.242.214.235].appcashpor.dbo.paymenttrnlog where clientid='10:15:35:01:54'


select * from [43.242.214.235].appcashpor.dbo.cds2 where clientid='10:15:35:01:54'

select * from [43.242.214.235].appcashpor.dbo.iciciupiresponse where merchanttranid='EZY10089551620250613062057'


update  [43.242.214.235].appcashpor.dbo.cds2 set Payment_Tran_ID='902176893360-EZY10089551620250613062057' ,
Payment_Tran_Date='20250616084601', clientloan2installmentnumber='5'where clientloan1id='10:15:35:01:54:R1:01'


----Query for CIPVU hold and Consent not done report 


select * from 
(
select B.Zone,B.DistrictName,B.BranchID,B.BranchName,P.clientID,P.targetName,Proposaldate,finalreviewdate,loandisbursementdate,P.trnloanID,
(case when P.trnloanID in(select Trnloanid from KYCverificationtrn p (nolock) where status=1) then 'KYC Verifield and OK'
when P.trnloanID in(select Trnloanid from KYCverificationtrn p (nolock) where status=2)  then 'KYC Verifield and Rejected'
when P.trnloanID not in(select Trnloanid from KYCverificationtrn p (nolock) )     then 'KYC not Verifield '

else 'Hold' end) KYC_Verification,
(case when P.trnloanID in(select Trnloanid from KYCverificationtrn p (nolock) where status=1 and ConsentDate is not null)
then 'KYC_concent_Done' else 'KYC_concent_NOT_Done' end) KYC_Consent,k.ClientSecondaryKycid
   from clientloanproposal p (nolock) inner join
   Branches b (nolock) on left(p.clientid,5)=b.Branchid
   inner join Products T (nolock) on p.productid=T.productid
   inner join kyc k (nolock) on p.trnloanid=isnull(k.EnrollTrnLoanID,k.TrnLoanid)
where left(b.Branchid,2) in('11') and
loandisbursementdate is null and  finalreviewdate is not null and
t.bcidno=0 and k.ClientSecondaryKycid is not null

) a where a.KYC_Verification='Hold'




select * from 
(
select B.Zone,B.DistrictName,B.BranchID,B.BranchName,P.clientID,P.targetName,Proposaldate,finalreviewdate,loandisbursementdate,P.trnloanID,
(case when P.trnloanID in(select Trnloanid from KYCverificationtrn p (nolock) where status=1) then 'KYC Verifield and OK'
when P.trnloanID in(select Trnloanid from KYCverificationtrn p (nolock) where status=2)  then 'KYC Verifield and Rejected'
when P.trnloanID not in(select Trnloanid from KYCverificationtrn p (nolock) )     then 'KYC not Verifield '

else 'Hold' end) KYC_Verification,
(case when P.trnloanID in(select Trnloanid from KYCverificationtrn p (nolock) where status=1 and ConsentDate is not null)
then 'KYC_concent_Done' else 'KYC_concent_NOT_Done' end) KYC_Consent,k.ClientSecondaryKycid
   from clientloanproposal p (nolock) inner join
   Branches b (nolock) on left(p.clientid,5)=b.Branchid
   inner join Products T (nolock) on p.productid=T.productid
   inner join kyc k (nolock) on p.trnloanid=isnull(k.EnrollTrnLoanID,k.TrnLoanid)
where left(b.Branchid,2) in('11') and
loandisbursementdate is null and  finalreviewdate is not null and
t.bcidno=0 and k.ClientSecondaryKycid is not null

) a where a.KYC_Verification='KYC Verifield and OK' and  KYC_Consent='KYC_concent_NOT_Done'



