--Ejercicio1:
select name,gender,
SUM(number) as suma 
from bigquery-public-data.usa_names.usa_1910_2013 
group by name,gender 
order by suma desc;

--Ejercicio2:
select date,state,tests_total,cases_positive_total,
SUM(tests_total) over(partition by state) as suma_total 
from bigquery-public-data.covid19_covidtracking.summary
order by state desc;


--Ejercicio3:
WITH grupo_pageviews AS
(
select channelGrouping,
SUM(totals.pageviews) over(partition by channelGrouping)  as pageviews
from `bigquery-public-data.google_analytics_sample.ga_sessions_20170801` 
)
select channelGrouping, pageviews,
(pageviews/(SUM(pageviews)over()))  as porcentaje_del_total,
avg (pageviews) over() as promedio 
from grupo_pageviews 
group by pageviews,channelGrouping 
order by pageviews desc;

--Ejercicio4:
Select Region, Country, Total_Revenue,
Dense_rank() over(partition by Region order by Total_Revenue desc ) as Rank 
from `fir-php-test-778ec.Ejercicio4_Yensi_Armijo_Script.Sales_Records`;

