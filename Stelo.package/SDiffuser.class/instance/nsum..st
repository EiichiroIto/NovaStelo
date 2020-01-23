accessing
nsum: anArray
	self privSrc: anArray.
	self nsumInner.
	self borders do: [ :each | self nsumBorderAt: each ].
	self corners do: [ :each | self nsumCornerAt: each ].
	^ dst