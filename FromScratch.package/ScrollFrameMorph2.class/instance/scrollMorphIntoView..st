scrolling
scrollMorphIntoView: aMorph

	| offset |
	(self bounds containsRect: aMorph fullBounds) ifTrue: [^ self].

	((aMorph fullBounds top < self top) and: [(aMorph fullBounds top < contents top) not]) ifTrue: [
		offset := aMorph fullBounds top - contents top.
		contents top: (self top + 3) - offset].

	((aMorph fullBounds left < self left) and: [(aMorph fullBounds left < contents left) not]) ifTrue: [
		offset := aMorph fullBounds left - contents left.
		contents left: (self left + 3) - offset].

	(aMorph fullBounds right > self right) ifTrue: [
		offset := aMorph fullBounds right - contents left.
		contents left: (self right - 3) - offset].

	(aMorph fullBounds bottom > self bottom) ifTrue: [
		offset := aMorph fullBounds bottom - contents top.
		contents top: (self bottom - 3) - offset].

	self updateContentsExtent.
	self updateScrollbars.
