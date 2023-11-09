extends Sprite2D
## Originally made by PixelToad ('pixeltoad' on discord)
var Note
var ReqFS = [0,0]
var ReqLR = [0,0]
signal dead

func _ready():
	Note = G.Note
	G.Note += 1
	if G.CurrentSong[G.SongSection] == 1:
		texture = load("res://Files/Sprites/SpriteSetA/Notes/Face1.png")
		ReqFS = [1,0]
	elif G.CurrentSong[G.SongSection] == 2:
		texture = load("res://Files/Sprites/SpriteSetA/Notes/Shoulder1.png")
		ReqFS = [0,1]
	elif G.CurrentSong[G.SongSection] == 3:
		texture = load("res://Files/Sprites/SpriteSetA/Notes/Face2.png")
		ReqFS = [2,0]
	elif G.CurrentSong[G.SongSection] == 4:
		texture = load("res://Files/Sprites/SpriteSetA/Notes/Shoulder2.png")
		ReqFS = [0,2]
	elif G.CurrentSong[G.SongSection] == 5:
		texture = load("res://Files/Sprites/SpriteSetA/Notes/Double11.png")
		ReqFS = [1,1]
	elif G.CurrentSong[G.SongSection] == 6:
		texture = load("res://Files/Sprites/SpriteSetA/Notes/Double21.png")
		ReqFS = [1,2]
	elif G.CurrentSong[G.SongSection] == 7:
		texture = load("res://Files/Sprites/SpriteSetA/Notes/Double12.png")
		ReqFS = [2,1]
	elif G.CurrentSong[G.SongSection] == 8:
		texture = load("res://Files/Sprites/SpriteSetA/Notes/Double22.png")
		ReqFS = [2,2]


func _process(delta):
	if Note == G.NoteDone:
		if global_position.x < 300 + (G.CurrentBPM*0.65) and global_position.x > 300 - (G.CurrentBPM*0.35):
			$Timer.start()
	if G.NoteDone == Note:
		if global_position.x < 300 - (G.CurrentBPM*0.35):
			G.Combo = 0
			G.NoteDone += 1
	if global_position.x < -200:
		queue_free()


func _on_timer_timeout():
	if ReqFS != [0,0] and ReqLR != [0,0]:
		if ReqFS == G.InputsA and ReqLR == G.InputsB:
			_spawneffects()
			G.InputsA = [0,0]
			G.InputsB = [0,0]
			G.NoteDone += 1
			_ranking()
			queue_free()
		else:
			if G.InputsA[0] > ReqFS[0]:
				_rankingmiss()
			if G.InputsA[1] > ReqFS[1]:
				_rankingmiss()
			if G.InputsB[0] > ReqLR[0]:
				_rankingmiss()
			if G.InputsB[1] > ReqLR[1]:
				_rankingmiss()
	elif ReqFS != [0,0]:
		if ReqFS == G.InputsA:
			_spawneffects()
			G.InputsA = [0,0]
			G.InputsB = [0,0]
			G.NoteDone += 1
			_ranking()
			queue_free()
		else:
			if G.InputsA[0] > ReqFS[0]:
				_rankingmiss()
			if G.InputsA[1] > ReqFS[1]:
				_rankingmiss()
	elif ReqLR != [0,0]:
		if ReqLR == G.InputsB:
			G.InputsA = [0,0]
			G.InputsB = [0,0]
			G.NoteDone += 1
			_ranking()
			queue_free()
		else:
			if G.InputsB[0] > ReqLR[0]:
				_rankingmiss()
			if G.InputsB[1] > ReqLR[1]:
				_rankingmiss()


func _ranking():
	if global_position.x < 300 + (G.CurrentBPM*0.15) and global_position.x > 300 - (G.CurrentBPM*0.15):
		G.RatingSignal = "FRESH"
	elif global_position.x < 300 + (G.CurrentBPM*0.35) and global_position.x > 300 - (G.CurrentBPM*0.35):
		G.RatingSignal = "GOOD"
	else:
		G.RatingSignal = "BAD"
	_spawnranking()

func _rankingmiss():
	G.RatingSignal = "MISS"
	G.InputsA = [0,0]
	G.InputsB = [0,0]
	G.NoteDone += 1
	_spawnranking()

func _spawnranking():
	var Rating = load("res://Files/Scenes/BaseGame/ratings.tscn")
	var rating = Rating.instantiate()
	var world = get_tree().current_scene
	world.add_child(rating)

func _spawneffects():
	var Effects = load("res://Files/Scenes/BaseGame/note_effects.tscn")
	var effects = Effects.instantiate()
	var world = get_tree().current_scene
	world.add_child(effects)
	effects.global_position = global_position
