CREATE TABLE Product (
       productEan CHAR(14) NOT NULL
     , salesUnit VARCHAR(10)
     , prodDescription VARCHAR(200)
     , prodName VARCHAR(50)
     , categoryId INTEGER
     , catDescription VARCHAR(200)
     , catName VARCHAR(50)
     , PRIMARY KEY (productEan)
);

CREATE TABLE Payment (
       paymentId INTEGER NOT NULL
     , pmDescription VARCHAR(200)
     , ccNo VARCHAR(20)
     , ccv2 VARCHAR(20)
     , ccOwner VARCHAR(100)
     , issuedBy VARCHAR(100)
     , iban VARCHAR(34)
     , bic VARCHAR(14)
     , actOwner VARCHAR(100)
     , pmType VARCHAR(10)
     , accountNo VARCHAR(34)
     , PRIMARY KEY (paymentId)
);

CREATE TABLE DateTable (
       dateId INTEGER NOT NULL
     , nDay SMALLINT
     , nMonth SMALLINT
     , nQuarter SMALLINT
     , nYear SMALLINT
     , PRIMARY KEY (dateId)
);

CREATE TABLE Customer (
       customerId INTEGER NOT NULL
     , mobile VARCHAR(20)
     , telephone VARCHAR(20)
     , email VARCHAR(40)
     , webURL VARCHAR(40)
     , corpName VARCHAR(40)
     , legalForm VARCHAR(10)
     , givenName VARCHAR(20)
     , familyName VARCHAR(20)
     , custType CHAR(1)
     , corporation VARCHAR(20)
     , address CHAR(100)
     , privatePerson VARCHAR(20)
     , PRIMARY KEY (customerId)
);

CREATE TABLE Sales (
       orderNo INTEGER NOT NULL
     , posNo SMALLINT NOT NULL
     , pricePerUnit DECIMAL(9,2)
     , noOfUnits SMALLINT
     , linePrice DECIMAL(9,2)
     , deliveryAddress VARCHAR(100)
     , remarks VARCHAR(160)
     , modeOfShipment VARCHAR(20)
     , customerId INTEGER NOT NULL
     , productEan CHAR(14) NOT NULL
     , paymentId INTEGER NOT NULL
     , shipDate INTEGER NOT NULL
     , orderDate INTEGER NOT NULL
     , PRIMARY KEY (orderNo, posNo)
     , CONSTRAINT FK_Sales_2 FOREIGN KEY (customerId)
                  REFERENCES Customer (customerId)
     , CONSTRAINT FK_Sales_3 FOREIGN KEY (productEan)
                  REFERENCES Product (productEan)
     , CONSTRAINT FK_Sales_4 FOREIGN KEY (paymentId)
                  REFERENCES Payment (paymentId)
     , CONSTRAINT FK_Sales_5 FOREIGN KEY (shipDate)
                  REFERENCES DateTable (dateId)
     , CONSTRAINT FK_Sales_6 FOREIGN KEY (orderDate)
                  REFERENCES DateTable (dateId)
);

-- Dimensions

CREATE DIMENSION CustomerDim
	LEVEL customerId IS (Customer.customerId)
	LEVEL corporation IS (Customer.corporation)
	LEVEL privatePerson IS (Customer.privatePerson)
	LEVEL legalForm IS (Customer.legalForm)
	LEVEL custType IS (Customer.custType)
	HIERARCHY legalFormBranch (legalForm CHILD OF corporation CHILD OF customerId)
	HIERARCHY privatePersonCustTypeBranch (custType CHILD OF privatePerson CHILD OF customerId)
	HIERARCHY corporateCustTypeBranch (custType CHILD OF corporation CHILD OF customerId)
	ATTRIBUTE customerId DETERMINES (email, webURL, telephone, mobile, address)
	ATTRIBUTE corporation DETERMINES (corpName)
	ATTRIBUTE privatePerson DETERMINES (givenName, familyName);

CREATE DIMENSION PaymentDim
	LEVEL paymentId IS (Payment.paymentId)
	LEVEL accountNo IS (Payment.accountNo)
	LEVEL ccNo IS (Payment.ccNo)
	LEVEL pmType IS (Payment.pmType)
	LEVEL issuedBy IS (Payment.issuedBy)
	HIERARCHY pmTypeCCNoBranch (pmType CHILD OF ccNo CHILD OF paymentId)
	HIERARCHY pmTypeAccountNoBranch (pmType CHILD OF accountNo CHILD OF paymentId)
	HIERARCHY issuedByBranch (issuedBy CHILD OF ccNo CHILD OF paymentId)
	ATTRIBUTE paymentId DETERMINES (pmDescription)
	ATTRIBUTE accountNo DETERMINES (iban, bic, actOwner)
	ATTRIBUTE ccNo DETERMINES (ccOwner, ccv2);

CREATE DIMENSION ProductDim
	LEVEL productEan IS (Product.productEan)
	LEVEL categoryId IS (Product.categoryId)
	HIERARCHY categoryBranch (categoryId CHILD OF productEan)
	ATTRIBUTE productEan DETERMINES (salesUnit, prodDescription, prodName)
	ATTRIBUTE categoryId DETERMINES (catDescription, catName);

CREATE DIMENSION DatumDim
	LEVEL nDay IS (DateTable.nDay)
	LEVEL nMonth IS (DateTable.nMonth)
	LEVEL nQuarter IS (DateTable.nQuarter)
	LEVEL nYear IS (DateTable.nYear)
	HIERARCHY calendar (nDay CHILD OF nMonth CHILD OF nQuarter CHILD OF nYear);
	
-- Constraints

ALTER TABLE DateTable
	ADD CONSTRAINT CHK_DAY
		CHECK(nDay BETWEEN 1 AND 31) ENABLE;

ALTER TABLE DateTable
	ADD CONSTRAINT CHK_MONTH
		CHECK(nMonth BETWEEN 1 AND 12) ENABLE;

ALTER TABLE DateTable
	ADD CONSTRAINT CHK_QUARTER
		CHECK(nQuarter BETWEEN 1 AND 4) ENABLE;

ALTER TABLE DateTable
	ADD CONSTRAINT CHK_YEAR
		CHECK(nYear > 1900) ENABLE;

ALTER TABLE Customer
	ADD CONSTRAINT CHK_CUSTTYPE
		CHECK(custType IN ('C', 'P')) ENABLE;

-- Indexes

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