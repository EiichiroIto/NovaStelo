accessing
diffuse: anInteger array: anArray
	self privSrc: anArray.
	self diffuseInner: anInteger.
	self borders do: [ :each | self diffuseBorder: anInteger at: each ].
	self corners do: [ :each | self diffuseCorner: anInteger at: each ].
	^ dst