----Same Day Adding,KYC,Proposal Entry,Proposal Review Query

DECLARE @ReportDate DATE = '2025-12-17';

SELECT  
    b.zone ZONE,  
    b.districtname REGION, 
    b.chid CHID,  
    b.chname CHNAME, 
    b.branchid BRANCHID,
    b.branchname BRANCHNAME, 
    ISNULL(c.adding_count, 0) AS ADDING_Report,
    ISNULL(p.proposal_count, 0) AS Proposal_Count,
    ISNULL(p.proposal_amount, 0) AS Proposal_Amount,
	ISNULL(clp.ProposalReview_Count, 0) AS Proposal_Review_Count,
	ISNULL(clp.ProposalReview_Amount, 0) AS Proposal_Review_Amount,
    ISNULL(k.kyc_count, 0) AS KYC
FROM branches b WITH (NOLOCK)

 
LEFT JOIN (
    SELECT 
        LEFT(clientid, 5) AS branchid, 
        COUNT(clientid) AS adding_count
    FROM clients WITH (NOLOCK)
    WHERE CAST(Amgrtdate AS DATE) = @ReportDate
    GROUP BY LEFT(clientid, 5)
) c ON c.branchid = b.branchid

 
LEFT JOIN (
    SELECT 
        LEFT(clientid, 5) AS branchid, 
        COUNT(clientid) AS proposal_count,
        SUM(ClientRequestedAmount) AS proposal_amount
    FROM clientloanproposal WITH (NOLOCK)
    WHERE CAST(proposaldate AS DATE) = @ReportDate
    GROUP BY LEFT(clientid, 5)
) p ON p.branchid = b.branchid


LEFT JOIN (
    SELECT 
        LEFT(clientid, 5) AS branchid, 
        COUNT(clientid) AS ProposalReview_Count,
        SUM(LoanAmountApproved) AS ProposalReview_Amount
    FROM clientloanproposal WITH (NOLOCK)
    WHERE CAST(FinalReviewDate AS DATE) = @ReportDate
    GROUP BY LEFT(clientid, 5)
) clp ON clp.branchid = b.branchid

 
LEFT JOIN (
    SELECT 
        LEFT(centerid, 5) AS branchid, 
        COUNT(clientid) AS kyc_count
    FROM kyc WITH (NOLOCK)
    WHERE CAST(datestamp AS DATE) =@ReportDate
    GROUP BY LEFT(centerid, 5)
) k ON k.branchid = b.branchid

 
WHERE LEFT(b.branchid, 2) IN ('05','14','16') 
  AND b.chid <> '0' 
  AND b.dissolveddate IS NULL

ORDER BY b.zone, b.districtname, b.chid, b.branchid;
