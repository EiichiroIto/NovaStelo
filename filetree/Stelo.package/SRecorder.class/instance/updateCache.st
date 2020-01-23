private
updateCache
	modelExtent := microworld extent.
	cell := self extent // modelExtent.
	offset := (self extent - (modelExtent * cell)) // 2.