accessing
ensureOSFont

	font isOSFont ifFalse: [
		self font: (StrikeFont osFontName: 'Helvetica Bold' size: font pointSize)].
