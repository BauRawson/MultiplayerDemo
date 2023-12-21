extends Node2D

'''
Most of this code comes from this tutorial: https://www.youtube.com/watch?v=K62jDMLPToA
'''

var peer = ENetMultiplayerPeer.new()
@export var character_scene: PackedScene

@onready var user_interface: Control = $CanvasLayer/UserInterface


func on_host_pressed() -> void:
	user_interface.hide()
	
	peer.create_server(7666)
	multiplayer.multiplayer_peer = peer
	multiplayer.peer_connected.connect(add_character)
	
	add_character() # This one is called for the Host


func on_join_pressed() -> void:
	user_interface.hide()
	
	peer.create_client("localhost", 7666)
	multiplayer.multiplayer_peer = peer


func add_character(id: int = 1) -> void:
	var character: Character = character_scene.instantiate()
	character.name = str(id)
	
	call_deferred("add_child", character)


func do_character_attack() -> void:
	rpc_id(1, "broadcast_character_attack") # Send the rpc only to the server


@rpc("any_peer", "call_local") # call_local is used only when the server is also a client. I hate it :)
func broadcast_character_attack(): # This will only be called in the server
	rpc("on_character_attack", multiplayer.get_remote_sender_id())


@rpc("call_local")
func on_character_attack(character_id: int) -> void: # This will be called on every client, including the server.
	print(str(character_id) + " attacked.")

