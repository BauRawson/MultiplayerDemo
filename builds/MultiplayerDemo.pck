GDPC                 0                                                                         P   res://.godot/exported/133200997/export-3ad5c15c4f3250da0cc7c1af1770d85f-main.scn@      U      �4	�8������*Kx    X   res://.godot/exported/133200997/export-b6bd7a241034177d7fe082a7597ba8ea-character.scn                 �̹��Ě����N_��    ,   res://.godot/global_script_class_cache.cfg   !      �       ����o���BU�E>2    D   res://.godot/imported/icon.svg-218a8f2b3041327d8a5756f3a245f83b.ctexp      �      �̛�*$q�*�́        res://.godot/uid_cache.bin  `%      g       ��8����E�;��       res://icon.svg  �!      �      C��=U���^Qu��U3       res://icon.svg.import   P      �       ��xP�� �1�T�o/@       res://project.binary�%      X      khm���r���puk%7       res://scenes/character.gd                �OZ"H݈����=г    $   res://scenes/character.tscn.remap           f       {ڜv'%�Tx�en       res://scenes/main.gd�      �      ��K��@$�e"���C;       res://scenes/main.tscn.remap�       a       
��������S8z�s                RSRC                    PackedScene            ��������                                                  . 	   position    resource_local_to_scene    resource_name    properties/0/path    properties/0/spawn    properties/0/replication_mode    script    custom_solver_bias    radius 	   _bundled       Script    res://scenes/character.gd ��������
   Texture2D    res://icon.svg Z$,�� 2   %   local://SceneReplicationConfig_egsbj          local://CircleShape2D_nfaoe j         local://PackedScene_7yvrk �         SceneReplicationConfig                                              CircleShape2D    	        �B         PackedScene    
      	         names "   
   
   Character    script    CharacterBody2D 	   Sprite2D    texture    MultiplayerSynchronizer    replication_config    CollisionShape2D    shape 	   disabled    	   variants                                                         node_count             nodes     &   ��������       ����                            ����                           ����                           ����         	                conn_count              conns               node_paths              editable_instances              version             RSRC    extends CharacterBody2D
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
     RSRC                    PackedScene            ��������                                                  ..    resource_local_to_scene    resource_name 	   _bundled    script       Script    res://scenes/main.gd ��������   PackedScene    res://scenes/character.tscn $-�c��0/      local://PackedScene_dripw K         PackedScene          	         names "         Main    script    character_scene    Node2D    CanvasLayer    UserInterface    layout_mode    anchors_preset    anchor_right    anchor_bottom    grow_horizontal    grow_vertical    Control    HostButton    offset_left    offset_top    offset_right    offset_bottom    text    Button    JoinButton    MultiplayerSpawner    _spawnable_scenes    spawn_path    on_host_pressed    pressed    on_join_pressed    	   variants                                           �?                  �A     C     <B      Host      �B     �B      Join "         res://scenes/character.tscn                 node_count             nodes     V   ��������       ����                                  ����                     ����                     	      
                             ����                              	      
                    ����                                                         ����                         conn_count             conns                                                              node_paths              editable_instances              version             RSRC           extends Node2D

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
func broadcast_character_attack():
	rpc("on_character_attack", multiplayer.get_remote_sender_id())


@rpc("call_local")
func on_character_attack(character_id: int) -> void:
	print(str(character_id) + " attacked.")

           GST2   �   �      ����               � �        �  RIFF�  WEBPVP8L�  /������!"2�H�$�n윦���z�x����դ�<����q����F��Z��?&,
ScI_L �;����In#Y��0�p~��Z��m[��N����R,��#"� )���d��mG�������ڶ�$�ʹ���۶�=���mϬm۶mc�9��z��T��7�m+�}�����v��ح�m�m������$$P�����එ#���=�]��SnA�VhE��*JG�
&����^x��&�+���2ε�L2�@��		��S�2A�/E���d"?���Dh�+Z�@:�Gk�FbWd�\�C�Ӷg�g�k��Vo��<c{��4�;M�,5��ٜ2�Ζ�yO�S����qZ0��s���r?I��ѷE{�4�Ζ�i� xK�U��F�Z�y�SL�)���旵�V[�-�1Z�-�1���z�Q�>�tH�0��:[RGň6�=KVv�X�6�L;�N\���J���/0u���_��U��]���ǫ)�9��������!�&�?W�VfY�2���༏��2kSi����1!��z+�F�j=�R�O�{�
ۇ�P-�������\����y;�[ ���lm�F2K�ޱ|��S��d)é�r�BTZ)e�� ��֩A�2�����X�X'�e1߬���p��-�-f�E�ˊU	^�����T�ZT�m�*a|	׫�:V���G�r+�/�T��@U�N׼�h�+	*�*sN1e�,e���nbJL<����"g=O��AL�WO!��߈Q���,ɉ'���lzJ���Q����t��9�F���A��g�B-����G�f|��x��5�'+��O��y��������F��2�����R�q�):VtI���/ʎ�UfěĲr'�g�g����5�t�ۛ�F���S�j1p�)�JD̻�ZR���Pq�r/jt�/sO�C�u����i�y�K�(Q��7őA�2���R�ͥ+lgzJ~��,eA��.���k�eQ�,l'Ɨ�2�,eaS��S�ԟe)��x��ood�d)����h��ZZ��`z�պ��;�Cr�rpi&��՜�Pf��+���:w��b�DUeZ��ڡ��iA>IN>���܋�b�O<�A���)�R�4��8+��k�Jpey��.���7ryc�!��M�a���v_��/�����'��t5`=��~	`�����p\�u����*>:|ٻ@�G�����wƝ�����K5�NZal������LH�]I'�^���+@q(�q2q+�g�}�o�����S߈:�R�݉C������?�1�.��
�ڈL�Fb%ħA ����Q���2�͍J]_�� A��Fb�����ݏ�4o��'2��F�  ڹ���W�L |����YK5�-�E�n�K�|�ɭvD=��p!V3gS��`�p|r�l	F�4�1{�V'&����|pj� ߫'ş�pdT�7`&�
�1g�����@D�˅ �x?)~83+	p �3W�w��j"�� '�J��CM�+ �Ĝ��"���4� ����nΟ	�0C���q'�&5.��z@�S1l5Z��]�~L�L"�"�VS��8w.����H�B|���K(�}
r%Vk$f�����8�ڹ���R�dϝx/@�_�k'�8���E���r��D���K�z3�^���Vw��ZEl%~�Vc���R� �Xk[�3��B��Ğ�Y��A`_��fa��D{������ @ ��dg�������Mƚ�R�`���s����>x=�����	`��s���H���/ū�R�U�g�r���/����n�;�SSup`�S��6��u���⟦;Z�AN3�|�oh�9f�Pg�����^��g�t����x��)Oq�Q�My55jF����t9����,�z�Z�����2��#�)���"�u���}'�*�>�����ǯ[����82һ�n���0�<v�ݑa}.+n��'����W:4TY�����P�ר���Cȫۿ�Ϗ��?����Ӣ�K�|y�@suyo�<�����{��x}~�����~�AN]�q�9ޝ�GG�����[�L}~�`�f%4�R!1�no���������v!�G����Qw��m���"F!9�vٿü�|j�����*��{Ew[Á��������u.+�<���awͮ�ӓ�Q �:�Vd�5*��p�ioaE��,�LjP��	a�/�˰!{g:���3`=`]�2��y`�"��N�N�p���� ��3�Z��䏔��9"�ʞ l�zP�G�ߙj��V�>���n�/��׷�G��[���\��T��Ͷh���ag?1��O��6{s{����!�1�Y�����91Qry��=����y=�ٮh;�����[�tDV5�chȃ��v�G ��T/'XX���~Q�7��+[�e��Ti@j��)��9��J�hJV�#�jk�A�1�^6���=<ԧg�B�*o�߯.��/�>W[M���I�o?V���s��|yu�xt��]�].��Yyx�w���`��C���pH��tu�w�J��#Ef�Y݆v�f5�e��8��=�٢�e��W��M9J�u�}]釧7k���:�o�����Ç����ս�r3W���7k���e�������ϛk��Ϳ�_��lu�۹�g�w��~�ߗ�/��ݩ�-�->�I�͒���A�	���ߥζ,�}�3�UbY?�Ӓ�7q�Db����>~8�]
� ^n׹�[�o���Z-�ǫ�N;U���E4=eȢ�vk��Z�Y�j���k�j1�/eȢK��J�9|�,UX65]W����lQ-�"`�C�.~8ek�{Xy���d��<��Gf�ō�E�Ӗ�T� �g��Y�*��.͊e��"�]�d������h��ڠ����c�qV�ǷN��6�z���kD�6�L;�N\���Y�����
�O�ʨ1*]a�SN�=	fH�JN�9%'�S<C:��:`�s��~��jKEU�#i����$�K�TQD���G0H�=�� �d�-Q�H�4�5��L�r?����}��B+��,Q�yO�H�jD�4d�����0*�]�	~�ӎ�.�"����%
��d$"5zxA:�U��H���H%jس{���kW��)�	8J��v�}�rK�F�@�t)FXu����G'.X�8�KH;���[             [remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://brpyml0qjvqmk"
path="res://.godot/imported/icon.svg-218a8f2b3041327d8a5756f3a245f83b.ctex"
metadata={
"vram_texture": false
}
                [remap]

path="res://.godot/exported/133200997/export-b6bd7a241034177d7fe082a7597ba8ea-character.scn"
          [remap]

path="res://.godot/exported/133200997/export-3ad5c15c4f3250da0cc7c1af1770d85f-main.scn"
               list=Array[Dictionary]([{
"base": &"CharacterBody2D",
"class": &"Character",
"icon": "",
"language": &"GDScript",
"path": "res://scenes/character.gd"
}])
      <svg height="128" width="128" xmlns="http://www.w3.org/2000/svg"><rect x="2" y="2" width="124" height="124" rx="14" fill="#363d52" stroke="#212532" stroke-width="4"/><g transform="scale(.101) translate(122 122)"><g fill="#fff"><path d="M105 673v33q407 354 814 0v-33z"/><path fill="#478cbf" d="m105 673 152 14q12 1 15 14l4 67 132 10 8-61q2-11 15-15h162q13 4 15 15l8 61 132-10 4-67q3-13 15-14l152-14V427q30-39 56-81-35-59-83-108-43 20-82 47-40-37-88-64 7-51 8-102-59-28-123-42-26 43-46 89-49-7-98 0-20-46-46-89-64 14-123 42 1 51 8 102-48 27-88 64-39-27-82-47-48 49-83 108 26 42 56 81zm0 33v39c0 276 813 276 813 0v-39l-134 12-5 69q-2 10-14 13l-162 11q-12 0-16-11l-10-65H447l-10 65q-4 11-16 11l-162-11q-12-3-14-13l-5-69z"/><path d="M483 600c3 34 55 34 58 0v-86c-3-34-55-34-58 0z"/><circle cx="725" cy="526" r="90"/><circle cx="299" cy="526" r="90"/></g><g fill="#414042"><circle cx="307" cy="532" r="60"/><circle cx="717" cy="532" r="60"/></g></g></svg>
             Z$,�� 2   res://icon.svg$-�c��0/   res://scenes/character.tscn�������    res://scenes/main.tscn         ECFG      application/config/name         MultiplayerDemo    application/run/main_scene          res://scenes/main.tscn     application/config/features(   "         4.2    GL Compatibility       application/config/icon         res://icon.svg     input/attack�              events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode    @ 	   key_label             unicode           echo          script            deadzone      ?#   rendering/renderer/rendering_method         gl_compatibility*   rendering/renderer/rendering_method.mobile         gl_compatibility        