private
buttonNamed: aString
	^ toolBar items detect: [ :each | each label = aString ]