extends Node2D

onready var earth = $Earth
onready var tween = $Earth/Tween
onready var dial_frame = 0

func _ready():
	earth_fall()

func earth_fall():
	tween.interpolate_property(earth, "scale", Vector2(0.1, 0.1), Vector2(50, 50), 300, Tween.TRANS_EXPO, Tween.EASE_IN)
	tween.start()


func _on_DialButton_pressed():
	if dial_frame < 2:
		dial_frame = dial_frame + 1
	else:
		dial_frame = 0
	
	$Console/Dial.set_frame(dial_frame)
