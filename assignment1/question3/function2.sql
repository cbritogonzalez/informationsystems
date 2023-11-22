CREATE OR REPLACE FUNCTION list_unique_books()
RETURNS TABLE("unique_booktitle" VARCHAR) AS
$$
DECLARE
    unique_books VARCHAR[];
BEGIN
    SELECT ARRAY_AGG(b."booktitle") INTO unique_books
    FROM (
        SELECT "booktitle"
        FROM bookstore
        GROUP BY "booktitle"
    ) b;

    RETURN QUERY SELECT unnest(unique_books);
END;
$$
LANGUAGE plpgsql;
