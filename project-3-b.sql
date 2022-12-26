use casestudy;
#1. Display the product details as per the following criteria and sort them in descending order of category:
   #a.  If the category is 2050, increase the price by 2000
   #b.  If the category is 2051, increase the price by 500
   #c.  If the category is 2052, increase the price by 600
select product_id,product_desc,product_class_code,product_price as old_price,
case 
when product_class_code =2050 then PRODUCT_PRICE+2000
 when product_class_code =2051 then PRODUCT_PRICE+500
when product_class_code =2052 then PRODUCT_PRICE+600
else PRODUCT_PRICE end as updated_price
 from product
 order by  product_class_code desc;
 
 #2. List the product description, class description and price of all products which are shipped. 
 select product_id,product_desc,product_class_code,product_price from product
 where product_id in
 (select distinct PRODUCT_ID from order_items where order_id in (
 select order_id from order_header
 where order_status ='Shipped'));
 
 #3. Show inventory status of products as below as per their available quantity:
#a. For Electronics and Computer categories, if available quantity is < 10, show 'Low stock', 11 < qty < 30, show 'In stock', > 31, show 'Enough stock'
#b. For Stationery and Clothes categories, if qty < 20, show 'Low stock', 21 < qty < 80, show 'In stock', > 81, show 'Enough stock'
#c. Rest of the categories, if qty < 15 – 'Low Stock', 16 < qty < 50 – 'In Stock', > 51 – 'Enough stock'
#For all categories, if available quantity is 0, show 'Out of stock'.

select product_id,product_desc,p.product_class_code,product_class_desc,PRODUCT_QUANTITY_AVAIL,
case 
when product_class_desc in( 'Electronics','computer') and  PRODUCT_QUANTITY_AVAIL <=10 then 'Low_stock'
when product_class_desc in('Stationery', 'Clothes') and PRODUCT_QUANTITY_AVAIL <=20 then 'low_stock'
when product_class_desc in( 'Electronics','computer') and  PRODUCT_QUANTITY_AVAIL between 11 and 30 then 'In_stock'
when product_class_desc in('Stationery', 'Clothes') and PRODUCT_QUANTITY_AVAIL between 21 and 80 then 'In_stock'
when product_class_desc in( 'Electronics','computer') and  PRODUCT_QUANTITY_AVAIL >31 then 'Enough_stock'
when product_class_desc in('Stationery', 'Clothes') and PRODUCT_QUANTITY_AVAIL >81 then 'Enough_stock'
when product_class_desc in( 'Electronics','computer') and  PRODUCT_QUANTITY_AVAIL =0 then 'out_of_stock'
when product_class_desc in('Stationery', 'Clothes') and PRODUCT_QUANTITY_AVAIL =0 then 'out_of_stock'
else 
	case 
		when PRODUCT_QUANTITY_AVAIL <= 15 then 'Low_stock'
        when PRODUCT_QUANTITY_AVAIL between 16 and 50 then 'In_stock'
        when PRODUCT_QUANTITY_AVAIL >51 then 'Enough_stock'
        when PRODUCT_QUANTITY_AVAIL =0 then 'out_of_stock'
end
end as 'Inventory'
 from product p join
 product_class using(product_class_code);
 
 #4.List customers from outside Karnataka who haven’t bought any toys or books
 select * from online_customer where customer_id in (
 select customer_id from order_header where order_id in (
 select order_id from order_items
 where product_id not in (
 select product_id from product
 where product_class_code in
 (select product_class_code from product_class
 where PRODUCT_CLASS_DESC like '%Toy%' or PRODUCT_CLASS_DESC like '$Book%'))))
 and address_id in (
 select address_id from address where state != 'Karnataka')
 
  