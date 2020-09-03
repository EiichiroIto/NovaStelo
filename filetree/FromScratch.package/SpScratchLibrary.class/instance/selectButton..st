accessing
selectButton: aString
	buttonMain state: (self mainLabel = aString).
	buttonOther state: (self otherLabel = aString)