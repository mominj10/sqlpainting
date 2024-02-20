select*from artist;
select*from canvas_size;
select*from image_link;
select*from museum_hours;
select*from museum;
select*from product_size;
select*from subject;
select*from work;

--Task 1 : Museums open on both sunday and monday,(Museum name and City)
select m.name as museum_name,m.city
from museum_hours a
join museum m on m.museum_id=a.museum_id
where day='Sunday'
and exists(select 1 from museum_hours b
		  where b.museum_id=a.museum_id
		  and b.day='Monday')
--The subquery selects the value '1' if there is a matching row in 'museum_hours' ('b') where the 'museum_id' 
--is the same as the outer query's 'museum_id' and the day is 'Monday'. The actual value '1' is not significant; 
--the purpose is to check for the existence of such a row.

--Task 2 : Museum open for longest during a day (Museum name, state, hours and which day)
select*from museum_hours
--to convert open and close to timestamp
select m.name as museum_name, m.state,b.day
, to_timestamp(open, 'HH:MI AM')as opentime
, to_timestamp(close, 'HH:MI PM')as closetime
, to_timestamp(close, 'HH:MI PM') - to_timestamp(open, 'HH:MI AM')as duration
, rank() over(order by (to_timestamp(close, 'HH:MI PM') - to_timestamp(open, 'HH:MI AM'))desc)
from museum_hours b
join museum m on m.museum_id=b.museum_id