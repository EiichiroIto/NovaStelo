geometry
extent: aRectangle
	"Overridden because SimpleButtonMorph tries to center the label, if there is one, and we want manual control."

	| label oldP oldPSub |
	(label := self findA: StringMorph) ifNil: [
		(self submorphCount = 1) ifTrue: [oldPSub := self firstSubmorph position].
		super extent: aRectangle.
		(self submorphCount = 1) ifTrue: [self firstSubmorph position: oldPSub].
		^self].
	oldP := label position.
	super extent: aRectangle.
	label position: oldP.
