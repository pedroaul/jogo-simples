extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var is_attacking = false
var takingDamage = false
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	
	
	gameOver()
	print(Global.vidaKuma)
	
	
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		is_attacking == false
	
	
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction and Input.is_action_pressed("ui_right"):
		velocity.x = direction * SPEED
		$AnimatedSprite2D.flip_h = false
		$bater/hitEs.disabled = true
		$bater/hitDi.disabled = false
		$'AnimatedSprite2D'.play("running")
		is_attacking = false
	elif Input.is_action_pressed("ui_left"):
		$AnimatedSprite2D.flip_h = true
		$bater/hitDi.disabled = true
		$bater/hitEs.disabled = false
		is_attacking = false
		velocity.x = direction * SPEED
		$AnimatedSprite2D.play("running")
		is_attacking == false
		
	elif not is_attacking:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		$AnimatedSprite2D.play("idle")
		
	if Input.is_action_just_pressed("ui_down"):
		$AnimatedSprite2D.play("attack")
		is_attacking = true
		Global.dano = 1
		
		
	move_and_slide()
	
func _on_animated_sprite_2d_animation_finished():
	if $AnimatedSprite2D.animation == "attack":
		is_attacking = false
		Global.hit = false
		Global.dano = 0

func _on_bater_body_entered(body):
	print(body.name)
	print(Global.danMons)
	$hitar.start()
	if body.name == "inimigo" and is_attacking == true:
		Global.hit = true
		_on_hitar_timeout()

func _on_bater_body_exited(body):
	if Global.vidaMons == 0:
		$hitar.stop()

func gameOver():
	if Global.vidaKuma == 0:
		queue_free()
		get_tree().change_scene_to_file("res://game_over.tscn")

func _on_hitar_timeout():
	if is_attacking == true:
		Global.hit = true
		Global.dano = 1
		Global.vidaMons -= Global.dano
		



