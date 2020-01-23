command
aimHighPatchVar: vid breed: bid id: id
	| x y heading |
	x := (breeds at: bid) xAt: id.
	y := (breeds at: bid) yAt: id.
	heading := (breeds at: bid) headingAt: id.
	^ self patches aimHighVarNo: vid atPoint: x @ y direction: heading