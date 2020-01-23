private
pushFloat
	| v |
	v := codes at: pc.
	pc := pc + 1.
	v := (codes at: pc) * 16r100 + v.
	pc := pc + 1.
	v := (codes at: pc) * 16r10000 + v.
	pc := pc + 1.
	v := (codes at: pc) * 16r1000000 + v.
	pc := pc + 1.
	v := Float fromIEEE32Bit: v.
	self push: v