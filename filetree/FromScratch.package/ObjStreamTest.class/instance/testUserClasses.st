tests
testUserClasses
	"Test conversions for fixed-format objects."

	| userClassList suspectClasses |
	userClassList := self newObjStream class userClasses
		collect: [ :rec | Smalltalk at: rec second ].
	userClassList := userClassList
		reject: [ :cl | (cl inheritsFrom: BlockMorph) | (cl inheritsFrom: ArgMorph) ].
	userClassList do: [ :cl | self serializeAndDeserialize: cl new ].
	suspectClasses := userClassList
		select: [ :cl | 
			(cl includesSelector: #fieldsVersion) not
				and: [ cl instVarNames notEmpty ] ].
	self assert: suspectClasses isEmpty