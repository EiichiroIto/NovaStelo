watcher
selectorAndArg
	"Answer an array containing my selector and argument (if any)."

	^ Array with: #getVar: with: self variable
