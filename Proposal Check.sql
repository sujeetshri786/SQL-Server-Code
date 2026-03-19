declare @cid varchar(14) ='14:28:84:01:44'
 
--update clients set suspenddate=hotlistdate where clientid='25:13:25:01:14'
---select * from ClientLoanProposal_FormFlow where loanproposalid in('22:24:16425')
--update ClientLoanProposal_FormFlow set CMID=Null,BMID=Null,BMReworkDate=Null,ROEID=Null,ROEReworkDate=Null,CMFinalDate=Null,
--BMFinalDate=Null where loanproposalid in('14:14:34830')
--update clients set loancycle=1 where clientid='08:23:cu:03:30'
--select * from EKYcdetail where   datestamp>='2022-11-14' and orgid='icici' and clientid like '21:09%'

--update clients set hotlistremark='Inregularattendance' where clientid='08:14:12:01:33'
--update clientloanproposal set DISBURSEMENTMODE=5 where loanproposalid='14:14:34819' 
--delete from CreditWorthinesstrn where trnloanid in('10957786')
--select * from ClientLoanProposal_FormFlow (NOLOCK) where clientid like '21:19:87:01:43%' and dropoutstatus=0
--update kyc set BmNeftReviewDate=Null where loanproposalid='22:14:16692'

Select  AppMode,ReviewedBy,ReviewedDate,* from CreditWorthinesstrn with (nolock) where clientid=@cid
Select * from KYC with (nolock) where clientid
in(Select  clientid from CreditWorthinesstrn with (nolock) where clientid=@cid) 
Select AppMode,ReviewedBy,ReviewedDate,* from LoanAppraisal_ClientDetail with (nolock) where clientid=@cid
Select  AppMode,ReviewedBy,ReviewedDate,* from LoanAppraisal_ClientDetailNext with (nolock) where clientid=@cid
Select  AppMode,ReviewedBy,ReviewedDate,* from LoanAppraisal_ClientHusbandIncome with (nolock) where clientid=@cid
Select  AppMode,ReviewedBy,ReviewedDate,* from LoanAppraisal_ChildrenStaywith1 with (nolock) where clientid=@cid
Select  AppMode,ReviewedBy,ReviewedDate,* from LoanAppraisal_ChildrenStaywith2 with (nolock) where clientid=@cid
Select  AppMode,ReviewedBy,ReviewedDate,ClientAnnualHHIncome,* from LoanAppraisal_ChildrenNotStaywith with (nolock) where clientid=@cid
Select  AppMode,ReviewedBy,ReviewedDate,* from LoanAppraisal_CCRDetail1 with (nolock) where clientid=@cid
Select  AppMode,ReviewedBy,ReviewedDate,* from LoanAppraisal_CCRDetail1Next with (nolock) where clientid=@cid
Select  AppMode,ReviewedBy,ReviewedDate,* from LoanAppraisal_CCRDetail2 with (nolock) where clientid=@cid
Select  AppMode,ReviewedBy,ReviewedDate,* from LoanAppraisal_CHIPPIDetail with (nolock) where clientid=@cid
Select  AppMode,ReviewedBy,ReviewedDate,* from LoanAppraisal_InsuranceDetail with (nolock) where clientid=@cid
Select  AppMode,ReviewedBy,ReviewedDate,* from CreditNeedAssessmenttrn with (nolock) where clientid=@cid
Select   KYCMismatch,VerifiedDate,ApprovedDate,* from ekycicici with (nolock) where clientid=@cid
select * from  clients with (nolock) where clientid=@cid
select CBREnquiry, clientid, BMID, LoanAmountBM, LoanAmountApproved, FinalreviewDate,AnnualIncome, * from ClientLoanproposal with (Nolock)
where Clientid=@cid and PrincipalOutstanding='1' and loanamountdisbursed=0
select clientloan2installmentnumber,ClientLoan1TotalCollected,*  from cds2   where  clientid=@cid
select *  from cds3  where   clientid=@cid
select * from  EnqueryStatus with (nolock) where clientid=@cid
select * from EKYcdetail with (nolock) where clientid=@cid
select * from CCRMFISUMMARY where REFERENCENUMBER=@cid
 

--select * from Ekycdetail with (nolock) where Centerid='25:02:70' order by clientid
--select * from Ekycdetail with (nolock) where Clientid='30:12:27:01:21' order by clientid


--select * from clients where  DropOutDate is not null and DropOutStatus=0 
--and ClientID in (select clientid from ClientLoanProposal where FinalReviewDate is null and PrincipalOutstanding=1 and
-- LoanAmountDisbursed=0 ) order by clientid
--update clients set loancycle =1 where clientid='10:15:e3:04:19'
--delete  from clientloanproposal  where loanproposalid like '10:18:60902%'


----begin tran
--update clients set DropOutDate=null where clientid in (select clientid 
--from ClientLoanProposal where FinalReviewDate is   null and PrincipalOutstanding=1 and LoanAmountDisbursed=0)
--and DropOutStatus=0 and DropOutDate is not null
----rollback tran

--update Branch_report set Minsurecollection='1100' Where BranchID='14:03'

--delete from CreditWorthinesstrn  where trnloanid in('11312822')
--Select   ClientPrimaryNameasperkyc,ClientPrimaryKycmember,CenterID,clientid from KYC with (nolock) 
--where centerid in('21:08:39') order by centerid
--select * from clients where clientid like '08:05:18%' and DropOutStatus='0'
--delete  from kyc where ClientPrimaryKycmember in('647454733020') and Datestamp='2022-07-17 18:07:27.897'
--select * from clients where clientid like '06:18:a3%' and dropoutstatus=0
--delete from clientloanproposal where loanproposalid in('10:14:58598')

--delete from CreditWorthinesstrn  where trnloanid in('11531945')
--delete from Kyc  where trnloanid in('11153129')

--delete from Kyc  where Kyctranid in('11323730')


--update  CreditNeedAssessmenttrn set ReviewedBy=Null,ReviewedDate=Null,appmode='0' where trnloanid='11803980'


--update clients set dropoutdate=Null where clientid='22:32:68:01:11'


--Select  AppMode,ReviewedBy,ReviewedDate,* from CreditWorthinesstrn with (nolock) where trnloanid='10232527'
--select AppMode,ReviewedBy,ReviewedDate,*  from LoanAppraisal_CCRDetail1  where   trnloanid='10158196'
--Select  AppMode,ReviewedBy,ReviewedDate,* from LoanAppraisal_CCRDetail1Next with (nolock) where trnloanid='10158196'


--update  CreditWorthinesstrn set ReviewedBy='6121',ReviewedDate='2022-08-01 20:22:47.570',appmode='2' where trnloanid='10078742'
--update  LoanAppraisal_CCRDetail1 set ReviewedBy='4033',ReviewedDate='2022-09-07 21:35:37.740',appmode='2' where trnloanid='10158196'


--select ApprovalRemarks,CBREnquiry,*  from     ClientLoanProposal  where ClientID='07:10:u7:01:50' and loanamountdisbursed=0
--update clientloanproposal set BMID=Null,LoanAmountBM=Null,FSMID=Null,LoanAmountApproved=0,FinalReviewDate=Null where loanproposalid='22:16:18993'


--declare @output nvarchar(150)
--exec ProposalInsertion '11876221',@output output
--print @output



--update  CreditWorthinesstrn set ReviewedBy=Null,ReviewedDate=Null,appmode='0',LoanAmtAppliedByClientBM=Null,LoanAmtApprovedByCenterBM=Null 
--where trnloanid='11803980'
--update  LoanAppraisal_ClientDetail set ReviewedBy=Null,ReviewedDate=Null,appmode='0' where trnloanid='11803980'
--update  LoanAppraisal_ClientDetailNext set ReviewedBy=Null,ReviewedDate=Null,appmode='0' where trnloanid='11803980'
--update  LoanAppraisal_ClientHusbandIncome set ReviewedBy=Null,ReviewedDate=Null,appmode='0' where trnloanid='11803980'
--update  LoanAppraisal_ChildrenStaywith1 set ReviewedBy=Null,ReviewedDate=Null,appmode='0' where trnloanid='11803980'
--update  LoanAppraisal_ChildrenStaywith2 set ReviewedBy=Null,ReviewedDate=Null,appmode='0' where trnloanid='11803980'
--update  LoanAppraisal_ChildrenNotStaywith set ReviewedBy=Null,ReviewedDate=Null,appmode='0' where trnloanid='11803980'
--update  LoanAppraisal_CCRDetail1 set ReviewedBy=Null,ReviewedDate=Null,appmode='0' where trnloanid='11803980'
--update  LoanAppraisal_CCRDetail1Next set ReviewedBy=Null,ReviewedDate=Null,appmode='0' where trnloanid='11803980'
--update  LoanAppraisal_CCRDetail2 set ReviewedBy=Null,ReviewedDate=Null,appmode='0' where trnloanid='11803980'
--update  LoanAppraisal_CHIPPIDetail set ReviewedBy=Null,ReviewedDate=Null,appmode='0' where trnloanid='11803980'
--update  LoanAppraisal_InsuranceDetail set ReviewedBy=Null,ReviewedDate=Null,appmode='0' where trnloanid='11803980'
--update  CreditNeedAssessmenttrn set ReviewedBy=Null,ReviewedDate=Null,appmode='0' where trnloanid='11803980'

--update  CreditNeedAssessmenttrn set ReviewedBy=Null,ReviewedDate=Null,appmode='0' where trnloanid='11122918'

 --update clientloanproposal set  Bankname=0,BankBranchname=0,AccountNumber=0,IFSCCode=0,BmAccountNumber=0,BmIfsccode=0,
 --FinalAccountNumber=0,FinalIfsccode=0,PrincipalOutstanding=1,bmneftreviewdate=Null,disbursementmode='5',
 --LoanDisbursementDate=Null,LoanAmountDisbursed=0 where  loanproposalid in('08:26:55450

--select * from CreditWorthinesstrn where ReviewedBy is null and ReviewedDate is null and Trnloanid
--in (select trnloanid from LoanAppraisal_ClientDetail where ReviewedBy is not null and ReviewedDate is not null)
--and trnloanid  in(select trnloanid from clientloanproposal where PrincipalOutstanding=1 and FinalReviewDate is null)
--order by clientid


--begin tran
--update CreditWorthinesstrn  set ReviewedBy=b.ReviewedBy,ReviewedDate=b.ReviewedDate,AppMode=b.appmode from LoanAppraisal_ClientDetail b
--where CreditWorthinesstrn.ReviewedBy is null and CreditWorthinesstrn.ReviewedDate is null and CreditWorthinesstrn.Trnloanid
--in (select trnloanid from LoanAppraisal_ClientDetail where ReviewedBy is not null and ReviewedDate is not null)
--and CreditWorthinesstrn.trnloanid  in(select trnloanid from clientloanproposal where PrincipalOutstanding=1 and FinalReviewDate is null)
--rollback tran

--select * from CreditWorthinesstrn where ReviewedBy is not null and ReviewedDate is not null and Trnloanid
--in (select trnloanid from LoanAppraisal_ClientDetail where ReviewedBy is  null and ReviewedDate is  null)
--and trnloanid  in(select trnloanid from clientloanproposal where PrincipalOutstanding=1 and FinalReviewDate is  null)
--order by clientid


--begin tran
--update CreditWorthinesstrn  set ReviewedBy=b.ReviewedBy,ReviewedDate=b.ReviewedDate,AppMode=b.appmode from LoanAppraisal_ClientDetail b
--where CreditWorthinesstrn.ReviewedBy is null and CreditWorthinesstrn.ReviewedDate is null and CreditWorthinesstrn.Trnloanid
--in (select trnloanid from LoanAppraisal_ClientDetail where ReviewedBy is not null and ReviewedDate is not null)
--and CreditWorthinesstrn.trnloanid  in(select trnloanid from clientloanproposal where PrincipalOutstanding>1 and FinalReviewDate is not null)
--rollback tran

--select * from CreditWorthinesstrn where ReviewedBy is not null and ReviewedDate is not null and Trnloanid
--in (select trnloanid from LoanAppraisal_ClientDetail where ReviewedBy is  null and ReviewedDate is  null)
--and trnloanid  in(select trnloanid from clientloanproposal where PrincipalOutstanding=1 and FinalReviewDate is  null)
--order by clientid

--select * from Cmkycclient where Clientid like '21:23%'



--select * from clientloanproposal with (nolock) where clientid='24:04:87:01:21' and LoanDisbursementDate is null

--select * from Ekycdata where clientid in('21:17:32:01:17','21:17:37:01:05')

--update Ekycdetail Set Poadetail='country=India loc=poari pc=847121 state=Bihar vtc=Khairi Banka' Where ClientID in ('31:07:33:01:08')

--update RebateFeb21NeedBank Set bankname =NULL,bankbranchname=NULL,accountnumber=NULL,ifsccode=NULL,
--bmaccountnumber=NULL,	bmifsccode=NULL,finalaccountnumber=NULL,finalifsccode=NULL
-- Where ClientId = '22:26:02:01:27'

--update Branch_Report Set send = '0'  Where BranchID = '21:21'

