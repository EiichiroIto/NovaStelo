fixed format-reading
getBigInt: anObject id: classID

	| digitCount result |
	digitCount := stream uint16.
	result := (self classForID: classID) new: digitCount.
	1 to: digitCount do: [:i | result digitAt: i put: stream next].
	^ result
