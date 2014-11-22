CREATE TABLE Produkt (
       productean VARCHAR(20) NOT NULL
     , salesUnit CHAR(10)
     , prodDescription CHAR(10)
     , proName CHAR(10)
     , categoryID CHAR(10)
     , catDescription CHAR(10)
     , catName CHAR(10)
     , PRIMARY KEY (productean)
);

CREATE TABLE Payment (
       paymentID CHAR(10) NOT NULL
     , pmDescription CHAR(10)
     , ccNo CHAR(10)
     , ccv2 CHAR(10)
     , ccOwner CHAR(10)
     , issuedBy CHAR(10)
     , iban CHAR(10)
     , bic CHAR(10)
     , actOwner CHAR(10)
     , accountNo CHAR(10)
     , PRIMARY KEY (paymentID)
);

CREATE TABLE Date (
       dateid CHAR(10) NOT NULL
     , day CHAR(10)
     , month CHAR(10)
     , quarter CHAR(10)
     , year CHAR(10)
     , PRIMARY KEY (dateid)
);

CREATE TABLE Customer (
       customerID INTEGER NOT NULL
     , mobile VARCHAR(20)
     , telephone VARCHAR(20)
     , email VARCHAR(100)
     , webURL VARCHAR(100)
     , CorpName VARCHAR(20)
     , legalForm VARCHAR(20)
     , givenName VARCHAR(20)
     , familyName VARCHAR(20)
     , custType VARCHAR(20)
     , PRIMARY KEY (customerID)
);

CREATE TABLE Sales (
       orderNo CHAR(10)
     , posNo CHAR(10)
     , pricePerUnit CHAR(10)
     , noOfUnits CHAR(10)
     , linePrice CHAR(10)
     , deliveryAddress CHAR(10)
     , remarks CHAR(10)
     , modOfShipment CHAR(10)
     , shipmentdate CHAR(10) NOT NULL
     , customerID INTEGER NOT NULL
     , productean VARCHAR(20) NOT NULL
     , paymentID CHAR(10) NOT NULL
     , shipdate CHAR(10) NOT NULL
     , orderdate CHAR(10) NOT NULL
     , CONSTRAINT FK_Sales_2 FOREIGN KEY (customerID)
                  REFERENCES Customer (customerID)
     , CONSTRAINT FK_Sales_3 FOREIGN KEY (productean)
                  REFERENCES Produkt (productean)
     , CONSTRAINT FK_Sales_4 FOREIGN KEY (paymentID)
                  REFERENCES Payment (paymentID)
     , CONSTRAINT FK_Sales_5 FOREIGN KEY (shipdate)
                  REFERENCES Date (dateid)
     , CONSTRAINT FK_Sales_6 FOREIGN KEY (orderdate)
                  REFERENCES Date (dateid)
);

