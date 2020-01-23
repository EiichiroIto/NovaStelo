accessing
growthFraction: aNumber
	"Set the amount to grow when contents do not fit, expressed as a fraction of the current size. For example, 0.5 makes the contains pane 50% larger if any submorph extends over the edge."

	growthFraction := aNumber max: 0.0.
