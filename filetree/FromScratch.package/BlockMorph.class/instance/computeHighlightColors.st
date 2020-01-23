drawing
computeHighlightColors

	| h s v |
	h := color hue.
	s := color saturation.
	v := color brightness.
	highlightColor1 := Color h: h s: (s - 0.13) v: (v + 0.1).
	highlightColor2 := Color h: h s: s v: (v + 0.07).
	shadowColor := color mixed: 0.7 with: Color black.
