-- =====================================================================
-- STEP 1: CREATE THE STRUCTURE 
-- =====================================================================
CREATE TABLE iso20022_payment_pipeline (
    uetr VARCHAR(50),              -- Unique End-to-End Transaction Reference
    message_type VARCHAR(10),       -- pacs.008, pacs.009, etc.
    debtor_name VARCHAR(100),       -- <Dbtr><Nm> Sender
    creditor_name VARCHAR(100),     -- <Cdtr><Nm> Receiver
    settlement_amt_usd DECIMAL(15,2),-- <IntrBkSttlmAmt> Amount
    sanctions_screening_flag VARCHAR(20), -- PASS, FALSE_POSITIVE, CRITICAL_ALERT
    pipeline_status VARCHAR(20)     -- Cleared, Investigating, Frozen
);

-- =====================================================================
-- STEP 2: ADDING DATA 
-- =====================================================================
INSERT INTO iso20022_payment_pipeline 
    (uetr, message_type, debtor_name, creditor_name, settlement_amt_usd, sanctions_screening_flag, pipeline_status)
VALUES 
    ('uetr-9876-abc', 'pacs.008', 'Aishwarya Sivakumar', 'Global Tech Corp', 15000.00, 'PASS', 'Cleared'),
    ('uetr-1122-xyz', 'pacs.008', 'A. Khan (Syria Resid.)', 'Al-Mada Logistics', 450000.00, 'CRITICAL_ALERT', 'Frozen'),
    ('uetr-4455-def', 'pacs.008', 'M. Al-Suri', 'Standard Euro Imports', 12000.00, 'CRITICAL_ALERT', 'Investigating'),
    ('uetr-7788-ghi', 'pacs.009', 'Apex Bank London', 'JPMorgan Chase NY', 5000000.00, 'PASS', 'Cleared'),
    ('uetr-3322-klm', 'pacs.008', 'Sarah Smith', 'Z-Corp Dubai', 1250000.00, 'FALSE_POSITIVE', 'Cleared'),
    ('uetr-5566-pqr', 'pacs.008', 'A. Khan (Mumbai Resid.)', 'Tech Parts India', 8500.00, 'FALSE_POSITIVE', 'Cleared'),
    ('uetr-9900-tuv', 'pacs.008', 'Unknown Entity LLC', 'Offshore Holdings', 950000.00, 'CRITICAL_ALERT', 'Investigating');

-- =====================================================================
-- STEP 3: RUNNING THE PAYMENT MONITORING ENGINE
-- =====================================================================
SELECT 
    message_type,
    COUNT(uetr) AS total_messages_processed,
    SUM(settlement_amt_usd) AS total_value_transferred_usd,
    -- Tracks the absolute maximum financial exposure stuck in investigation
    SUM(CASE WHEN pipeline_status IN ('Frozen', 'Investigating') THEN settlement_amt_usd ELSE 0 END) AS value_at_compliance_risk,
    -- Dynamically flags if the message queue requires high-priority intervention
    MAX(CASE WHEN sanctions_screening_flag = 'CRITICAL_ALERT' THEN 'IMMEDIATE 2LoD ESCALATION' ELSE 'Queue Normal' END) AS risk_operational_status
FROM 
    iso20022_payment_pipeline
GROUP BY 
    message_type
HAVING 
    SUM(CASE WHEN pipeline_status IN ('Frozen', 'Investigating') THEN settlement_amt_usd ELSE 0 END) > 10000
ORDER BY 
    value_at_compliance_risk DESC;