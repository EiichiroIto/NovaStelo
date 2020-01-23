private-reading
fixRefsInArray: anArray
	"Replace any ObjRefRecord objects in the given array with references to the actual objects."

	| el |
	1 to: anArray size do: [:i |
		el := anArray at: i.
		el class = ObjRefRecord ifTrue: [
			el objectID > objects size
				ifTrue: [anArray at: i put: #badObjRef]
				ifFalse: [anArray at: i put: (objects at: el objectID) first]]].
