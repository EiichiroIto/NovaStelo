accessing
setupFrom: aCollection
	| blockColor sel category |
	blocks := Dictionary new.
	blockColor := Color blue.
	category := nil.
	aCollection
		do: [ :spec | 
			(spec isString and: [ (self isSpacer: spec) not ])
				ifTrue: [ category := spec.
					blockColor := self blockColorFor: category ]
				ifFalse: [ spec isArray
						ifTrue: [ sel := spec at: 3.
							blockSpecs at: sel put: spec.
							blockColors at: sel put: blockColor ].
					self addSpec: spec category: category ] ]