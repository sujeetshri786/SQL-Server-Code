----PENDING BRANCH REPORT/AFTER CLOSING DETAIL

Select b.DistrictName ReginName, UPPER(b.CHNAME) as ChibName,CONCAT(c.BranchId, '  /  ',UPPER(c.BranchName) )as BranchName ,'PENDING BRANCH REPORT' as ClosingStatus 
 from [43.242.214.235].appcashpor.dbo.DailyClosingDtl c inner join Branches b on b.BranchId=c.BranchId
Where c.Send='0' and Left(c.BranchID,2)  IN  ('22','21','10')
Order by b.DistrictName, b.CHNAME,c.BranchId


--CLOSING RATIO

SELECT 
    b.DistrictName AS RegionName,
    COUNT(b.Regionid) AS NumBranch,

   
    (SELECT COUNT(DISTINCT d.BranchId) 
     FROM [43.242.214.235].appcashpor.dbo.DailyClosingDtl d 
     WHERE d.send = '1' AND LEFT(d.BranchID, 2) = b.Regionid
    ) AS ReportDone,

  
    (COUNT(b.Regionid) - 
     (SELECT COUNT(DISTINCT d.BranchId) 
      FROM [43.242.214.235].appcashpor.dbo.DailyClosingDtl d 
      WHERE d.send = '1' AND LEFT(d.BranchID, 2) = b.Regionid)
    ) AS PendingReport,

  
    CAST(
        (SELECT COUNT(DISTINCT d.BranchId) 
         FROM [43.242.214.235].appcashpor.dbo.DailyClosingDtl d 
         WHERE d.send = '1' AND LEFT(d.BranchID, 2) = b.Regionid
        ) * 100 / COUNT(b.Regionid) 
    AS VARCHAR) + '%' AS ClosingRatio,

    '' AS Remarks

FROM 
    [43.242.214.235].appcashpor.dbo.Branches b 
WHERE 
    b.Dissolveddate IS NULL 
    AND b.Regionid IN ('10', '21', '22')
GROUP BY 
    b.DistrictName, b.Regionid
ORDER BY 
    b.DistrictName;

=================================================

------AFTER CLOSING DETAIL


SELECT 
    CASE 
        WHEN LEFT(BranchId, 2) = '10' THEN 'SARAN'
        WHEN LEFT(BranchId, 2) = '22' THEN 'EAST CHAMPARAN'
        WHEN LEFT(BranchId, 2) = '21' THEN 'MUZAFFARPUR'
    END AS RegionName,
    BranchId,
    UPPER(BranchName) AS BranchName,
    FORMAT(DateStamp, 'dd-MM-yyyy') AS ClosingDate,
    FORMAT(DateStamp, 'hh:mm:ss tt') AS ClosingTime
FROM [43.242.214.235].appcashpor.dbo.DailyClosingDtl
WHERE Send = '1'
  AND LEFT(BranchID, 2) IN ('10', '21', '22')
ORDER BY LEFT(BranchId, 2), DateStamp DESC;
