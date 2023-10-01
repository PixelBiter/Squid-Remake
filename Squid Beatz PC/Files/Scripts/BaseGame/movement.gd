extends Node2D
## Originally made by PixelToad ('pixeltoad' on discord)
var lastposition = 2000
var TimePosition = 0

func _ready():
	position = Vector2(2000,750)
	TimePosition = G.TotalTime

func _process(_delta):
	if G.Playing == true:
		if G.TotalTime > 0:
			global_position.x = -(G.TotalTime*G.CurrentBPM*3) + lastposition + (TimePosition*G.CurrentBPM*3)
		else:
			global_position.x -= G.CurrentBPM * 0.05
			lastposition = global_position.x
	if G.Playing != true:
		queue_free()
	if global_position.x < -200:
		queue_free()
	


func _on_note_sprite_dead():
	queue_free()
