private
updateCache
	forceModelChanged := false.
	modelExtent := sworld extent.
	cell := self extent // modelExtent.
	cell := 1 @ 1 * cell min.
	offset := (self extent - (modelExtent * cell)) // 2