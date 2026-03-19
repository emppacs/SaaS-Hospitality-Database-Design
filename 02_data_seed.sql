-----------------------------------------
--- INSERTS ---- PARENT TABLES FIRST-----
-----------------------------------------

--(21-30)
-- select * from country 
INSERT INTO country (country_name)
VALUES  ('Singapore'),
        ('Malaysia'),
        ('Indonesia'),
        ('Philippines'),
        ('Fiji'),
        ('Algeria'),
        ('Egypt'),
        ('Saudi Arabia'),
        ('USA'),
        ('Canada');
        
-- (7-9)        
-- select * from region
INSERT INTO region (region_name, description)
VALUES  ('APAC','East/Southeast/South/West Asia, and Oceania'),
        ('EMEA','Europe, Middle East, and Africa'),
        ('AMER','North America, Central America, South America');

-- select * from address
INSERT INTO address (country_id, street, city, postal_code)
VALUES  (1, '2 Temasek Blvd', 'Singapore', '038982'),
        (2, '9/9 Moo 3, Bophut', 'Koh Samui', '84320'),
        (3, 'Waigani Drive', 'Port Moresby', '121'),
        (4, 'Namaka, Nadi', 'Nadi', '0000'),
        (5, '75 Jalan Bukit Gambir', 'Penang', '10050'),
        (6, '4 Rue Didouche Mourad', 'Algiers', '16000'),
        (7, '1 Ahmed Ragheb Street', 'Cairo', '11511'),
        (8, 'Citystars Heliopolis', 'Cairo', '11361'),
        (9, 'Al Salam District', 'Jeddah', '21432'),
        (10, '371 East Coast Road', 'Singapore', '459121');

(--start 16)
-- select * from client
INSERT INTO client (client_name, region_id, address_id, email)
VALUES  ('Conrad Centennial Singapore', 1, 1, 'conrad@conrad.com'),
        ('Hilton Koh Samui', 2, 2, 'samui@hilton.com'),
        ('Hilton Port Moresby', 3, 3, 'moresby@hilton.com'),
        ('Hilton Fiji Beach Resort', 1, 4, 'fiji@hilton.com'),
        ('Hilton Penang', 1, 5, 'penang@hilton.com'),
        ('Hilton Algiers', 2, 6, 'algiers@hilton.com'),
        ('Hilton Cairo Heliopolis', 2, 7, 'cairo@hilton.com'),
        ('Hilton Jeddah', 2, 8, 'jeddah@hilton.com'),
        ('Hilton Cleveland Downtown', 3, 9, 'clevelandd@hilton.com'),
        ('Hilton Chicago', 3, 10, 'chicago@hilton.com');

--(11-15)
-- SELECT * FROM contract_status
INSERT INTO contract_status (contract_status_name)
VALUES  ('Active'),('Expired'),('Terminated'),('Renewal'),('Pending');

(--7-10)
-- SELECT * FROM subscription_status
INSERT INTO subscription_status (subscription_status_name)      
VALUES  ('Active'),('Cancelled'),('Trial');

(--start 7-9)
-- select * from billing_status
INSERT INTO billing_status (billing_status_name)
VALUES  ('Paid'),('Pending'),('Overdue');

(--start 11-15_)
-- select * from ticket_status
INSERT INTO ticket_status (ticket_status_name)
VALUES  ('Open'),('In Progress'),('Closed'),('On Hold'),('Escalated');        

(--7-9 )
-- select * from contract_type
INSERT INTO contract_type (contract_type_name)  
VALUES  ('Standard'),('Premium'),('Enterprise');

(--9-12)
-- select * from ticket_category
INSERT INTO ticket_category (ticket_category_name)
VALUES  ('Account Issue'),('Workflow Issue'),('Development'),('Login Issue');

--(11-15)
-- select * from support_engineer
INSERT INTO support_engineer (first_name, last_name, email, region_id)
VALUES  ('Luneil', 'Bayawa', 'lb@docmx.com', 1),
        ('Ben', 'Beh', 'bbeh@docmx.com', 1),
        ('Fitri', 'Mohd', 'dfmohd@docmx.com', 1),
        ('Ellen', 'Pacquiao', 'epacs@docmx.com', 2),
        ('Billy', 'Mooney', 'bmoon@docmx.com', 3);

-----------------------------------------
--- INSERTS ---- CHILD TABLES -----
-----------------------------------------

-- select * from contract
INSERT INTO contract (client_id, end_date, signed_date, start_date, contract_status_id, contract_type_id)
VALUES  (1, '2026-12-31', '2024-01-01', '2025-01-01', 1, 1),
        (2, '2025-11-30', '2024-02-01', '2025-02-01', 1, 1),
        (3, '2026-03-31', '2024-03-01', '2025-03-01', 1, 1),
        (4, '2026-01-14', '2024-01-15', '2025-01-15', 1, 2),
        (5, '2025-12-31', '2024-04-01', '2025-04-01', 2, 3),
        (6, '2026-06-30', '2024-05-01', '2025-05-01', 2, 2),
        (7, '2025-09-30', '2024-06-01', '2025-06-01', 3, 3),
        (8, '2026-08-31', '2024-07-01', '2025-07-01', 4, 1),
        (9, '2025-10-31', '2024-08-01', '2025-08-01', 5, 2),
        (10, '2026-11-30', '2024-09-01', '2025-09-01', 1, 1);

(--start 4)
-- select * from subscription
INSERT INTO subscription (contract_id, start_date, end_date, subscription_status_id)
VALUES  (1, '2025-01-01', '2026-12-31', 1),
        (2, '2025-02-01', '2025-11-30', 1),
        (3, '2025-03-01', '2026-03-31', 1),
        (4, '2025-01-15', '2026-01-14', 1),
        (5, '2025-04-01', '2025-12-31', 2),
        (6, '2025-05-01', '2026-06-30', 2),
        (7, '2025-06-01', '2025-09-30', 3),
        (8, '2025-07-01', '2026-08-31', 3),
        (9, '2025-08-01', '2025-10-31', 3),
        (10, '2025-09-01', '2026-11-30', 1);


-- select * from billing
INSERT INTO billing (client_id, subscription_id, invoice_date, amount, billing_status_id)
VALUES  (1, 1, '2025-01-05', 5000.00, 1),
        (2, 2, '2025-02-05', 3000.00, 1),
        (3, 3, '2025-03-05', 4500.00, 1),
        (4, 4, '2025-01-20', 6000.00, 1),
        (5, 5, '2025-04-05', 3500.00, 2),
        (6, 6, '2025-05-05', 4000.00, 2),
        (7, 7, '2025-06-05', 5500.00, 1),
        (8, 8, '2025-07-05', 7000.00, 3),
        (9, 9, '2025-08-05', 6500.00, 3),
        (10, 10, '2025-09-05', 8000.00, 1);


(--start 2)
-- select * from app_user
INSERT INTO app_user (client_id, first_name, last_name, last_update)
VALUES  (1, 'Alice', 'Wong', CURRENT_TIMESTAMP),
        (2, 'Bob', 'Tan', CURRENT_TIMESTAMP),
        (3, 'Charlie', 'Lim', CURRENT_TIMESTAMP),
        (4, 'Diana', 'Lee', CURRENT_TIMESTAMP),
        (5, 'Ethan', 'Ng', CURRENT_TIMESTAMP),
        (6, 'Fiona', 'Goh', CURRENT_TIMESTAMP),
        (7, 'George', 'Chua', CURRENT_TIMESTAMP),
        (8, 'Hannah', 'Koh', CURRENT_TIMESTAMP),
        (9, 'Ian', 'Liew', CURRENT_TIMESTAMP),
        (10, 'Jasmine', 'Yeo', CURRENT_TIMESTAMP),
        (1, 'Kevin', 'Sim', CURRENT_TIMESTAMP),
        (2, 'Lara', 'Ong', CURRENT_TIMESTAMP),
        (3, 'Mike', 'Foo', CURRENT_TIMESTAMP),
        (4, 'Nina', 'Quek', CURRENT_TIMESTAMP),
        (5, 'Oscar', 'Tan', CURRENT_TIMESTAMP);


-- select * from ticket_category
--(start 4)
-- select * from support_ticket
INSERT INTO support_ticket (user_id, engineer_id, ticket_status_id, ticket_category_id, issue_description, created_date, closed_date)
VALUES  (1, 1, 1, 4, 'Unable to login to the system', '2025-01-10', NULL),
        (2, 1, 1, 1, 'Incorrect username', '2025-02-12', NULL),
        (3, 1, 1, 2, 'Workflow automation not functioning', '2025-03-15', '2025-03-20'),
        (4, 1, 1, 3, 'Request for new feature development', '2025-01-25', NULL),
        (5, 1, 1, 1, 'Account access issue', '2025-04-10', NULL),
        (6, 2, 2, 1, 'Incorrect job roles added', '2025-05-05', NULL),
        (7, 2, 2, 1, 'User was assigned to wrong hotel/entity', '2025-06-07', '2025-06-12'),
        (8, 2, 1, 4, 'Login page not loading', '2025-07-09', NULL),
        (9, 3, 4, 2, 'Request to change workflow', '2025-08-11', NULL),
        (10, 3, 3, 2, 'Workflow rules not applying', '2025-09-13', NULL),
        (11, 3, 4, 3, 'Need development for custom report', '2025-10-15', '2025-10-20'),
        (12, 4, 4, 1, 'Cannot access account settings', '2025-11-17', NULL),
        (13, 5, 3, 1, 'Password reset not working', '2025-12-19', NULL),
        (14, 5, 2, 2, 'Issue with workflow notifications', '2025-02-21', '2025-02-26'),
        (15, 5, 2, 3, 'Development of mobile app feature', '2025-03-23', NULL);