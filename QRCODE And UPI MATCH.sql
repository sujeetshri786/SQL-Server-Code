----QRCODE And UPI MATCH


declare @BID varchar(14) ='10:26'
select LEFT(CLIENTLOAN1ID,5) as branchid, sum(ClientLoan1totalCollected)  collection  , 'QRcode'  Coll_MOde   from 
cds2 where LEFT(CLIENTLOAN1ID,5)=@BID  and ClientLoan1TotalCollected>0 and ClientLoan2InstallmentNumber='1'    and  Payment_Tran_ID  is not   null
group by LEFT(CLIENTLOAN1ID,5)
UNION ALL
select  LEFT(CLIENTLOAN1ID,5)  as branchid , sum(ClientLoan1totalCollected)   collection  , 'AIRTELupi'     Coll_MOde   from 
cds2 where LEFT(CLIENTLOAN1ID,5)=@BID  and ClientLoan1TotalCollected>0 and ClientLoan2InstallmentNumber='1'    and  Payment_Tran_ID  is    null
group by LEFT(CLIENTLOAN1ID,5)
order by LEFT(CLIENTLOAN1ID,5)

--------------------------2025-06-11
declare @BID varchar(14) ='39:22'

select LEFT(CLIENTLOAN1ID,5) as branchid, sum(ClientLoan1totalCollected)  collection  , 'CASH'  Coll_MOde   from 
cds2 where LEFT(CLIENTLOAN1ID,5)=@BID  and ClientLoan1TotalCollected>0 and ClientLoan2InstallmentNumber  IN ('0','2')  
group by LEFT(CLIENTLOAN1ID,5)
UNION ALL
select LEFT(CLIENTLOAN1ID,5) as branchid, sum(ClientLoan1totalCollected)  collection  , 'QRcode'  Coll_MOde   from 
cds2 where LEFT(CLIENTLOAN1ID,5)=@BID  and ClientLoan1TotalCollected>0 and ClientLoan2InstallmentNumber='1'    and  Payment_Tran_ID  is not   null
group by LEFT(CLIENTLOAN1ID,5)
UNION ALL
select  LEFT(CLIENTLOAN1ID,5)  as branchid , sum(ClientLoan1totalCollected)   collection  , 'AIRTELupi'     Coll_MOde   from 
cds2 where LEFT(CLIENTLOAN1ID,5)=@BID  and ClientLoan1TotalCollected>0 and ClientLoan2InstallmentNumber='1'    and  Payment_Tran_ID  is    null
group by LEFT(CLIENTLOAN1ID,5)
order by LEFT(CLIENTLOAN1ID,5)
