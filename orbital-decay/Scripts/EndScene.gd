extends Control

func _on_tryagain_pressed():
	get_tree().change_scene("res://Scenes/PlayScene.tscn")

func _on_quit_pressed():
	get_tree().quit()
