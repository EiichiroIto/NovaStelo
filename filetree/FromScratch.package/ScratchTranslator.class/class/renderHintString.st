Unicode rendering
renderHintString
	"Answer a string to be used as an example button lable to adjust button size and label centering."

	"self renderHintString"

	"self showHintString"

	| stream |
	stream := WriteStream on: String new.
	#('New' 'Open' 'Save' 'Save As' 'Share!' 'Undo' 'Language' 'Extras' 'Want Help?' 'motion' 'looks' 'sound' 'pen' 'control' 'sensing' 'operators' 'variables')
		do: [ :each | stream nextPutAll: each ].
	^ stream contents