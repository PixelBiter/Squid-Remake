extends Node2D
## Originally made by PixelToad ('pixeltoad' on discord)
func _ready():
	if G.InputsA == [1,0]:
		$Note.texture = load("res://Files/Sprites/SpriteSetA/Notes/Face1.png")
		$Bar.texture = load("res://Files/Sprites/SpriteSetA/Hitter/BarLightFace.png")
		$Squid.visible = true
	if G.InputsA == [0,1]:
		$Note.texture = load("res://Files/Sprites/SpriteSetA/Notes/Shoulder1.png")
		$Bar.texture = load("res://Files/Sprites/SpriteSetA/Hitter/BarLightShoulder.png")
		$Octo.visible = true
	if G.InputsA == [2,0]:
		$Note.texture = load("res://Files/Sprites/SpriteSetA/Notes/Face2.png")
		$Bar.texture = load("res://Files/Sprites/SpriteSetA/Hitter/BarLightFace.png")
		$Squid.visible = true
	if G.InputsA == [0,2]:
		$Note.texture = load("res://Files/Sprites/SpriteSetA/Notes/Shoulder2.png")
		$Bar.texture = load("res://Files/Sprites/SpriteSetA/Hitter/BarLightShoulder.png")
		$Octo.visible = true
	if G.InputsA == [1,1]:
		$Note.texture = load("res://Files/Sprites/SpriteSetA/Notes/Double11.png")
		$Bar.texture = load("res://Files/Sprites/SpriteSetA/Hitter/BarLightDouble.png")
		$Squid.visible = true
		$Octo.visible = true
	if G.InputsA == [1,2]:
		$Note.texture = load("res://Files/Sprites/SpriteSetA/Notes/Double21.png")
		$Bar.texture = load("res://Files/Sprites/SpriteSetA/Hitter/BarLightDouble.png")
		$Squid.visible = true
		$Octo.visible = true
	if G.InputsA == [2,1]:
		$Note.texture = load("res://Files/Sprites/SpriteSetA/Notes/Double12.png")
		$Bar.texture = load("res://Files/Sprites/SpriteSetA/Hitter/BarLightDouble.png")
		$Squid.visible = true
		$Octo.visible = true
	if G.InputsA == [2,2]:
		$Note.texture = load("res://Files/Sprites/SpriteSetA/Notes/Double22.png")
		$Bar.texture = load("res://Files/Sprites/SpriteSetA/Hitter/BarLightDouble.png")
		$Squid.visible = true
		$Octo.visible = true
	$Bar/AnimationPlayer.play("FadeBar")
	$Squid/AnimationPlayer.play("Squid Fade")
	$Octo/AnimationPlayer.play("Squid Fade")



func _process(delta):
	if $Note.global_position.y < -200:
		queue_free()
	if G.Playing != true:
		queue_free()
	$Note.global_position.y -= 3000 * delta
	$Squid.global_position = Vector2(300,796)
	$Octo.global_position = Vector2(300,704)
	$Bar.global_position.x = 300
