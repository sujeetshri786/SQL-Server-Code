use CASHPORONE

---Monthly Arrears----

Select 
	b.zone,		b.DistrictName as Region,	MANA.BranchID,	MANA.BranchName,	b.AMID as [ARO ID], 
	(select fs.staffname from FieldStaff fs with(nolock) where fs.StaffID = b.AmID) as [ARO Name],
	MANA.ClientLoanID,	MANA.TargetName as ClientName,	cls.LoanAmountDisbursed as DisbursementAmount,	MANA.TransactionDate,		
	(select LoanDescription from ClientLoanProposal clp with(nolock) where clp.LoanProposalID = CLS.LoanProposalID) as LoanPurpose, 
	cls.principaloutstanding,		cls.InterestOutstanding,	(cls.principaloutstanding + cls.InterestOutstanding) as LoanOutstanding,
	Case When CLS.DeathPerson=0 Then 'Actual Arrear' When CLS.DeathPerson=1 Then 'Client Death' When CLS.DeathPerson=2 Then 'Husband Death' End as [Arrear/PAR/Default Type],
	MANA.PrincipalInstallmentAmt,	MANA.PrincipalCollected,	MANA.InterestInstallmentAmt,	MANA.InterestCollected, 
	MANA.PrincipalInArrears,		MANA.InterestInArrears,		(MANA.PrincipalInArrears+MANA.InterestInArrears) as [Arrear/PAR Amount], 
case 
	when c.CenterMeetingDay = '1' then 'Monday'
	when c.CenterMeetingDay = '2' then 'Tuesday'
	when c.CenterMeetingDay = '3' then 'Wednessday'
	when c.CenterMeetingDay = '4' then 'Thursday'
	when c.CenterMeetingDay = '5' then 'Friday'
	when c.CenterMeetingDay = '6' then 'Saturday'	
end as CenterMeetindDay,	c.StaffID as [CM ID handled the Center], 
(select f.StaffName from FieldStaff f with(nolock) where f.StaffID = c.StaffID) as [CM Name handled the Center],
 NULL as Remark,		SUBSTRING(MANA.ClientLoanID,16,2) as ProductID,		Cls.DeathEntryDate
 from 
	ClientLoanSubscription as CLS 
		inner join	MasterActivity..NewArrears as MANA	ON CLS.LoanProposalID		=	MANA.LoanProposalID
		inner join	branches b							ON left(cls.clientloanid,5)	=	b.branchid
		inner join	Centers c with(nolock)				ON c.CenterID				=	CLS.CenterID
		and			CLS.ActualPaidUpDate is null and MANA.TransactionDate between '2025-02-10' and '2025-04-02' 
		and			b.Zone = 'Deogarh Zone' and b.RegionID = '28'

order by MANA.BranchID,MANA.ClientLoanID


---Monthly Risk----

Select 
	b.zone,		b.DistrictName as Region,	MANA.BranchID,	MANA.BranchName,	b.AMID as [ARO ID],
	(select fs.staffname from FieldStaff fs with(nolock) where fs.StaffID = b.AmID) as [ARO Name],
	MANA.ClientLoanID,	MANA.TargetName as ClientName, CLS.LoanAmountDisbursed as DisbursedAmount, MANA.TransactionDate,
	(select LoanDescription from ClientLoanProposal clp with(nolock) where clp.LoanProposalID = CLS.LoanProposalID) as LoanPurpose, 
	(cls.principaloutstanding + cls.InterestOutstanding) as LoanOutstanding,
	Case When CLS.DeathPerson=0 Then 'Actual Arrear' When CLS.DeathPerson=1 Then 'Client Death' When CLS.DeathPerson=2 Then 'Husband Death' End as [Arrear/PAR/Default Type],
	MANA.PrincipalInstallmentAmt,MANA.PrincipalCollected,MANA.InterestInstallmentAmt,MANA.InterestCollected,
	(MANA.PrincipalInArrears+MANA.InterestInArrears) as [Arrear/PAR Amount],
	NULL as Remark,SUBSTRING(MANA.ClientLoanID,16,2) as ProductID,Cls.DeathEntryDate,cls.principaloutstanding,
	case 
		when c.CenterMeetingDay = '1' then 'Monday'
		when c.CenterMeetingDay = '2' then 'Tuesday'
		when c.CenterMeetingDay = '3' then 'Wednessday'
		when c.CenterMeetingDay = '4' then 'Thursday'
		when c.CenterMeetingDay = '5' then 'Friday'
		when c.CenterMeetingDay = '6' then 'Saturday'	
	end as CenterMeetindDay,	c.StaffID as [CM ID handled the Center], 
(select f.StaffName from FieldStaff f with(nolock) where f.StaffID = c.StaffID) as [CM Name handled the Center]
from 
	ClientLoanSubscription as CLS 
		inner join	MasterActivity..NewRisk as MANA		ON CLS.LoanProposalID			=	MANA.LoanProposalID
		inner join	Centers c with(nolock)				ON c.CenterID					=	CLS.CenterID
		inner join	branches b							ON left(cls.clientloanid,5)		=	b.branchid
		and			CLS.ActualPaidUpDate is null	and MANA.TransactionDate  between '2025-02-10' and '2025-04-02' 
		and			b.Zone = 'Ballia Zone'			and b.RegionID = '10'
order by MANA.BranchID,MANA.ClientLoanID



----Monthly Defaulter==

SELECT
	branches.Zone,	Branches.districtname as Region,	Branches.BranchID,	Branches.BranchName,	branches.AMID as [ARO ID],
	(select fs.staffname from FieldStaff fs with(nolock) where fs.StaffID = Branches.AmID) as [ARO Name],	Clients.ClientID,
	ClientLoanSubscription.ClientLoanID,	Targets.TargetName as TargetName,	ClientLoanSubscription.LoanAmountDisbursed as DisbursedAmount,Targets.HusbandName,
	(select LoanDescription from ClientLoanProposal clp with(nolock) where clp.LoanProposalID = ClientLoanSubscription.LoanProposalID) as LoanPurpose, 
	ClientLoanSubscription.DisbursementDate,ClientLoanSubscription.ActualPaidUpDate, ClientLoanSubscription.LoanAmountDisbursed,
	(ClientLoanSubscription.PrincipalOutstanding + ClientLoanSubscription.InterestOutstanding) as LoanOutstanding,
	Case When ClientLoanSubscription.DeathPerson=0 Then 'Actual Arrear' When ClientLoanSubscription.DeathPerson=1 Then 'Client Death' When ClientLoanSubscription.DeathPerson=2 Then 'Husband Death' End as [Arrear/PAR/Default Type],
	(ClientLoanSubscription.PrincipalInArrears + ClientLoanSubscription.InterestInArrears) as [Arrear/PAR Amount], ClientLoanSubscription.NumInstallmentsInArrears, ClientLoanSubscription.CurrentInstallmentPeriod, 
	ClientLoanSubscription.DeathDate,ClientLoanSubscription.principaloutstanding,
	case 
		when Centers.CenterMeetingDay = '1' then 'Monday'
		when Centers.CenterMeetingDay = '2' then 'Tuesday'
		when Centers.CenterMeetingDay = '3' then 'Wednessday'
		when Centers.CenterMeetingDay = '4' then 'Thursday'
		when Centers.CenterMeetingDay = '5' then 'Friday'
		when Centers.CenterMeetingDay = '6' then 'Saturday'	
	end as CenterMeetindDay,	Centers.StaffID as [CM ID handled the Center], 
	(select f.StaffName from FieldStaff f with(nolock) where f.StaffID = Centers.StaffID) as [CM Name handled the Center]
FROM         
	Centers 
		INNER JOIN	Branches				ON	Centers.BranchID					=	Branches.BranchID 
		INNER JOIN	Groups					ON	Centers.CenterID					=	Groups.CenterID 
		INNER JOIN	Clients					ON	Groups.GroupID						=	Clients.GroupID 
		INNER JOIN	Targets					ON	Clients.TargetID					=	Targets.TargetID 
		INNER JOIN	ClientLoanProposal		ON	Clients.ClientID					=	ClientLoanProposal.ClientID 
		INNER JOIN	ClientLoanSubscription	ON	ClientLoanProposal.LoanProposalID	=	ClientLoanSubscription.LoanProposalID

WHERE     
	(ClientLoanSubscription.ActualPaidUpDate IS NULL) AND (ClientLoanSubscription.PrincipalOutstanding > 0) AND 
	(ClientLoanSubscription.CurrentInstallmentPeriod > ClientLoanSubscription.LoanDurationInWeeks)  
	and		expectedpaidupdate  between '2025-02-10' and '2025-04-02' 
	and		Branches.Zone = 'Deogarh Zone' and Branches.RegionID = '28'
