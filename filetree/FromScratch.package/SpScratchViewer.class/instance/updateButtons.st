private
updateButtons
	self class buttons
		do: [ :each | 
			| name |
			self selectButton: each first.
			name := each second.
			(self instVarNamed: each first)
				icon:
					(ScratchTheme
						formAt:
							(name asLowercase = currentCategory
								ifTrue: [ (name , 'Pressed') asSymbol ]
								ifFalse: [ name ])) ]