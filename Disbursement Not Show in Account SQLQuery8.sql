--Disbursement Not Show In Account Local
SELECT * FROM ClientLoanSubscription WHERE ClientLoanID Like '05:21:Gx:01:78%'

--cancel ka details hota hai
SELECT updatedrecords,Comments,AccountNo,IFSCCode,* FROM ATClientLoanSubscription WHERE ClientLoanID Like '05:21:Gx:01:78%'

Select * From products Where Productid = 'h2'

---  for utr
select SIWAN..ClientLoanSubscription.clientloanid,[Benef Name]as Client_Name,[Benef Ac No]as Account_No,[BENEF IFSC CODE]as IFSC_CODE,
[UTR Sr No]as UTR_No,
SIWAN..ClientLoanSubscription.LoanAmountDisbursed,SIWAN..ClientLoanSubscription.DisbursementDate
from cashpor..ReversedMISDetailReverse 
With(Nolock)inner join SIWAN..ClientLoanSubscription on cashpor..ReversedMISDetailReverse.[Benef Ac No]=
SIWAN..ClientLoanSubscription.accountno

--where clientloanid = '14:04:J2:02:06:R0:01'--
Where [benef Ac No] ='60720100001104'
order by DisbursementDate desc

-- For ICICI BANK UTR NO....

Select * From cashpor..Rever
sedMISICICI where [Bemeficiary account no]='1005331030017818' And 'Beneficiary name' = 'DEVANTI DEVI'

Select Amount, [Beneficiary name], [IFSC Code], [Bemeficiary account no], [UTR NO], [Payment date]
From cashpor..ReversedMISICICI Where [Bemeficiary account no] = '1971001700012667'

Select Amount, [Beneficiary name], [IFSC Code], [Bemeficiary account no], [UTR NO], [Payment date],*
From cashpor..ReversedMISICICI Where [IFSC Code] = '60720100001104'

--Match With CLS LoanProposalID 
Select * From Cashpor..APBSNEFTDisbursement with (NOLock) Where ClientID like '14:14:57:01:31%'

--Disbursement nahi hua hai disbursementdate show nahi hota to 
Select * From Cashpor..APBSNEFTDisbursement With (NoLock) Where ClientID = '21:18:48:01:04'

select  * from ClientLoanSubscription with(nolock) where clientloanid like '10:18:40:01:19%'  and ActualPaidUpDate is null --order by ActualPaidUpDate --
       
