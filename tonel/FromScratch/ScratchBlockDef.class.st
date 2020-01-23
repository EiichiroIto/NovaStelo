Class {
	#name : #ScratchBlockDef,
	#superclass : #Object,
	#instVars : [
		'blockColors',
		'blockSpecs',
		'categoryColors',
		'blocks'
	],
	#category : #'FromScratch-Project'
}

{ #category : #accessing }
ScratchBlockDef >> addCategory: aString color: aColor [
	categoryColors at: aString asLowercase put: aColor
]

{ #category : #private }
ScratchBlockDef >> addSpec: anObject category: aString [
	| list |
	list := blocks at: aString ifAbsentPut: [ OrderedCollection new ].
	list add: anObject copy
]

{ #category : #accessing }
ScratchBlockDef >> blockCategories [
	^ blocks keys
]

{ #category : #accessing }
ScratchBlockDef >> blockColorAt: aSymbol [
	^ blockColors at: aSymbol ifAbsent: [ Color red ]
]

{ #category : #accessing }
ScratchBlockDef >> blockColorFor: aCategory [
	^ categoryColors
		at: aCategory
		ifAbsent: [ self unknownCategoryColor ]
]

{ #category : #accessing }
ScratchBlockDef >> blockSpecAt: aSymbol [
	^ blockSpecs at: aSymbol ifAbsent: [ nil ]
]

{ #category : #accessing }
ScratchBlockDef >> blocksFor: aCategory script: aScript [
	| list result b color |
	list := blocks at: aCategory ifAbsent: [ ^ Array new ].
	color := self blockColorFor: aCategory.
	result := WriteStream on: Array new.
	list
		do: [ :each | 
			(self isSpacer: each)
				ifTrue: [ result nextPut: each ]
				ifFalse: [ (b := aScript blockFromSpec: each color: color)
						ifNotNil: [ result nextPut: b ] ] ].
	^ result contents
]

{ #category : #initialization }
ScratchBlockDef >> initialize [
	blockSpecs := IdentityDictionary new: 250.
	blockColors := IdentityDictionary new: 250.
	categoryColors := Dictionary new.
	blocks := Dictionary new
]

{ #category : #testing }
ScratchBlockDef >> isCategory: aString [
	^ aString isString and: [ (self isSpacer: aString) not ]
]

{ #category : #testing }
ScratchBlockDef >> isSpacer: aString [
	^ #(#- #~) includes: aString
]

{ #category : #private }
ScratchBlockDef >> privBlockColors [
	^ blockColors
]

{ #category : #private }
ScratchBlockDef >> privBlockSpecs [
	^ blockSpecs
]

{ #category : #private }
ScratchBlockDef >> privBlocks [
	^ blocks
]

{ #category : #private }
ScratchBlockDef >> privCategoryColors [
	^ categoryColors
]

{ #category : #accessing }
ScratchBlockDef >> setupFrom: aCollection [
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
]

{ #category : #private }
ScratchBlockDef >> unknownCategoryColor [
	^ Color h: 0 s: 0.81 v: 0.83
]
