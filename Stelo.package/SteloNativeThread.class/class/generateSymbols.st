acccessing
generateSymbols
	"self generateSymbols inspect."
	| w |
	self setupCachedSymbols.
	w := WriteStream on: ''.
	w
		nextPutAll: 'enum SteloSymbol {';
		nextPutAll: String lf;
		nextPutAll: '  SS_nop = -1,';
		nextPutAll: String lf.
	cachedSymbols
		withIndexDo: [ :each :index | 
			w
				nextPutAll: '  SS_';
				nextPutAll: each;
				nextPutAll: ',';
				nextPutAll: ' /* ';
				nextPutAll: (index - 1) asString;
				nextPutAll: ' */';
				nextPutAll: String lf ].
	w
		nextPutAll: '};';
		nextPutAll: String lf.
	^ w contents