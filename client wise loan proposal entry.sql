--Appcashpor proposal entry clientwise
select bb.DistrictName,bb.BranchName,T.BranchID,c.clientid,t.TargetName,LoanamountappliedbyClient,n.StaffID,ff.StaffName,n.datestamp  from CreditWorthinesstrn a inner join KYC b on a.trnloanid=b.trnloanid 
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
inner join clients cl on c.ClientID=cl.ClientID
inner join Targets t on t.TargetID=cl.targetid
inner join Branches bb on bb.branchid=t.branchid
inner join fieldstaff ff on ff.staffid=n.staffid
where left(a.ClientID,2) in('14')
order by a.ClientID
