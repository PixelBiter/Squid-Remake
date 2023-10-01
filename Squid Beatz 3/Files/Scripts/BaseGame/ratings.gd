extends Node2D
## Originally made by PixelToad ('pixeltoad' on discord)
func _ready():
	position = Vector2(285,608)
	if G.RatingSignal == "FRESH":
		G.Combo += 1
		G.Golds += 1
		G.Silvers += 1
		$FRESH.visible = true
		if G.Combo > 1:
			$FRESH/Combo.text = str(G.Combo)
		G.RatingSignal = ""
	elif G.RatingSignal == "GOOD":
		G.Combo += 1
		G.Silvers += 1
		$GOOD.visible = true
		if G.Combo > 1:
			$GOOD/Combo.text = str(G.Combo)
		G.RatingSignal = ""
	elif G.RatingSignal == "BAD":
		G.Combo = 0
		$BAD.visible = true
		G.RatingSignal = ""
	elif G.RatingSignal == "MISS":
		G.Combo = 0
		$MISS.visible = true
		G.RatingSignal = ""

func _physics_process(delta):
	position.y -= 1


func _on_timer_timeout():
	queue_free()
