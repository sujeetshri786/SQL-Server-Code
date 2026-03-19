--Proposal Entry Details
select * from (
select left(a.clientid,5) as BranchID,(select distinct(UPPER(BranchName)) from Branches where left(Branchid,5)=left(a.clientid,5)) as RegionName,count(distinct a.clientid)as NOLoanproposal,cast(a.datestamp as date) as ProposalDate  from CreditWorthinesstrn a inner join KYC b on a.trnloanid=b.trnloanid 
inner join LoanAppraisal_ClientDetail c on a.trnloanid=c.trnloanid and a.Clientid=c.clientid
inner join LoanAppraisal_ClientDetailNext d on a.trnloanid=d.trnloanid and a.Clientid=d.clientid
inner join LoanAppraisal_ClientHusbandIncome e on a.trnloanid=e.trnloanid and a.Clientid=e.clientid
inner join LoanAppraisal_ChildrenStaywith1 f on a.trnloanid=f.trnloanid and a.Clientid=f.clientid
inner join LoanAppraisal_ChildrenStaywith2 g on a.trnloanid=g.trnloanid and a.Clientid=g.clientid
inner join LoanAppraisal_ChildrenNotStaywith h on a.trnloanid=h.trnloanid and a.Clientid=h.clientid
inner join LoanAppraisal_CCRDetail1 i on a.trnloanid=i.trnloanid and a.Clientid=i.clientid
inner join LoanAppraisal_CCRDetail1Next j on a.trnloanid=j.trnloanid and a.Clientid=j.clientid
inner join LoanAppraisal_CCRDetail2 k on a.trnloanid=k.trnloanid and a.Clientid=k.clientid
inner join LoanAppraisal_CHIPPIDetail l on a.trnloanid=l.trnloanid and a.Clientid=l.clientid
inner join LoanAppraisal_InsuranceDetail m on a.trnloanid=m.trnloanid and a.Clientid=m.clientid
inner join CreditNeedAssessmenttrn n on a.trnloanid=n.trnloanid and a.Clientid=n.clientid
where left(a.ClientID,5) in('31:07')
group by left(a.clientid,5),cast(a.datestamp as date)
--order by left(a.clientid,2),cast(a.datestamp as date)
) z
pivot
(
sum(NOLoanproposal)  for ProposalDate in([2022-05-23],[2022-05-24], [2022-05-25],[2022-05-26],[2022-05-27],[2022-05-28],[2022-05-29],[2022-05-30],[2022-05-31],
[2022-06-01],[2022-06-02],[2022-06-03],[2022-06-04],[2022-06-05],[2022-06-06],[2022-06-07])
)b


-----Pending Staff List

Select b.Zone,b.DistrictName,b.Branchid,b.BranchName,f.Staffid,f.StaffName,DM.DesignationName,f.CompanyJoinDate,f.statusact from fieldstaff f with(nolock)
join branches b with(nolock) on b.branchid=f.branchid
join designationmaster dm with(nolock) on dm.designationid=f.designation
where exitdate is null and designation in('12','13','14','15','46','47') and staffid not in(
Select cna.StaffID from CreditWorthinesstrn CW with (nolock) 
 join KYC with (nolock) on kyc.Trnloanid=cw.Trnloanid
Join LoanAppraisal_ClientDetail LA_CD with (nolock) on LA_CD.clientid=cw.Clientid and kyc.Trnloanid=cw.Trnloanid
Join LoanAppraisal_ClientDetailNext LA_CDN with (nolock) on LA_CDN.clientid=LA_CD.Clientid and LA_CD.Trnloanid=LA_CDN.Trnloanid
join LoanAppraisal_ClientHusbandIncome LA_CHI with (nolock) on LA_CHI.clientid=LA_CDN.Clientid and LA_CD.Trnloanid=LA_CHI.Trnloanid
Join LoanAppraisal_ChildrenStaywith1 LA_CH1 with (nolock) on LA_CH1.clientid=LA_CHI.Clientid and LA_CH1.Trnloanid=LA_CHI.Trnloanid
Join LoanAppraisal_ChildrenStaywith2 LA_CH2 with (nolock)  on LA_CH2.clientid=LA_CH1.Clientid and LA_CH2.Trnloanid=LA_CH1.Trnloanid
Join LoanAppraisal_ChildrenNotStaywith LA_CH3  with (nolock) on LA_CH3.clientid=LA_CH2.Clientid and LA_CH3.Trnloanid=LA_CH2.Trnloanid
Join LoanAppraisal_CCRDetail1 LA_CCR1 with (nolock) on LA_CCR1.clientid=LA_CH3.Clientid and LA_CCR1.Trnloanid=LA_CH3.Trnloanid
Join LoanAppraisal_CCRDetail1Next LA_CCR2 with (nolock)  on LA_CCR2.clientid=LA_CCR1.Clientid and LA_CCR2.Trnloanid=LA_CCR1.Trnloanid
Join LoanAppraisal_CCRDetail2 LA_CCR3 with (nolock) on LA_CCR2.clientid=LA_CCR3.Clientid and LA_CCR2.Trnloanid=LA_CCR3.Trnloanid
Join LoanAppraisal_InsuranceDetail LA_INS with (nolock)   on LA_INS.clientid=LA_CCR3.Clientid and LA_INS.Trnloanid=LA_CCR3.Trnloanid
Join LoanAppraisal_CHIPPIDetail LA_PPI with (nolock) on LA_INS.clientid=LA_PPI.Clientid and LA_INS.Trnloanid=LA_PPI.Trnloanid
Join CreditNeedAssessmenttrn CNA with (nolock)  on CNA.clientid=LA_PPI.Clientid and CNA.Trnloanid=LA_PPI.Trnloanid)
and left(b.branchid,2) in('14') and staffname not like'dummy%'
order by b.branchid
