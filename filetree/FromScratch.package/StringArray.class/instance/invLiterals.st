private
invLiterals
	^ invLiterals ifNil: [ invLiterals := self generateInvLiterals ]