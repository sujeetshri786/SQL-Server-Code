select ClientID, Targetname,Kycname,Case When KYCName='Aadhar' Then '********'+Right(KYCNo,4) 
Else  KYCNo End KYCNumber,MobileNumber,LoanAmountDisbursed from clientloanproposal where ProductCategory='Bridge' and  
LoanDisbursementDate is not null and clientid like '16%' and PrincipalOutstanding>0