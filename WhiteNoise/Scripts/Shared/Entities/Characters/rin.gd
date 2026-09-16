extends StaticBody3D

@export var dialogue_resource: DialogueResource
@export var dialogue_start: String = "start"

var player_in_range: bool = false

@onready var interaction_area: Area3D = $Area3D

func _ready():
	interaction_area.body_entered.connect(_on_body_entered)
	interaction_area.body_exited.connect(_on_body_exited)

func _process(delta):
	if player_in_range and Input.is_action_just_pressed("Player_Interact_Action"):
		_interact()

func _interact():
	DialogueManager.show_dialogue_balloon(dialogue_resource, dialogue_start)

func _on_body_entered(body):
	if body.is_in_group("player"):
		player_in_range = true

func _on_body_exited(body):
	if body.is_in_group("player"):
		player_in_range = false
