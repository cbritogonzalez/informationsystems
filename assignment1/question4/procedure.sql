CREATE OR REPLACE PROCEDURE CALCULATE_MONTHLY_BOOK_SALES() LANGUAGE PLPGSQL AS $$
DECLARE
	item record;
BEGIN -- subtracting the amount from the sender's account
	FOR item in SELECT order_details::jsonb->>'order_id' as orderid, jsonb_array_elements_text(order_details::jsonb->'prices')::DECIMAL as price, jsonb_array_elements_text(order_details::jsonb->'book_titles') as book_title, EXTRACT(MONTH FROM TO_DATE(order_details::jsonb->>'order_date', 'YYYY-MM-DD')) as order_month, EXTRACT(YEAR FROM TO_DATE(order_details::jsonb->>'order_date', 'YYYY-MM-DD')) as order_year FROM customer_orders as co
	WHERE co.order_details::jsonb->>'order_id' not in (select orderid from processedordersforreport)
	LOOP
		INSERT INTO MonthlySalesReportPerBook as mpb (Month, Year, BookTitle, TotalSales) 
		VALUES (item.order_month, item.order_year, item.book_title, item.price) 
		ON CONFLICT(month, year, booktitle) DO UPDATE SET TotalSales= mpb.TotalSales + item.price WHERE item.book_title = mpb.BookTitle AND item.order_year = mpb.year AND item.order_month = mpb.month;
-- 		RAISE NOTICE '% % % %', item.price, item.book_title, item.order_month, item.order_year;		
		INSERT INTO processedordersforreport as pfr (orderid) 
		VALUES (item.orderid) 
		ON CONFLICT(orderid) DO NOTHING;
	END LOOP;
END;
$$