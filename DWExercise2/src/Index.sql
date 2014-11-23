CREATE INDEX IDX_SALE_CUSTOMERID ON Sales (customerId) NOPARALLEL;

CREATE INDEX IDX_SALE_PAYMENTID ON Sales (paymentId) NOPARALLEL;

CREATE INDEX IDX_SALE_PRODUCTEAN ON Sales (productEan) NOPARALLEL;

CREATE INDEX IDX_SALE_SHIPDATE ON Sales (shipDate) NOPARALLEL;

CREATE INDEX IDX_SALE_ORDERDATE ON Sales (orderDate) NOPARALLEL;

CREATE BITMAP INDEX IDX_SALE_MODEOFSHIPMENT ON Sales (modeOfShipment) NOPARALLEL;

-- BITMAP JOIN INDEXES:

CREATE BITMAP INDEX IDX_PRODUCT_SALE ON Sales(prodName, prodDescription, categoryId, catDescription)
	FROM Sales s, Product p
	WHERE s.productEan = p.productEan;

CREATE BITMAP INDEX IDX_CUST_SALE ON Sales (address, corpName, givenName, familyName)
	FROM Sales s, Customer c
	WHERE s.customerId = c.customerId;

CREATE BITMAP INDEX IDX_ORDER_SALE ON Sales (nDay, nMonth, nQuarter , nYear)
	FROM Sales s, DateTable d 
	WHERE s.shipDate = d.dateId;

CREATE BITMAP INDEX IDX_PAYMENT_SALE ON Sales(pmType, actOwner, ccOwner)
	FROM Sales s, Payment p
	WHERE s.paymentId = p.paymentId;