Extension { #name : 'Object' }

{ #category : '*FromScratch' }
Object >> asNumberNoError [

	^ 0
]

{ #category : '*FromScratch' }
Object >> initFieldsNamed: varList from: anObjStream [
	"Initialize my instance variables in the given list from the given object stream."

	| allVars |
	allVars := self class allInstVarNames.
	varList
		do: [ :varName | 
			(allVars indexOf: varName)
				in: [ :index | 
					index = 0
						ifTrue: [ anObjStream nextField ]
						ifFalse: [ self instVarAt: index put: anObjStream nextField ] ] ]
]

{ #category : '*FromScratch' }
Object >> isNumberString [
	^ false
]

{ #category : '*FromScratch' }
Object >> localized [

	^ self
]

{ #category : '*FromScratch' }
Object >> storeFieldsNamed: varList on: anObjStream [
	"Store the instance variables in the given list on the given object stream."

	| allVars |
	allVars := self class allInstVarNames.
	varList
		do: [ :varName | 
			(allVars indexOf: varName)
				in: [ :index | 
					index = 0
						ifTrue: [ anObjStream putField: 0 ]
						ifFalse: [ anObjStream putField: (self instVarAt: index) ] ] ]
]
