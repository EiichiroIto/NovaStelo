private
installNewProject: aProject
	self stopAllProcesses.
	self sworld: self newWorld.
	project := aProject.
	project application: self.
	project setupScripts.
	project fixVars.
	project modified: false.
	self restoreProject.
	self setupView.
	presenter updateTurtles.
	Smalltalk garbageCollect