specs
defaultSpec
	^ SpBoxLayout newVertical
		add: #labelName;
		add:
			(SpBoxLayout newHorizontal
				add: #clearTurtleButton;
				add: #clearPatchesButton;
				add: #setupButton;
				add: #stepButton;
				add: #stopButton;
				add: #eventButton;
				add: #loopSlowButton;
				add: #loopButton;
				yourself);
		yourself