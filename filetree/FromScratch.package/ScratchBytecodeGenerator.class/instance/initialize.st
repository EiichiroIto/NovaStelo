initialization
initialize
	super initialize.
	stream := WriteStream on: Array new.
	labelId := BaseId new.
	address := 1.