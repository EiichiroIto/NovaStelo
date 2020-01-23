Class {
	#name : #Variables,
	#superclass : #Object,
	#instVars : [
		'vars',
		'varNames'
	],
	#category : #'FromScratch-Core'
}

{ #category : #accessing }
Variables >> clear [
	vars ifNil: [ ^ self ].
	vars do: [ :each | each ifNotNil: #reset ].
]

{ #category : #accessing }
Variables >> clearVarNo: anInteger [
	(self varAt: anInteger) reset.
]

{ #category : #accessing }
Variables >> copyElementFrom: anInteger1 to: anInteger2 [
	vars do: [ :each | each at: anInteger2 put: (each at: anInteger1) ].
]

{ #category : #'object i/o' }
Variables >> fieldsVersion [
	^ 1
]

{ #category : #private }
Variables >> fixVars: varId [
	| desirableClass |
	self updateVarDef: varId.
	vars
		withIndexDo: [ :each :index | 
			each
				ifNotNil: [ desirableClass := varId classNameForVarNo: index.
					desirableClass
						ifNil: [ vars at: index put: nil ]
						ifNotNil: [ each className ~= desirableClass
								ifTrue: [ self error. vars at: index put: (each className: desirableClass) ] ] ] ]
]

{ #category : #accessing }
Variables >> forceSize: anInteger [
	vars
		withIndexDo: [ :each :index | each ifNotNil: [ each forceSize: anInteger ] ]
]

{ #category : #'object i/o' }
Variables >> initFieldsFrom: anObjStream version: classVersion [
	self initFieldsNamed: #(vars varNames) from: anObjStream.
]

{ #category : #initialization }
Variables >> initialize [
	varNames := #().
	vars := nil.
]

{ #category : #accessing }
Variables >> max [
	^ (vars collect: #size) max
]

{ #category : #accessing }
Variables >> multiply: vno by: aNumber [
	vno = 0
		ifTrue: [ ^ self ].
	^ (self varAt: vno) multiplyBy: aNumber
]

{ #category : #private }
Variables >> privVarNames [
	^ varNames
]

{ #category : #private }
Variables >> privVarNames: aCollection [
	varNames := aCollection.
]

{ #category : #private }
Variables >> privVars [
	^ vars
]

{ #category : #private }
Variables >> privVars: aCollection [
	vars := aCollection
]

{ #category : #accessing }
Variables >> realArrayAt: anInteger [
	^ (self varAt: anInteger) array
]

{ #category : #accessing }
Variables >> setVar: anInteger toAll: anObject [
	(self varAt: anInteger asInteger)
		in:
			[ :variable | 1 to: variable size do: [ :each | variable at: each put: anObject ] ]
]

{ #category : #accessing }
Variables >> setVar: anInteger toArray: aCollection [
	(self varAt: anInteger) setArray: aCollection.
]

{ #category : #accessing }
Variables >> size [
	^ self max
]

{ #category : #'object i/o' }
Variables >> storeFieldsOn: anObjStream [
	self storeFieldsNamed: #(vars varNames) on: anObjStream.
]

{ #category : #accessing }
Variables >> updateVarDef: aVarId [
	| newVarNames newVars index class size |
	size := nil.
	newVarNames := aVarId varNames asArray.
	varNames = newVarNames
		ifTrue: [ ^ self ].
	newVars := newVarNames
		collect: [ :each | 
			index := varNames indexOf: each.
			index = 0
				ifTrue: [ class := aVarId classFor: each.
					(class notNil and: [ size notNil ])
						ifTrue: [ class forceSize: size ] ]
				ifFalse: [ class := vars at: index.
					(class notNil and: [ class isFixed ])
						ifTrue: [ size := class fixedSize ] ].
			class ].
	vars := newVars.
	varNames := newVarNames
]

{ #category : #accessing }
Variables >> var: anInteger at: id [
	id = 0
		ifTrue: [ ^ 0 ].
	^ (self varAt: anInteger asInteger) at: id
]

{ #category : #accessing }
Variables >> var: anInteger at: id put: anObject [
	id = 0
		ifTrue: [ ^ self ].
	(self varAt: anInteger asInteger) at: id put: anObject.
]

{ #category : #accessing }
Variables >> var: anInteger list: id [
	^ (self varAt: anInteger asInteger) list: id
]

{ #category : #accessing }
Variables >> var: anInteger list: id add: anObject [
	(self varAt: anInteger asInteger) list: id add: anObject
]

{ #category : #accessing }
Variables >> var: anInteger list: id at: anInteger2 [
	^ (self varAt: anInteger asInteger) list: id at: anInteger2
]

{ #category : #accessing }
Variables >> var: anInteger list: id at: anInteger2 put: aNumber [
	(self varAt: anInteger asInteger) list: id at: anInteger2 put: aNumber
]

{ #category : #accessing }
Variables >> var: anInteger list: id contains: anInteger2 [
	^ (self varAt: anInteger asInteger) list: id contains: anInteger2
]

{ #category : #accessing }
Variables >> var: anInteger list: id remove: anObject [
	(self varAt: anInteger asInteger) list: id remove: anObject
]

{ #category : #accessing }
Variables >> var: anInteger list: id set: aCollection [
	(self varAt: anInteger asInteger) list: id set: aCollection
]

{ #category : #accessing }
Variables >> var: anInteger listSizeOf: id [
	^ (self varAt: anInteger asInteger) listSizeOf: id
]

{ #category : #accessing }
Variables >> varAt: anInteger [
	^ vars at: anInteger
]
