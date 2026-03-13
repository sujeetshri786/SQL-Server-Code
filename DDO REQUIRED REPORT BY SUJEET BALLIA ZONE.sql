----late report closed qql

select districtname,dtl.branchid,dtl.branchname,
Branches.chid, (select STAFFNAME from fieldstaff With (NoLock) where staffid=Branches.chid) CH_NAME,
Branches.AMID ARO_ID,  (select STAFFNAME from fieldstaff With (NoLock)  where staffid=Branches.AMID) ARO_NAME,
dtl.datestamp  closing_time from dailyclosingdtl  dtl with (nolock)
inner join branches with (nolock) on  branches.branchid=dtl.branchid 
where dtl.regionid in ('05','14','16')  and cast (dtl.datestamp as time) >='15:30'
order by districtname,Branches.chid,dtl.branchid,dtl.datestamp desc

----not documented qql

select branches.DistrictName,
branches.BranchName,branches.BranchID,branches.CHid,fieldstaff.Staffname as CHName,
Branches.amid aro_ID,(select staffname from fieldstaff where staffid=Branches.amid) ARO_NAME,
(select isnull(count(distinct ClientID),0) from prevcds2 with(nolock) where branches.BranchID=left(ClientLoan1ID,5) 
and ClientLoan1AmtDueDisbursed>0)as NoOfClientsdue,
(select isnull(sum(ClientLoan1AmtDueDisbursed),0) from prevcds2 with(nolock) where branches.BranchID=left(ClientLoan1ID,5)
and ClientLoan1AmtDueDisbursed>0)as LoanamtDue,
(select count(distinct ClientID) from prevcds2 with(nolock) where branches.BranchID=left(ClientLoan1ID,5) 
and ClientLoan1AmountDisbursed>0)as NoOfClientsDisbursed,
(select isnull(sum(ClientLoan1AmountDisbursed),0) from prevcds2 with(nolock) where branches.BranchID=left(ClientLoan1ID,5) 
and ClientLoan1AmountDisbursed>0)as LoanamtDisbursed,
(select isnull(sum(CLIENTLOAN1TOTALCOLLECTED),0) from prevcds2 with(nolock) where branches.BranchID=left(ClientLoan1ID,5)
and CLIENTLOAN1TOTALCOLLECTED>0)as TotalCollection
from Branches with(nolock) inner join fieldstaff with(nolock) on branches.chid=fieldstaff.staffid 
where branches.DissolvedDate is null and LEFT(branches.branchid,2) IN   ('05','14','16')
order by branches.DistrictName DESC,branches.chid



----ARREAR PAR DEFAULT----
----Branch Wise ARREAR Detail----

SELECT    Branches.zone,Branches.districtname ,Branches.BranchID,BranchName,
Branches.AMID ARO_ID,  (select UPPER (LEFT (STAFFNAME,12)) from fieldstaff With (NoLock)  where staffid=Branches.AMID) ARO_NAME,
Branches.chid, (select UPPER (LEFT (STAFFNAME,12)) from fieldstaff With (NoLock) where staffid=Branches.chid) CH_NAME   ,
count(distinct left(clientloanid,14))ALC,sum(PrincipalOutstanding) Outstanding,      
count(distinct centers.centerid) as No_of_Centers,    
            
count(distinct case when NumInstallmentsInArrears 
between '1' and '4' and currentinstallmentperiod<=loandurationinweeks        
  then left(clientloanid,14) end) 'TOTAL Arrear',               
isnull(sum( case when NumInstallmentsInArrears       
between '1' and '4' and currentinstallmentperiod<=loandurationinweeks        
  then (principalinarrears+interestinarrears) end),0) 'TOTAL_Arrear_Amount', 
            
count(distinct case when NumInstallmentsInArrears >4           
 and currentinstallmentperiod<=loandurationinweeks              
  then left(clientloanid,14) end) PAR,    
  isnull(sum( case when NumInstallmentsInArrears >4               
   and currentinstallmentperiod<=loandurationinweeks             
   then (PrincipalOutstanding) end),0) PAR_Amount,    
            
count(distinct case when   currentinstallmentperiod>loandurationinweeks   
  then left(clientloanid,14) end) Defaulter,         
   isnull(sum( case when currentinstallmentperiod>loandurationinweeks        
   then (PrincipalOutstanding) end),0) Defaulter_Amount          
            
from ClientLoanSubscription 
inner join Centers on centers.centerid=left(clientloanid,8)      
inner join Branches on branches.BranchID=centers.BranchID              
inner join FieldStaff on fieldstaff.StaffID=centers.StaffID          
where ActualPaidUpDate is null and ClientLoanSubscription.PrincipalOutstanding > 0 and ClientLoanSubscription.regionid in ('05','14','16') 
            
group by  Branches.zone,Branches.districtname ,Branches.BranchID,BranchName ,Branches.chid,Branches.AMID    
order by  Branches.districtname,Branches.AMID ,Branches.BranchID,BranchName      

------ARREAR DDO Si----

SELECT   Branches.zone,Branches.DistrictName , Branches.BranchID, Branches.BranchName,
Branches.AMID ARO_ID,  (select UPPER (LEFT (STAFFNAME,12)) from fieldstaff With (NoLock)  where staffid=Branches.AMID) ARO_NAME,
Branches.chid, (select UPPER (LEFT (STAFFNAME,12)) from fieldstaff With (NoLock) where staffid=Branches.chid) CH_NAME,
fs.Staffid,fs.Staffname,Case When centers.ReportingDay=1 Then 'Monday'
       When centers.ReportingDay=2 Then 'Tuesday'
       When centers.ReportingDay=3 Then 'Wednesday'
       When centers.ReportingDay=4 Then 'Thursday'
       When centers.ReportingDay=5 Then 'Friday'
       When centers.ReportingDay=6 Then 'Saturday' End as MeetingDay,centers.centermeetingtime,
                   centers.CenterID,centers.Centername, ClientLoanSubscription.ClientLoanID, Targets.TargetName as ClientName, Targets.Husbandname, 
                                                                   ClientLoanSubscription.DisbursementDate,ClientLoanSubscription.LoanAmountDisbursed,
               ClientLoanSubscription.CurrentInstallmentPeriod,ClientLoanSubscription.NumInstallmentsInArrears,
                       ClientLoanSubscription.PrincipalOutstanding,clientloansubscription.Loandurationinweeks,clientloansubscription.PrincipalInArrears,
                      clientloansubscription.interestinarrears,case when DeathPerson='1' then 'ClientDeath' when deathperson=2
              then 'HusbandDeath' else 'NormalArrear'end as Remarks, ClientLoanSubscription.DeathDate, ClientLoanSubscription.DeathEntryDate,ClientLoanProposal.Productcategory,
                                                  clientloanproposal.KYCName,(case when clientloanproposal.KYCname='Aadhar' then ('********'+right(clientloanproposal.KYCNO,4)) else clientloanproposal.KYCno end)KYCNO
FROM         Centers INNER JOIN
                      Branches With (NoLock) ON Centers.BranchID = Branches.BranchID INNER JOIN
                      Groups With (NoLock) ON Centers.CenterID = Groups.CenterID INNER JOIN
                      Clients With (NoLock) ON Groups.GroupID = Clients.GroupID INNER JOIN
                      ClientLoanProposal With (NoLock) ON Clients.ClientID = ClientLoanProposal.ClientID INNER JOIN
                      ClientLoanSubscription INNER JOIN
                      LoanLedger With (NoLock) ON ClientLoanSubscription.ClientLoanID = LoanLedger.ClientLoanID  ON 
                      ClientLoanProposal.LoanProposalID = ClientLoanSubscription.LoanProposalID INNER JOIN
                      Targets ON Clients.TargetID = Targets.TargetID
                                    inner join fieldstaff as fs With (NoLock)  on fs.staffid=centers.staffid
WHERE    (ClientLoanSubscription.ActualPaidUpDate IS NULL) AND 
                      (ClientLoanSubscription.CurrentInstallmentPeriod <= ClientLoanSubscription.LoanDurationInWeeks) AND 
                      (ClientLoanSubscription.NumInstallmentsInArrears between 1 and 4)  and ClientLoanSubscription.regionid in ('05','14','16')

                      
GROUP BY    Branches.zone,Branches.DistrictName,Branches.BranchID, Branches.BranchName,Branches.chid,Branches.AMID, ClientLoanSubscription.ClientLoanID, Targets.TargetName,Targets.Husbandname, 
                                                                   ClientLoanSubscription.DisbursementDate,ClientLoanSubscription.DeathDate, ClientLoanSubscription.CurrentInstallmentPeriod,ClientLoanSubscription.NumInstallmentsInArrears,
                       ClientLoanSubscription.PrincipalOutstanding,clientloansubscription.interestoutstanding,DeathPerson,ClientLoanSubscription.LoanAmountDisbursed,
                       clientloansubscription.interestinarrears,ClientLoanSubscription.DisbursementDate,fs.staffid,fs.staffname,
                                                                                   centers.ReportingDay,centers.CenterID,centers.centername,clientloansubscription.PrincipalInArrears,ClientLoanProposal.Productcategory ,clientloanproposal.KYCName,clientloanproposal.KYCNo,centers.centermeetingtime,ClientLoanSubscription.DeathEntryDate,clientloansubscription.loandurationinweeks
ORDER BY Branches.DistrictName,Branches.AMID,Branches.branchid,staffid,Reportingday,centers.CenterID,clientloanid


----PAR detail DDO Sir----


SELECT   Branches.zone,Branches.DistrictName , Branches.BranchID, Branches.BranchName,
Branches.AMID ARO_ID,  (select UPPER (LEFT (STAFFNAME,12)) from fieldstaff With (NoLock)  where staffid=Branches.AMID) ARO_NAME,
Branches.chid, (select UPPER (LEFT (STAFFNAME,12)) from fieldstaff With (NoLock) where staffid=Branches.chid) CH_NAME,
fs.Staffid,fs.Staffname,Case When centers.ReportingDay=1 Then 'Monday'
       When centers.ReportingDay=2 Then 'Tuesday'
       When centers.ReportingDay=3 Then 'Wednesday'
       When centers.ReportingDay=4 Then 'Thursday'
       When centers.ReportingDay=5 Then 'Friday'
       When centers.ReportingDay=6 Then 'Saturday' End as MeetingDay,centers.centermeetingtime,
                   centers.CenterID,centers.Centername, ClientLoanSubscription.ClientLoanID, Targets.TargetName as ClientName, Targets.Husbandname, 
                                                                   ClientLoanSubscription.DisbursementDate,ClientLoanSubscription.LoanAmountDisbursed,
               ClientLoanSubscription.CurrentInstallmentPeriod,ClientLoanSubscription.NumInstallmentsInArrears,
                       ClientLoanSubscription.PrincipalOutstanding,ClientLoanSubscription.LoanDurationInWeeks,clientloansubscription.PrincipalInArrears,
                      clientloansubscription.interestinarrears,case when DeathPerson='1' then 'ClientDeath' when deathperson=2
              then 'HusbandDeath' else 'RISKClient'end as Remarks, ClientLoanSubscription.DeathDate, ClientLoanSubscription.DeathEntryDate,ClientLoanProposal.Productcategory,
                                                  clientloanproposal.KYCName,(case when clientloanproposal.KYCname='Aadhar' then ('********'+right(clientloanproposal.KYCNO,4)) else clientloanproposal.KYCno end)KYCNO
FROM         Centers INNER JOIN
                      Branches With (NoLock) ON Centers.BranchID = Branches.BranchID INNER JOIN
                      Groups With (NoLock) ON Centers.CenterID = Groups.CenterID INNER JOIN
                      Clients With (NoLock) ON Groups.GroupID = Clients.GroupID INNER JOIN
                      ClientLoanProposal With (NoLock) ON Clients.ClientID = ClientLoanProposal.ClientID INNER JOIN
                      ClientLoanSubscription INNER JOIN
                      LoanLedger With (NoLock) ON ClientLoanSubscription.ClientLoanID = LoanLedger.ClientLoanID  ON 
                      ClientLoanProposal.LoanProposalID = ClientLoanSubscription.LoanProposalID INNER JOIN
                      Targets ON Clients.TargetID = Targets.TargetID
                                    inner join fieldstaff as fs With (NoLock)  on fs.staffid=centers.staffid
WHERE    (ClientLoanSubscription.ActualPaidUpDate IS NULL) AND 
                      (ClientLoanSubscription.CurrentInstallmentPeriod <= ClientLoanSubscription.LoanDurationInWeeks) AND 
                      (ClientLoanSubscription.NumInstallmentsInArrears>4)  and ClientLoanSubscription.regionid in ('05','14','16')

                      
GROUP BY    Branches.zone,Branches.DistrictName,Branches.BranchID, Branches.BranchName,Branches.chid,Branches.AMID, ClientLoanSubscription.ClientLoanID, Targets.TargetName,Targets.Husbandname, 
                                                                   ClientLoanSubscription.DisbursementDate,ClientLoanSubscription.DeathDate, ClientLoanSubscription.CurrentInstallmentPeriod,ClientLoanSubscription.NumInstallmentsInArrears,
                       ClientLoanSubscription.PrincipalOutstanding,clientloansubscription.interestoutstanding,DeathPerson,ClientLoanSubscription.LoanAmountDisbursed,
                       clientloansubscription.interestinarrears,ClientLoanSubscription.DisbursementDate,fs.staffid,fs.staffname,
                                                                                   centers.ReportingDay,centers.CenterID,centers.centername,clientloansubscription.PrincipalInArrears,ClientLoanProposal.Productcategory ,clientloanproposal.KYCName,clientloanproposal.KYCNo,centers.centermeetingtime,ClientLoanSubscription.DeathEntryDate,ClientLoanSubscription.LoanDurationInWeeks
ORDER BY Branches.DistrictName,Branches.AMID,Branches.branchid,staffid,Reportingday,centers.CenterID,clientloanid

-----------------Defaulter detail DDO Sir ------------------------------ 


SELECT   Branches.zone,Branches.DistrictName , Branches.BranchID, Branches.BranchName,
Branches.AMID ARO_ID,  (select UPPER (LEFT (STAFFNAME,12)) from fieldstaff With (NoLock)  where staffid=Branches.AMID) ARO_NAME,
Branches.chid, (select UPPER (LEFT (STAFFNAME,12)) from fieldstaff With (NoLock) where staffid=Branches.chid) CH_NAME,
fs.Staffid,fs.Staffname,Case When centers.ReportingDay=1 Then 'Monday'
       When centers.ReportingDay=2 Then 'Tuesday'
       When centers.ReportingDay=3 Then 'Wednesday'
       When centers.ReportingDay=4 Then 'Thursday'
       When centers.ReportingDay=5 Then 'Friday'
       When centers.ReportingDay=6 Then 'Saturday' End as MeetingDay,centers.centermeetingtime,
                   centers.CenterID,centers.Centername, ClientLoanSubscription.ClientLoanID, Targets.TargetName as ClientName, Targets.Husbandname, 
                                                                   ClientLoanSubscription.DisbursementDate,ClientLoanSubscription.LoanAmountDisbursed,
               ClientLoanSubscription.CurrentInstallmentPeriod,ClientLoanSubscription.NumInstallmentsInArrears,
                       ClientLoanSubscription.PrincipalOutstanding,ClientLoanSubscription.LoanDurationInWeeks,clientloansubscription.PrincipalInArrears,
                      clientloansubscription.interestinarrears,case when DeathPerson='1' then 'ClientDeath' when deathperson=2
              then 'HusbandDeath' else 'Defaulterclient'end as Remarks, ClientLoanSubscription.DeathDate, ClientLoanSubscription.DeathEntryDate,ClientLoanProposal.Productcategory,
                                                  clientloanproposal.KYCName,(case when clientloanproposal.KYCname='Aadhar' then ('********'+right(clientloanproposal.KYCNO,4)) else clientloanproposal.KYCno end)KYCNO
FROM         Centers INNER JOIN
                      Branches With (NoLock) ON Centers.BranchID = Branches.BranchID INNER JOIN
                      Groups With (NoLock) ON Centers.CenterID = Groups.CenterID INNER JOIN
                      Clients With (NoLock) ON Groups.GroupID = Clients.GroupID INNER JOIN
                      ClientLoanProposal With (NoLock) ON Clients.ClientID = ClientLoanProposal.ClientID INNER JOIN
                      ClientLoanSubscription INNER JOIN
                      LoanLedger With (NoLock) ON ClientLoanSubscription.ClientLoanID = LoanLedger.ClientLoanID  ON 
                      ClientLoanProposal.LoanProposalID = ClientLoanSubscription.LoanProposalID INNER JOIN
                      Targets ON Clients.TargetID = Targets.TargetID
                                    inner join fieldstaff as fs With (NoLock)  on fs.staffid=centers.staffid
WHERE    (ClientLoanSubscription.ActualPaidUpDate IS NULL) AND 
                      (ClientLoanSubscription.CurrentInstallmentPeriod > ClientLoanSubscription.LoanDurationInWeeks) AND 
                         ClientLoanSubscription.regionid in ('05','14','16') and ClientLoanSubscription.PrincipalOutstanding > 0
                      
GROUP BY    Branches.zone,Branches.DistrictName,Branches.BranchID, Branches.BranchName,Branches.chid,Branches.AMID, ClientLoanSubscription.ClientLoanID, Targets.TargetName,Targets.Husbandname, 
                                                                   ClientLoanSubscription.DisbursementDate,ClientLoanSubscription.DeathDate, ClientLoanSubscription.CurrentInstallmentPeriod,ClientLoanSubscription.NumInstallmentsInArrears,
                       ClientLoanSubscription.PrincipalOutstanding,clientloansubscription.interestoutstanding,DeathPerson,ClientLoanSubscription.LoanAmountDisbursed,
                       clientloansubscription.interestinarrears,ClientLoanSubscription.DisbursementDate,fs.staffid,fs.staffname,
                                                                                   centers.ReportingDay,centers.CenterID,centers.centername,clientloansubscription.PrincipalInArrears,ClientLoanProposal.Productcategory ,clientloanproposal.KYCName,clientloanproposal.KYCNo,centers.centermeetingtime,ClientLoanSubscription.DeathEntryDate,ClientLoanSubscription.LoanDurationInWeeks
ORDER BY Branches.DistrictName,Branches.AMID,Branches.branchid,staffid,Reportingday,centers.CenterID,clientloanid

----DAILY NEW ARREAR PAR/Defaulter report ----

select B.Districtname,B.BranchName,Left(p.Clientid,5) as Branchid,
B.AMID ARO_ID,  (select UPPER (LEFT (STAFFNAME,25)) from fieldstaff With (NoLock)  where staffid=B.AMID) ARO_NAME,
B.chid, (select UPPER (LEFT (STAFFNAME,25)) from fieldstaff With (NoLock) where staffid=B.chid) CH_NAME   ,
P.ClientID,P.clientLoanId,clp.TargetName,(cls.PrincipalInArrears+cls.InterestInArrears) ArrearAmt,cls.NumInstallmentsInArrears,Cls.PrincipalOutstanding,
cls.CurrentInstallmentPeriod,cls.LoanDurationInWeeks,Case when cls.DeathDate is not null then 'DeathArrear'
else 'ActualArrear' end as ArrearRemark,case when (cls.NumInstallmentsInArrears in('1') and (cls.CurrentInstallmentPeriod<cls.LoanDurationInWeeks)) then 'Arrear' 
when (cls.NumInstallmentsInArrears in('5') and (cls.CurrentInstallmentPeriod<cls.LoanDurationInWeeks)) then 'Risk' 
when (cls.CurrentInstallmentPeriod=(cls.LoanDurationInWeeks+1) and  (cls.CurrentInstallmentPeriod>cls.LoanDurationInWeeks)) then 'Defaulter' end as ArrearStatus from loanledger p with(nolock)
join Clientloansubscription cls on cls.clientloanid=p.clientloanid
join clientloanproposal clp on clp.loanproposalid=cls.loanproposalid
join branches b on b.branchid=Left(clp.Clientid,5) where 
 p.RegionID in('05','14','16') and 
 (p.Principalinstallmentamt+p.Interestinstallmentamt)>0  and (p.Principalcollected+p.Interestcollected)=0
and ((cls.NumInstallmentsInArrears in('1','5') and cls.CurrentInstallmentPeriod<cls.LoanDurationInWeeks) or
(cls.CurrentInstallmentPeriod=cls.LoanDurationInWeeks+1 and (cls.CurrentInstallmentPeriod>cls.LoanDurationInWeeks) and ((p.Principalcollected+p.Interestcollected)>0  or (p.Principalcollected+p.Interestcollected)=0)
)) and cls.principaloutstanding>0
and Cast(p.weeklytransactiondate as date)
='2026-03-13'
order by B.Districtname,B.AMID,Left(p.Clientid,5) 


----Loan Reject by BC BANK take proposal in own appcashpor 	
	
Select b.Zone,B.DistrictName RegionName,B.BranchID,b.BranchName, case 	
	when BCIDNo='1' then 'INDUSIND BC' 
	when BCIDNo='2' then 'ICICI BC' 
	when BCIDNo='3' then 'IDBI BC' 
	when BCIDNo='4' then 'KOTAK BC' 
	when BCIDNo='5' then 'SIDBI BC'
	when BCIDNo='6' Then 'IDFC BC' end as BCBankName,r.ClientID, t.TargetName Clientname,t.HusbandName,
LoanProposalID,case when RejectionRemarks IS NULL then 'Loan Reject by BC BANK' else RejectionRemarks end RejectionRemarks,	
cast(AttemptDate as date) As RejectionDate,'Waiting To Take Proposal In Own Loan' As SolutionRemark 	
from [43.242.214.235].AppCashpor.dbo.Proposal_Rejected_By_BCBank R (nolock)	
inner join clients c (nolock) on c.clientid=r.clientid	
inner join Targets t (nolock) on c.TargetID=t.TargetID	
	
inner join Branches b (nolock) on b.BranchID=left(r.ClientID,5)	
where cast(AttemptDate as date)>= cast(getdate()-7 as date) and left(LoanProposalID,2) in ('05','14','16') and not Exists (	
Select ClientID from [43.242.214.235].AppCashpor.dbo.ClientLoanProposal p (nolock) 	
where p.clientid=r.clientid and proposaldate>=cast(AttemptDate as date)	
and p.principaloutstanding>=1	
) Order by BCIDNo	


----Appcashpor

-----------------------CM NEFT PENDING REPORT Appcashpor
 
select branches.Zone,branches.DistrictName, branches.branchid,branches.branchname,branches.CHID,branches.CHNAME,
Branches.AMID ARO_ID,  (select STAFFNAME from fieldstaff With (NoLock)  where staffid=Branches.AMID) ARO_NAME
,clientid,loanproposalid,targetname,husbandname,proposaldate,loandescription,
clientrequestedamount,productcategory,numberofinstallments,finalreviewdate,AccountNumber,clientloanproposal.IFSCCode,BmAccountNumber,
BmIfsccode,FinalAccountNumber,clientloanproposal.FinalIfsccode
from clientloanproposal inner join
branches on left(clientloanproposal.clientid,5)=branches.branchid
where loanamountdisbursed='0' and left(clientid,2) in ('05','14','16')  and ProposalDate>='2024-04-01'  
and accountnumber='0'  and  approvalremarks  not like '%BAN%'
order by DistrictName,chid,branchid


-----------------------BM  NEFT			

   select branches.Zone,branches.DistrictName, branches.branchid,branches.branchname,branches.CHID,branches.CHNAME,
    Branches.AMID ARO_ID,  (select STAFFNAME from fieldstaff With (NoLock)  where staffid=Branches.AMID) ARO_NAME,
   clientid,loanproposalid,targetname,husbandname,proposaldate,loandescription,
 clientrequestedamount,productcategory,numberofinstallments,finalreviewdate,BmAccountNumber,BmIfsccode,FinalAccountNumber,clientloanproposal.FinalIfsccode
   from clientloanproposal inner join
 branches on left(clientloanproposal.clientid,5)=branches.branchid
 where loanamountdisbursed='0' and left(clientid,2) in ('05','14','16')  and ProposalDate>='2024-04-01' 
   and accountnumber>'0' and bmaccountnumber='0' and  approvalremarks  not like '%BAN%'
 order by DistrictName,chid,branchid

-----------------------ROE  NEFT
								 
  select branches.Zone,branches.DistrictName, branches.branchid,branches.branchname,branches.chid,
  (Select staffname from fieldstaff where branches.chid=fieldstaff.staffid)CHNAME,
  
   Branches.AMID ARO_ID,  (select STAFFNAME from fieldstaff With (NoLock)  where staffid=Branches.AMID) ARO_NAME,
   
   clientid,loanproposalid,targetname,husbandname,proposaldate,loandescription,
 clientrequestedamount,productcategory,numberofinstallments,finalreviewdate,FinalAccountNumber,clientloanproposal.FinalIfsccode
   from clientloanproposal inner join
 branches on left(clientloanproposal.clientid,5)=branches.branchid
 where loanamountdisbursed='0' and left(clientid,2) in ('05','14','16')  and ProposalDate>='2024-04-01' 
  and finalreviewdate is not null  and accountnumber>'0' and bmaccountnumber>'0' and  FinalAccountNumber='0' and  approvalremarks  not like '%BAN%'
order by DistrictName,branches.chid,branches.branchid

------KYC BACK DATE -- between '2025-03-08' and '2025-03-09'

Select  left(clientid,2)RID,k.TrnLoanid,(select distinct(upper(districtname)) from Branches where left(Branchid,2)=left(clientid,2)) RegionName, 
left(k.ClientID,5) BranchID,(select Branchname from Branches where Branchid=left(k.clientid,5)) BranchName,
(select CHID from Branches where Branchid=left(k.clientid,5)) CHIBID,
(select CHNAME from Branches where Branchid=left(k.clientid,5)) CHNAME,
(select amid from Branches where Branchid=left(k.clientid,5)) ARO_ID,
(SELECT STAFFNAME FROM FIELDSTAFF (NOLOCK) WHERE STAFFID IN (select DISTINCT amid from Branches (NOLOCK) where Branchid=left(k.clientid,5)))  ARO_NAME,
Clientid ,
(case when ClientPrimaryKyctype='Aadhar' then ('********'+right(ClientPrimaryKycmember,4)) else ClientPrimaryKycmember end)KYCNO
,ClientPrimaryKyctype,ClientPrimaryNameasperkyc,k.Datestamp
from KYC k(nolock) where Cast(datestamp as date)=(convert(nvarchar(28),getdate()-1,23))  and left(clientid,2) in ('05','14','16')
group by clientid,ClientPrimaryKycmember ,ClientPrimaryKyctype,ClientPrimaryNameasperkyc,k.TrnLoanid,k.Datestamp
order by clientid

----Proposal not Review

select branches.Zone,branches.DistrictName, branches.branchid,branches.branchname,branches.CHID,
(select staffname from fieldstaff (nolock) where fieldstaff.staffid=branches.CHID)CHNAME,
Branches.AMID ARO_ID,  (select STAFFNAME from fieldstaff With (NoLock)  where staffid=Branches.AMID) ARO_NAME,
clientid,loanproposalid,targetname,husbandname,proposaldate,loandescription,
clientrequestedamount,productcategory,numberofinstallments,finalreviewdate,approvalremarks,AccountNumber,clientloanproposal.IFSCCode,BmAccountNumber,BmIfsccode,FinalAccountNumber,clientloanproposal.FinalIfsccode
   from clientloanproposal (nolock) inner join
branches (nolock) on left(clientloanproposal.clientid,5)=branches.branchid
where loanamountdisbursed='0' and left(clientid,2) in ('05','16','14')  and ProposalDate>='2024-04-01' 
 and finalreviewdate is null and approvalremarks not like '%BAN%' 
and trnloanid in (select trnloanid from CreditNeedAssessmenttrn (nolock)where finalreviewdate is null)
order by Districtname,CHID,branchid

----Staff wise Daily Proposal Entry----
----Staff wise----

 declare @date date=(convert(nvarchar(28),getdate()-1,23))
select b.DistrictName,B.BranchName,a.Branchid,b.CHID,B.CHName,B.AMID,
 (select STAFFNAME from fieldstaff With (NoLock)  where staffid=B.AMID) ARO_NAME,
a.StaffId,a.StaffName,ISNULL(k.NoOfProposals,0) NoOfProposals,ISNULL(k.Amount,0) ProposalAmt,
ISNULL(c.NoOfProposals,0) NoOfRevieclients,ISNULL(LoanAmountApproved,0)ReviewAmt,
ISNULL(NoOfAddings,0) NoOfAddings  from  (select BranchId,StaffId,StaffName from fieldstaff with(nolock) where exitdate is null and designation in('12','13','14','15','46','47')
and left(branchid,2) in ('05','14','16') and staffname not like'Dumm%') a
left Join  (select DistrictName,BranchId,BranchName,CHID,CHName,AMID from branches with(nolock) where dissolveddate is null) b on b.branchid=a.branchid
left join  (select EntryBy,Count(clientid) NoOfProposals,Sum(ClientRequestedAmount) as Amount from clientloanproposal with(nolock) where 
 ProposalDate=@date group by entryBy) k  on k.entryby=a.staffid
left join  (select EntryBy,Count(clientid) NoOfProposals,Sum(LoanAmountApproved) as LoanAmountApproved from clientloanproposal with(nolock) where 
 loandisbursementdate is null and Principaloutstanding=1 and FinalReviewDate=@date
group by entryBy) c on c.entryby=a.staffid
left join  (select entryby,Count(clientid) NoOfAddings from clients with(nolock) where cast(Joindate as date)=@date and amgrtdate is not null
group by entryby) d on d.entryby=a.staffid
order by b.DistrictName,CHID,Branchid

----Staff not Entry IGL Proposal 

select b.Districtname RegionName,F.Branchid,b.BranchName,B.chid,b.CHname,
B.AMID ARO_ID,  (select STAFFNAME from fieldstaff With (NoLock)  where staffid=B.AMID) ARO_NAME,
StaffId,F.StaffName,D.DesignationName ,F.Telephone,F.Mobilenumber
from fieldstaff f join designationmaster d on f.designation=d.designationid
join branches b on b.branchid=f.branchid 
where exitdate is null and designation in('12','13','14','15','46','47') and left(f.branchid,2) in ('05','14','16')
and staffname not like'%Dummy%' and  
staffid not in(select clientloanproposal.entryby from clientloanproposal
inner join products p on clientloanproposal.productid=p.productid
 where proposaldate =(convert(nvarchar(28),getdate()-1,23))  and p.Loan_Category=0)
order by  f.Branchid,b.Districtname, b.chid

----Intimation done but not entry Proposal

select b.zone,B.DistrictName,B.BranchID,b.branchname,B.CHID,b.chname,
B.AMID ARO_ID,  (select STAFFNAME from fieldstaff With (NoLock)  where staffid=B.AMID) ARO_NAME,
Clp.Clientid,Clp.TargetName,Clp.HusbandName,Clp.PrincipalOutstanding,IntimationSettleDate,
Clp.IntimationDoneBy,F.StaffName as IntimationDoneByStaffName,IntimationDoneDt from clientloanproposal clp with(nolock)  
join Products p with(nolock) on p.productid=clp.productid
join branches b with(nolock) on b.branchid=Left(clp.Clientid,5)
join fieldstaff f on f.staffid=clp.intimationDoneBy where principaloutstanding>1 
and intimationsettledate is not null and not exists
(select Clientid from clientloanproposal with(nolock) where principaloutstanding=1 and clientid=clp.clientid) 
and LEFT(clientid,2) IN ('05','14','16') and p.loan_category=0
order by B.DistrictName,b.chname,B.BranchID

------pending by CIPVU TEAM

select B.Zone,B.DistrictName,B.BranchID,B.BranchName,
B.CHID,b.chname,
B.AMID ARO_ID,  (select STAFFNAME from fieldstaff With (NoLock)  where staffid=B.AMID) ARO_NAME,
P.clientID,P.targetName,Proposaldate,finalreviewdate,loandisbursementdate,P.trnloanID,
P.mobilenumber , 
(case when P.trnloanID in(select Trnloanid from KYCverificationtrn p (nolock) where status=1) then ' Primary KYC Verifield and OK'
when P.trnloanID in(select Trnloanid from KYCverificationtrn p (nolock) where status=2)  then ' Primary KYC Verifield and Rejected'
when P.trnloanID not in(select Trnloanid from KYCverificationtrn p (nolock) )     then ' Primary KYC not Verifield '
else 'Hold' end) KYC_Verification,
(case when P.trnloanID in(select Trnloanid from KYCverificationtrn p (nolock) where status=1 and ConsentDate is not null)
then 'KYC_concent_Done' else 'KYC_Verified_concent_NOT_Done' end) KYC_Consent,
(case when P.trnloanID in(select Trnloanid from client_monthly_obligation_log p (nolock)) then ' Monthly Obligation Verifield' else ' Monthly Obligation not Verifield' end)  Monthly_Obligation_Verification,
(case when P.trnloanID in(select Trnloan_id from second_kyc_verification_trn p (nolock) where Flag='1') then 'Secondry KYC Verifield' 
when P.trnloanID in(select Trnloan_id from second_kyc_verification_trn p (nolock) where Flag='2') 
then 'Secondry KYC rejected' else 'Secondry kyc not Verifield'  end) SecondryKYC_Verification
from clientloanproposal p (nolock) inner join
kyc k (nolock) on isnull(k.EnrollTrnLoanID,k.TrnLoanid)=p.TRNLoanID inner join
Branches b (nolock) on left(p.clientid,5)=b.Branchid 
inner join CreditWorthinesstrn c with(nolock) on c.TrnLoanid=isnull(k.EnrollTrnLoanID,k.TrnLoanid)      
where left(b.Branchid,2) in ('05','14','16') and loandisbursementdate is null and  finalreviewdate is not null  and k.ClientSecondaryKycid is not null
and c.productcategory not like '%BC%' and c.productcategory not like '%SIDBI%'       
and k.ClientPrimaryMobileNumber not in('8888888888','9999999999')
and not exists(select a.TrnLoanid from KycVerificationtrn a with(nolock) where a.TrnLoanid=isnull(k.EnrollTrnLoanID,k.TrnLoanid) and a.ClientID=k.ClientID)    
 and not exists(select a.Trnloan_id from second_kyc_verification_trn a with(nolock) where a.Trnloan_id=isnull(k.EnrollTrnLoanID,k.TrnLoanid) and a.client_id=k.ClientID)    
 and not exists(select a.Trnloanid from Client_Monthly_Obligation_Log a with(nolock) where a.Trnloanid=isnull(k.EnrollTrnLoanID,k.TrnLoanid) and a.clientid=k.ClientID)  
 order by B.DistrictName,B.BranchID

----HOLD by CIPVU

select * from (
select B.Zone,B.DistrictName,B.BranchID,B.BranchName,b.chid,UPPER(LEFT(b.chname,12)) CHIB_NAME,b.amid ARO_ID,
(select  UPPER(LEFT(staffname,12)) from fieldstaff  (nolock) where staffid=b.amid )  ARO_NAME ,P.clientID,P.targetName,
Proposaldate,finalreviewdate,loandisbursementdate,P.trnloanID,
(case when P.trnloanID in(select Trnloanid from KYCverificationtrn p (nolock) where status=1) then 'KYC Verifield and OK'
when P.trnloanID in(select Trnloanid from KYCverificationtrn p (nolock) where status=2)  then 'KYC Verifield and Rejected'
when P.trnloanID not in(select Trnloanid from KYCverificationtrn p (nolock) )     then 'KYC not Verifield '
else 'Hold' end) KYC_Verification,
(case when P.trnloanID in(select Trnloanid from KYCverificationtrn p (nolock) where status=1 and ConsentDate is not null)
then 'KYC_concent_Done' else 'KYC_concent_NOT_Done' end) KYC_Consent,k.ClientSecondaryKycid
from clientloanproposal p (nolock) inner join   Branches b (nolock)
on left(p.clientid,5)=b.Branchid inner join Products T (nolock) 
on p.productid=T.productid inner join kyc k (nolock) 
on p.trnloanid=isnull(k.EnrollTrnLoanID,k.TrnLoanid)
where left(b.Branchid,2) in ('05','14','16') and loandisbursementdate is null and  finalreviewdate is not null and
t.bcidno=0 and k.ClientSecondaryKycid is not null) a where a.KYC_Verification='Hold' ORDER BY a.DistrictName,A.chid

----concent_NOT_Done

select * from 
(
select B.Zone,B.DistrictName,B.BranchID,B.BranchName,
b.chid,UPPER(LEFT(b.chname,12)) CHIB_NAME,b.amid ARO_ID,
(select  UPPER(LEFT(staffname,12)) from fieldstaff  (nolock) where staffid=b.amid )  ARO_NAME 
,P.clientID,P.targetName,Proposaldate,finalreviewdate,loandisbursementdate,P.trnloanID,
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
where left(b.Branchid,2) in ('05','14','16') and
loandisbursementdate is null and  finalreviewdate is not null and
t.bcidno=0 and k.ClientSecondaryKycid is not null
) a where a.KYC_Verification='KYC Verifield and OK' and  KYC_Consent='KYC_concent_NOT_Done'
ORDER BY a.DistrictName,A.chid



--------NEFT PENDING REPORT

-- select branches.Zone,branches.DistrictName, branches.branchid,branches.branchname,branches.CHID,branches.CHNAME,
-- Branches.AMID ARO_ID,  (select STAFFNAME from fieldstaff With (NoLock)  where staffid=Branches.AMID) ARO_NAME,
-- clientid,loanproposalid,targetname,husbandname,proposaldate,loandescription,
-- clientrequestedamount,productcategory,numberofinstallments,finalreviewdate,
--(case when  AccountNumber='0' AND BmAccountNumber='0' THEN 'NEFT PENDING BY CM'
--when  AccountNumber !='0' AND BmAccountNumber='0' THEN 'NEFT PENDING BY BM'
--when  AccountNumber !='0' AND BmAccountNumber !='0' and FinalAccountNumber='0'  and (finalreviewdate is not null or finalreviewdate is null) THEN 'NEFT PENDING BY ROE'
--end) Remark 

--   from clientloanproposal inner join
-- branches on left(clientloanproposal.clientid,5)=branches.branchid
-- where loanamountdisbursed='0' and left(clientid,2) in ('05','16','14')  and ProposalDate>='2024-04-01' 
--   and  (  accountnumber='0'  or bmaccountnumber='0' or FinalAccountNumber='0'  ) and  approvalremarks  not like '%BAN%'
-- order by DistrictName,chid,branchid

