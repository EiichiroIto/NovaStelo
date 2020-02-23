initialization
initializeWindow: aWindow
	aWindow
		initialExtent: self defaultExtent;
		aboutText: application aboutAppString.
	application class stickyWindow
		ifTrue: [ aWindow window beSticky ]