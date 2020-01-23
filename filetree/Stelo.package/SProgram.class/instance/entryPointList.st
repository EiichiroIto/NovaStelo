accessing
entryPointList
	| stream list |
	stream := WriteStream on: Array new.
	entryPoints keys sort
		do: [ :eno | 
			list := (self forEventNo: eno) entryPointList.
			list do: [ :each | stream nextPut: ({eno} , each) ] ].
	^ stream contents