extends CharacterBody3D

enum CarStates { CarMoving, CarStop }
var current_CarState = CarStates.CarMoving

@export var CarSpeed = 5

@onready var CarDetect: Area3D = $Area3D
var CarPath: PathFollow3D = null

func _ready():
	CarDetect.body_entered.connect(_on_body_entered)
	CarDetect.body_exited.connect(_on_body_exited)
	
	CarPath = get_parent()

func _physics_process(delta):
	match current_CarState:
		CarStates.CarMoving:
			_follow_path(delta)
		CarStates.CarStop:
			pass

func _follow_path(delta):
	if CarPath == null:
		return

	CarPath.progress += CarSpeed * delta

	global_position = CarPath.global_position
	global_rotation = CarPath.global_rotation
	rotation.y += PI

func _on_body_entered(body):
	if body.is_in_group("player"):
		current_CarState = CarStates.CarStop

func _on_body_exited(body):
	if body.is_in_group("player"):
		current_CarState = CarStates.CarMoving
