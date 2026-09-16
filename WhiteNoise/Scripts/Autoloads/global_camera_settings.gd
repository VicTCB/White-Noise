extends Node

var CCTV_active: Node = null

func request_switch(CCTV_new: Node):

	if CCTV_new == CCTV_active:
		return
	
	# Deactivate the old camera
	if CCTV_active != null:
		CCTV_active.deactivate()

	# Activate the new one
	CCTV_active = CCTV_new
	CCTV_active.activate()
