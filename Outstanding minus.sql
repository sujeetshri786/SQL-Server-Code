--Staff Performance

select fs.BranchID,br.BranchName,bfs.StaffID,fs.StaffName,bfs.ReportingDate,bfs.NumCentersManaged,bfs.NumLoanClients,bfs.TotalOutstanding from BackDateRptFieldStaff bfs with(nolock) 
inner join FieldStaff as fs on fs.StaffID=bfs.StaffID
inner join Branches as br on br.BranchID=fs.BranchID
where bfs.ReportingDate='2023-04-20' and bfs.NumCentersManaged>0
order by br.branchid,bfs.StaffID asc
