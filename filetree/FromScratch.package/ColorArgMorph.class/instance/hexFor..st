other
hexFor: aNumber
	"Answer a string representing the given number, rounded, in hexadecimal."

	| s |
	s := (255.0 * aNumber) rounded hex.
	s := s copyFrom: 4 to: s size.
	s := (String new: 2 - s size withAll: $0), s.  "pad to two digits"
	^ s
