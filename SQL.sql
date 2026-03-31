create database BANK;
USE BANK;
    
SELECT * FROM credit_debit;

SELECT 
    COUNT(*) AS total_rows
FROM 
    credit_debit;
    
 
 /* Total Amount*/
    
    SELECT 
  CASE 
    WHEN SUM(amount) >= 1000000 THEN CONCAT(ROUND(SUM(amount)/1000000, 2), 'M')
    WHEN SUM(amount) >= 1000 THEN CONCAT(ROUND(SUM(amount)/1000, 2), 'K')
    ELSE ROUND(SUM(amount), 2)
  END AS total_amount
FROM credit_debit;

/* Total Balance */
    
    SELECT 
  CASE 
    WHEN SUM(balance) >= 1000000 THEN CONCAT(ROUND(SUM(balance)/1000000, 2), 'M')
    WHEN SUM(balance) >= 1000 THEN CONCAT(ROUND(SUM(balance)/1000, 2), 'K')
    ELSE ROUND(SUM(balance), 2)
  END AS total_balance
FROM credit_debit;

/* NO.Client */
    
    SELECT 
  CASE 
    WHEN COUNT(`Customer Name`) >= 1000000 THEN CONCAT(ROUND(COUNT(`Customer Name`)/1000000, 2), 'M')
    WHEN COUNT(`Customer Name`) >= 1000 THEN CONCAT(ROUND(COUNT(`Customer Name`)/1000, 2), 'K')
    ELSE COUNT(`Customer Name`)
  END AS total_customers
FROM credit_debit;
    
/* Total Credit */
 
 SELECT 
  CASE 
    WHEN SUM(amount) >= 1000000 THEN CONCAT(ROUND(SUM(amount)/1000000, 2), 'M')
    WHEN SUM(amount) >= 1000 THEN CONCAT(ROUND(SUM(amount)/1000, 2), 'K')
    ELSE ROUND(SUM(amount), 2)
  END AS total_credit
FROM credit_debit
WHERE `Transaction Type` = 'Credit';

/* Total Debit */
    
    SELECT 
  CASE 
    WHEN SUM(amount) >= 1000000 THEN CONCAT(ROUND(SUM(amount)/1000000, 2), 'M')
    WHEN SUM(amount) >= 1000 THEN CONCAT(ROUND(SUM(amount)/1000, 2), 'K')
    ELSE ROUND(SUM(amount), 2)
  END AS total_debit
FROM credit_debit
WHERE `Transaction Type` = 'Debit';

/* Net Balance */   

SELECT 
  CASE 
    WHEN (SUM(CASE WHEN `Transaction Type` = 'Credit' THEN amount ELSE 0 END) -
          SUM(CASE WHEN `Transaction Type` = 'Debit' THEN amount ELSE 0 END)) >= 1000000
    THEN CONCAT(ROUND((
        SUM(CASE WHEN `Transaction Type` = 'Credit' THEN amount ELSE 0 END) -
        SUM(CASE WHEN `Transaction Type` = 'Debit' THEN amount ELSE 0 END)
    ) / 1000000, 2), 'M')
    
    WHEN (SUM(CASE WHEN `Transaction Type` = 'Credit' THEN amount ELSE 0 END) -
          SUM(CASE WHEN `Transaction Type` = 'Debit' THEN amount ELSE 0 END)) >= 1000
    THEN CONCAT(ROUND((
        SUM(CASE WHEN `Transaction Type` = 'Credit' THEN amount ELSE 0 END) -
        SUM(CASE WHEN `Transaction Type` = 'Debit' THEN amount ELSE 0 END)
    ) / 1000, 2), 'K')
    
    ELSE ROUND((
        SUM(CASE WHEN `Transaction Type` = 'Credit' THEN amount ELSE 0 END) -
        SUM(CASE WHEN `Transaction Type` = 'Debit' THEN amount ELSE 0 END)
    ), 2)
  END AS net_balance
FROM credit_debit;
    
    
/* top 5 bank with most customer */

SELECT 
    `Bank Name`,
    CASE 
        WHEN COUNT(DISTINCT `Customer Name`) >= 1000000 THEN CONCAT(ROUND(COUNT(DISTINCT `Customer Name`) / 1000000, 2), 'M')
        WHEN COUNT(DISTINCT `Customer Name`) >= 1000 THEN CONCAT(ROUND(COUNT(DISTINCT `Customer Name`) / 1000, 2), 'K')
        ELSE COUNT(DISTINCT `Customer Name`)
    END AS total_customers
FROM 
    credit_debit
GROUP BY 
    `Bank Name`
ORDER BY 
    COUNT(DISTINCT `Customer Name`) DESC
LIMIT 5;



/* Branch with most Customer  */
SELECT 
    Branch,
    CASE 
        WHEN COUNT(DISTINCT `Customer Name`) >= 1000000 THEN CONCAT(ROUND(COUNT(DISTINCT `Customer Name`) / 1000000, 2), 'M')
        WHEN COUNT(DISTINCT `Customer Name`) >= 1000 THEN CONCAT(ROUND(COUNT(DISTINCT `Customer Name`) / 1000, 2), 'K')
        ELSE COUNT(DISTINCT `Customer Name`)
    END AS total_customers
FROM 
    credit_debit
GROUP BY 
    Branch
ORDER BY 
    COUNT(DISTINCT `Customer Name`) DESC
LIMIT 1;


/* transaction method by customer */
SELECT 
    `Transaction Method`,
    CASE 
        WHEN COUNT(DISTINCT `Customer Name`) >= 1000000 THEN CONCAT(ROUND(COUNT(DISTINCT `Customer Name`) / 1000000, 2), 'M')
        WHEN COUNT(DISTINCT `Customer Name`) >= 1000 THEN CONCAT(ROUND(COUNT(DISTINCT `Customer Name`) / 1000, 2), 'K')
        ELSE COUNT(DISTINCT `Customer Name`)
    END AS total_customers
FROM 
    credit_debit
GROUP BY 
    `Transaction Method`
ORDER BY 
    COUNT(DISTINCT `Customer Name`) DESC;

    
/* customers by discription  */
SELECT 
    Description,
    CASE 
        WHEN COUNT(DISTINCT `Customer Name`) >= 1000000 THEN CONCAT(ROUND(COUNT(DISTINCT `Customer Name`) / 1000000, 2), 'M')
        WHEN COUNT(DISTINCT `Customer Name`) >= 1000 THEN CONCAT(ROUND(COUNT(DISTINCT `Customer Name`) / 1000, 2), 'K')
        ELSE COUNT(DISTINCT `Customer Name`)
    END AS total_customers
FROM 
    credit_debit
GROUP BY 
    Description
ORDER BY 
    COUNT(DISTINCT `Customer Name`) DESC
LIMIT 5;


/* Campare transaction type  */
SELECT 
    `Transaction Type`,

    -- Total Transactions (K/M)
    CASE 
        WHEN COUNT(*) >= 1000000 THEN CONCAT(ROUND(COUNT(*) / 1000000, 2), 'M')
        WHEN COUNT(*) >= 1000 THEN CONCAT(ROUND(COUNT(*) / 1000, 2), 'K')
        ELSE COUNT(*)
    END AS total_transactions,

    -- Total Amount (K/M)
    CASE 
        WHEN SUM(Amount) >= 1000000 THEN CONCAT(ROUND(SUM(Amount) / 1000000, 2), 'M')
        WHEN SUM(Amount) >= 1000 THEN CONCAT(ROUND(SUM(Amount) / 1000, 2), 'K')
        ELSE ROUND(SUM(Amount), 2)
    END AS total_amount,

    -- Total Balance (K/M)
    CASE 
        WHEN SUM(Balance) >= 1000000 THEN CONCAT(ROUND(SUM(Balance) / 1000000, 2), 'M')
        WHEN SUM(Balance) >= 1000 THEN CONCAT(ROUND(SUM(Balance) / 1000, 2), 'K')
        ELSE ROUND(SUM(Balance), 2)
    END AS total_balance,

    -- Average Amount (K/M)
    CASE 
        WHEN AVG(Amount) >= 1000000 THEN CONCAT(ROUND(AVG(Amount) / 1000000, 2), 'M')
        WHEN AVG(Amount) >= 1000 THEN CONCAT(ROUND(AVG(Amount) / 1000, 2), 'K')
        ELSE ROUND(AVG(Amount), 2)
    END AS average_amount

FROM 
    credit_debit
GROUP BY 
    `Transaction Type`
ORDER BY 
    SUM(Amount) DESC;

 -- Monthly Trend of Transactions
    SELECT 
    monthname(STR_TO_DATE(`Transaction Date`, '%d-%m-%Y')) AS month,
    COUNT(*) AS total_transactions
FROM credit_debit
GROUP BY month
ORDER BY month;

-- Average Balance by Bank
SELECT 
    `Bank Name`,
    ROUND(AVG(Balance), 2) AS average_balance
FROM credit_debit
GROUP BY `Bank Name`
ORDER BY average_balance DESC;


-- monthwise Customer Growth
DELIMITER $$
CREATE PROCEDURE MonthlyCustomerGrowth()
BEGIN
    SELECT 
        Branch, 
        MONTH(STR_TO_DATE(`Transaction Date`, '%d-%m-%Y')) AS MonthNumber,
        MONTHNAME(STR_TO_DATE(`Transaction Date`, '%d-%m-%Y')) AS Month,
        COUNT(*) AS NewCustomers
    FROM credit_debit
    GROUP BY Branch, MonthNumber, Month
    ORDER BY Branch, monthnumber;
END $$
DELIMITER ;

call MonthlyCustomerGrowth;



CREATE OR REPLACE VIEW View_CustomerMonthlyTrend AS
SELECT
    `Customer Name`,
    `Account Number`,
    Branch,
    DATE_FORMAT(STR_TO_DATE(`Transaction Date`, '%d-%m-%Y'), '%M %Y') AS MonthText,
    
    SUM(CASE WHEN `Transaction Type` = 'Credit' THEN Amount ELSE 0 END) AS TotalCredits,
    SUM(CASE WHEN `Transaction Type` = 'Debit' THEN Amount ELSE 0 END) AS TotalDebits,
    
    SUM(CASE 
        WHEN `Transaction Type` = 'Credit' THEN Amount 
        WHEN `Transaction Type` = 'Debit' THEN -Amount 
        ELSE 0 
    END) AS NetChange
FROM Credit_Debit
GROUP BY 
    `Customer Name`, 
    `Account Number`,
    Branch,
    DATE_FORMAT(STR_TO_DATE(`Transaction Date`, '%d-%m-%Y'), '%M %Y'),
    MONTH(STR_TO_DATE(`Transaction Date`, '%d-%m-%Y')),
    YEAR(STR_TO_DATE(`Transaction Date`, '%d-%m-%Y'))
ORDER BY 
    `Customer Name`, 
    YEAR(STR_TO_DATE(`Transaction Date`, '%d-%m-%Y')),
    MONTH(STR_TO_DATE(`Transaction Date`, '%d-%m-%Y'));

SELECT * FROM View_CustomerMonthlyTrend ;





    
   
    
    
  

