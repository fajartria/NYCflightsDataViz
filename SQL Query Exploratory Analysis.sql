/* main queries that we used*/

/* let see what we got*/
select *
from airlines;

select *
from airports;

select *
from flights;

select *
from planes;

select *
from weather;

SELECT      A. Name AS Airline_Company,
            CASE WHEN dep_delay>0 THEN (SELECT dep_delay
                                        FROM flights
                                        WHERE dep_delay>0) 
            ELSE 0 END dep_positive,
            CASE WHEN arr_delay>0 THEN (SELECT arr_delay
                                        FROM flights
                                        WHERE dep_delay>0) 
            ELSE 0 END arr_positive,
            CASE WHEN dep_delay<0 THEN (SELECT dep_delay
                                        FROM flights
                                        WHERE dep_delay<0) 
            ELSE 0 END dep_delay,
            CASE WHEN arr_delay<0 THEN (SELECT arr_delay
                                        FROM flights
                                        WHERE dep_delay<0) 
            ELSE 0 END arr_delay, 
            
            flight AS 'Flight Number', 
            origin, 
            dest, 
            air_time, 
            time_hour AS 'flight schedule',
FROM flights;

/* datas are for 2013, for the flights from 3 air ports to others*/
/* we dont need the airports which is not our destination*/
/*we dont need planes which is not in the flight table*/
/* let split positive and negative delays, and join all table based on flights
cuse there are many airports which are not our destination*/
/*we use case to create colum for departur lang and lat and use join to have long and lat of destinations*/
/*year and day and month is in flight schedule, then we dont use them to have a more efficient dataset*/

    

/* one thing left, we want to join wheter to flights that we create in the tabluea based on date and origin
 we can filter the data of whether based on the flight scheduel because we will have less rwose and the analysing will be easier*/

SELECT 	origin, temp,dewp,humid,wind_dir,
		wind_speed,wind_gust,precip,pressure,visib,time_hour 
FROM weather
WHERE time_hour  IN (SELECT time_hour
                     FROM flights);





/* to speed up the process we will filter here the airports alsom because there are airports with no flights*/

SELECT faa, name AS 'Airport Name' , lat AS latitude,lon AS longitude
FROM Airports
WHERE faa  in (SELECT dest
               FROM flights)
               OR (SELECT origin
                   FROM flights);
				   
/* other Queries*/				   
----------------------------------------------------------------------
/* the below queries was for our first trials*/
/* we chenged this code and kept it, this is our first version*/
SELECT      A.carrier as Carrier,
            case when dep_delay>0 then (select dep_delay
                                        from flights
                                        where dep_delay>0) 
            else 0 end dep_positive,
            case when arr_delay>0 then (select arr_delay
                                        from flights
                                         where dep_delay>0) 
            else 0 end arr_positive,
            case when dep_delay<0 then (select dep_delay
                                        from flights
                                        where dep_delay<0) 
            else 0 end dep_delay,
            case when arr_delay<0 then (select arr_delay
                                        from flights
                                        where dep_delay<0) 
            else 0 end arr_delay, 
            case when origin = "JFK" then (select lat
                                        from Airports
                                        where faa = "JFK") 
                  when origin = "LGA" then (select lat
                                        from Airports
                                        where faa = "LGA")                     
            else                        (select lat
                                        from Airports
                                        where faa = "EWR") end Dep_latitude,
            case when origin = "JFK" then (select lon
                                        from Airports
                                        where faa = "JFK") 
                  when origin = "LGA" then (select lon
                                        from Airports
                                        where faa = "LGA")                     
            else                        (select lon
                                        from Airports
                                        where faa = "EWR") end Dep_longitude, 
            A. Name as Airline_Company,
            F.tailnum, 
            F.flight, 
            F.origin, 
            F.dest, 
            F.air_time, 
            F.distance, 
            F.time_hour as flight_schedule,
            P.year as year_Manufactured, 
            P.manufacturer,
            Air.faa,
            Air.name as Aiport_Name, 
            Air.lat as arr_latitude, 
            Air.lon as arr_longitude,
            p.model as airplanModel,
            p.engine as engintype
        
FROM flights f
    LEFT JOIN airlines a ON f.carrier = a.carrier
    LEFT JOIN planes P ON F.tailnum = P.tailnum
    LEFT JOIN airports Air ON F.dest = Air.faa
;


SELECT      A. Name as Airline_Company,
            case when dep_delay>0 then (select dep_delay
                                        from flights
                                        where dep_delay>0) 
            else 0 end dep_positive,
            case when arr_delay>0 then (select arr_delay
                                        from flights
                                         where dep_delay>0) 
            else 0 end arr_positive,
            case when dep_delay<0 then (select dep_delay
                                        from flights
                                        where dep_delay<0) 
            else 0 end dep_delay,
            case when arr_delay<0 then (select arr_delay
                                        from flights
                                        where dep_delay<0) 
            else 0 end arr_delay, 
            
            F.flight as 'Flight Number', 
            F.origin, 
            F.dest, 
            F.air_time, 
            F.time_hour as 'flight schedule',
            P.year as 'year Manufactured', 
            P.manufacturer 'manufacturer Name',
            p.model as 'airplan Model',
            p.engine as 'engin type'
FROM flights f
    LEFT JOIN airlines a ON f.carrier = a.carrier
    LEFT JOIN planes P ON F.tailnum = P.tailnum;
	

                        