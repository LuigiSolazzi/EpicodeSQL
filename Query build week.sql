-- Ogni qual volta un prodotto viene venduto in un negozio, qual è la query da eseguire per aggiornare le tabelle di riferimento?

rollback ;


start transaction;
INSERT INTO Sales (Date, StockID, Amount) VALUES (CURDATE(), 7, 2000.00);
SET @sales_id = LAST_INSERT_ID();
INSERT INTO SalesRow (SalesID, SalesRowID, FK2_ProductID, Quantity, UnitPrice) VALUES ( @sales_id, 1, 1, 2, 1000.00);
UPDATE Stock SET Quantity = Quantity - 2 WHERE StockID = 7 AND FK3_ProductID = 1;
COMMIT;
-- Quali sono le query da eseguire per verificare quante unità di un prodotto ci sono in un dato magazzino e per monitorare le soglie di restock?

start transaction;
UPDATE Stock SET Quantity = Quantity - 10 WHERE StockID = 6 AND FK3_ProductID = 6;
COMMIT;

SELECT 
    s.ShopID,
    p.ProductID,
    p.NameProduct,
    st.Quantity,
    st.RestockLevel,
    (st.Quantity < st.RestockLevel) AS NeedsRestock
FROM 
    Stock st
JOIN 
    Product p ON st.FK3_ProductID = p.ProductID
JOIN 
    Shop s ON st.FK1_ShopID = s.ShopID
WHERE 
    st.FK1_ShopID = 3 AND p.ProductID = 6;