accessing
choice: aSymbol
	"Update the toggle button when an argument is changed within a block."

	| block doLocalization label |
	"frame := self meOrOwnerThatIsA: ScratchFrameMorph."
	"((#soundNames = getOptionsSelector) and:
	 [aSymbol = ('record' localized, ScratchTranslator ellipsesSuffix)]) ifTrue: [
		frame ifNotNil: [^ frame newSound]]."

	"((#sceneNames = getOptionsSelector) and:
	 [aSymbol = ('record' localized, ScratchTranslator ellipsesSuffix)]) ifTrue: [
		frame ifNotNil: [^ frame workPane newScene]]."

	"((#sceneNames = getOptionsSelector) and:
	 [aSymbol = ('re-record' localized, ScratchTranslator ellipsesSuffix)]) ifTrue: [
		frame ifNotNil: [^ frame workPane rerecordScene]]."

	choice := label := aSymbol.
	(label isKindOf: String) ifFalse: [label := label asString].
	doLocalization := (#( varNames ) includes: getOptionsSelector) not.
	doLocalization
		ifTrue:[labelMorph contents: label localized]
		ifFalse:[labelMorph contents: label].
	labelMorph position: self position + borderWidth + (3 @ -1).
	labelMorph layoutChanged; changed.
	self extent: (labelMorph extent + (16@2) + borderWidth).

	menuIconMorph position: (self right - borderWidth - 10)@(self top + borderWidth + 4).

	(block := self meOrOwnerThatIsA: HatBlockMorph) ifNotNil: [
		block fixBlockLayout].

	"(palette := self meOrOwnerThatIsA: ScratchBlockPaletteMorph) ifNil: [^ self].
	(block := self meOrOwnerThatIsA: BlockMorph) ifNil: [^ self]."

	"block isReporter ifTrue: [palette updateWatcherButtonsForFrame: frame].
"