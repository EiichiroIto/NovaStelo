private
setupNeighbor8
	| list |
	list := OrderedCollection new.
	list add: 1.
	list add: -1.
	list add: rows negated - 1.
	list add: rows negated.
	list add: rows negated + 1.
	list add: rows - 1.
	list add: rows.
	list add: rows + 1.
	neighbor := list asArray.
	cornerIndexes := #(1 2 3 4 6 7 8 9).