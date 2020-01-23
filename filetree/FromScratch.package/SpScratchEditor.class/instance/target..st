accessing
target: aScratchObjectOrNil
	target := aScratchObjectOrNil.
	aScratchObjectOrNil
		ifNil: [ labelName label: 'no object' localized.
			self editorContents: (Morph new color: Color red).
			^ self ].
	labelName label: aScratchObjectOrNil objName.
	self currentTab: self scriptsLabel