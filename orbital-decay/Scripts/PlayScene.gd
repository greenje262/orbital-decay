extends Node2D

onready var earth = $Earth
onready var tween = $Earth/Tween
onready var title = $TitleText
onready var tween2 = $TitleText/Tween
onready var tween3 = $Earth/SaveTween
onready var dial_frame = 0
onready var foley
onready var robo
onready var saved

# Phase bools to track progression
onready var phase1 = false
onready var phase2 = false
onready var phase3a = false
onready var phase3b = false
onready var phase4a = false
onready var phase4b = false
onready var phase5a = false
onready var phase5b = false
onready var phase6a = false
onready var phase6b = false
onready var phase7a = false
onready var phase7b = false
onready var phase8b = false

func _ready():
	title()
	$Fan.playing = true

func _process(delta):
	if saved == true:
		$ReEntryHeat.hide()

func _on_QuitButton_pressed():
	get_tree().quit()

func title():
	title.show()
	title.rect_position = Vector2(186, 240)
	$PlayButton.show()
	$QuitButton.show()
	$Console.hide()
	$DarkOverlay.show()
	$ReEntryHeat.playing = false
	$ReEntryHeat.hide()
	$Laser.playing = false
	$Laser.hide()
	earth.show()
	earth.position = Vector2(-200, 340)
	earth.scale = Vector2(0.1, 0.1)

func _on_PlayButton_pressed():
	$PlayButton.hide()
	$QuitButton.hide()
	tween2.interpolate_property(title, "rect_position", Vector2(186, 240), Vector2(2308, 240), 30, Tween.TRANS_LINEAR)
	tween2.start()
	tween.interpolate_property(earth, "position", Vector2(-200, 340), Vector2(936, 340), 15, Tween.TRANS_LINEAR)
	tween.start()
	yield(get_tree().create_timer(10), "timeout")
	robo = "res://Audio/Robo/robo01.ogg"
	play_robo(robo)
	yield(get_tree().create_timer(17), "timeout")
	phase1 = true
	$Console.show()
	$DarkOverlay.hide()
	robo = "res://Audio/Robo/robo02.ogg"
	play_robo(robo)
	yield(get_tree().create_timer(3), "timeout")
	title.hide()
	earth_fall()

func earth_fall():
	tween.interpolate_property(earth, "scale", Vector2(0.1, 0.1), Vector2(50, 50), 240, Tween.TRANS_EXPO, Tween.EASE_IN)
	tween.start()
	yield(get_tree().create_timer(180), "timeout")
	$ReEntryHeat.show()
	$ReEntryHeat.playing = true
	yield(get_tree().create_timer(60), "timeout")
	$Manual.hide()
	get_tree().change_scene("res://Scenes/GameOver.tscn")

func play_robo(robo):
	if $Robo.playing == true:
		$Robo.stop()
	
	$Robo.stream = load(robo)
	$Robo.play(0)

func play_foley(foley):	
	if $Foley1.playing == true:
		$Foley2.stream = load(foley)
		$Foley2.play(0)
	else:
		$Foley1.stream = load(foley)
		$Foley1.play(0)

func console_reset():
	$Console/Battery1.pressed = false
	$Console/Battery2.pressed = false
	$Console/Battery3.pressed = false
	$Console/Battery4.pressed = false
	$Console/Battery5.pressed = false
	$Console/Battery6.pressed = false
	$Console/Battery7.pressed = false
	$Console/Battery8.pressed = false
	$Console/Battery9.pressed = false
	$Console/Battery10.pressed = false
	$Console/Battery11.pressed = false
	$Console/Battery12.pressed = false
	$Console/Battery13.pressed = false
	$Console/Dial.set_frame(0)
	$Console/FlipSwitch1.pressed = false
	$Console/FlipSwitch2.pressed = false
	$Console/FlipSwitch3.pressed = false
	$Console/FlipSwitch4.pressed = false
	$Console/FlipSwitch5.pressed = false
	$Console/OrangeButton1.pressed = false
	$Console/OrangeButton2.pressed = false
	$Console/OrangeButton3.pressed = false
	$Console/OrangeButton4.pressed = false
	$Console/Slider.pressed = false
	yield(get_tree().create_timer(2), "timeout")
	robo = "res://Audio/Robo/robo07b.ogg"
	play_robo(robo)

func battery_charge():
	$Console/BatterySprite1.show()
	yield(get_tree().create_timer(2), "timeout")
	$Console/BatterySprite2.show()
	yield(get_tree().create_timer(2), "timeout")
	$Console/BatterySprite3.show()
	yield(get_tree().create_timer(2), "timeout")
	$Console/BatterySprite4.show()
	yield(get_tree().create_timer(2), "timeout")
	$Console/BatterySprite5.show()
	yield(get_tree().create_timer(2), "timeout")
	$Console/BatterySprite6.show()
	yield(get_tree().create_timer(2), "timeout")
	$Console/BatterySprite7.show()
	yield(get_tree().create_timer(2), "timeout")
	$Console/BatterySprite8.show()
	yield(get_tree().create_timer(2), "timeout")
	$Console/BatterySprite9.show()
	yield(get_tree().create_timer(7), "timeout")
	robo = "res://Audio/Robo/robo10a.ogg"
	play_robo(robo)

func earth_kill():
	$Laser.show()
	$Laser.playing = true
	$Laser/EarthKill.emitting = true
	yield(get_tree().create_timer(3), "timeout")
	$Laser/EarthDie.emitting = true
	yield(get_tree().create_timer(0.5), "timeout")
	earth.hide()
	$Laser/EarthKill.emitting = false
	$ReEntryHeat.hide()
	yield(get_tree().create_timer(1.5), "timeout")
	$Laser.hide()
	$Laser.playing = false
	yield(get_tree().create_timer(3), "timeout")
	robo = "res://Audio/Robo/robo12a.ogg"
	play_robo(robo)
	yield(get_tree().create_timer(15), "timeout")
	get_tree().change_scene("res://Scenes/WinScene.tscn")

func earth_save():
	$ReEntryHeat.hide()
	saved = true
	robo = "res://Audio/Robo/robo11b.ogg"
	play_robo(robo)
	var earth_scale = earth.scale
	tween3.interpolate_property(earth, "scale", earth_scale, Vector2(0.1, 0.1), 20, Tween.TRANS_EXPO, Tween.EASE_OUT)
	tween3.start()
	yield(get_tree().create_timer(20), "timeout")
	get_tree().change_scene("res://Scenes/WinScene.tscn")

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
	
	if phase2 == true:
		if dial_frame == 2:
			phase2 = false
			phase3b = true
			robo = "res://Audio/Robo/robo04b.ogg"
			play_robo(robo)
	
	if phase5b == true:
		phase5b_get()

func _on_BigRedButton_pressed():
	foley = "res://Audio/button.wav"
	play_foley(foley)
	
	if phase7a == true:
		earth_kill()

func _on_OnOffSwitch_pressed():
	foley = "res://Audio/click1.wav"
	play_foley(foley)
	
	if phase1 == true:
		phase1_get()
	
	if phase8b == true && $Console/OnOffSwitch.pressed == false:
		earth_save()

func _on_Slider_pressed():
	foley = "res://Audio/beep2.wav"
	play_foley(foley)
	
	if phase5a == true && $Console/Slider.pressed:
		phase5a_get()

# BATTERY BUTTONS

func _on_Battery1_pressed():
	foley = "res://Audio/beep1.wav"
	play_foley(foley)
	
	if phase4b == true:
		phase4b_get()

func _on_Battery2_pressed():
	foley = "res://Audio/beep1.wav"
	play_foley(foley)
	
	if phase4b == true:
		phase4b_get()
	
	if phase7b == true:
		if $Console/Battery3.pressed && $Console/Battery5.pressed && $Console/Battery7.pressed && $Console/Battery11.pressed && $Console/Battery13.pressed:
			phase7b_get()

func _on_Battery3_pressed():
	foley = "res://Audio/beep1.wav"
	play_foley(foley)
	
	if phase4b == true:
		phase4b_get()
	
	if phase7b == true:
		if $Console/Battery2.pressed && $Console/Battery5.pressed && $Console/Battery7.pressed && $Console/Battery11.pressed && $Console/Battery13.pressed:
			phase7b_get()

func _on_Battery4_pressed():
	foley = "res://Audio/beep1.wav"
	play_foley(foley)
	
	if phase4b == true:
		phase4b_get()

func _on_Battery5_pressed():
	foley = "res://Audio/beep1.wav"
	play_foley(foley)
	
	if phase4b == true:
		phase4b_get()
	
	if phase7b == true:
		if $Console/Battery2.pressed && $Console/Battery3.pressed && $Console/Battery7.pressed && $Console/Battery11.pressed && $Console/Battery13.pressed:
			phase7b_get()

func _on_Battery6_pressed():
	foley = "res://Audio/beep1.wav"
	play_foley(foley)
	
	if phase4b == true:
		phase4b_get()

func _on_Battery7_pressed():
	foley = "res://Audio/beep1.wav"
	play_foley(foley)
	
	if phase4b == true:
		phase4b_get()
	
	if phase7b == true:
		if $Console/Battery2.pressed && $Console/Battery3.pressed && $Console/Battery5.pressed && $Console/Battery11.pressed && $Console/Battery13.pressed:
			phase7b_get()

func _on_Battery8_pressed():
	foley = "res://Audio/beep1.wav"
	play_foley(foley)
	
	if phase4b == true:
		phase4b_get()

func _on_Battery9_pressed():
	foley = "res://Audio/beep1.wav"
	play_foley(foley)
	
	if phase4b == true:
		phase4b_get()

func _on_Battery10_pressed():
	foley = "res://Audio/beep1.wav"
	play_foley(foley)
	
	if phase4b == true:
		phase4b_get()

func _on_Battery11_pressed():
	foley = "res://Audio/beep1.wav"
	play_foley(foley)
	
	if phase4b == true:
		phase4b_get()
	
	if phase7b == true:
		if $Console/Battery2.pressed && $Console/Battery3.pressed && $Console/Battery5.pressed && $Console/Battery7.pressed && $Console/Battery13.pressed:
			phase7b_get()

func _on_Battery12_pressed():
	foley = "res://Audio/beep1.wav"
	play_foley(foley)
	
	if phase4b == true:
		phase4b_get()

func _on_Battery13_pressed():
	foley = "res://Audio/beep1.wav"
	play_foley(foley)
	
	if phase4b == true:
		phase4b_get()
	
	if phase7b == true:
		if $Console/Battery2.pressed && $Console/Battery3.pressed && $Console/Battery5.pressed && $Console/Battery7.pressed && $Console/Battery11.pressed:
			phase7b_get()

# ORANGE BUTTONS

func _on_OrangeButton1_pressed():
	foley = "res://Audio/click3.wav"
	play_foley(foley)
	
	if phase4a == true:
		phase4a_get()
	
	if $Console/OrangeButton1.pressed && $Console/OrangeButton2.pressed && $Console/OrangeButton3.pressed && $Console/OrangeButton4.pressed:
		if phase3b == true:
			phase3b_get()
		elif phase6b == true:
			phase6b_get()

func _on_OrangeButton2_pressed():
	foley = "res://Audio/click3.wav"
	play_foley(foley)
	
	if $Console/OrangeButton1.pressed && $Console/OrangeButton2.pressed && $Console/OrangeButton3.pressed && $Console/OrangeButton4.pressed:
		if phase3b == true:
			phase3b_get()
		elif phase6b == true:
			phase6b_get()

func _on_OrangeButton3_pressed():
	foley = "res://Audio/click3.wav"
	play_foley(foley)
	
	if phase2 == true:
		phase2a_get()
	
	if $Console/OrangeButton1.pressed && $Console/OrangeButton2.pressed && $Console/OrangeButton3.pressed && $Console/OrangeButton4.pressed:
		if phase3b == true:
			phase3b_get()
		elif phase6b == true:
			phase6b_get()

func _on_OrangeButton4_pressed():
	foley = "res://Audio/click3.wav"
	play_foley(foley)
	
	if $Console/OrangeButton1.pressed && $Console/OrangeButton2.pressed && $Console/OrangeButton3.pressed && $Console/OrangeButton4.pressed:
		if phase3b == true:
			phase3b_get()
		elif phase6b == true:
			phase6b_get()

# FLIP SWITCHES

func _on_FlipSwitch1_pressed():
	foley = "res://Audio/click1.wav"
	play_foley(foley)
	
	if phase3a == true:
		if $Console/FlipSwitch1.pressed && $Console/FlipSwitch2.pressed && $Console/FlipSwitch4.pressed:
			phase3a_get()
	
	if phase6a == true:
		if $Console/FlipSwitch1.pressed == false && $Console/FlipSwitch2.pressed == false && $Console/FlipSwitch3.pressed == false && $Console/FlipSwitch4.pressed == false && $Console/FlipSwitch5.pressed == false:
			phase6a_get()

func _on_FlipSwitch2_pressed():
	foley = "res://Audio/click1.wav"
	play_foley(foley)
	
	if phase3a == true:
		if $Console/FlipSwitch1.pressed && $Console/FlipSwitch2.pressed && $Console/FlipSwitch4.pressed:
			phase3a_get()
		elif $Console/FlipSwitch2.pressed && $Console/FlipSwitch4.pressed && $Console/FlipSwitch5.pressed:
			phase3a_fix_get()
	
	if phase6a == true:
		if $Console/FlipSwitch1.pressed == false && $Console/FlipSwitch2.pressed == false && $Console/FlipSwitch3.pressed == false && $Console/FlipSwitch4.pressed == false && $Console/FlipSwitch5.pressed == false:
			phase6a_get()

func _on_FlipSwitch3_pressed():
	foley = "res://Audio/click1.wav"
	play_foley(foley)
	
	if phase6a == true:
		if $Console/FlipSwitch1.pressed == false && $Console/FlipSwitch2.pressed == false && $Console/FlipSwitch3.pressed == false && $Console/FlipSwitch4.pressed == false && $Console/FlipSwitch5.pressed == false:
			phase6a_get()

func _on_FlipSwitch4_pressed():
	foley = "res://Audio/click1.wav"
	play_foley(foley)
	
	if phase3a == true:
		if $Console/FlipSwitch1.pressed && $Console/FlipSwitch2.pressed && $Console/FlipSwitch4.pressed:
			phase3a_get()
		elif $Console/FlipSwitch2.pressed && $Console/FlipSwitch4.pressed && $Console/FlipSwitch5.pressed:
			phase3a_fix_get()
	
	if phase6a == true:
		if $Console/FlipSwitch1.pressed == false && $Console/FlipSwitch2.pressed == false && $Console/FlipSwitch3.pressed == false && $Console/FlipSwitch4.pressed == false && $Console/FlipSwitch5.pressed == false:
			phase6a_get()

func _on_FlipSwitch5_pressed():
	foley = "res://Audio/click1.wav"
	play_foley(foley)
	
	if phase3a == true:
		if $Console/FlipSwitch2.pressed && $Console/FlipSwitch4.pressed && $Console/FlipSwitch5.pressed:
			phase3a_fix_get()
	
	if phase6a == true:
		if $Console/FlipSwitch1.pressed == false && $Console/FlipSwitch2.pressed == false && $Console/FlipSwitch3.pressed == false && $Console/FlipSwitch4.pressed == false && $Console/FlipSwitch5.pressed == false:
			phase6a_get()

# PHASE FUNCTIONS

func phase1_get():
	phase1 = false
	phase2 = true
	robo = "res://Audio/Robo/robo03.ogg"
	play_robo(robo)

# GOOD ENDING

func phase2a_get():
	phase3a = true
	robo = "res://Audio/Robo/robo04a.ogg"
	play_robo(robo)

func phase3a_get():
	phase3a = false
	phase4a = true
	robo = "res://Audio/Robo/robo05a.ogg"
	play_robo(robo)

func phase4a_get():
	phase4a = false
	phase3a = true
	robo = "res://Audio/Robo/robo06a.ogg"
	play_robo(robo)

func phase3a_fix_get():
	phase3a = false
	phase5a = true
	robo = "res://Audio/Robo/robo07a.ogg"
	play_robo(robo)
	yield(get_tree().create_timer(30), "timeout")
	robo = "res://Audio/Robo/robo08a.ogg"
	play_robo(robo)

func phase5a_get():
	phase5a = false
	phase6a = true
	robo = "res://Audio/Robo/robo09a.ogg"
	play_robo(robo)
	battery_charge()

func phase6a_get():
	phase6a = false
	robo = "res://Audio/Robo/robo11a.ogg"
	play_robo(robo)
	$Console/BatterySprite10.show()
	yield(get_tree().create_timer(2), "timeout")
	$Console/BatterySprite11.show()
	yield(get_tree().create_timer(2), "timeout")
	$Console/BatterySprite12.show()
	yield(get_tree().create_timer(2), "timeout")
	$Console/BatterySprite13.show()
	phase7a = true

# BEST ENDING

func phase2b_get():
	phase2 = false
	phase3b = true
	robo = "res://Audio/Robo/robo04b.ogg"
	play_robo(robo)

func phase3b_get():
	phase3b = false
	phase4b = true
	robo = "res://Audio/Robo/robo05b.ogg"
	play_robo(robo)

func phase4b_get():
	phase4b = false
	phase5b = true
	robo = "res://Audio/Robo/robo06b.ogg"
	play_robo(robo)
	yield(get_tree().create_timer(18), "timeout")
	console_reset()

func phase5b_get():
	phase5b = false
	phase6b = true
	robo = "res://Audio/Robo/robo08b.ogg"
	play_robo(robo)

func phase6b_get():
	phase6b = false
	phase7b = true
	robo = "res://Audio/Robo/robo09b.ogg"
	play_robo(robo)

func phase7b_get():
	phase7b = false
	phase8b = true
	robo = "res://Audio/Robo/robo10b.ogg"
	play_robo(robo)
