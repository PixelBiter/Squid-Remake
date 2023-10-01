extends Node2D
## Originally made by PixelToad ('pixeltoad' on discord)
var InputsUsed = [0,0,0,0,0,0,0,0]
var Title = ""
var MenuSelectSong = 0
var file
var _textreading
var medal
var medalll

signal SongSelected(Select)

func _ready():
	_updatesong()
	if FileAccess.open("user://medalsaving.txt", FileAccess.READ) == null:
		_savemedals()
		medal = FileAccess.open("user://medalsaving.txt", FileAccess.READ)
		medalll = JSON.parse_string(medal.get_as_text())
		S.Medals = medalll
	else:
		medal = FileAccess.open("user://medalsaving.txt", FileAccess.READ)
		medalll = JSON.parse_string(medal.get_as_text())
		S.Medals = medalll

func _updatesong():
	file = FileAccess.open(S.SongList[MenuSelectSong], FileAccess.READ)
	_textreading = JSON.parse_string(file.get_as_text())
	G.CurrentSong = _textreading.Chart
	G.CurrentSongBeats = _textreading.Beats
	G.CurrentBPM = _textreading.BPM
	G.CurrentWait = _textreading.Wait
	G.CurrentDelay = _textreading.Delay
	G.CurrentAmount = _textreading.Amount
	G.CurrentLength = (len(str(G.CurrentSong))-1)/3
	G.CurrentSongName = _textreading.SongName
	G.CurrentSongLocation = _textreading.MusicLocation
	$Audio/Music.stream = load(_textreading.MusicLocation)
	$Timer/BeatTimer.wait_time = G.CurrentWait
	$Background/Title.text = _textreading.SongName
	emit_signal("SongSelected",MenuSelectSong)
	_medalshow()

func _input(event):
	$Timer/InputTimer1.start()
	if Input.is_action_just_pressed("FaceA1") or Input.is_action_just_pressed("FaceA2"): #Left inputs Sound A
		if InputsUsed[0] == 0:
			InputsUsed[0] = 1
			G.InputsA[0] += 1
			G.InputsB[0] += 1
			$Audio/Face2.playing = false
			$Audio/Face2.playing = true
	if Input.is_action_just_pressed("FaceA3") or Input.is_action_just_pressed("FaceA4"): #Right inputs Sound A
		if InputsUsed[1] == 0:
			InputsUsed[1] = 1
			G.InputsA[0] += 1
			G.InputsB[1] += 1
			$Audio/Face2.playing = false
			$Audio/Face2.playing = true
	if Input.is_action_just_pressed("FaceB1") or Input.is_action_just_pressed("FaceB2"): #Left inputs Sound B
		if InputsUsed[2] == 0:
			InputsUsed[2] = 1
			G.InputsA[0] += 1
			G.InputsB[0] += 1
			$Audio/Face1.playing = false
			$Audio/Face1.playing = true
	if Input.is_action_just_pressed("FaceB3") or Input.is_action_just_pressed("FaceB4"): #Right inputs Sound B
		if InputsUsed[3] == 0:
			InputsUsed[3] = 1
			G.InputsA[0] += 1
			G.InputsB[1] += 1
			$Audio/Face1.playing = false
			$Audio/Face1.playing = true
	if Input.is_action_just_pressed("ShoulderA1"): #L
		if InputsUsed[4] == 0:
			InputsUsed[4] = 1
			G.InputsA[1] += 1
			G.InputsB[0] += 1
			$Audio/Shoulder1.playing = false
			$Audio/Shoulder1.playing = true
	if Input.is_action_just_pressed("ShoulderA2"): #R
		if InputsUsed[5] == 0:
			InputsUsed[5] = 1
			G.InputsA[1] += 1
			G.InputsB[1] += 1
			$Audio/Shoulder1.playing = false
			$Audio/Shoulder1.playing = true
	if Input.is_action_just_pressed("ShoulderB1"): #ZL
		if InputsUsed[6] == 0:
			InputsUsed[6] = 1
			G.InputsA[1] += 1
			G.InputsB[0] += 1
			$Audio/Shoulder2.playing = false
			$Audio/Shoulder2.playing = true
	if Input.is_action_just_pressed("ShoulderB2"): #ZR
		if InputsUsed[7] == 0:
			InputsUsed[7] = 1
			G.InputsA[1] += 1
			G.InputsB[1] += 1
			$Audio/Shoulder2.playing = false
			$Audio/Shoulder2.playing = true
		
	if Input.is_action_just_pressed("Select"):
		if G.Playing != true:
			G.Playing = true
			$Timer/BeatTimer.one_shot = false
			$Timer/WaitTimer.wait_time = G.CurrentDelay
			$Timer/WaitTimer.start()
			$Timer/BeatTimer.start()
		else:
			G.Playing = false
			$Audio/Music.playing = false
			$Timer/BeatTimer.one_shot = true
			$Timer/WaitTimer.stop()
			$Timer/BeatTimer.stop()
			G.Note = 0
			G.NoteDone = 0
			G.SongSection = 0
			G.Silvers = 0
			G.Golds = 0
			G.Combo = 0
		
	if G.Playing != true:
		if Input.is_action_just_pressed("Left"):
			if MenuSelectSong > 0:
				MenuSelectSong -= 1
			else:
				MenuSelectSong = len(S.SongList)-1
			_updatesong()
		if Input.is_action_just_pressed("Right"):
			if MenuSelectSong < len(S.SongList)-1:
				MenuSelectSong += 1
			else:
				MenuSelectSong = 0
			_updatesong()
		

func _process(delta):
	G.TotalTime = $Audio/Music.get_playback_position() + AudioServer.get_time_since_last_mix() - AudioServer.get_output_latency()
	if G.LastUpdate + G.CurrentWait <= G.TotalTime:
		G.LastUpdate = G.TotalTime
	$Background/GoldLabel.text = str(G.Golds)
	$Background/SilverLabel.text = str(G.Silvers) + "/" + str(G.CurrentAmount)


#Use For later
func _OnBeat():
	print("Activated")
	if G.SongSection <= G.CurrentLength:
		if G.CurrentSong[G.SongSection] != 0:
			var Note = load("res://Files/Scenes/BaseGame/notes.tscn")
			var note = Note.instantiate()
			var world = get_tree().current_scene
			world.add_child(note)
		if G.CurrentSongBeats[G.SongSection] != 0:
			var Beat = load("res://Files/Scenes/BaseGame/bars.tscn")
			var beat = Beat.instantiate()
			var world = get_tree().current_scene
			world.add_child(beat)
		G.SongSection += 1
	else:
		if G.Golds == G.CurrentAmount:
			S.Medals[MenuSelectSong] = "Gold"
			_savemedals()
		elif G.Silvers == G.CurrentAmount:
			S.Medals[MenuSelectSong] = "Silver"
			_savemedals()

func _on_beat_timer_timeout():
	if G.SongSection <= G.CurrentLength:
		if G.CurrentSong[G.SongSection] != 0:
			var Note = load("res://Files/Scenes/BaseGame/notes.tscn")
			var note = Note.instantiate()
			var world = get_tree().current_scene
			world.add_child(note)
		if G.CurrentSongBeats[G.SongSection] != 0:
			var Beat = load("res://Files/Scenes/BaseGame/bars.tscn")
			var beat = Beat.instantiate()
			var world = get_tree().current_scene
			world.add_child(beat)
		G.SongSection += 1
	else:
		if G.Golds == G.CurrentAmount:
			S.Medals[MenuSelectSong] = "Gold"
			_savemedals()
		elif G.Silvers == G.CurrentAmount:
			S.Medals[MenuSelectSong] = "Silver"
			_savemedals()

func _savemedals():
	medal = FileAccess.open("user://medalsaving.txt", FileAccess.WRITE)
	medalll = JSON.stringify(S.Medals)
	medal.store_line(medalll)
	_medalshow()

func _medalshow():
	if len(S.SongList) > len(S.Medals):
		for i in range(len(S.SongList)-len(S.Medals)):
			S.Medals += [""]
	elif S.Medals[MenuSelectSong] == "Gold":
		$Medals/MedalSprite.texture = load("res://Files/Sprites/SpriteSetA/Ratings/GoldSquid.png")
		$Medals/MedalSprite.visible = true
	elif S.Medals[MenuSelectSong] == "Silver":
		$Medals/MedalSprite.texture = load("res://Files/Sprites/SpriteSetA/Ratings/SilverSquid.png")
		$Medals/MedalSprite.visible = true
	else:
		$Medals/MedalSprite.visible = false

func _on_input_timer_1_timeout():
	InputsUsed = [0,0,0,0,0,0,0,0]
	G.InputsA = [0,0]
	G.InputsB = [0,0]

func _on_wait_timer_timeout():
	$Audio/Music.playing = true


