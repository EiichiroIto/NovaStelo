private
pointOfRow: r col: c
	^ (r - 1 - (order // 2)) @ (c - 1 - (order // 2))