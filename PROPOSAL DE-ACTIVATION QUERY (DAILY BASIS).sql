--PROPOSAL DE-ACTIVATION QUERY (DAILY BASIS)

DECLARE @ToDate DATETIME = '2025-08-19';

SELECT
    b.DistrictName,
    CONCAT(LEFT(clp.ClientID, 5), ' / ', UPPER(b.BranchName)) AS BranchName,
    CONCAT(UPPER(f.StaffName), ' / ', clp.EntryBy) AS StaffId,
    DM.DesignationName,
    clp.ClientID,
    UPPER(t.TargetName) AS ClientName,
    CAST(clp.DeActivationflagdatestamp AS DATE) AS DeActivationflagDate,
    FORMAT(clp.DeActivationflagdatestamp, 'hh:mm tt') AS DeActivationflagTime,
    CAST(clp.DeActivationDate AS DATE) AS DeActivationDate,
    clp.LoanDeletionType  LoanDeletionType
FROM (
    SELECT *,
        ROW_NUMBER() OVER (
            PARTITION BY ClientID, CAST(DeActivationflagdatestamp AS DATE)
            ORDER BY DeActivationflagdatestamp DESC
        ) AS rn
    FROM ProposalDeactivation
    WHERE
        CAST(DeActivationflagdatestamp AS DATE) = @ToDate
        AND LEFT(ClientID, 2) IN ('10','21','22')
) clp
INNER JOIN FieldStaff f ON f.StaffId = clp.EntryBy
INNER JOIN Branches b ON b.BranchId = LEFT(clp.ClientID, 5)
INNER JOIN Clients c ON c.Clientid = clp.Clientid
INNER JOIN Targets t ON t.targetid = c.targetid
INNER JOIN DesignationMaster DM ON DM.DesignationId = f.Designation
WHERE clp.rn = 1
ORDER BY LEFT(clp.ClientID, 5), clp.ClientID;
