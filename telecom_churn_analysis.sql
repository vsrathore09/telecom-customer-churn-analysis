create database telecom_churn;
use telecom_churn;
SELECT * FROM telecom_data
LIMIT 10;

# total customers :-
select count(*) as total_customers from telecom_data;

#overall churn rate:-
SELECT COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' 
    THEN 1 
	ELSE 0 
	END) AS churn_customers,
    ROUND(
	SUM(CASE WHEN Churn = 'Yes' 
	THEN 1 
	ELSE 0 
	END) * 100.0 / COUNT(*),
	2
    ) AS churn_rate_percentage
FROM telecom_data;

-- now calculate How much revenue is at risk due to churn:-
SELECT 
    ROUND(SUM(TotalCharges),2) AS revenue_at_risk
FROM telecom_data
WHERE Churn = 'Yes';

-- now Which contract type has the highest churn:- 
SELECT Contract, COUNT(*) AS total_customers,
SUM(CASE 
		WHEN Churn = 'Yes' 
		THEN 1 
		ELSE 0 
	END) AS churn_customers,
ROUND(
	SUM(CASE 
			WHEN Churn = 'Yes' 
			THEN 1 
			ELSE 0 
		END) * 100.0 / COUNT(*),
	2
) AS churn_rate
FROM telecom_data
GROUP BY Contract
ORDER BY churn_rate DESC;

-- now Which internet service contributes most to churn:-
SELECT InternetService, COUNT(*) AS customers,
	SUM(CASE 
		WHEN Churn = 'Yes' 
		THEN 1 
		ELSE 0 
	END) AS churn_customers,
ROUND(
	SUM(CASE 
			WHEN Churn = 'Yes' 
			THEN 1 
			ELSE 0 
		END) * 100.0 / COUNT(*),
	2
) AS churn_rate
FROM telecom_data
GROUP BY InternetService
ORDER BY churn_rate DESC;

-- Do customers with tech support churn less:-
SELECT TechSupport, COUNT(*) AS customers,
	SUM(CASE 
		WHEN Churn = 'Yes' 
		THEN 1 
		ELSE 0 
	END) AS churn_customers,
ROUND(
	SUM(CASE 
			WHEN Churn = 'Yes' 
			THEN 1 
			ELSE 0 
		END) * 100.0 / COUNT(*),
	2
) AS churn_rate
FROM telecom_data
GROUP BY TechSupport
ORDER BY churn_rate DESC;

-- Which payment method has the highest churn:-
SELECT PaymentMethod, COUNT(*) AS customers,
	SUM(CASE 
		WHEN Churn = 'Yes' 
		THEN 1 
		ELSE 0 
	END) AS churn_customers,
ROUND(
	SUM(CASE 
			WHEN Churn = 'Yes' 
			THEN 1 
			ELSE 0 
		END) * 100.0 / COUNT(*),
	2
) AS churn_rate
FROM telecom_data
GROUP BY PaymentMethod
ORDER BY churn_rate DESC;

-- Are senior citizens more likely to churn:-
SELECT SeniorCitizen, COUNT(*) AS customers,
	SUM(CASE 
		WHEN Churn = 'Yes' 
		THEN 1 
		ELSE 0 
	END) AS churn_customers,
ROUND(
	SUM(CASE 
			WHEN Churn = 'Yes' 
			THEN 1 
			ELSE 0 
		END) * 100.0 / COUNT(*),
	2
) AS churn_rate
FROM telecom_data
GROUP BY SeniorCitizen;

-- Revenue Loss by Contract Type:-
SELECT Contract, ROUND(SUM(TotalCharges),2) AS revenue_loss
FROM telecom_data
WHERE Churn = 'Yes'
GROUP BY Contract
ORDER BY revenue_loss DESC;

/*
Key Findings:
- Month-to-month contracts contribute highest churn.
- Fiber optic users show higher churn probability.
- Customers without tech support are at higher risk.
*/

/*
Recommendations:
- Encourage yearly contracts.
- Improve customer support adoption.
- Target high-risk segments with retention offers.
*/