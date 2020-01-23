turtle ops
dy
	| delta |
	delta := world delta: breedId at: id.
	self push: delta y