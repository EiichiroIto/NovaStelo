accessing variable
varsBreed: bno at: id
	| stream breed v vno |
	stream := WriteStream on: Array new.
	stream
		nextPut:
			{'id'.
			id}.
	breed := self breedOf: bno.
	breed varNames
		do: [ :each | 
			vno := breed varNoFor: each.
			v := self var: vno breed: bno at: id.
			stream
				nextPut:
					{each.
					v} ].
	^ stream contents