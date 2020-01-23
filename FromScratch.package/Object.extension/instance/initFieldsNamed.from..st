*FromScratch
initFieldsNamed: varList from: anObjStream
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