private
selectButton: aSymbol
	| button |
	button := self instVarNamed: aSymbol.
	button state: currentCategory = button label asString asLowercase