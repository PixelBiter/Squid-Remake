extends Sprite2D
## Originally made by PixelToad ('pixeltoad' on discord)
var SongLocation = G.EditorSection
var Look = G.CurrentSong[SongLocation]
var Song = G.CurrentSongName

func _ready():
	_createsong()

func _createsong():
	if SongLocation < 8000:
		z_index = 4096-SongLocation
	else:
		position.y -= 1
		z_index = 4096-SongLocation+8000
	position.y = 300
	if Look == 1:
		texture = load("res://Files/Sprites/SpriteSetA/Notes/Face1.png")
	elif Look == 2:
		texture = load("res://Files/Sprites/SpriteSetA/Notes/Shoulder1.png")
	elif Look == 3:
		texture = load("res://Files/Sprites/SpriteSetA/Notes/Face2.png")
	elif Look == 4:
		texture = load("res://Files/Sprites/SpriteSetA/Notes/Shoulder2.png")
	elif Look == 5:
		texture = load("res://Files/Sprites/SpriteSetA/Notes/Double11.png")
	elif Look == 6:
		texture = load("res://Files/Sprites/SpriteSetA/Notes/Double21.png")
	elif Look == 7:
		texture = load("res://Files/Sprites/SpriteSetA/Notes/Double12.png")
	elif Look == 8:
		texture = load("res://Files/Sprites/SpriteSetA/Notes/Double22.png")
	else:
		queue_free()
	
func _process(delta):
	position.x = -(G.EditorSection * 10) + (SongLocation*10) + 1000
	if Song != G.CurrentSongName:
		queue_free()
	elif len(G.CurrentSong) < SongLocation:
		queue_free()
	elif G.CurrentSong[SongLocation] != Look:
		queue_free()
	
