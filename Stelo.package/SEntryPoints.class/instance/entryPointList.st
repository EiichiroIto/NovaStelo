accessing
entryPointList
	| stream list |
	stream := WriteStream on: Array new.
	breeds keys sort
		do: [ :bno | 
			list := self forBreedNo: bno.
			list
				do: [ :address | stream nextPut: (Array with: bno with: address) ] ].
	^ stream contents