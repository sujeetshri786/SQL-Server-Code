--EKYC details appcashpor

select LEFT(e.centerid,5) BranchId,(e.Clientid),t.Targetname as Clientname,t.HusbandName,ISNULL(CBRRemark,0) as CBRRemark,
(select ISNULL(sum(principalOutstanding),0) from ClientLoanProposal with(nolock) where principalOutstanding>1 and e.Clientid=Clientid) as PrincipalOut from Ekycdetail e with(nolock)
full join kyc l with(nolock) on e.clientid=l.clientid and l.ClientPrimaryMobileNumber='8888888888'
full join CCRMFISUMMARY cc with(nolock) on l.Trnloanid=cc.CustRefField
full join clients cl with(nolock) on e.clientid=cl.clientid
full join targets t with(nolock) on t.targetid=cl.targetid
where e.centerid like'14:01%' and e.Datestamp>='2022-11-03' --and e.Clientid  in(select clientid from ClientLoanProposal where PrincipalOutstanding=1 and loandisbursementdate is null)
group by LEFT(e.centerid,5),e.Clientid,CBRRemark,Targetname,t.HusbandName
order by e.Clientid
