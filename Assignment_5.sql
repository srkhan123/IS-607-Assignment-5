
/* ---Shazia Khan - Assignment 5

For flights from any of the three major NYC airports to Los Angeles Intl airport during the period between 2/23/2013 and 3/1/2013, please include the following information: 
• Airport of origin 
• Carrier 
• Approximate temperature at scheduled time of departure 
• Departure Delay
• Arrival Delay 
• Air Time in Minutes 
• Seating Capacity of Airplane 

*/

select  f.origin, f.carrier, w.temp, f.dep_delay, f.arr_delay, f.air_time, p.seats
from flights f 
	left outer join weather w on  
	f.origin = w.origin and 
	f.year = w.year and 
	f.month = w.month and 
	f.day = w.day and 
	-- convert dep_time to hour; if there are more than 30 min then add 1 to hour then join to hour in weather table
	(
	case 
			when (length(dep_time :: numeric :: text) = 3 ) then
				case when ((substring((dep_time ::numeric :: text) from 2 for 2)) :: text :: numeric)  > 30 then
					((substring((dep_time ::numeric :: text) from 1 for 1)) :: text :: numeric) + 1
				else 
					(substring((dep_time ::numeric :: text) from 1 for 1)) :: text :: numeric 
				end
			when (length(dep_time :: numeric :: text) = 4 ) then
				case when ((substring((dep_time ::numeric :: text) from 3 for 2)) :: text :: numeric)  > 30 then
					((substring((dep_time ::numeric :: text) from 1 for 2)) :: text :: numeric) + 1
				else 
					(substring((dep_time ::numeric :: text) from 1 for 2)) :: text :: numeric 
				end
			else dep_time
			end
	) = w.hour
	left outer join planes p on f.tailnum = p.tailnum --this is for including seats
where  f.origin in ( 'EWR' ,'LGA' , 'JFK')
	and f.dest = 'LAX'
	and  (((f.month::numeric:: text) || '/' || (f.day::numeric:: text) || '/' ||(f.year::numeric:: text))::text :: date) between '2013-02-23' and '2013-03-01'
	
group by  f.origin, f.carrier, w.temp, f.dep_delay, f.arr_delay, f.air_time, p.seats
order by f.origin, f.carrier, w.temp, f.dep_delay, f.arr_delay, f.air_time, p.seats

---------------------------
/*
select to_date(cast(month as varchar(2))|| '/'||cast(day as varchar(2)) ||'/' || cast(year as varchar(4)), 'dd/mm/YYYY')
from flights
where to_date(cast(month as varchar(2))|| '/'||cast(day as varchar(2)) ||'/' || cast(year as varchar(4)), 'dd/mm/YYYY') between '2013-02-23' and '2013-03-01'
group by to_date(cast(month as varchar(2))|| '/'||cast(day as varchar(2)) ||'/' || cast(year as varchar(4)), 'dd/mm/YYYY')
order by to_date(cast(month as varchar(2))|| '/'||cast(day as varchar(2)) ||'/' || cast(year as varchar(4)), 'dd/mm/YYYY')
*/
-----------------------------

/*
select * from weather limit 10;
select * from flights limit 10;
select * from planes limit 10;
select * from airports where faa = 'LAX'

select hour from weather
group by hour
order by hour
*/
----------------------------
/*
select dep_time, w.hour
from flights 
left outer join weather w on dep_time = w.hour
group by dep_time, w.hour
*/
-------------------------------------------------------------------------------------------------------
/*
select length(dep_time :: numeric :: text) , (dep_time ::numeric :: text) ,dep_time,  
		case 
		when (length(dep_time :: numeric :: text) = 3 ) then
			case when ((substring((dep_time ::numeric :: text) from 2 for 2)) :: text :: numeric)  > 30 then
				((substring((dep_time ::numeric :: text) from 1 for 1)) :: text :: numeric) + 1
			else 
				(substring((dep_time ::numeric :: text) from 1 for 1)) :: text :: numeric 
			end
		when (length(dep_time :: numeric :: text) = 4 ) then
			case when ((substring((dep_time ::numeric :: text) from 3 for 2)) :: text :: numeric)  > 30 then
				((substring((dep_time ::numeric :: text) from 1 for 2)) :: text :: numeric) + 1
			else 
				(substring((dep_time ::numeric :: text) from 1 for 2)) :: text :: numeric 
			end
		else dep_time
		end
from flights limit 10
*/

/*
-- check number of rows in original table
select  f.origin, f.carrier,  f.dep_delay, f.arr_delay, f.air_time
from flights f
where  origin in ( 'JFK' ,'LGA' , 'EWR') and dest = 'LAX'
	and (((month::numeric:: text) || '/' || (day::numeric:: text) || '/' ||(year::numeric:: text))::text :: date) between '2013-02-23' and '2013-03-01'
group by f.origin, f.carrier,  f.dep_delay, f.arr_delay, f.air_time
 */






