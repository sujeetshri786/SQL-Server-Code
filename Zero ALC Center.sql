---------------------Zero alc wala center Local--------------------------
select BranchID,CenterID,CenterName,FormationDate from Centers where DissolvedDate is null and left(CenterID,2) in ('14')
and CenterID not in (select LEFT(clientloanid,8) from ClientLoanSubscription where ActualPaidUpDate is null) order by CenterID


--Sourabh SIr
select BranchId,CenterId,CenterName,Formationdate from centers with(nolock) where dissolveddate is null and RegionID in ('14') and centerid not in(
select distinct left(clientloanid,8) from clientloansubscription with(nolock) where actualpaidupdate is null)
order by centerid
