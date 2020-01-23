private
importScripts: aCollection
	| script |
	aCollection
		do: [ :each | 
			each first = 'for'
				ifTrue: [ script := project findObjName: each second.
					each third do: [ :v | script addVariable: v ].
					self importScripts: each fourth for: script ] ]