--QR Code Query

Select * into #df from [137.59.201.177].Appcashpor.dbo.iciciupiresponse where cast(datestamp as date)='2025-04-10' and TxnStatus='SUCCESS' 

select br.districtname,br.branchname,ll.branchid,clp.clientid,clp.targetname,left(ll.Payment_Tran_ID,12) Bank_RRN,
Substring(ll.Payment_Tran_ID,14,len(ll.Payment_Tran_ID)) MID,
ll.Payment_Tran_Date,(Principalcollected+interestcollected) as amount,
(Select PayerVA from #df d(nolock) where d.merchantTranId=Substring(ll.Payment_Tran_ID,14,len(ll.Payment_Tran_ID))),'SUCCESS' Status
from Cashporone..loanledger as ll with (nolock)
join Cashporone..clientloansubscription as cls  with (nolock)  on ll.clientloanid=cls.clientloanid
join Cashporone..clientloanproposal as clp   with (nolock) on cls.loanproposalid=clp.loanproposalid 
join Cashporone..branches as br with (nolock) on br.branchid=ll.branchid 
where ll.regionid in ('12') and ll.weeklytransactiondate='2025-04-10' and Payment_Tran_Date is not null 
order by ll.branchid



select br.districtname,br.branchname,ll.branchid,SUM(Principalcollected+interestcollected) as amount
from CashporOne..loanledger as ll with (nolock)
join CashporOne..clientloansubscription as cls  with (nolock)  on ll.clientloanid=cls.clientloanid
join CashporOne..clientloanproposal as clp   with (nolock) on cls.loanproposalid=clp.loanproposalid 
join CashporOne..branches as br with (nolock) on br.branchid=ll.branchid 
where ll.regionid in ('12') and ll.weeklytransactiondate='2025-04-10' and Payment_Tran_Date is not null 
group by br.districtname,br.branchname,ll.branchid
order by ll.branchid
