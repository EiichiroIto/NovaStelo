event handling
showMenu: anEvent script: aScript
	"Present a menu of Scratch script operations."

	| app menu |
	app := self project application.
	menu := MenuMorph new.
	menu target: app.
	menu add: 'Clear Plots' target: self selector: #clearPlots.
	menu add: 'Save Plots as PNG' selector: #savePlotsAsImage.
	menu localize.
	menu popUpEvent: anEvent in: self world