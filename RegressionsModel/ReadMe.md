# Logistic Regressions and Multiple Linear Regression Model
To observe whether the trend of PMI decline or increase is influenced by industrial principal components, actual EPMI, and measured PMI trends, a model was built to analyze data over a period of 70 months from January 1 2018 to December 1 2023.

## Process
1. Calculate the trend of each variable and assign values: 1 for increase, -1 for decrease, and 0 for no change.
2. Compare with the PMI trend, use Excel to calculate accuracy.
3. Since EPMI has many sub-items, there will focuses on the impact rate of EMPI.

## Result
- Individually:<br/>
  1. The industrial principal component's accuracy is 51.7% over five years, 52.8% over the three years, 66.72% over one year, and 80% over the past ten months.<br/>
  2. The actual EPMI accuracy is 63.3% over five years, 72.2% over three years, 66.7% over one year, and 70% over the past ten months.<br/>
  3. The measured PMI accuracy is 56.7% over five years, 63.9% over three years, 58.3% over one year, and 60% over the past ten monnths.<br/>

- Overall:<br/>
  The probability of PMI and all three indicators rising simultaneously is 63.6%, while the probability of PMI and all three indicators declining simultaneously is 92.3%.<br/>

- From the perspective of EPMI sub-items:<br/>
  The actual EPMI trend aligns with the cumulative direction of its sub-components, with EPMI production volume and EPMI product orders being the primary contributors, followed by imports and employment. Over the past two years, the proportion of product orders has gradually increased. The actual EPMI and PMI trends mostly correspond to production volume, while other sub-components influence the overall trend in proportion.
  
## Basic Data

#### Industrial Principal Component:
![img](Img/IPCA.png)

#### Actual EPMI:
![IMG](Img/A-EPMI.png)

#### Measured PMI:
![IMG](Img/M-PMI.png)

The three indicators rose simultaneously 11 times, and PMI showed the same trend 7 times, with a probability of 63.6%; the three indicators declined simulatneously 13 times, and PMI showed the same downward trend 12 times, with a probability of 92.3%. During other times, PMI fluctuated up and down under the influence. 

![image](https://github.com/user-attachments/assets/0d9d0796-3b53-4e3b-be54-ae55afd1e5f6)

## EPMI Sub-components:
Compare the Following five sets of indicators: EPMI and PMI production volume, EPMI product orders and PMI new orders, EPMI and PMI imports, EPMI procurement prives, EPMI ex-factory prices, and EPMI and PMI employment.
<br/>
From the charts, it can be obeserbed that the actual EPMI trend is similar to the trends of all the sub-components, and the PMI trend is also similar to that of all the sub-components. However, there may ne slight differences due to the relatively small number of indicatoers.
<br/>
Based on the observations, EPMI production volume and product orders have a significant impact on the actual EPMI, followed by employment or imports. Procurement prices have the least impact, or even none, and can be considered negligible.
![image](https://github.com/user-attachments/assets/6579695c-4b43-41c8-976c-0892f0eed761)
<br/>
![image](https://github.com/user-attachments/assets/0e3d156c-33aa-4acd-919d-95f4227fbb84)
<br/>
The trend of EPMI procurement pricies shows a large difference from the actual EPMI trend, with an accuracy of only 48.6%. Additionally, data is missing for the past 8 months, so this indicator can be excluded. The focus should be on observing EPMI and PMI production volume and product orders.



