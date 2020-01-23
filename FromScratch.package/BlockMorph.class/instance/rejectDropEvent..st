dropping/grabbing
rejectDropEvent: evt
	"Reject being dropped by the given event."

	evt hand rejectDropMorph: self event: evt.