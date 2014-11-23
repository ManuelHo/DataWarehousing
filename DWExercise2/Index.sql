CREATE INDEX IDX_SALE_CUSTOMERID ON Sale (customerId) NOPARALLEL;

CREATE INDEX EDX_SALE_PAYMENTID ON Sale (paymentId) NOPARALLEL;

CREATE INDEX EDX_SALE_PRODUCTEAN ON Sale (productEan) NOPARALLEL;

CREATE INDEX EDX_SALE_SHIPDATE ON Sale (shipDate) NOPARALLEL;

CREATE INDEX EDX_SALE_ORDERDATE ON Sale (orderDate) NOPARALLEL;

CREATE BITMAP INDEX EDX_SALE_MODEOFSHIPMENT ON Sale (modeOfShipment) NOPARALLEL;


Create BITMAP INDEX BJIX_Product_Sale on Sale(prodName, prodDescriptiont, categoryID, catDescription)
From Sale s, Produkt p
Where s.produktEan = p.produtEan

Create Bitmap Index BJIX_Cust_Sale on Sale ( address, corpname, givenName, familiyName) 