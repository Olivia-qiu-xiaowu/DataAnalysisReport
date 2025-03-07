# Interest Rate Cut Prediction Alert Model:

The "Rule of Thumb" model is an interest rate cut warning model based on intuitive logic and objective data. According to the model, the "Rule of Thumb" exhibits quantifiability, 
ease of understanding, relative objectivity, and high adaptability. However, based on backtesting data, its accuracy requires further observation. This study primarily reconstructs the interest 
rate cut prediction framework using Wind data based on the "Rule of Thumb" model developed by Guosen Securities Economic Research Institute and conducts backtesting on the model.

## Rule of Thumb
1. Timeliness:
   Considering the timeliness of interest rate cut warnings, this model limits the effective prediction period to three months. For example, if a rate cut is predicted in May,
   the actual implementation must occur no later than July; otherwise, the warning is considered invalid.
2. Warning Conditions:
   The model monitors interest rate cuts based on eight indicators, and the warning condition follows a "six-out-of-eight" rule—meaning a warning is triggered if six out of the eight
   indicators meet the criteria. If backtesting data is missing, the warning conditions will be adjusted to observe whether the predictions remain consistent with expectations.
3. Warning Performance:
   - Single warning: Indicates a rate cut within the next two months.
   - Two consecutive warnings: Indicates a rate cut within the next month.
   - Three consecutive warnings: Indicates a rate cut in the current month.
   - Unwarned rate cut: A rate cut occurs without any prior warning in the current or preceding two months.

## Model Backtesting
To assess the model’s accuracy across different economic policy periods, backtesting is conducted in three phases: **2005–2010, 2010–2017, and 2017–2023**.<br/>
From these three retrospective periods, the model's accuracy shows a continuous improvement. The persistent prediction failures before 2016 may be attributed to data selection 
and data completeness issues.

#### 2005-2010
Since the policy interest rate "anchor" was shifted to the 7-day reverse repo rate in 2016, data prior to 2016 is observed based on the Medium-term Lending Facility (MLF) rate. 
Due to the 18-year gap, many data points in this period are missing.
| Warning Type | Number of Warnings | Effective Times | Percentage|
| --- | --- | --- | --- |
| Single Warning | 5 | 1 | 20% |
| Two Consecutive Warning | 1 | 0 | 0% |
| Three Consecutive Warning | 1 | 0 | 0%|

**Unwarned Rate Cuts： 2 Times**<br/>

From August to December 2008, there were three rate cuts, but the model failed to issue any warnings. This unwarned rate cut scenario may be attributed to data gaps and changes 
in economic policies during that period.
![image](https://github.com/user-attachments/assets/e4818509-bfd2-4e39-aed4-29b24ec59d79)<br/>
![image](https://github.com/user-attachments/assets/acb08753-8dd1-418e-9878-5b402e87ca4b)<br/>

#### 2010-2017
Since the policy interest rate "anchor" shifted to the 7-day reverse repo rate in 2016, the model uses different benchmarks for rate cut predictions:
 - Before 2016: Predictions are based on the Medium-term Lending Facility (MLF) rate.
 - 2016–2017: Predictions are based on the 7-day reverse repo rate.
| Warning Type | Number of Warnings | Effective Times | Percentage|
| --- | --- | --- | --- |
| Single Warning | 42 | 15 | 35.7% |
| Two Consecutive Warning | 32 | 8 | 25% |
| Three Consecutive Warning | 27 | 9 | 33.3%|

**Unwarned Rate Cuts： 1 Times**<br/>

In May 2012, a rate cut occurred, followed by rate cuts in February, April, June, September, and October 2015.
The model successfully issued warnings for all rate cuts except for September 2015. However, the excessive number of warnings led to multiple false signals, which ultimately reduced 
the overall accuracy of the model.
![image](https://github.com/user-attachments/assets/7cd422f1-c74f-4a7c-8c47-0f37dc995e51)<br/>
![image](https://github.com/user-attachments/assets/e09df818-0340-4576-8544-9667f60cbe5b)<br/>

#### 2017-2023
| Warning Type | Number of Warnings | Effective Times | Percentage|
| --- | --- | --- | --- |
| Single Warning | 17 | 11 | 64.7% |
| Two Consecutive Warning | 7 | 5 | 85.7% |
| Three Consecutive Warning | 3 | 3 | 100%|

**Unwarned Rate Cuts： 0 Times**<br/>

![image](https://github.com/user-attachments/assets/33d2423e-2f78-4826-99b0-9f24fc261db4)<br/>
![image](https://github.com/user-attachments/assets/78f3660e-a761-44d2-8e10-60bec6149e62)<br/>

## Overall
The "Rule of Thumb" model demonstrates strong optimization potential and a certain degree of foresight. Since 2016, the model's accuracy has significantly improved, supported by 
more complete data. However, historical backtesting results have been less than ideal, likely due to data gaps and policy changes. The model still requires further observation and appropriate adjustments.





