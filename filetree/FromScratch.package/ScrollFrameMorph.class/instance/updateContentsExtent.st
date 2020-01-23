private
updateContentsExtent
	"Make sure my content morph is large enough to both enclose all it's submorphs and to fill me. Adjust the scroll offsets if my bounds have shrunk."

	| r delta scrolledOff w h visible |
	r := self contentsBounds.
	((r left < 0) or: [r top < 0]) ifTrue: [
		"contents has morphs that stick out over its top or left edge"
		delta := (r topLeft truncated min: (0@0)) negated.
		contents submorphsDo: [:m | m position: m position + delta]].  "move all submorphs by delta"

	visible := self visibleExtent - (8@20).
	w := visible x. r width > w ifTrue: [w := (r width + (growthFraction * visible x)) rounded].
	h := visible y. r height > h ifTrue: [h := (r height + (growthFraction * visible y))  rounded].

	scrolledOff := ((self topLeft + borderWidth) - contents position) max: 0@0.
	contents extent: ((w@h) max: (self visibleExtent + scrolledOff)).
	contentsChanged := false.
