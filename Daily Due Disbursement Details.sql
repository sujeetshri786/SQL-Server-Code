--Daily due Disbursement detail

select left(a.clientid,5) as Brnachid,a.ClientID,a.ClientLoan1AmtDueDisbursed as DueAmount,ClientLoan1AmountDisbursed,b.ClientName,b.ClientCRFDue as Insurance,a.ClientLoan1UpFrontFee as ProcessingFee
,a.ClientLoan1ProductName,a.ClientLoan2AccountNumber as AccountNumber,ClientLoan2UtilizationStatus as IFSC,a.ClientLoan2ProductName as BankName
  from cds2 a inner join cds3 b on a.clientid=b.clientid 
 where clientloan1amtduedisbursed>0 and a.clientid like '31%'  order by a.clientid
