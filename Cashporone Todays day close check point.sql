---------------------------------------------------------------Todays day close check point cashpor X

select left(c.Groupid,5)Branchid, sum(c.clientloan1totalcollected) C_collection,sum(ClientLoan1AmountDisbursed) C_ClientLoan1AmountDisbursed,
sum(case when c.RiskFundDate=cast(getdate() as date) then ClientLoan2UpFrontFee+ClientCRFCollected else 0 end)c_Ins,
sum(case when c.UpFrontFeeDate=cast(getdate() as date) then ClientLoan1UpFrontFee else 0 end)c_Pro,(t.TotalCollection+t.UPI_Collection)Tcoll,DailyDocumentAmt,
t.InsuranceCollection ,
t.ProcessingFees,
(sum(c.clientloan1totalcollected)-((t.TotalCollection+t.UPI_Collection))) Col_dif,
(sum(ClientLoan1AmountDisbursed) -DailyDocumentAmt)dis_diff,
(sum(case when c.RiskFundDate=cast(getdate() as date) then ClientLoan2UpFrontFee+ClientCRFCollected else 0 end)-t.InsuranceCollection) Ins_diff,
(sum(case when c.UpFrontFeeDate=cast(getdate() as date) then ClientLoan1UpFrontFee else 0 end)-t.ProcessingFees)Proc_diff
from PREVCDS2 c (nolock) inner join cds3 cc (nolock) on c.ClientID=cc.ClientID
inner join tempdailyclosingdtl t (nolock) on left(cc.Groupid,5)=t.Branchid
where cast(t.MeetingDate as date)=cast(getdate() as date) and c.RegionID = '14'
group by left(c.Groupid,5),t.InsuranceCollection,t.ProcessingFees,DailyDocumentAmt,UPI_Collection,t.TotalCollection
order by left(c.Groupid,5)

--select * from tempDailyClosingDtl where branchid like '05:01'
--select * from DailyClosingDtl where branchid like '05:01'
--select * from logfile with(nolock) where EndProcDwhere branchid like '05:01'
--select * from PrevCDS3

