accessing
fromProgram: aProgram
	stream := WriteStream on: Array new.
	self convert: aProgram.
	^ stream contents