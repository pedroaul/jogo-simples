extends Area2D

var dimas = 1
func _on_body_entered(body):
	if body.name == "personagem":
		queue_free() 
		Global.dimas += dimas
		print(Global.dimas)
