private
addressOfSubName: aString
	subTable ifNil: [ self error ].
	^ subTable at: aString