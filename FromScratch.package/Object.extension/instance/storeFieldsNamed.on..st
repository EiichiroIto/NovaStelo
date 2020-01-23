*FromScratch
storeFieldsNamed: varList on: anObjStream
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