extends Node2D
## Originally made by PixelToad ('pixeltoad' on discord)
#FixStuffs
var Frames = [0,0,0,0,0,0,0,0]

var SelectedOption = 0
var SelectedIncrement = 1

var Inside = -1


var VDelay
var SongEdited = 0
var Song

var SaveDict

func _ready():
	_loadsong()

func _loadsong():
	VDelay = round(G.CurrentDelay * 100)/100
	Song = G.CurrentSongName
	for i in range(G.CurrentLength):
		_spawn()
		_spawnbeat()
		if G.EditorSection <= G.CurrentLength:
			G.EditorSection += 1
	$EditorMenu/Options/ValueChanging/Labels/LenLabel.text = str(G.CurrentLength)
	$EditorMenu/Options/ValueChanging/Labels/AmountLabel.text = str(G.CurrentAmount)
	$EditorMenu/Options/ValueChanging/Labels/DelayLabel.text = str(VDelay)
	$EditorMenu/Options/ValueChanging/Labels/BPMLabel.text = str(G.CurrentBPM)
	G.EditorSection = 0


func _process(delta):
	if G.CurrentSongName != Song:
		_loadsong()
	if Input.is_action_just_pressed("EditorLeft"):
		G.EditorSection -= SelectedIncrement
		if G.EditorSection < 0:
			G.EditorSection = 0
	if Input.is_action_pressed("EditorLeftFast"):
		G.EditorSection -= SelectedIncrement
		if G.EditorSection < 0:
			G.EditorSection = 0
	if Input.is_action_just_pressed("EditorRight"):
		G.EditorSection += SelectedIncrement
		if G.EditorSection > G.CurrentLength:
			G.EditorSection = G.CurrentLength
	if Input.is_action_pressed("EditorRightFast"):
		G.EditorSection += SelectedIncrement
		if G.EditorSection > G.CurrentLength:
			G.EditorSection = G.CurrentLength
	if Input.is_action_just_pressed("EditorPlace"):
		if Frames == [Frames[0],Frames[1],Frames[2],Frames[3],Frames[4],0,0,0]:
			if Frames == [1,0,0,0,0,0,0,0]:
				G.CurrentSong[G.EditorSection] = 0
			elif Frames == [0,0,0,0,1,0,0,0]:
				G.CurrentSong[G.EditorSection] = 1
			elif Frames == [0,0,0,1,0,0,0,0]:
				G.CurrentSong[G.EditorSection] = 2
			elif Frames == [0,0,1,0,0,0,0,0]:
				G.CurrentSong[G.EditorSection] = 3
			elif Frames == [0,1,0,0,0,0,0,0]:
				G.CurrentSong[G.EditorSection] = 4
			elif Frames == [0,0,0,1,1,0,0,0]:
				G.CurrentSong[G.EditorSection] = 5
			elif Frames == [0,1,0,0,1,0,0,0]:
				G.CurrentSong[G.EditorSection] = 6
			elif Frames == [0,0,1,1,0,0,0,0]:
				G.CurrentSong[G.EditorSection] = 7
			elif Frames == [0,1,1,0,0,0,0,0]:
				G.CurrentSong[G.EditorSection] = 8
			_spawn()
		else:
			if Frames == [0,0,0,0,0,1,0,0]:
				G.CurrentSongBeats[G.EditorSection] = 1
			elif Frames == [0,0,0,0,0,0,1,0]:
				G.CurrentSongBeats[G.EditorSection] = 2
			elif Frames == [0,0,0,0,0,0,0,1]:
				G.CurrentSongBeats[G.EditorSection] = 0
			_spawnbeat()

#ChangeNotes/Beats
func _replaceframe():
	SelectedOption = Inside
	if SelectedOption == 1:
		Frames = [0,0,Frames[2],0,Frames[4],0,0,0]
	elif SelectedOption == 3:
		Frames = [0,0,Frames[2],0,Frames[4],0,0,0]
	elif SelectedOption == 2:
		Frames = [0,Frames[1],0,Frames[3],0,0,0,0]
	elif SelectedOption == 4:
		Frames = [0,Frames[1],0,Frames[3],0,0,0,0]
	else:
		Frames = [0,0,0,0,0,0,0,0]
	Frames[SelectedOption] = 1
	$EditorMenu/Notes/EraseFlick.frame = Frames[0]
	$EditorMenu/Notes/DoubleShoulderFlick.frame = Frames[1]
	$EditorMenu/Notes/DoubleFaceFlick.frame = Frames[2]
	$EditorMenu/Notes/ShoulderFlick.frame = Frames[3]
	$EditorMenu/Notes/FaceFlick.frame = Frames[4]
	$EditorMenu/Beats/BigBeatFlick.frame = Frames[5]
	$EditorMenu/Beats/SmallBeatFlick.frame = Frames[6]
	$EditorMenu/Beats/EraseFlick.frame = Frames[7]

func _spawn():
	var note = load("res://Files/Scenes/BaseGame/editor_notes.tscn")
	var Note = note.instantiate()
	var world = $NoteHold
	world.add_child(Note)

func _spawnbeat():
	var beat = load("res://Files/Scenes/BaseGame/editor_bars.tscn")
	var Beat = beat.instantiate()
	var world = $NoteHold
	world.add_child(Beat)


#Moving Menu Down Selection
func _on_go_down_mouse_entered():
	if $EditorMenu/Options.global_position.y == 0:
		$EditorMenu/Options.global_position.y = 178
	elif $EditorMenu/Options.global_position.y == 178:
		$EditorMenu/Options.global_position.y = 0
func _on_go_down_2_mouse_entered():
	if $EditorMenu/Beats.global_position.y == 0:
		$EditorMenu/Beats.global_position.y = 178
	elif $EditorMenu/Beats.global_position.y == 178:
		$EditorMenu/Beats.global_position.y = 0
func _on_go_down_3_mouse_entered():
	if $EditorMenu/Notes.global_position.y == 0:
		$EditorMenu/Notes.global_position.y = 300
	elif $EditorMenu/Notes.global_position.y == 300:
		$EditorMenu/Notes.global_position.y = 0


func _on_button_pressed():
	SaveDict = {
		"Chart":G.CurrentSong,
		"Beats":G.CurrentSongBeats,
		"BPM":G.CurrentBPM,
		"Wait":G.CurrentWait,
		"Delay":G.CurrentDelay,
		"Amount":G.CurrentAmount,
		"MusicLocation":G.CurrentSongLocation,
		"SongName":G.CurrentSongName
	}
	var songsfile = FileAccess.open(S.SongList[SongEdited], FileAccess.WRITE)
	var SaveStringed = JSON.stringify(SaveDict)
	songsfile.store_line(SaveStringed)

func _on_len_up_pressed():
	G.CurrentLength += SelectedIncrement
	for i in range(SelectedIncrement):
		G.CurrentSong += [0]
		G.CurrentSongBeats += [0]
	$EditorMenu/Options/ValueChanging/Labels/LenLabel.text = str(G.CurrentLength)
func _on_len_down_pressed():
	G.CurrentLength -= SelectedIncrement
	G.CurrentSong.resize(G.CurrentLength)
	G.CurrentSongBeats.resize(G.CurrentLength + 2)
	$EditorMenu/Options/ValueChanging/Labels/LenLabel.text = str(G.CurrentLength)
	if G.CurrentLength < 0:
		G.CurrentLength = 1
		G.CurrentSong.resize(G.CurrentLength)
		G.CurrentSongBeats.resize(G.CurrentLength + 2)
func _on_note_up_pressed():
	G.CurrentAmount += SelectedIncrement
	$EditorMenu/Options/ValueChanging/Labels/AmountLabel.text = str(G.CurrentAmount)
func _on_note_down_pressed():
	G.CurrentAmount -= SelectedIncrement
	$EditorMenu/Options/ValueChanging/Labels/AmountLabel.text = str(G.CurrentAmount)
	if G.CurrentAmount < 1:
		G.CurrentAmount = 1
func _on_delay_up_pressed():
	G.CurrentDelay += SelectedIncrement * 0.01
	VDelay = round(G.CurrentDelay * 100)/100
	$EditorMenu/Options/ValueChanging/Labels/DelayLabel.text = str(VDelay)
func _on_delay_down_pressed():
	G.CurrentDelay -= SelectedIncrement * 0.01
	VDelay = round(G.CurrentDelay * 100)/100
	$EditorMenu/Options/ValueChanging/Labels/DelayLabel.text = str(VDelay)
	if G.CurrentDelay < 0:
		G.CurrentDelay = 0
func _on_bpm_up_pressed():
	G.CurrentBPM += SelectedIncrement
	$EditorMenu/Options/ValueChanging/Labels/BPMLabel.text = str(G.CurrentBPM)
func _on_bpm_down_pressed():
	G.CurrentBPM -= SelectedIncrement
	$EditorMenu/Options/ValueChanging/Labels/BPMLabel.text = str(G.CurrentBPM)
	if G.CurrentBPM < 1:
		G.CurrentBPM = 1

func _on_inc_1_pressed():
	SelectedIncrement = 1
	$EditorMenu/Options/IncrementFlick.frame = 0
func _on_inc_2_pressed():
	SelectedIncrement = 2
	$EditorMenu/Options/IncrementFlick.frame = 1
func _on_inc_4_pressed():
	SelectedIncrement = 4
	$EditorMenu/Options/IncrementFlick.frame = 2
func _on_inc_8_pressed():
	SelectedIncrement = 8
	$EditorMenu/Options/IncrementFlick.frame = 3


func _on_select_big_pressed():
	Inside = 5
	_replaceframe()
func _on_select_small_pressed():
	Inside = 6
	_replaceframe()
func _on_select_erase_b_pressed():
	Inside = 7
	_replaceframe()


func _on_erase_pressed():
	Inside = 0
	_replaceframe()
func _on_double_shoulder_pressed():
	Inside = 1
	_replaceframe()
func _on_double_face_pressed():
	Inside = 2
	_replaceframe()
func _on_shoulder_pressed():
	Inside = 3
	_replaceframe()
func _on_face_pressed():
	Inside = 4
	_replaceframe()

func _on_squid_beatz_3_song_selected(Select):
	SongEdited = Select

	
