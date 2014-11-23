CREATE INDEX IDX_SALE_CUSTOMERID ON Sale (customerId) NOPARALLEL;

CREATE INDEX IDX_SALE_PAYMENTID ON Sale (paymentId) NOPARALLEL;

CREATE INDEX IDX_SALE_PRODUCTEAN ON Sale (productEan) NOPARALLEL;

CREATE INDEX IDX_SALE_SHIPDATE ON Sale (shipDate) NOPARALLEL;

CREATE INDEX IDX_SALE_ORDERDATE ON Sale (orderDate) NOPARALLEL;

CREATE BITMAP INDEX IDX_SALE_MODEOFSHIPMENT ON Sale (modeOfShipment) NOPARALLEL;

CREATE BITMAP INDEX IDX_PRODUCT_SALE ON Sale(prodName, prodDescription, categoryId, catDescription)
	FROM Sale s, Product p
	WHERE s.productEan = p.productEan;

CREATE BITMAP INDEX IDX_CUST_SALE ON Sale (address, corpName, givenName, familyName)
	FROM Sale s, Product p
	WHERE s.customerId = p.customerId;

CREATE BITMAP INDEX IDX_ORDER_SALE ON Sale (nDay, nMonth, nQuarter , nYear)
	FROM Sale s, DateTable d 
	WHERE s.shipDate = d.dateId;

REATE BITMAP INDEX IDX_PAYMENT_SALE ON Sale(pmType, actOwner, ccOwner)
	FROM Sale s, Date d
	WHERE s.paymentId = d.paymentId;