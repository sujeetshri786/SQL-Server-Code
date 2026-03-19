select * from logfile With (NoLock) Where IniProcDate = '2022-03-27'

select distinct branchid from dicds1 With (NoLock) where meetingdate = '2022-03-27'

select distinct branchid from cds1 With (NoLock) where meetingdate = '2022-03-27'

select * from branches where dissolveddate is null