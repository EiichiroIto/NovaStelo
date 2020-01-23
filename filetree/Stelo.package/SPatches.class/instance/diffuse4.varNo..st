microworld
diffuse4: anInteger1 varNo: anInteger2
	| buf |
	buf := variables realArrayAt: anInteger2.
	diffuser diffuse: buf order: order percent: anInteger1 neighborSize: 4.