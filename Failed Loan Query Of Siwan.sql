--Failed Loan Query Local

--For Own
select * from atClientLoanSubscription with(nolock) where cast(DateofUpdation as date)='2022-02-05' 
and UpdatedRecords='Disbursement Failed by bank'  

--For Bc
select * from clientloansubscription with(nolock) where actualpaidupdate>='2022-02-05'
and Comments='Disbursement Failed by bank' order by clientloanid



