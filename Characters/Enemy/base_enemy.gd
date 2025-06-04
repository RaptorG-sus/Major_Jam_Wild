extends CharacterBody2D

@export var speed :float

@onready var agent :NavigationAgent2D = $Agent


var player :Node = null


@export var gravity = 1000.0
@export var jump_velocity = -640
@export var max_slope_angle = 30.0


func _physics_process(delta :float) -> void:
	
	_apply_gravity(delta)
	var target_pos = agent.get_next_path_position()
	var direction = (target_pos - global_position).normalized()
	
	if agent.is_navigation_finished():
		velocity.x = 0
	# fameux epsilon (pour éviter les trenblement)
	else:
		velocity.x = direction.x * speed

	
	if not is_on_floor() and (agent.get_next_path_position().y - global_position.y) > 0:
		velocity.y += gravity * delta
		
	# Logique de saut simple si obstacle détecté (à améliorer)
	elif should_jump_to_reach(target_pos):
		jump()
	
	move_and_slide()



func _apply_gravity(delta :float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.y = 0

func jump():
	if is_on_floor():
		velocity.y = jump_velocity

func should_jump_to_reach(target_pos: Vector2) -> bool:
	return target_pos.y < global_position.y - 10.0 and is_on_floor() and abs(target_pos.x - global_position.x) < 24 



func _on_finder_body_entered(body: Node2D) -> void:
	if body is Player:
		$Finder/CollisionShape2D.shape.radius *=2
		
		$Timer.start()
		player = body
		agent.target_position = player.global_position


func _on_finder_body_exited(body: Node2D) -> void:
	if body is Player:
		$Finder/CollisionShape2D.shape.radius /=2

		$Timer.stop()
		player = null



func _on_timer_timeout() -> void:
	#recalule
	agent.target_position = player.global_position
