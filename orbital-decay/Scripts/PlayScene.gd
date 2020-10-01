extends Node2D

onready var earth = $Earth
onready var tween = $Earth/Tween
onready var title = $TitleText
onready var tween2 = $TitleText/Tween
onready var dial_frame = 0
onready var foley

func _ready():
	title()
	$Fan.playing = true

func title():
	title.show()
	title.rect_position = Vector2(186, 240)
	$PlayButton.show()
	$Console.hide()
	$DarkOverlay.show()
	$ReEntryHeat.playing = false
	$ReEntryHeat.hide()
	$Laser.playing = false
	$Laser.hide()
	earth.position = Vector2(-200, 340)
	earth.scale = Vector2(0.1, 0.1)
	#console_reset()

func _on_PlayButton_pressed():
	$PlayButton.hide()
	tween2.interpolate_property(title, "rect_position", Vector2(186, 240), Vector2(2308, 240), 30, Tween.TRANS_LINEAR)
	tween2.start()
	tween.interpolate_property(earth, "position", Vector2(-200, 340), Vector2(936, 340), 15, Tween.TRANS_LINEAR)
	tween.start()
	yield(get_tree().create_timer(30), "timeout")
	title.hide()
	earth_fall()

func earth_fall():
	tween.interpolate_property(earth, "scale", Vector2(0.1, 0.1), Vector2(50, 50), 300, Tween.TRANS_EXPO, Tween.EASE_IN)
	tween.start()
	$Console.show()
	$DarkOverlay.hide()
	yield(get_tree().create_timer(240), "timeout")
	$ReEntryHeat.show()
	$ReEntryHeat.playing = true
	yield(get_tree().create_timer(60), "timeout")
	$Manual.hide()
	get_tree().change_scene("res://Scenes/GameOver.tscn")

#func console_reset():

func play_foley(foley):	
	if $Foley1.playing == true:
		$Foley2.stream = load(foley)
		$Foley2.play(0)
	else:
		$Foley1.stream = load(foley)
		$Foley1.play(0)

#fuck fuck fuck I can't wait to figure out how to never do this again

func _on_Manual_pressed():
	foley = "res://Audio/pageflip.wav"
	play_foley(foley)
	
	$Manual.show()

func _on_ManualClose_pressed():
	foley = "res://Audio/pageflip.wav"
	play_foley(foley)
	
	$Manual.hide()

func _on_DialButton_pressed():
	foley = "res://Audio/click2.wav"
	play_foley(foley)
	
	if dial_frame < 2:
		dial_frame = dial_frame + 1
	else:
		dial_frame = 0
	
	$Console/Dial.set_frame(dial_frame)

func _on_BigRedButton_pressed():
	foley = "res://Audio/button.wav"
	play_foley(foley)

func _on_OnOffSwitch_pressed():
	foley = "res://Audio/click1.wav"
	play_foley(foley)

func _on_Slider_pressed():
	foley = "res://Audio/beep2.wav"
	play_foley(foley)

func _on_Battery1_pressed():
	foley = "res://Audio/beep1.wav"
	play_foley(foley)

func _on_Battery2_pressed():
	foley = "res://Audio/beep1.wav"
	play_foley(foley)

func _on_Battery3_pressed():
	foley = "res://Audio/beep1.wav"
	play_foley(foley)

func _on_Battery4_pressed():
	foley = "res://Audio/beep1.wav"
	play_foley(foley)

func _on_Battery5_pressed():
	foley = "res://Audio/beep1.wav"
	play_foley(foley)

func _on_Battery6_pressed():
	foley = "res://Audio/beep1.wav"
	play_foley(foley)

func _on_Battery7_pressed():
	foley = "res://Audio/beep1.wav"
	play_foley(foley)

func _on_Battery8_pressed():
	foley = "res://Audio/beep1.wav"
	play_foley(foley)

func _on_Battery9_pressed():
	foley = "res://Audio/beep1.wav"
	play_foley(foley)

func _on_Battery10_pressed():
	foley = "res://Audio/beep1.wav"
	play_foley(foley)

func _on_Battery11_pressed():
	foley = "res://Audio/beep1.wav"
	play_foley(foley)

func _on_Battery12_pressed():
	foley = "res://Audio/beep1.wav"
	play_foley(foley)

func _on_Battery13_pressed():
	foley = "res://Audio/beep1.wav"
	play_foley(foley)

func _on_OrangeButton1_pressed():
	foley = "res://Audio/click3.wav"
	play_foley(foley)

func _on_OrangeButton2_pressed():
	foley = "res://Audio/click3.wav"
	play_foley(foley)

func _on_OrangeButton3_pressed():
	foley = "res://Audio/click3.wav"
	play_foley(foley)

func _on_OrangeButton4_pressed():
	foley = "res://Audio/click3.wav"
	play_foley(foley)

func _on_FlipSwitch1_pressed():
	foley = "res://Audio/click1.wav"
	play_foley(foley)

func _on_FlipSwitch2_pressed():
	foley = "res://Audio/click1.wav"
	play_foley(foley)

func _on_FlipSwitch3_pressed():
	foley = "res://Audio/click1.wav"
	play_foley(foley)

func _on_FlipSwitch4_pressed():
	foley = "res://Audio/click1.wav"
	play_foley(foley)

func _on_FlipSwitch5_pressed():
	foley = "res://Audio/click1.wav"
	play_foley(foley)
	
