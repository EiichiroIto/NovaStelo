private
selectButtons
	(self class buttons collect: #first)
		do: [ :each | self selectButton: each ]