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

