-----------------------------------------
--- UPDATE ------------------------------
-----------------------------------------
UPDATE client
SET email = 'centennial@hilton.com'
WHERE client_id = 1;
-- select * from client
-----------------------------------------
--- DELETE ------------------------------
-----------------------------------------
-- DELETE FROM support_ticket
-- WHERE ticket_id = 15


-----------------------------------------
--- SIMPLE SELECT -----------------------
-----------------------------------------
SELECT client_id, client_name, email
FROM client;


-----------------------------------------
------- Aggregation / Grouping ----------
---- Total Billing amount per client ----
-----------------------------------------
SELECT c.client_name, SUM(b.amount) AS total_billed
FROM client c
JOIN billing b ON c.client_id = b.client_id
GROUP BY c.client_name;


--------------------------------------------------
----- One-to-Many JOIN: Contracts per client -----
--------------------------------------------------
SELECT c.client_name, ct.contract_type_name, co.start_date, co.end_date
FROM client c
JOIN contract co ON c.client_id = co.client_id
JOIN contract_type ct ON co.contract_type_id = ct.contract_type_id
ORDER BY c.client_name;


---------------------------------------------------
-- Many-to-Many JOIN: Clients handled by support engineers via tickets
---------------------------------------------------
SELECT DISTINCT c.client_name, CONCAT(se.first_name,' ',se.last_name) AS engineer_name
FROM client c
JOIN app_user au ON c.client_id = au.client_id
JOIN support_ticket st ON au.user_id = st.user_id
JOIN support_engineer se ON st.engineer_id = se.engineer_id
ORDER BY c.client_name;


---------------------------------------------------
-- Recursive JOIN: Supervisors and their subordinates
---------------------------------------------------
SELECT CONCAT(u1.first_name, ' ', u1.last_name) AS subordinate,
       CONCAT(u2.first_name, ' ', u2.last_name) AS supervisor
FROM app_user u1
LEFT JOIN app_user u2 ON u1.supervisor_id = u2.user_id
ORDER BY subordinate;


---------------------------------------------------
---------- Sorting: Top 5 invoices by amount ------
---------------------------------------------------
SELECT b.invoice_id, c.client_name, b.amount
FROM billing b
JOIN client c ON b.client_id = c.client_id
ORDER BY b.amount DESC
LIMIT 5;


---------------------------------------------------
---- Column aliasing: Rename subscription dates ---
---------------------------------------------------
SELECT s.subscription_id AS sub_id,
       s.start_date AS start,
       s.end_date AS end
FROM subscription s;


---------------------------------------------------
-- Table aliasing: Tickets with category names using aliases
---------------------------------------------------
SELECT st.ticket_id AS ticket,
       tc.ticket_category_name AS category,
       st.issue_description AS issue
FROM support_ticket st
JOIN ticket_category tc ON st.ticket_category_id = tc.ticket_category_id;