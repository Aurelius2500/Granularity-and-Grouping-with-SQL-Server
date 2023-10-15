-- Database Basics: Granularity and Grouping with SQL Server

-- In this video, we will be exploring the Houses table that we have been using in previous tutorials, but with more data
-- In addition, we will use multiple techniques to create summaries using GROUP BY 

CREATE TABLE Houses (
Owner_ID VARCHAR(100),
Street VARCHAR(200),
[State] VARCHAR(200),
Price INT,
Price_Date DATE,
Years_since_construction INT,
Downpayment INT,
Years_since_renovation INT
);

INSERT INTO Houses (Owner_ID, Street, [State], Price, Price_Date, Years_since_construction, Downpayment, Years_since_renovation)
VALUES ('1', '240 Main Street', 'CA', 1900000, '2019-01-01', 18, 4000, 5), 
('1', '140 Maple Street', 'GA', 1300000, '2021-01-01', 5, 5000, NULL),
('2', '555 New Way', 'TX', 1100000, '2017-01-01', 12, 5400, 6),
('2', '14 Paradise Street', 'MO', 700000, '2020-01-01', 30, 21000, 6),
('4', '123 School Street', 'MI', 400000, '2019-01-01', 18, 67000, 8),
('1', '70 Smith Way', 'VA', 1500000, '2012-07-10', 12, 10000, 8),
('2', '230 Valley Way', 'TX', 1200000, '2007-02-08', 2, 56000, NULL),
('1', '23 King Drive', 'CA', 3300000, '2022-04-08', 5, 54000, NULL),
('3', '12 Felicity Way', 'RI', 2200000, '2017-04-12', 1, 56000, NULL),
('2', '34 Hollow Drive', 'FL', 1950000, '2019-05-29', 2, 34000, NULL),
('2', '345 Forest Drive', 'FL', 1900000, '2020-05-29', 2, 43000, NULL),
(NULL, '123 Rock Drive', 'MO', 1000000, '2016-03-29', 12, 65000, 6),
('3', '167 Maple Street', 'AL', 800000, '2012-01-01', 20, 3000, 2),
('1', '1346 Main Street', 'KS', 1200000, '2020-01-01', 21, 15000, 8);

-- Now we have the following columns
-- Street is the address of the house
-- State is the U.S State in which the house is located
-- Price is the current listed price of the house
-- Price_Date is when the price was retrieved
-- Years_since_construction is how many years have passed since the house was built
-- Downpayment is the amount of money put when the house was bought
-- Years_since_renovation is how many years it has been since the house was renovated, if it was, if not, it is null

-- We will first look at the original table with a simple SELECT *
SELECT *
FROM Houses

-- We can start by getting a count of how many records we have in the table
-- We are counting all the different records given all the columns in the table
SELECT COUNT(*)
FROM Houses

-- But what happens if we want to count only the Owners in the table?
SELECT COUNT(Owner_ID)
FROM Houses

-- We have to use the DISTINCT keyword in order to ensure that we only count the different values in the field
SELECT COUNT(DISTINCT Owner_ID)
FROM Houses

-- Notice how the new field does not have any name, we can use the AS keyword to assign it an alias
SELECT COUNT(DISTINCT Owner_ID) AS Number_of_Distinct_Owners
FROM Houses

-- There are more aggregation functions in SQL, we can demonstrate SUM by adding all the Prices and Downpayments
SELECT SUM(Price) AS Total_Price, 
SUM(Downpayment) AS Total_Downpayment
FROM  Houses

-- MIN and MAX are pretty self-explanatory, they give us the minimum of maximum of each column
SELECT MIN(Price) AS Minimum_Price,
MAX(Price) AS Maximum_Price
FROM Houses

-- Or AVG, that allows us to get the average of a column
SELECT AVG(Price) AS Average_Price
FROM Houses

-- But we have been doing these reports for the whole table, what if we want to get a summary for each state, for example?
-- The GROUP BY clause allows us to do this
SELECT MIN(Price) AS Minimum_Price,
MAX(Price) AS Maximum_Price,
AVG(Price) AS Average_Price
FROM Houses
GROUP BY [State]

-- But we cannot see the state label, and we don't know which aggregations belong to. We are going to need to put the label in the SELECT clause 
SELECT MIN(Price) AS Minimum_Price,
MAX(Price) AS Maximum_Price,
AVG(Price) AS Average_Price,
[State]
FROM Houses
GROUP BY [State]

--We can use the WHERE clause to filter out data before it goes into the aggregation, this detail will be important later
SELECT MIN(Price) AS Minimum_Price,
MAX(Price) AS Maximum_Price,
AVG(Price) AS Average_Price,
[State]
FROM Houses
WHERE [State] IN ('CA', 'FL', 'GA', 'TX')
GROUP BY [State]

-- The other way to filter the aggregation is by using HAVING instead
SELECT MIN(Price) AS Minimum_Price,
MAX(Price) AS Maximum_Price,
AVG(Price) AS Average_Price,
[State]
FROM Houses
GROUP BY [State]
HAVING MIN(Price) >= 1000000

-- The last operation that we want to perform if we will not use the tables anymore is drop them
DROP TABLE Houses;