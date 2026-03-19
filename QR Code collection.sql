--QR Code collection
				
				
				Select * into #df from [43.242.214.235].Appcashpor.dbo.iciciupiresponse where  TxnStatus='SUCCESS' 
                select PayerVA,count(PayerVA) from #df  where cast(datestamp as date)='2025-04-15'
                group by PayerVA
                having count(PayerVA)>1
                
                select br.districtname,br.branchname,ll.branchid,clp.clientid,clp.targetname,left(ll.Payment_Tran_ID,12) Bank_RRN,
                Substring(ll.Payment_Tran_ID,14,len(ll.Payment_Tran_ID)) MID,
                ll.Payment_Tran_Date,(case when collectionmode=6 then (ll.PrincipalInstallmentAmt+ll.InterestInstallmentAmt) 
                else Principalcollected+interestcollected end) as amount,
                (Select top(1) PayerVA from #df d(nolock) where d.merchantTranId=Substring(ll.Payment_Tran_ID,14,len(ll.Payment_Tran_ID))
                and cast(d.datestamp as date)=cast(ll.weeklytransactiondate as date)
                
                ),'SUCCESS' Status
                from Cashporone..loanledger as ll with (nolock)
                join Cashporone..clientloansubscription as cls  with (nolock)  on ll.clientloanid=cls.clientloanid
                join Cashporone..clientloanproposal as clp   with (nolock) on cls.loanproposalid=clp.loanproposalid 
                join Cashporone..branches as br with (nolock) on br.branchid=ll.branchid 
                where  ll.weeklytransactiondate='2025-04-15' and Payment_Tran_Date is not null 
                order by ll.branchid
                
                

                select br.districtname,br.branchname,ll.branchid,SUM(case when collectionmode=6 then (ll.PrincipalInstallmentAmt+ll.InterestInstallmentAmt) 
                else Principalcollected+interestcollected end ) as amount
                from CashporOne..loanledger as ll with (nolock)
                join CashporOne..clientloansubscription as cls  with (nolock)  on ll.clientloanid=cls.clientloanid
                join CashporOne..clientloanproposal as clp   with (nolock) on cls.loanproposalid=clp.loanproposalid 
                join CashporOne..branches as br with (nolock) on br.branchid=ll.branchid 
                where  ll.weeklytransactiondate='2025-04-15' and Payment_Tran_Date is not null 
                group by br.districtname,br.branchname,ll.branchid
                order by ll.branchid
