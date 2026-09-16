extends Node3D

@export var area_CCTV_zone: Area3D
@export var rotation_CCTV_speed: float = 3

@onready var CCTV: Camera3D = $Camera3D

var tracker_player: Node3D = null

func _ready():
	CCTV.current = false  # turn off camera by default when not in used para di magulo sa code later on

	if area_CCTV_zone:
		area_CCTV_zone.body_entered.connect(_on_body_entered)
		area_CCTV_zone.body_exited.connect(_on_body_exited)
	else:
		pass

func _process(delta):
	if tracker_player == null:
		return
	
	# tracks player left and right, no up and down
	var look_player = tracker_player.global_position

	# camera follow
	var target_transform = CCTV.global_transform.looking_at(look_player, Vector3.UP)
	CCTV.global_transform = CCTV.global_transform.interpolate_with(
		target_transform,
		rotation_CCTV_speed * delta
	)

func activate():
	CCTV.current = true

func deactivate():
	CCTV.current = false

func _on_body_entered(body):
	if body.is_in_group("player"):
		tracker_player = body
		GlobalCameraSettings.request_switch(self)

func _on_body_exited(body):
	if body.is_in_group("player"):
		tracker_player = null
