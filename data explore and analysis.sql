SELECT *         # Showing the menu items table 
FROM menu_items ;

SELECT count(menu_item_id) #showing the count of items in the menu  
FROM menu_items ;  #32 Item 

SELECT Max(price) AS "most expencive item" , min(price) as "least expencive item" #showing the most and leat expensive items 
FROM menu_items ;  #most expencive is 19.95 and the least is 5.00 

SELECT count(menu_item_id) #showing the number of Items in italian category 
FROM menu_items 
WHERE category = 'Italian'; # 9 Items 

SELECT max(price) as 'highst italian item cost' , min(price) as 'lowest italian item cost' #showing highest and lowest italian items cost 
FROM menu_items 
WHERE category = 'Italian' ; #19.95 is the highst and 14.50 is the lowst 

SELECT category ,count(menu_item_id) as 'number_of_items' # showing the number items in each category 
FROM menu_items 
GROUP BY category 
order by number_of_items DESC;

SELECT category ,round(avg(price),2) as 'avg_of_price' # showing the avg price for each category 
FROM menu_items 
GROUP BY category 
order by avg_of_price DESC; #Italian food have the most avg of prices 

SELECT * # view the order details data 
FROM order_details ;  

SELECT min(order_date) , max(order_date) # showing the order date range 
FROM order_details ; 

SELECT count(distinct order_id) #how many orders  
FROM order_details; #5370 order 

SELECT  count(order_id) 
FROM order_details ; #12234 

SELECT order_id , count(order_details_id) as'number_of_items'
FROM order_details 
GROUP BY order_id 
ORDER BY number_of_items DESC ; # order 330 have the most number of items 

SELECT order_id , row_number() over (order by order_id) #number of item 
FROM order_details 
GROUP BY order_id 
HAVING count(order_details_id)  >12;

SELECT *  # compining the two tables together 
FROM menu_items as mi
JOIN order_details as od
ON mi.menu_item_id = od.item_id ;

#what are the least and most orderd item ? 

SELECT mi.item_name as 'item_name', mi.category as 'category',count(mi.menu_item_id) as 'number_of_orders' # compining the two tables together 
FROM menu_items as mi
JOIN order_details as od
ON mi.menu_item_id = od.item_id 
GROUP BY mi.item_name ,mi.category 
ORDER BY number_of_orders DESC; #american hamburger is the most requested food in the list  , mexican checken tacos is the least 

# what are the top 5 orders spent most money 

SELECT od.order_id ,od.order_date as 'order_date',sum(price) as 'order_cost' # compining the two tables together 
FROM menu_items as mi
JOIN order_details as od
ON mi.menu_item_id = od.item_id 
GROUP BY od.order_id  , od.order_date
ORDER BY order_cost DESC 
LIMIT 5 ; 

SELECT *  
FROM menu_items as mi
JOIN order_details as od
ON mi.menu_item_id = od.item_id 
WHERE od.order_id IN (440,2075,1957,330,2675);