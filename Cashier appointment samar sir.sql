---------------------Cashier appointment detail 

SELECT b.DistrictName As Regionname,
    b.BranchID,
    b.BranchName,
    c.staffid,
    fs1.StaffName AS CashierName,
    c.Collection_date,
    c.Createddate,
    isnull(c.verifyby,0) as VerifybyCHIBID,
    isnull(fs2.StaffName,0) AS VerifiedByCHIBName,
    c.verifydate
FROM [43.242.214.235].appcashpor.dbo.CashCollector c
LEFT JOIN Branches b 
    ON b.BranchID = c.branch_id
LEFT JOIN FieldStaff fs1
    ON c.staffid = fs1.StaffID
LEFT JOIN FieldStaff fs2
    ON c.verifyby = fs2.StaffID
WHERE 
    c.collection_date = '2025-03-20'  and c.Branch_ID like '16%'
                order by b.branchid

-------------------------------------Cashier Not Appointment
  
                ;WITH LatestStaff AS
(
    SELECT 
        f.StaffID,
        f.StaffName,
        f.BranchID,
        f.ExitDate,
        f.Designation,
        f.BranchJoinDate,
        ROW_NUMBER() OVER (
            PARTITION BY f.BranchID 
            ORDER BY f.BranchJoinDate DESC
        ) AS rn
    FROM FieldStaff f WITH (NOLOCK)
    WHERE f.ExitDate IS NULL
      AND f.Designation = '16'
)
SELECT 
    b.Zone,
    b.DistrictName AS RegionName,
    b.BranchID,
    b.BranchName,
    f.StaffID BMID,
    f.StaffName BMNAME
FROM branches b WITH (NOLOCK)
INNER JOIN LatestStaff f 
        ON b.BranchID = f.BranchID 
       AND f.rn = 1
WHERE b.DissolvedDate IS NULL
  AND b.BranchID NOT IN (
        SELECT c.branch_id
        FROM [43.242.214.235].appcashpor.dbo.CashCollector c
        WHERE c.Collection_date = '2026-03-20'
  )
ORDER BY 
    b.Zone,
    b.DistrictName;

-----------------------

--Select * from [43.242.214.235].appcashpor.dbo.CashCollector where left(branch_id,2) in ('05','14','16')  and Collection_date>='2025-12-03'

----or

SELECT b.BranchID,b.BranchName,cc.StaffID,fs.StaffName,cc.Collection_Date,cc.CreatedBY,s.StaffName CreatedByName,cc.CreatedDate
FROM [43.242.214.235].appcashpor.dbo.CashCollector cc
inner join Branches as b on b.BranchId=cc.Branch_ID
inner join FieldStaff as fs on fs.StaffId=cc.StaffID
inner join FieldStaff as s on s.StaffId=cc.CreatedBy
WHERE LEFT(cc.Branch_ID, 2) IN ('05', '14', '16')
AND cc.Collection_date = '2026-03-20'


----Shubhendra
 ;WITH LatestStaff AS
(
    SELECT         f.StaffID, f.StaffName,  f.BranchID, f.ExitDate,  f.Designation, f.BranchJoinDate,
        ROW_NUMBER() OVER ( PARTITION BY f.BranchID  ORDER BY f.BranchJoinDate DESC) AS rn
    FROM FieldStaff f WITH (NOLOCK)
    WHERE f.ExitDate IS NULL AND f.Designation = '16'
)
SELECT 
    b.Zone, b.DistrictName AS RegionName, b.BranchID, b.BranchName, f.StaffID BMID,f.StaffName BMNAME
FROM branches b WITH (NOLOCK)
INNER JOIN LatestStaff f  ON b.BranchID = f.BranchID and left(b.branchid,2) in ( '05','14','16')  AND f.rn = 1
WHERE b.DissolvedDate IS NULL AND b.BranchID NOT IN ( SELECT c.branch_id
        FROM [43.242.214.235].appcashpor.dbo.CashCollector c
        WHERE c.Collection_date = '2026-03-20' and left(c.branch_id,2) in ( '05','14','16')
  )
ORDER BY     b.Zone,    b.DistrictName;