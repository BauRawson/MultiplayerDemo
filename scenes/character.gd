extends CharacterBody2D
class_name Character


signal on_character_attacked


func _enter_tree() -> void:
	set_multiplayer_authority(name.to_int())
	on_character_attacked.connect(get_parent().do_character_attack)


func _physics_process(delta: float) -> void:
	if is_multiplayer_authority():
		velocity = Input.get_vector("ui_left","ui_right","ui_up","ui_down") * 400
	
		if Input.is_action_just_pressed("attack"):
			on_character_attacked.emit() # The main script connected to this signal, so it will now call the RPC
	
	move_and_slide()
