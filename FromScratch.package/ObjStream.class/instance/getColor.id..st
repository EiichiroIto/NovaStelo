fixed format-reading
getColor: anObject id: classID
	| rgb |
	firstPass
		ifFalse: [ ^ anObject ].
	rgb := stream uint32.
	^ Color basicNew
		setRGB: rgb;
		setAlpha: stream next / 255.0.