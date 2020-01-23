Class {
	#name : #VarDef,
	#superclass : #Object,
	#instVars : [
		'varNames',
		'classNames',
		'reservedVarNames'
	],
	#category : #'FromScratch-Core'
}

{ #category : #private }
VarDef >> add: aString className: aSymbol [
	| id |
	self setupVarNames.
	id := (self includes: aString)
		ifTrue: [ self varNoFor: aString ]
		ifFalse: [ varNames := varNames copyWith: aString.
			varNames size ].
	classNames at: id put: aSymbol.
	^ id
]

{ #category : #accessing }
VarDef >> addComputedVariable: aString varNo: anInteger [
	^ self addReserved: aString varNo: anInteger className: nil
]

{ #category : #accessing }
VarDef >> addList: aString [
	^ self add: aString className: #Array
]

{ #category : #private }
VarDef >> addReserved: aString varNo: anInteger className: aSymbol [
	classNames at: anInteger put: aSymbol.
	reservedVarNames size < anInteger
		ifTrue: [ reservedVarNames := reservedVarNames
				forceTo: anInteger
				paddingWith: nil ].
	reservedVarNames at: anInteger put: aString.
	^ anInteger
]

{ #category : #accessing }
VarDef >> addReservedVariable: aString varNo: anInteger [
	^ self addReserved: aString varNo: anInteger className: #FloatArray
]

{ #category : #accessing }
VarDef >> addVariable: aString [
	^ self add: aString className: #FloatArray
]

{ #category : #accessing }
VarDef >> allVarNames [
	| list |
	list := classNames keys
		select: [ :each | (classNames at: each) notNil ].
	^ list collect: [ :each | varNames at: each ]
]

{ #category : #accessing }
VarDef >> classFor: aString [
	| vno className |
	vno := self varNoFor: aString.
	className := self classNameForVarNo: vno.
	className ifNil: [ ^ nil ].
	^ LazyArray className: className
]

{ #category : #accessing }
VarDef >> classNameForVarNo: anInteger [
	^ classNames at: anInteger
]

{ #category : #accessing }
VarDef >> delete: aString [
	| vno |
	(self includes: aString)
		ifFalse: [ self error: 'cannot delete not existing var' ].
	(self isReserved: aString)
		ifTrue: [ self error: 'cannot delete reserved var' ].
	vno := self varNoFor: aString.
	"varNames := varNames copyWithout: aString."
	varNames at: vno put: nil.
	classNames removeKey: vno
]

{ #category : #'object i/o' }
VarDef >> fieldsVersion [
	^ 1
]

{ #category : #accessing }
VarDef >> fixVars [
	varNames := varNames asOrderedCollection removeDuplicates.
	self regularize
]

{ #category : #testing }
VarDef >> includes: aString [
	^ varNames includes: aString
]

{ #category : #'object i/o' }
VarDef >> initFieldsFrom: anObjStream version: classVersion [
	self initFieldsNamed: #(varNames classNames) from: anObjStream.
	varNames ifNotNil: [ self regularize ]
]

{ #category : #initialization }
VarDef >> initialize [
	super initialize.
	varNames := nil.
	reservedVarNames := Array new.
	classNames := Dictionary new.
	self setupReservedVarNames
]

{ #category : #testing }
VarDef >> isReserved: aString [
	^ reservedVarNames includes: aString
]

{ #category : #accessing }
VarDef >> listNames [
	| list |
	list := classNames keys
		select: [ :each | (classNames at: each) notNil ].
	list := list select: [ :each | (classNames at: each) = #Array ].
	^ list collect: [ :each | varNames at: each ]
]

{ #category : #private }
VarDef >> privClassNames [
	^ classNames
]

{ #category : #private }
VarDef >> privReservedVarNames [
	^ reservedVarNames
]

{ #category : #private }
VarDef >> privReservedVarNames: aCollection [
	reservedVarNames := aCollection
]

{ #category : #private }
VarDef >> privVarNames [
	^ varNames
]

{ #category : #private }
VarDef >> privVarNames: anObject [
	varNames := anObject.
]

{ #category : #accessing }
VarDef >> realVarNames [
	^ self varNames
		withIndexSelect: [ :each :index | (self classNameForVarNo: index) notNil ]
]

{ #category : #accessing }
VarDef >> regularize [
	varNames := varNames copyWithoutAll: reservedVarNames.
	varNames := reservedVarNames , varNames.
	varNames := varNames asArray
]

{ #category : #private }
VarDef >> reservedNo [
	^ reservedVarNames size
]

{ #category : #private }
VarDef >> setupReservedVarNames [
	"do nothing"
]

{ #category : #private }
VarDef >> setupVarNames [
	varNames ifNotNil: [ ^ self ].
	reservedVarNames
		do: [ :each | each ifNil: [ self error: 'reservedVarNames has nil' ] ].
	varNames := reservedVarNames copy
]

{ #category : #accessing }
VarDef >> size [
	^ varNames size
]

{ #category : #'object i/o' }
VarDef >> storeFieldsOn: anObjStream [
	self storeFieldsNamed: #(varNames classNames) on: anObjStream.
]

{ #category : #accessing }
VarDef >> userDefinedVarNames [
	^ self varNames
		reject: [ :each | each isNil or: [ reservedVarNames includes: each ] ]
]

{ #category : #accessing }
VarDef >> userDefinedVarNoAndNames [
	^ self userDefinedVarNames
		collect: [ :each | 
			{(self varNoFor: each).
			each} ]
]

{ #category : #private }
VarDef >> varNames [
	^ varNames ifNil: [ #() ]
]

{ #category : #accessing }
VarDef >> varNoFor: aString [
	aString isEmpty ifTrue: [ ^ nil ].
	(self includes: aString)
		ifFalse: [ ^ NotFound signalFor: self ].
	^ varNames indexOf: aString
]
