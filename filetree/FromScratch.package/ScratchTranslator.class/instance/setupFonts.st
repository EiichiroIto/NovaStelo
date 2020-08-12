private
setupFonts
	| str |
	str := self textAt: 'ArgFont'.
	(self fontFromString: str)
		ifNotNil: [ :font | self fontAt: 'Arg' put: font ].
	str := self textAt: 'ButtonFont'.
	(self fontFromString: str)
		ifNotNil: [ :font | 
			self fontAt: 'Button' put: font.
			StandardFonts buttonFont: font ].
	str := self textAt: 'LabelFont'.
	(self fontFromString: str)
		ifNotNil: [ :font | 
			self fontAt: 'Label' put: font.
			StandardFonts
				listFont: font;
				menuFont: font;
				defaultFont: font ].
	str := self textAt: 'CodeFont'.
	(self fontFromString: str)
		ifNotNil: [ :font | StandardFonts codeFont: font ].
	str := self textAt: 'TitleFont'.
	(self fontFromString: str)
		ifNotNil: [ :font | 
			StandardFonts
				windowTitleFont: font;
				balloonFont: font ]