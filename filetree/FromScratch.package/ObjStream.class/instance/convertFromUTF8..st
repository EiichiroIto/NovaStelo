private
convertFromUTF8: aString
	^ UTF8TextConverter new convertFromSystemString: aString asString asByteString