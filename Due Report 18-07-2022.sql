--Staff Wise due disbusement--
select D.Zone,A.BranchID,d.Branchname,
A.StaffID,A.StaffName,Position,isnull(b.dueloan,0) as LoanDue,isnull(b.dueAMT,0) as AmountDue,isnull(c.LoanDOC,0) as LoanDocumented,isnull(c.Amtdoc,0) as AmountDocumented

from (
select Branchid,Staffid,StaffName ,case                                     
                                         When f.Designation='12' Then 'CM'
                                         When f.Designation='13' Then 'CM'
                                         When f.Designation='14' Then 'PCM'
                                         When f.Designation='15' Then 'TCM'
                                         When f.Designation='46' Then 'CTPCM'
                                         When f.Designation='47' Then 'CTTCM'
                                         End As 'Position'



from FieldStaff f (nolock)
where f.Designation in('12','13','14','15','47','46') and exitdate is null and StaffName not like 'Dummy%'
) A left join 
(
select Staffid,count(clientloan1id) as dueloan,sum(ClientLoan1AmtDueDisbursed) as dueAMT from prevcds1 p1 (nolock) inner join prevcds2 p2 (nolock) on
p1.groupid=p2.groupid
where p2.ClientLoan1AmtDueDisbursed>0
group by Staffid
) B on A.Staffid=b.Staffid left join 

(select Staffid,count(clientloan1id) as LoanDOC,sum(ClientLoan1AmountDisbursed) as Amtdoc from prevcds1 p1 (nolock) inner join prevcds2 p2 (nolock) on
p1.groupid=p2.groupid
where p2.ClientLoan1AmountDisbursed>0
group by Staffid
) C     on A.Staffid=c.Staffid left join
Branches D on A.Branchid=D.Branchid
where d.DissolvedDate is null
order by A.BranchID,A.StaffID

---Branch wise due disbusement--

select b.BranchID,b.BranchName, 
(select ISNULL(count(distinct(clientloan1id)),0) from PrevCDS2 with (nolock) where ClientLoan1AmtDueDisbursed>0 and  left(ClientID,5)=b.BranchID )'#Loans',
(select ISNULL(sum(ClientLoan1AmtDueDisbursed),0) from PrevCDS2 with (nolock) where ClientLoan1AmtDueDisbursed>0 and   left(ClientID,5)=b.BranchID )'#Due Disburse',
(select ISNULL(count(distinct(clientloan1id)),0) from PrevCDS2 with (nolock) where ClientLoan1AmountDisbursed>0 and   left(ClientID,5)=b.BranchID )'#Loans Disburse',
(select ISNULL(sum(ClientLoan1AmtDueDisbursed),0) from PrevCDS2 with (nolock) where ClientLoan1AmountDisbursed>0  and  left(ClientID,5)=b.BranchID)'#AMt Disburse'
 --(select round(cast(isnull(sum(ClientLoan1AmountDisbursed),0) as float )*100/
 -- cast(sum(ClientLoan1AmtDueDisbursed) as float),2) from PrevCDS2 where left(ClientID,5)=b.BranchID ) as Ratio

from Branches as b with (nolock)   where  b.DissolvedDate is null and b.Zone='HOT-North east Zone'  
group by  b.BranchID,b.BranchName 
order by  b.BranchID,b.BranchName

----Staff Wise proposal entry--- its run appcashpur--

select D.Zone,A.BranchID,d.Branchname,
A.StaffID,A.StaffName,Position,isnull(b.Numpro,0) as proposal, isnull(b.LoanAmount,0) as proposal_AMT,
isnull(e.NumBAN,0) as BAN
from (
select Branchid,Staffid,StaffName ,case                                     
                                         When f.Designation='12' Then 'CM'
                                         When f.Designation='13' Then 'CM'
                                         When f.Designation='14' Then 'PCM'
                                         When f.Designation='15' Then 'TCM'
                                         When f.Designation='46' Then 'CTPCM'
                                         When f.Designation='47' Then 'CTTCM'
                                         End As 'Position'

from FieldStaff f (nolock)
where f.Designation in('12','13','14','15','47','46') and exitdate is null and StaffName not like 'Dummy%'
) A left join 
(
select c.entryby as Staffid ,count(c.LoanProposalID) Numpro,sum(LoanAmountApproved) LoanAmount
from clientloanproposal c (nolock) 
where c.proposaldate>= cast(getdate()-2 as date)
group by c.entryby,left(clientid,5)
) B on A.Staffid=b.Staffid left join 

(select c.entryby as Staffid ,count(c.LoanProposalID) NumBAN
from clientloanproposal c (nolock) 
where c.proposaldate>= cast(getdate()-2 as date) and ApprovalRemarks  like '%BAN%'
group by c.entryby,left(clientid,5)
) e     on A.Staffid=e.Staffid left join
Branches D on A.Branchid=D.Branchid
where d.DissolvedDate is null and d.Branchid like '14%'

order by A.BranchID,A.StaffID


---Staff not entry Single proposal -- its run appcashpor

select Branchid,(select Branchname from Branches b where f.Branchid=b.Branchid and branchid like'14%') as Branchname,Staffid,StaffName ,case                                     
                                         When f.Designation='12' Then 'CM'
                                         When f.Designation='13' Then 'CM'
                                         When f.Designation='14' Then 'PCM'
                                         When f.Designation='15' Then 'TCM'
                                         When f.Designation='46' Then 'CTPCM'
                                         When f.Designation='47' Then 'CTTCM'
                                         End As 'Position'



from FieldStaff f (nolock)
where f.Designation in('12','13','14','15','47','46') and exitdate is null and StaffName not like 'Dummy%' and Branchid like '14%'
 and staffid not in (select entryby from clientloanproposal (nolock) where proposaldate>='2022-07-10' and clientid like '14%')

 ---BM not Review Single proposal -- its run appcashpor
 select Branchid,(select Branchname from Branches b where f.Branchid=b.Branchid and branchid like'14%') as Branchname,Staffid,StaffName ,case                                     
                                         When f.Designation='16' Then 'BM'
                                                                                End As 'Position'

from FieldStaff f (nolock)
where f.Designation in('16') and exitdate is null and StaffName not like 'Dummy%' and Branchid like '14%'
 and staffid not in (select BMID from clientloanproposal (nolock) where proposaldate>='2022-07-10' and clientid like '14%')


 --Staff not disbursed Single loan--
 select Branchid,(select Branchname from Branches b where f.Branchid=b.Branchid and branchid like'14%') as Branchname,Staffid,StaffName ,case                                     
                                         When f.Designation='12' Then 'CM'
                                         When f.Designation='13' Then 'CM'
                                         When f.Designation='14' Then 'PCM'
                                         When f.Designation='15' Then 'TCM'
                                         When f.Designation='46' Then 'CTPCM'
                                         When f.Designation='47' Then 'CTTCM'
                                         End As 'Position'



from FieldStaff f (nolock)
where f.Designation in('12','13','14','15','47','46') and exitdate is null and StaffName not like 'Dummy%' and Branchid like '14%'
 and staffid not in (select StaffID from ClientLoanSubscription (nolock) where ActualDisbursementDate>='2022-07-10' and ClientLoanID like '14%')
