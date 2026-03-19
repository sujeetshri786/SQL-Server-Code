declare @cid varchar(14) ='25:17:59:01:50'
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
select * from  clients with (nolock) where clientid=@cid
select CBREnquiry, clientid, BMID, LoanAmountBM, LoanAmountApproved, FinalreviewDate,AnnualIncome, * from ClientLoanproposal with (Nolock)
where Clientid=@cid and PrincipalOutstanding='1' and loanamountdisbursed=0
select clientloan2installmentnumber,ClientLoan1TotalCollected,*  from cds2   where  clientid=@cid
select *  from cds3  where   clientid=@cid
select * from  EnqueryStatus with (nolock) where clientid=@cid
--select * from clients where  DropOutDate is not null and DropOutStatus=0 
--and ClientID in (select clientid from ClientLoanProposal where FinalReviewDate is null and PrincipalOutstanding=1 and LoanAmountDisbursed=0 ) order by clientid
--update clients set loancycle =1 where clientid='10:15:e3:04:19'

----begin tran
--update clients set DropOutDate=null where clientid in (select clientid 
--from ClientLoanProposal where FinalReviewDate is null and PrincipalOutstanding=1 and LoanAmountDisbursed=0)
--and DropOutStatus=0 and DropOutDate is not null
----rollback tran

--delete from CreditWorthinesstrn  where trnloanid in('10499621')
--Select   ClientPrimaryNameasperkyc,ClientPrimaryKycmember,CenterID,clientid from KYC with (nolock) 
--where centerid in('21:08:39') order by centerid
--select * from clients where clientid like '21:23:35%' and DropOutStatus='0'
--select *  from kyc where ClientPrimaryKycmember in('776407973362')
--select * from clients where clientid like '06:18:a3%' and dropoutstatus=0
--delete from clientloanproposal where loanproposalid in('10:14:58598')


--update clients set dropoutdate=Null where clientid='22:32:68:01:11'

--Select  AppMode,ReviewedBy,ReviewedDate,* from CreditWorthinesstrn with (nolock) where clientid='01:03:t1:01:45'
--select AppMode,ReviewedBy,ReviewedDate,*  from LoanAppraisal_CCRDetail1  where   clientid='01:03:t1:01:45'
--Select  AppMode,ReviewedBy,ReviewedDate,* from LoanAppraisal_CCRDetail1Next with (nolock) where clientid='01:03:t1:01:45'


--update  CreditWorthinesstrn set ReviewedBy='4033',ReviewedDate='2022-06-16 20:22:15.673',appmode='1' where clientid='01:03:t1:01:45'
--update  LoanAppraisal_CCRDetail1 set ReviewedBy='4033',ReviewedDate='2022-09-07 21:35:37.740',appmode='2' where clientid='01:03:t1:01:45'

--select ApprovalRemarks,CBREnquiry,*  from     ClientLoanProposal  where ClientID='07:10:u7:01:50' and loanamountdisbursed=0
--update clientloanproposal set BMID=Null,LoanAmountBM=Null,FSMID=Null,LoanAmountApproved=0,FinalReviewDate=Null where loanproposalid='22:16:18993'
 




--delete from CreditWorthinesstrn   where clientid='21:07:B7:01:02'
--delete from kyc   where clientid='21:07:B7:01:02'
--delete from LoanAppraisal_ClientDetail   where clientid='21:07:B7:01:02'
--delete from LoanAppraisal_ClientDetailNext   where clientid='21:07:B7:01:02'
--delete from LoanAppraisal_ClientHusbandIncome   where clientid='21:07:B7:01:02'
--delete from LoanAppraisal_ChildrenStaywith1  where clientid='21:07:B7:01:02'
--delete from LoanAppraisal_ChildrenStaywith2  where clientid='21:07:B7:01:02'
--delete from LoanAppraisal_ChildrenNotStaywith   where clientid='21:07:B7:01:02'
--delete from LoanAppraisal_CCRDetail1   where clientid='21:07:B7:01:02'
--delete from LoanAppraisal_CCRDetail1Next   where clientid='21:07:B7:01:02'
--delete from LoanAppraisal_CCRDetail2   where clientid='21:07:B7:01:02'
--delete from LoanAppraisal_CHIPPIDetail  where clientid='21:07:B7:01:02'
--delete from LoanAppraisal_InsuranceDetail   where clientid='21:07:B7:01:02'
--delete from CreditNeedAssessmenttrn   where clientid='14:11:46:01:42'


--delete from CreditWorthinesstrn   where clientid='10517407'
--delete from kyc   where clientid='10517407'
--delete from LoanAppraisal_ClientDetail   where clientid='10517407'
--delete from LoanAppraisal_ClientDetailNext   where clientid='10517407'
--delete from LoanAppraisal_ClientHusbandIncome   where clientid='10517407'
--delete from LoanAppraisal_ChildrenStaywith1  where clientid='10517407'
--delete from LoanAppraisal_ChildrenStaywith2  where clientid='10517407'
--delete from LoanAppraisal_ChildrenNotStaywith   where clientid='10517407'
--delete from LoanAppraisal_CCRDetail1   where clientid='10517407'
--delete from LoanAppraisal_CCRDetail1Next   where clientid='10517407'
--delete from LoanAppraisal_CCRDetail2   where clientid='10517407'
--delete from LoanAppraisal_CHIPPIDetail  where clientid='10517407'
--delete from LoanAppraisal_InsuranceDetail   where clientid='10517407'
--delete from CreditNeedAssessmenttrn   where clientid='10517407'



--Select  * from LoanAppraisal_ChildrenNotStaywith with (nolock) where clientid='21:07:B7:01:02'
--Select  * from LoanAppraisal_CCRDetail1 with (nolock) where clientid='21:07:B7:01:02'

--update  LoanAppraisal_CCRDetail1 set ReviewedBy='4699',ReviewedDate='2022-09-07 14:11:21.883',appmode='2' where clientid='21:07:B7:01:02'
--update  CreditNeedAssessmenttrn set ReviewedBy='0',ReviewedDate=Null,appmode='0' where clientid='21:07:B7:01:02'



-- declare @output nvarchar(150)
--exec ProposalInsertion '10448083',@output output
--print @output



--update  CreditWorthinesstrn set ReviewedBy=Null,ReviewedDate=Null,appmode='0',LoanAmtAppliedByClientBM=Null,LoanAmtApprovedByCenterBM=Null 
--where clientid='21:07:B7:01:02'
--update  LoanAppraisal_ClientDetail set ReviewedBy=Null,ReviewedDate=Null,appmode='0' where clientid='21:07:B7:01:02'
--update  LoanAppraisal_ClientDetailNext set ReviewedBy=Null,ReviewedDate=Null,appmode='0' where clientid='21:07:B7:01:02'
--update  LoanAppraisal_ClientHusbandIncome set ReviewedBy=Null,ReviewedDate=Null,appmode='0' where clientid='21:07:B7:01:02'
--update  LoanAppraisal_ChildrenStaywith1 set ReviewedBy=Null,ReviewedDate=Null,appmode='0' where clientid='21:07:B7:01:02'
--update  LoanAppraisal_ChildrenStaywith2 set ReviewedBy=Null,ReviewedDate=Null,appmode='0' where clientid='21:07:B7:01:02'
--update  LoanAppraisal_ChildrenNotStaywith set ReviewedBy=Null,ReviewedDate=Null,appmode='0' where clientid='21:07:B7:01:02'
--update  LoanAppraisal_CCRDetail1 set ReviewedBy=Null,ReviewedDate=Null,appmode='0' where clientid='21:07:B7:01:02'
--update  LoanAppraisal_CCRDetail1Next set ReviewedBy=Null,ReviewedDate=Null,appmode='0' where clientid='21:07:B7:01:02'
--update  LoanAppraisal_CCRDetail2 set ReviewedBy=Null,ReviewedDate=Null,appmode='0' where clientid='21:07:B7:01:02'
--update  LoanAppraisal_CHIPPIDetail set ReviewedBy=Null,ReviewedDate=Null,appmode='0' where clientid='21:07:B7:01:02'
--update  LoanAppraisal_InsuranceDetail set ReviewedBy=Null,ReviewedDate=Null,appmode='0' where clientid='21:07:B7:01:02'
--update  CreditNeedAssessmenttrn set ReviewedBy=Null,ReviewedDate=Null,appmode='0' where clientid='21:07:B7:01:02'
