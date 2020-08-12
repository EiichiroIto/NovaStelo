private
dataMenu
	^ self newMenu
		addGroup: [ :grp | 
			grp
				addItem: [ :item | 
					item
						name: 'Save Stage as PNG' localized;
						action: [ application saveStageAsImage ] ];
				addItem: [ :item | 
					item
						name: [ application isRecording
								ifTrue: [ 'Stop Stage Recording' localized ]
								ifFalse: [ 'Start Stage Recording' localized ] ];
						autoRefresh: true;
						action: [ application toggleStageRecording ] ] ];
		addGroup: [ :grp | 
			grp
				addItem: [ :item | 
					item
						name: 'Plots Data to Observer List' localized;
						action: [ application copyPlotsToList ] ];
				addItem: [ :item | 
					item
						name: 'Observer List to Plots Data' localized;
						action: [ application copyListToPlots ] ] ];
		yourself