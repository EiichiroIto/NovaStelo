Extension { #name : #OSSDL2Driver }

{ #category : #'*FromScratch' }
OSSDL2Driver >> visitDropEvent: dropEvent [

	"The dragged file name comes as a C-string of utf8 encoded bytes.
	Get the string, and decode it to a string using a utf8 decoder"
	| fileName |
	fileName := dropEvent file readString asUTF8Bytes utf8Decoded.
	
	"Free the file handle after it has been read, as specified by SDL2
	https://wiki.libsdl.org/SDL_DropEvent"
	dropEvent file free.
	
	^ OSWindowDropEvent new
		timestamp: dropEvent timestamp;
		filePath: fileName
]
