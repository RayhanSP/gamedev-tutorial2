extends Area2D

func _on_ObjectiveArea_body_entered(body: RigidBody2D):
	if (body.name == "BlueShip"):
		print("Reached objective!")
		
		get_tree().change_scene_to_file("res://scenes/MainLevel2.tscn")
		
	if (body.name == "GreenShip"):
		print("Reached objective again!")
