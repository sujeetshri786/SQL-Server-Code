
  Select LEFT(cr.Clientid,5) as BranchID, cr.Clientid,cr.Trnloanid ,'1' as Remarks,cr.DateStamp , GetDate(), '3857'
from CreditWorthinesstrn as cr  join ClientLoanProposal as clp on cr.Trnloanid=clp.TRNLoanID
where clp.LoanAmountDisbursed='0' and Cr.Clientid in 
(


) 
union all

  Select LEFT(cr.Clientid,5) as BranchID, cr.Clientid,cr.Trnloanid ,'1' as Remarks ,cr.DateStamp, GetDate(), '3857'
from CreditWorthinesstrn as cr  where Not Exists(Select Trnloanid from ClientLoanProposal  clp(nolock) where cr.Trnloanid=clp.Trnloanid)
and Cr.Clientid  in 
(


)
