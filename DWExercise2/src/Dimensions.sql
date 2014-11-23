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