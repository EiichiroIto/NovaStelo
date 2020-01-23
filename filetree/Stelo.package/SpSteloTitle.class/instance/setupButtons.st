private
setupButtons
	toolBar
		addItem:
			(SpToolBarButton new
				label: 'ClearT';
				icon: (ScratchTheme formAt: #clearTurtlesButtonGray);
				help: 'Clear turtles');
		addItem:
			(SpToolBarButton new
				label: 'ClearP';
				icon: (ScratchTheme formAt: #clearGraphicsButtonGray);
				help: 'Clear patches');
		addItem:
			(SpToolBarButton new
				label: 'Setup';
				icon: (ScratchTheme formAt: #setupButtonGray);
				help: 'Setup');
		addItem:
			(SpToolBarButton new
				label: 'Stop';
				icon: (ScratchTheme formAt: #stopButtonGray);
				help: 'Stop');
		addItem:
			(SpToolBarButton new
				label: 'Step';
				icon: (ScratchTheme formAt: #stepButtonGray);
				help: 'Step');
		addItem:
			(SpToolBarButton new
				label: 'Slowly';
				icon: (ScratchTheme formAt: #loopSlowButtonGray);
				help: 'Loop slowly');
		addItem:
			(SpToolBarButton new
				label: 'Loop';
				icon: (ScratchTheme formAt: #loopButtonGray);
				help: 'Loop')