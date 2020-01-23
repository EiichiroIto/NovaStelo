layout
layoutInWidth: w height: h
	"Resize myself to the given width and height. Called during when I am in an AlignmentMorph."

	self extent: w@h.
