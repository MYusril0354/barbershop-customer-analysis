WITH datajumlah_qty AS (SELECT
    SUBSTR(c.name,1,INSTR(c.name,' ')-1)[name],
    o.order_date,
    SUM(o.amount)[jumlah],COUNT(*) OVER(PARTITION BY SUBSTR(c.name,1,INSTR(c.name,' ')-1))[qty_transaksi]
FROM orders o
JOIN customers c ON o.customer_id=c.customer_id
GROUP BY name
ORDER BY qty_transaksi DESC)

SELECT name,
       qty_transaksi 
FROM datajumlah_qty
GROUP BY name
HAVING qty_transaksi>7
ORDER BY qty_transaksi DESC;

WITH datajumlah_qty AS (SELECT
    SUBSTR(c.name,1,INSTR(c.name,' ')-1)[name],
    o.order_date,
    SUM(o.amount)[jumlah],COUNT(*) OVER(PARTITION BY SUBSTR(c.name,1,INSTR(c.name,' ')-1))[qty_transaksi]
FROM orders o
JOIN customers c ON o.customer_id=c.customer_id
GROUP BY name
ORDER BY qty_transaksi DESC)

SELECT *
FROM datajumlah_qty;