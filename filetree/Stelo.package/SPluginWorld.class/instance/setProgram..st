private
setProgram: aProgram
	| bytecode ext |
	bytecode := aProgram bytecode.
	ext := FFIExternalArray externalNewType: 'byte' size: bytecode size.
	[ bytecode withIndexDo: [ :each :index | ext at: index put: each ].
	plugin setProgram: ext size: bytecode size ]
		ensure: [ ext free ].
	aProgram entryPointList
		do: [ :each | 
			plugin
				addEntryPoint: each third
				eventNo: each first
				breedNo: each second ]