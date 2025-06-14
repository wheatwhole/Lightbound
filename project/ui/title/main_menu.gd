extends Node

func _ready():
	pass
	


func _on_play_button_up():
	get_tree().change_scene_to_file("uid://duk6xqmcinbi7") 


func _on_quit_button_up():
	get_tree().quit()
