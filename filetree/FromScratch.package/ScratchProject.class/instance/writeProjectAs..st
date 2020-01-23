file read/write
writeProjectAs: aFileReference
	| saveError out tmpFile |
	"self scripts setupBlockDef."
	self scripts
		do: [ :m | 
			m blocksBin
				allMorphsDo: [ :b | 
					b isBlockMorph
						ifTrue: [ b stopProcess ] ].
			m convertStacksToTuples ].
	saveError := nil.
	tmpFile := (self
		unusedNameStartingWith: 'tmp'
		in: aFileReference parent) asFileReference.
	SpScratchApp
		try: [ out := tmpFile binaryWriteStream.
			out
				ifNil: [ saveError := 'Folder may be locked or read-only' ]
				ifNotNil: [ out nextPutAll: self appVersion asByteArray.
					self storeProjectInfoOn: out.
					self newObjStream storeObj: self on: out.
					out close ] ]
		onFailure: [ :err :rcvr | 
			out
				ifNotNil: [ [ out close.
					tmpFile delete ] ifError: [  ] ].
			saveError := err ].
	self scripts do: [ :m | m convertTuplesToStacks ].
	saveError
		ifNotNil: [ UIManager default alert: saveError title: 'Save failed'.
			^ false ].
	aFileReference deleteIfAbsent: [  ].
	[ tmpFile renameTo: aFileReference basename ]
		ifError: [ UIManager default
				alert: 'Is the folder read-only?' localized
				title: 'Save failed'.
			^ false ].
	^ true