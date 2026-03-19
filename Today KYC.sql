----Today KYC

DECLARE @TargetDate DATE = '2025-07-19'; 
WITH KYC_Data AS (
    SELECT 
        StaffID,
        LEFT(ClientID, 5) AS BranchID,
        COUNT(*) AS Total_Scan,
        SUM(CASE WHEN LEN(ClientID) = 8 THEN 1 ELSE 0 END) AS Adding_Client,
        SUM(CASE WHEN LEN(ClientID) > 8 THEN 1 ELSE 0 END) AS Old_Client
    FROM KYC
    WHERE CAST(DateStamp AS DATE) = @TargetDate
    GROUP BY StaffID, LEFT(ClientID, 5)
),

CBR_Data AS (
    SELECT 
        k.StaffID,
        SUM(CASE WHEN LEFT(c.CBRRemark, 2) = 'OK' THEN 1 ELSE 0 END) AS CBR_OK,
        SUM(CASE WHEN LEFT(c.CBRRemark, 2) = 'BA' THEN 1 ELSE 0 END) AS CBR_BAN
    FROM CCRMFISUMMARY c
    INNER JOIN KYC k ON k.TrnLoanID = c.CustRefField
    WHERE 
        c.BorrowerType = 'Client'
        AND CAST(k.DateStamp AS DATE) = @TargetDate
    GROUP BY k.StaffID
)

SELECT 
    b.DistrictName AS RegionName,
    f.BranchID,
    UPPER(b.BranchName) AS BranchName,
    CONCAT(f.StaffID, ' / ', UPPER(f.StaffName)) AS StaffName,
    d.DesignationName,
    ISNULL(k.Total_Scan, 0) AS Total_Scan,
    ISNULL(k.Adding_Client, 0) AS Adding_Client,
    ISNULL(k.Old_Client, 0) AS Old_Client,
    ISNULL(c.CBR_OK, 0) AS CBR_OK,
    ISNULL(c.CBR_BAN, 0) AS CBR_BAN,
 
    ISNULL(k.Total_Scan, 0) - (ISNULL(c.CBR_OK, 0) + ISNULL(c.CBR_BAN, 0)) AS Remaining_Scan
FROM FieldStaff f
INNER JOIN DesignationMaster d ON d.DesignationID = f.Designation
INNER JOIN Branches b ON b.BranchID = f.BranchID
LEFT JOIN KYC_Data k ON k.StaffID = f.StaffID AND k.BranchID = LEFT(f.BranchID, 5)
LEFT JOIN CBR_Data c ON c.StaffID = f.StaffID
WHERE 
    LEFT(f.BranchID, 2) IN ('10')
    AND f.Designation IN ('12', '13', '14', '15', '46', '47')
    AND f.ExitDate IS NULL
ORDER BY 
    b.DistrictName DESC,
    LEFT(f.BranchID, 5);
