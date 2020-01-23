accessing
getOptionsSelector: aSymbolOrString
	"Set a selector that is used to get a set of options from my command block's receiver. This is used when the options can change over time, such as selecting from a list of available sounds or costumes in the objects media library."

	getOptionsSelector := aSymbolOrString asSymbol.
