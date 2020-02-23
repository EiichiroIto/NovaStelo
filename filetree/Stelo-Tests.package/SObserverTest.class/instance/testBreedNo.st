test
testBreedNo
	| o |
	o := SObserver new.
	self assert: o breedNo equals: SBreedId observerBreedNo.
	o breedNo: 123.
	self assert: o breedNo equals: SBreedId observerBreedNo.