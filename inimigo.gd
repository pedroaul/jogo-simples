extends CharacterBody2D

var vely = 900
var impulsoy = 0 
var chao = Vector2(0,-1)
var velx = 0 
var isFollowing = false
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var takingDamage = false

func _physics_process(delta):
	
	print(Global.hit)
	if not is_on_floor():
		velocity.y += gravity * delta
	
	
	if isFollowing == true and takingDamage == false:
		$AnimatedSprite2D.play("monsAttack")
	elif velx == 0 and takingDamage == false:
		$AnimatedSprite2D.play("idle")
	
	var gravidade = Vector2(0,impulsoy*vely)
	
	position = Vector2(position.x + velx, position.y)
	move_and_slide()
		
	if Global.hit == true:
		$AnimatedSprite2D.play("damage")
		takingDamage == true
		print("tomou les é ", Global.hit)
		
	if Global.vidaMons == 0:
		queue_free()
	
func _on_direita_area_entered(area):
	velx = 3
		
	if velx <= 3 and Global.hit == false:
		isFollowing = true
		$AnimatedSprite2D.flip_h = true
	

func _on_esquerda_area_entered(area):
	velx = -3
	if velx < 0 and velx == -3 and takingDamage == false:
		isFollowing = true
		$AnimatedSprite2D.flip_h = false
		

func _on_direita_area_exited(area):
	velx = 0
	if velx == 0 and Global.hit == false:
		$AnimatedSprite2D.play("idle")
		$AnimatedSprite2D.flip_h = true
		isFollowing = false
		takingDamage = false

func _on_esquerda_area_exited(area):
	velx = 0
	if velx == 0 and Global.hit == false:
		$AnimatedSprite2D.play("idle")
		isFollowing = false
		takingDamage = false
		

func _on_animated_sprite_2d_animation_finished():
	if $AnimatedSprite2D.animation == "damage":
		takingDamage = false
		isFollowing = true
		
func _on_area_2d_body_entered(body):
	print(body.name)
	
	if Global.hit == true:
		takingDamage = true
		Global.danMons = 0
		isFollowing = false
	elif body.name == "personagem" and isFollowing == true:
		$danudo.start()
		
func _on_area_2d_body_exited(body):
	if body.name == "personagem":
		$danudo.stop()
	if Global.vidaKuma == 0:
		$danudo.stop()
	
func _on_danudo_timeout():
	if Global.hit == false:
		Global.danMons = 1
		Global.vidaKuma -= Global.danMons
	



