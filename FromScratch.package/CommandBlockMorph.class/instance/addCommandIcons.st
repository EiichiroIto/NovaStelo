private
addCommandIcons
	"Add additional icons to certain blocks. Do nothing if this isn't one of those blocks."

	| f m |
	#turnLeft: = selector ifTrue: [
		f := ScratchTheme formAt: #turnCCW.
		m := self firstSubmorph delete.
		self addMorphFront: (ImageMorph new form: f).
		self addMorphFront: m].

	#turnRight: = selector ifTrue: [
		f := ScratchTheme formAt: #turnCW.
		m := self firstSubmorph delete.
		self addMorphFront: (ImageMorph new form: f).
		self addMorphFront: m].

	#stopAll = selector ifTrue: [
		f := ScratchTheme formAt: #stopButton.
		self addMorphBack: (ImageMorph new form: f)].
