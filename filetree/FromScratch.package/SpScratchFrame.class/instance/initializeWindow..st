initialization
initializeWindow: aWindow
	aWindow
		initialExtent: self defaultExtent;
		aboutText: application aboutAppString;
		whenClosedDo: [ application windowClosing ].
	application class stickyWindow
		ifTrue: [ aWindow window beSticky ]