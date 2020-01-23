private
indexAtCol: c row: r
	| i |
	i := (r - 1) * order + c.
	^ ((i - 1) \\ self size) + 1