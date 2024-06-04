
create view bossbunch_wh.coupon_analysis as 
select Coupon,year,round(sum(TotalAmount),2) from bossbunch_wh.SalesPerWOC sp
inner join bossbunch_wh.Orders o
on sp.OrdersKey= o.OrdersKey
inner join bossbunch_wh.Calendar c
on sp.CalendarKey = c.CalendarKey
group by Coupon,year
order by Coupon,year
;

create view bossbunch_wh.overall_coupon_rev as 
select year,month,round(sum(TotalAmount),2) from bossbunch_wh.SalesPerWOC sp
inner join bossbunch_wh.Orders o
on sp.OrdersKey= o.OrdersKey
inner join bossbunch_wh.Calendar c
on sp.CalendarKey = c.CalendarKey
        group by year,month
        order by year,month;
        
        
drop table bossbunch_wh.`Inventory`;
CREATE TABLE bossbunch_wh.`Inventory` (
  `InventoryKey` int NOT NULL auto_increment,
  `InventoryID` int NOT NULL,
  `WineID` varchar(25) NOT NULL,
  `Stock` int NOT NULL,
  PRIMARY KEY (`InventoryKey`)
) 
;


DELIMITER //

CREATE PROCEDURE get_stock_details()
BEGIN
    SELECT Winename, Stock FROM bossbunch_wh.`Inventory`  I
    inner join bossbunch_wh.`Wine`  w
    on I.WineID = w.WineID
    ORDER BY Stock ASC;     
END //

DELIMITER ;
