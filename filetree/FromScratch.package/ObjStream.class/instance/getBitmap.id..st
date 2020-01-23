fixed format-reading
getBitmap: anObject id: classID

	| count result |
	count := stream uint32.
	result := Bitmap new: count.
	1 to: count do: [:i | result at: i put: stream uint32].
	^ result
