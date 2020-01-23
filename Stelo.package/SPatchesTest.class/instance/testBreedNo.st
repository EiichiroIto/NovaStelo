tests-accessing
testBreedNo
	| o |
	o := SPatches new.
	self assert: o breedNo equals: SBreedId patchBreedNo.
	o breedNo: 123.
	self assert: o breedNo equals: SBreedId patchBreedNo.