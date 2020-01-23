event handling
scriptsMenu: anEvent script: aScript
	"Present a menu of Scratch script operations."

	| app menu |
	app := self project application.
	menu := MenuMorph new.
	menu target: app.
	menu
		add: 'add sub block'
		target: app
		selector: #addSubBlock:script:
		argumentList:
			{anEvent.
			aScript}.
	menu addLine.
	menu add: 'clean up' target: self selector: #cleanUp.
	menu add: 'save picture of scripts' selector: #saveScriptsToImage.
	menu localize.
	menu popUpEvent: anEvent in: self world