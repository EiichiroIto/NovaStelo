scrolling
scrollSubmorphIntoView: aMorph

	| offset |
	(contents submorphs includes: aMorph) ifFalse: [^ self].
	(self bounds containsRect: aMorph fullBounds) ifTrue: [^ self].

	(aMorph fullBounds bottom > self bottom) ifTrue: [
		offset := aMorph fullBounds bottom - contents top.
		contents top: (self bottom - 3) - offset].

	(aMorph fullBounds top < self top) ifTrue: [
		offset := aMorph fullBounds top - contents top.
		contents top: (self top + 3) - offset].

	self updateScrollbars.
