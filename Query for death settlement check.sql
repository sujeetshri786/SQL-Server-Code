----------Query for death settlement check

DECLARE @regionid VARCHAR(10) = '22';

WITH base_ledger AS (
    SELECT *
    FROM loanledger
    WHERE regionid = @regionid
),
prev AS (
    SELECT 
        branchid,
        SUM(clientloan1totalcollected) AS prev_total
    FROM prevcds2
    WHERE clientid LIKE @regionid + '%'
    GROUP BY branchid
),
ledger AS (
    SELECT 
        branchid,
        SUM(principalcollected + interestcollected) AS ledger_total
    FROM base_ledger
    WHERE CAST(weeklytransactiondate AS date) = CAST(GETDATE() AS date)
    GROUP BY branchid
),
death AS (
    SELECT 
        branchid,
        SUM(principalcollected + interestcollected) AS deathsettle_amount
    FROM base_ledger
    WHERE staffid = '0000'
      AND CAST(weeklytransactiondate AS date) = CAST(GETDATE() AS date)
    GROUP BY branchid
)

SELECT 
    COALESCE(p.branchid, l.branchid) AS branchid,
    p.prev_total,
    l.ledger_total,
    d.deathsettle_amount,
    (l.ledger_total - p.prev_total) AS difference
FROM prev p
FULL OUTER JOIN ledger l ON p.branchid = l.branchid
LEFT JOIN death d ON COALESCE(p.branchid, l.branchid) = d.branchid
WHERE l.ledger_total > COALESCE(p.prev_total, 0);
