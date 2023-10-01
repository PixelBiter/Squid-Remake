extends Sprite2D
## Originally made by PixelToad ('pixeltoad' on discord)
var SongLocation = G.EditorSection
var Look = G.CurrentSongBeats[SongLocation]
var Song = G.CurrentSongName

func _ready():
	if SongLocation < 8000:
		z_index = 4096-SongLocation-3
	else:
		position.y -= 1
		z_index = 4096-SongLocation+8000
	position.y = 300
	if Look == 1:
		texture = load("res://Files/Sprites/SpriteSetA/Notes/BarBigBeat.png")
	elif Look == 2:
		texture = load("res://Files/Sprites/SpriteSetA/Notes/BarSmallBeat.png")
	else:
		queue_free()
	
func _process(delta):
	position.x = -(G.EditorSection * 10) + (SongLocation*10) + 1000
	if Song != G.CurrentSongName:
		queue_free()
	elif len(G.CurrentSongBeats) < SongLocation:
		queue_free()
	elif G.CurrentSongBeats[SongLocation] != Look:
		queue_free()

