extends CharacterBody3D
@onready var animated_sprite_3d: AnimatedSprite3D = $AriSprites
const speed_walk = 1.5
const speed_sprint = 3

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	var speed_current = speed_walk
	if Input.is_action_pressed("Player_Sprint_Movement"):
		speed_current = speed_sprint

	if Input.is_action_pressed("Player_Jump_Movement"):
		velocity.y = 5.0

	var input_dir := Input.get_vector("Player_Left_Movement", "Player_Right_Movement", "Player_Up_Movement", "Player_Down_Movement")

	# Use active camera's basis if available, otherwise fall back to player's own basis
	var cam_basis
	if GlobalCameraSettings.CCTV_active != null:
		cam_basis = GlobalCameraSettings.CCTV_active.CCTV.global_transform.basis
	else:
		cam_basis = transform.basis

	var direction = (cam_basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	direction.y = 0

	if direction:
		velocity.x = direction.x * speed_current
		velocity.z = direction.z * speed_current
	else:
		velocity.x = move_toward(velocity.x, 0, speed_current)
		velocity.z = move_toward(velocity.z, 0, speed_current)

	_set_animation(input_dir)
	move_and_slide()

func _set_animation(input_dir: Vector2) -> void:
	if input_dir.y < 0:
		animated_sprite_3d.play("Sprite_Ari_Up")
	elif input_dir.y > 0:
		animated_sprite_3d.play("Sprite_Ari_Down")
	elif input_dir.x < 0:
		animated_sprite_3d.play("Sprite_Ari_Left")
	elif input_dir.x > 0:
		animated_sprite_3d.play("Sprite_Ari_Right")
	else:
		animated_sprite_3d.play("Sprite_Ari_Default")
