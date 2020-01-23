other
computeHighlightColors

	| h s v |
	h := color hue.
	s := color saturation.
	v := color brightness.
	highlightColor1 := Color h: h s: (s - 0.13) v: (v + 0.17).
	highlightColor2 := Color h: h s: s v: (v + 0.06).
	shadowColor := color mixed: 0.8 with: Color black.
