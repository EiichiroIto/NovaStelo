private
convert: anEventCodes eventNo: anInteger
	anEventCodes breedNoList
		do: [ :each | 
			(anEventCodes forBreedNo: each)
				do: [ :code | self addCode: code eventNo: anInteger breed: each ] ]