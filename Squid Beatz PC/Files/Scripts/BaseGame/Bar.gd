extends Sprite2D

func _ready():
	if G.CurrentSongBeats[G.SongSection] == 1:
		texture = load("res://Files/Sprites/SpriteSetA/Notes/BarBigBeat.png")
	if G.CurrentSongBeats[G.SongSection] == 2:
		texture = load("res://Files/Sprites/SpriteSetA/Notes/BarSmallBeat.png")
		scale = Vector2(1,1)
