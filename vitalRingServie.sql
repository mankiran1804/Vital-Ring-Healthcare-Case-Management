                                               #DDL and SQL Queries for Vital Ring Service
CREATE TABLE Customer (
CustomerID varchar(20) NOT NULL,
FirstName varchar(100) NOT NULL,
LastName varchar (100) NOT NULL,
PhoneNumber varchar (50),
Email varchar (255),
DOB date,
PRIMARY KEY (CustomerID)
);

CREATE TABLE Address (
AddressID varchar(20) NOT NULL,
CustomerID varchar(20) NOT NULL,
Street varchar(255),
City varchar (100),
PostalCode varchar (20),
StateProvince varchar (100),
Country varchar (100),
PRIMARY KEY (AddressID),
FOREIGN KEY (CustomerID) REFERENCES Customer (CustomerID)
);

CREATE TABLE Product (
ProductID VARCHAR(20) PRIMARY KEY,
Name VARCHAR(50),
Description VARCHAR(500),
Type ENUM('ReturnKit', 'ChargerKit', 'RingProduct'),
Model VARCHAR(50),
Size VARCHAR(25)
);

CREATE TABLE VitalRingService.ServiceRequest(                                                                                                                                                                                                        
CaseID VARCHAR(20) PRIMARY KEY,                                                                                                                                                                                                        
   CustomerID VARCHAR(20) NOT NULL,                                                                                                                                                                                                        
ProductID VARCHAR(20) NOT NULL,                                                                                                                                                                                                        
Source VARCHAR(50) NOT NULL,                                                                                                                                                                                                        
AgentID VARCHAR(20) NOT NULL,                                                                                                                                                                                                        
Type ENUM('Problem','Request','Question','Complaint') NOT NULL,                                                                                                                                                                                                        
Reason VARCHAR(100) NOT NULL,                                                                                                                                                                                                        
Priority ENUM('Low','Medium', 'High') NOT NULL,                                                                                                                                                                                                        
Status ENUM('Open', 'In Progress', 'Closed', 'Cancelled', 'On-hold') NOT NULL,                                                                                                                                                                                                        
Description VARCHAR(2000),                                                                                                                                                                                                        
ProductType VARCHAR(20),                                                                                                                                                                                                        
OpenedDateTime TIMESTAMP NOT NULL,                                                                                                                                                                                                        
ClosedDateTime TIMESTAMP NOT NULL,                                                                                                                                                                                                        
CONSTRAINT Case_1_FK FOREIGN KEY (CustomerID) REFERENCES Customer (CustomerID),                                                                                                                                                                                                        
CONSTRAINT Case_2_FK FOREIGN KEY (ProductID) REFERENCES Product (ProductID),                                                                                                                                                                                                        
CONSTRAINT Case_3_FK FOREIGN KEY (AgentID) REFERENCES Agent (AgentID)                                                                                                                                                                                                        
); 

CREATE TABLE Agent (
AgentID varchar(20) NOT NULL,
FirstName varchar(100) NOT NULL,
LastName varchar(100) NOT NULL,
Email varchar (255),
PhoneNumber varchar (50),
HireDate date,
ManagerID varchar (20),
PRIMARY KEY (AgentID),
CONSTRAINT FOREIGN KEY (ManagerID) REFERENCES Agent (AgentID)
);

CREATE TABLE Feedback (
FeedbackID VARCHAR(20) PRIMARY KEY,
CaseID VARCHAR(20),
CustomerID VARCHAR(20),
SatisfactionScore INT ,
Comments VARCHAR(500),
FOREIGN KEY (CaseID) REFERENCES VitalRingService.ServiceRequest(CaseID),
FOREIGN KEY (CustomerID) REFERENCES Customer (CustomerID)
);                                                                                                                                                                                                

CREATE TABLE VitalRingService.ServiceOrder(
OrderID VARCHAR(20) PRIMARY KEY,
CustomerID VARCHAR(20),
AddressID VARCHAR(20),
CaseID VARCHAR(20),
OrderDate DATE NOT NULL,
Status  ENUM('Open','InProgress', 'Closed', ' Cancelled'),
FOREIGN KEY (CustomerID) REFERENCES Customer (CustomerID),
FOREIGN KEY (AddressID) REFERENCES Address (AddressID),
FOREIGN KEY (CaseID) REFERENCES VitalRingService.ServiceRequest(CaseID)
);

CREATE TABLE OrderLine (
OrderLineID VARCHAR(20) PRIMARY KEY,
OrderID VARCHAR(20),
ProductID VARCHAR(20),
Quantity INT,
UnitPrice DECIMAL(10, 2),
FOREIGN KEY (OrderID) REFERENCES VitalRingService.ServiceOrder(OrderID),
FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

CREATE TABLE CallLog (
CallLogID VARCHAR(20) PRIMARY KEY,
CaseID VARCHAR(20),
Comment VARCHAR(1000),
AgentID VARCHAR(20),
CallType VARCHAR(20),
CallDateTime TIMESTAMP NOT NULL,
FOREIGN KEY (CaseID) REFERENCES VitalRingService.ServiceRequest(CaseID),
FOREIGN KEY (AgentID) REFERENCES Agent(AgentID)
);

CREATE TABLE Article(
ArticleID VARCHAR(20) PRIMARY KEY,
Content VARCHAR(10000),
FirstPublishedDate Date NOT NULL,
LastPublishedDate Date NOT NULL,
Status ENUM('Active', 'Inactive')
);

CREATE TABLE CaseArticle(
CaseArticleID VARCHAR(20) PRIMARY KEY,
CaseID VARCHAR(20) NOT NULL,
ArticleID VARCHAR(20) NOT NULL,
CONSTRAINT CaseArticle_1_FK FOREIGN KEY (ArticleID) REFERENCES Article (ArticleID),
CONSTRAINT CaseArticle_2_FK FOREIGN KEY (CaseID) REFERENCES VitalRingService.ServiceRequest (CaseID)
);



									#Insert Statements 

INSERT INTO Customer (CustomerID,FirstName,LastName,PhoneNumber,Email,DOB) VALUES ('1','John','Doe','222-333-4444','john.doe@gmail.com','1974-01-01');
INSERT INTO Customer (CustomerID,FirstName,LastName,PhoneNumber,Email,DOB) VALUES ('10','Alex','Jackson','873-376-2345','alex.jackson@gmail.com','1956-03-17');
INSERT INTO Customer (CustomerID,FirstName,LastName,PhoneNumber,Email,DOB) VALUES ('2','Lisa','Stone','425-456-8971','lisa.stone@gmail.com','1987-03-18');
INSERT INTO Customer (CustomerID,FirstName,LastName,PhoneNumber,Email,DOB) VALUES ('3','Jack','Black','765-234-7685','jack.black@gmail.com','1968-08-13');
INSERT INTO Customer (CustomerID,FirstName,LastName,PhoneNumber,Email,DOB) VALUES ('4','James','Cook','234-456-8798','james.cook@gmail.com','1985-09-15');
INSERT INTO Customer (CustomerID,FirstName,LastName,PhoneNumber,Email,DOB) VALUES ('5','Jenna','Cook','234-546-8798','jenna.cook@gmail.com','1989-09-15');
INSERT INTO Customer (CustomerID,FirstName,LastName,PhoneNumber,Email,DOB) VALUES ('6','Tim','Johnson','678-456-7896','tim.johnson@gmail.com','1978-03-04');
INSERT INTO Customer (CustomerID,FirstName,LastName,PhoneNumber,Email,DOB) VALUES ('7','Maria','Chan','786-789-1234','maria.chan@gmail.com','2003-07-07');
INSERT INTO Customer (CustomerID,FirstName,LastName,PhoneNumber,Email,DOB) VALUES ('8','Sarah','Bee','678-980-1234','sarah.bee@gmail.com','1999-11-20');
INSERT INTO Customer (CustomerID,FirstName,LastName,PhoneNumber,Email,DOB) VALUES ('9','Drew','Bean','789-908-3782','drew.bean@gmail.com','2000-04-09');


INSERT INTO Address (AddressID, CustomerID, Street, City, PostalCode, StateProvince, Country) VALUES ('1','1','1799 Middleton St','Miami','33111','FL','USA');
INSERT INTO Address (AddressID, CustomerID, Street, City, PostalCode, StateProvince, Country) VALUES ('10','7','98 Activity Rd','Carmel','93921','CA','USA');
INSERT INTO Address (AddressID, CustomerID, Street, City, PostalCode, StateProvince, Country) VALUES ('11','7','157 17th St','New York','10003','NY','USA');
INSERT INTO Address (AddressID, CustomerID, Street, City, PostalCode, StateProvince, Country) VALUES ('12','7','7897 Willow Rd','Dallas','75032','TX','USA')
INSERT INTO Address (AddressID, CustomerID, Street, City, PostalCode, StateProvince, Country) VALUES ('13','8','46 First St','Atlanta','30302','GA','USA');
INSERT INTO Address (AddressID, CustomerID, Street, City, PostalCode, StateProvince, Country) VALUES ('14','9','8 Black Rd','Portland','97201','OR','USA')
INSERT INTO Address (AddressID, CustomerID, Street, City, PostalCode, StateProvince, Country) VALUES ('15','9','1090 Oak Ln','Austin','78613','TX','USA');
INSERT INTO Address (AddressID, CustomerID, Street, City, PostalCode, StateProvince, Country) VALUES ('16','10','9801 Terry Pl','Boseman','59718','MT','USA')
INSERT INTO Address (AddressID, CustomerID, Street, City, PostalCode, StateProvince, Country) VALUES ('17','10','10 Main St','Cleveland','44103','OH','USA')
INSERT INTO Address (AddressID, CustomerID, Street, City, PostalCode, StateProvince, Country) VALUES ('2','1','10 Block Ave','Chicago','60106','IL','USA');
INSERT INTO Address (AddressID, CustomerID, Street, City, PostalCode, StateProvince, Country) VALUES ('3','2','118 Hope Rd','Knoxville','37909','TN','USA');
INSERT INTO Address (AddressID, CustomerID, Street, City, PostalCode, StateProvince, Country) VALUES ('4','3','56 Cedar St','Flagstaff','86004','AZ','USA');
INSERT INTO Address (AddressID, CustomerID, Street, City, PostalCode, StateProvince, Country) VALUES ('5','4','123 Happy Ave','San Mateo','94022','CA','USA');
INSERT INTO Address (AddressID, CustomerID, Street, City, PostalCode, StateProvince, Country) VALUES ('6','5','123 Happy Ave','San Mateo','94022','CA','USA');
INSERT INTO Address (AddressID, CustomerID, Street, City, PostalCode, StateProvince, Country) VALUES ('7','6','1754 Memory Ln','Portland','04101','ME','USA');
INSERT INTO Address (AddressID, CustomerID, Street, City, PostalCode, StateProvince, Country) VALUES ('8','6','8346 Summer Ave','Boston','02110','MA','USA');
INSERT INTO Address (AddressID, CustomerID, Street, City, PostalCode, StateProvince, Country) VALUES ('9','6','56 Daisy Cir','Charleston','29403','SC','USA');

INSERT INTO Product (ProductID, Name, Description, Type, Model, Size)
VALUES (1, 'Charger Kit', 'Complete charging kit for ring','ChargerKit', 'CK100', 'One Size'),
(2, 'Regular Rings', 'Classic rings available in two colors and sizes', 'RingProduct', 'RR200', 'Size 1, Color: Silver'),
(3, 'Regular Rings', 'Classic rings available in two colors and sizes', 'RingProduct', 'RR201', 'Size 1, Color: Gold'),
(4, 'Regular Rings', 'Classic rings available in two colors and sizes', 'RingProduct', 'RR202', 'Size 2, Color: Silver'),
(5, 'Regular Rings', 'Classic rings available in two colors and sizes', 'RingProduct', 'RR203', 'Size 2, Color: Gold'),
(6, 'Return Kit', 'Kit for processing product returns', 'ReturnKit', 'RK300', 'One Size') ;

INSERT INTO VitalRingService.ServiceRequest (CaseID, CaseNumber, CustomerID, ProductID, Source, AgentID, Type, Reason, Priority, Status, Description, OpenedDateTime, ClosedDateTime)
VALUES ('CS500', '8978676', '1', '2', 'Call', '1', 'Question', 'Product usage', 'Low', 'In Progress', 'I have a question in connecting the ring product to the mobile app', '2023-01-23 12:45:56', '2023-02-23 01:45:56'),
('CS501', '8978677', '2', '2', 'Call', '1', 'Complaint', 'Product usage', 'High', 'Closed', 'Ring product is not measuing my activitiy and seeing an interruption in recording my daily activity', '2023-02-23 12:45:56', '2023-05-23 01:35:56'),
('CS502', '8978678', '3', '3', 'Call', '1', 'Request', 'Product usage', 'Medium', 'In Progress', 'I would like to talk to a person to discuss my issue', '2023-03-23 12:45:56', '2023-04-23 02:45:56'),
('CS503', '8978679', '4', '3', 'Call', '1', 'Question', 'Product usage', 'Low', 'In Progress', 'I have a question in enrolling to subscription', '2023-04-23 12:45:56', '2023-05-23 12:45:56'),
('CS504', '8978680', '5', '4', 'Call', '1', 'Request', 'Product usage', 'Low', 'Closed', 'Make the app easier in ordering your product on a periodic basis', '2023-05-23 12:45:56', '2023-08-23 01:35:56'),
('CS505', '8978681', '6', '4', 'Call', '1', 'Complaint', 'Product usage', 'High', 'In Progress', 'My finger gets black as I started wearing your ring product', '2023-06-23 12:45:56', '2023-08-23 5:45:56'),
('CS506', '8978682', '7', '5', 'Call', '1', 'Request', 'Product usage', 'Medium', 'In Progress', 'Request you offer ring in more sizes and colors', '2023-07-23 12:45:56', '2023-08-23 12:40:56'),
('CS507', '8978683', '8', '5', 'Call', '1', 'Problem', 'Product usage', 'Low', 'Closed', 'The signal in ring product is very intermittent and doesnt capture the data all the time', '2023-08-23 12:45:56', '2023-11-23 12:23:56'),
('CS508', '8978684', '9', '1', 'Call', '1', 'Problem', 'Product usage', 'Low', 'Cancelled', 'The battery usage is abnormal as the charge gets over very quickly', '2023-09-23 12:45:56', '2023-09-23 12:50:56'),
('CS510', '8978687', '2', '1', 'Call', '1', 'Question', 'Product usage', 'Low', 'In Progress', 'I have a question in connecting the ring product to the mobile app', '2023-01-23 12:45:56', '2023-01-23 12:45:56'),
('CS511', '8978688', '1', '1', 'Call', '1', 'Request', 'Improvements', 'Low', 'In Progress', 'I would like to have a feature to start tracking my diet properly', '2023-01-24 12:45:56',''),
('CS512', '8978689', '1', '1', 'Call', '1', 'Request', 'Improvements', 'Low', 'Closed', 'Is ther any referral program', '2023-01-26 12:45:56', ''),
('CS513', '8978690', '3', '1', 'Call', '1', 'Request', 'Improvements', 'Low', 'Closed', 'Is ther any referral program', '2023-01-26 12:45:56', ''),
('CS514', '8978691', '5', '4', 'Call', '1', 'Request', 'Improvements', 'Low', 'Closed', 'Is ther any referral program', '2023-01-26 12:45:56', ''),
('CS515', '8978692', '6', '4', 'Call', '1', 'Request', 'Improvements', 'Low', 'Closed', 'Is ther any referral program', '2023-01-26 12:45:56', '') ;

INSERT INTO Agent (AgentID, FirstName, LastName, Email, PhoneNumber, HireDate, ManagerID) VALUES ('1','Will','Smith','will.smith@gmail.com','897-343-0934','2022-03-08',NULL);
INSERT INTO Agent (AgentID, FirstName, LastName, Email, PhoneNumber, HireDate, ManagerID)  VALUES ('2','Marry','Wilson','marry.wilson@gmail.com','897-343-8912','2018-12-04',NULL);
INSERT INTO Agent (AgentID, FirstName, LastName, Email, PhoneNumber, HireDate, ManagerID) VALUES  ('3','Bob','Jackson','bob.jackson@gmail.com','897-343-6789','2020-01-02','2');
INSERT INTO Agent (AgentID, FirstName, LastName, Email, PhoneNumber, HireDate, ManagerID) VALUES  ('4','Tasha','Storm','tasha.storm@gmail.com','897-343-5793','2019-06-25','2');
INSERT INTO Agent (AgentID, FirstName, LastName, Email, PhoneNumber, HireDate, ManagerID) VALUES ('5','Simon','Lee','simon.lee@gmail.com','897-343-5780','2023-12-01','2');
INSERT INTO Agent (AgentID, FirstName, LastName, Email, PhoneNumber, HireDate, ManagerID) VALUES  ('6','Keela','Brown','keela.brown@gmail.com','897-343-2345','2022-08-01','1');
INSERT INTO Agent (AgentID, FirstName, LastName, Email, PhoneNumber, HireDate, ManagerID) VALUES  ('7','John','Snow','john.snow@gmail.com','897-343-7896','2023-02-20','1');
INSERT INTO Agent (AgentID, FirstName, LastName, Email, PhoneNumber, HireDate, ManagerID) VALUES  ('8','Olivia','Kim','olivia.kim@gmail.com','897-343-0098','2018-03-08','1');

INSERT INTO Feedback (FeedbackID, CaseID, CustomerID, SatisfactionScore, Comments)
VALUES
('1', 'CS500', '1', 3, 'Outstanding service, very impressed!'),
('2', 'CS501', '2', 2, 'Could improve response time.'),
('3', 'CS502', '3', 2, 'Service was okay, but could be better.'),
('4', 'CS503', '4', 4, 'Satisfied with the service, had a good experience.'),
('5', 'CS504', '5', 3, 'Had some issues, but they were resolved.')
('6', 'CS505', '6', 5, 'Very satisfied with the service.'),
('7', 'CS506', '7', 5, 'Great experience, will recommend!'),
('8', 'CS507', '8', 4, 'Support team was very understanding.'),
('9', 'CS508', '9', 5, 'Great experience, will recommend!'),
('10', 'CS510', '2', 1, 'Not happy with the resolution provided.');

INSERT INTO VitalRingService.ServiceOrder (OrderID, CustomerID, AddressID, CaseID, OrderDate, Status)
VALUES
('ORD001', '2', '3', 'CS501', '2023-05-23', 'Open'),
('ORD002', '8', '13', 'CS507', '2023-11-23', 'InProgress'),
('ORD003', '3', '4', 'CS502', '2023-04-23', 'Closed'),
('ORD004', '1', '1', 'CS500', '2023-02-23', 'Closed'),
('ORD005', '6', '8', 'CS505', '2023-08-23', 'Closed'),
('ORD006','2','3','CS503','2023-09-23','Open'),
('ORD007', '8', '13', 'CS512', '2023-10-23', 'InProgress'),
('ORD008', '3', '4', 'CS510', '2023-02-23', 'Closed'),
('ORD009', '1', '1', 'CS514', '2023-03-23', 'Open'),
('ORD010', '6', '8', 'CS508', '2023-07-23', 'Closed'),
('ORD011', '7', '12', 'CS503', '2023-09-23', 'Open'),
('ORD012', '1', '2', 'CS512', '2023-10-23', 'InProgress'),
('ORD013', '10', '16', 'CS510', '2023-02-23', 'Open'),
('ORD014', '6', '9', 'CS514', '2023-03-23', 'Cancelled'),
('ORD015', '4', '5', 'CS508', '2023-07-23', 'Closed');

-- Dummy data for 3 Orders with 1 Ring + Charger Kit
INSERT INTO VitalRingService.OrderLine (OrderLineID, OrderID, ProductID, Quantity, UnitPrice)
VALUES
('OL1001', 'ORD002', '2', 1, 99.99),
('OL1002', 'ORD002', '1', 1, 19.99),
('OL1003', 'ORD003', '4', 1, 99.99),
('OL1004', 'ORD003', '1', 1, 19.99),
('OL1005', 'ORD004', '5', 1, 99.99),
('OL1006', 'ORD004', '1', 1, 19.99);

-- Dummy data for 3 Orders with 1 Ring + Charger Kit + Return Kit
INSERT INTO VitalRingService.OrderLine (OrderLineID, OrderID, ProductID, Quantity, UnitPrice)
VALUES
('OL1007', 'ORD001', '4', 1, 99.99),
('OL1008', 'ORD001', '1', 1, 19.99),
('OL1009', 'ORD001', '6', 1, 9.99),
('OL1010', 'ORD005', '3', 1, 99.99),
('OL1011', 'ORD005', '1', 1, 19.99),
('OL1012', 'ORD005', '6', 1, 9.99);

INSERT INTO CallLog (CallLogID, CaseID, Comment, AgentID, CallType, CallDateTime) VALUES
('1', 'CS500', 'Follow-up call regarding service issue', '1', 'Inbound', '2023-12-07 09:00:00'),
('2', 'CS501', 'Initial inquiry about product', '1', 'Inbound', '2023-12-07 10:15:00'),
('3', 'CS502', 'Customer requested a callback', '2', 'Outbound', '2023-12-07 11:30:00'),
('4', 'CS503', 'Technical support provided', '2', 'Inbound', '2023-12-07 12:45:00'),
('5', 'CS504', 'Feedback received on recent service', '3', 'Inbound', '2023-12-07 14:00:00'),
('6', 'CS505', 'Discussion of account details', '4', 'Outbound', '2023-12-07 15:15:00'),
('7', 'CS506', 'Resolved billing query', '6', 'Inbound', '2023-12-07 16:30:00'),
('8', 'CS507', 'Scheduled maintenance call', '6', 'Outbound', '2023-12-07 17:45:00'),
('9', 'CS508', 'Update provided on case status', '7', 'Inbound', '2023-12-08 09:00:00'),
('10', 'CS510', 'Customer expressed satisfaction with resolution', '7', 'Inbound', '2023-12-08 10:15:00'),
('11', 'CS510', 'Additional follow-up on resolution', '7', 'Outbound', '2023-12-08 11:30:00');

INSERT INTO VitalRingService.Article (ArticleID, Content, FirstPublishedDate, LastPublishedDate)
VALUES
('A190', 'Can I wear Ring only at night? Yes. However, you may miss out on useful activity data that loop into your other scores, and your Oura experience may seem incomplete as a result. We recommend to all Oura members that they wear their rings 24/7 for optimal accuracy and personalization.', '2023-08-23', '2023-09-23');
INSERT INTO VitalRingService.Article (ArticleID, Content, FirstPublishedDate, LastPublishedDate)
VALUES
('A191', 'How should I store the ring? If you plan on taking a break from wearing your Oura Ring for more than two weeks, we recommend putting it into power saving mode to prevent any potential battery deterioration.', '2023-08-23', '2023-09-23');
INSERT INTO VitalRingService.Article (ArticleID, Content, FirstPublishedDate, LastPublishedDate)
VALUES
('A192', 'What is Restricted Mode? Restricted Mode protects your information in case an unwanted party gets a hold of your Oura Ring and attempts to pair it with their device, or if you attempt to pair your ring to a new device without performing a factory reset on it first.', '2023-09-23', '2023-10-23');

INSERT INTO VitalRingService.CaseArticle
VALUES
('CA190', 'CS500', 'A190')
INSERT INTO VitalRingService.CaseArticle
VALUES
('CA191', 'CS502', 'A191')
INSERT INTO VitalRingService.CaseArticle
VALUES
('CA192', 'CS505', 'A192')
INSERT INTO VitalRingService.CaseArticle
VALUES
('CA193', 'CS506', 'A192')
INSERT INTO VitalRingService.CaseArticle
VALUES
('CA194', 'CS507', 'A192')
INSERT INTO VitalRingService.CaseArticle
VALUES
('CA195', 'CS508', 'A190');










