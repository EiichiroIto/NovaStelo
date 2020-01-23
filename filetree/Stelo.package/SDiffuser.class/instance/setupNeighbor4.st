private
setupNeighbor4
	| list |
	list := OrderedCollection new.
	list add: 1.
	list add: -1.
	list add: rows negated.
	list add: rows.
	neighbor := list asArray.
	cornerIndexes := #(2 4 6 8).