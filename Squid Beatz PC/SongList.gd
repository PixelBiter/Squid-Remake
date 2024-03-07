extends Node
## Originally made by PixelToad ('pixeltoad' on discord)
var FauxSongList
var fauxsonglist
var SongList = ["res://Files/ChartFiles/BaseGame/1. Inkoming - Wet Floor.txt",
"res://Files/ChartFiles/BaseGame/2. Rip Entry - Wet Floor.txt",
"res://Files/ChartFiles/BaseGame/3. Undertow - Wet Floor.txt",
"res://Files/ChartFiles/BaseGame/4. Don't Slip - Wet Floor.txt",
"res://Files/ChartFiles/BaseGame/5. Endolphin Surge - Wet Floor.txt",
"res://Files/ChartFiles/BaseGame/6. Now Or Never - Wet Floor.txt",
"res://Files/ChartFiles/BaseGame/7. Turf Master - Wet Floor.txt",
"res://Files/ChartFiles/BaseGame/8. Ink Another Day - Wet Floor.txt",
"res://Files/ChartFiles/BaseGame/9. Low Tide.txt",
"res://Files/ChartFiles/BaseGame/10. Octo Canyon - Turquoise October.txt",
"res://Files/ChartFiles/BaseGame/11. Octo Eight-Step - Turquoise October.txt",
"res://Files/ChartFiles/BaseGame/12. The Girl From Inkopolis - Turquoise October.txt",
"res://Files/ChartFiles/BaseGame/13. Bouyant Boogie - Turquoise October.txt",
"res://Files/ChartFiles/BaseGame/14. Shooting Starfish - Turquoise October.txt",
"res://Files/ChartFiles/BaseGame/15. Tentacular Circus - Turquoise October.txt"]
var Medals = ["","","","","","","","","","","","","","",""]

func _ready():
	if FileAccess.open("res://Files/ChartFiles/SongList.txt", FileAccess.READ) == null:
		_savesongs()
		FauxSongList = FileAccess.open("res://Files/ChartFiles/SongList.txt", FileAccess.READ)
		fauxsonglist = JSON.parse_string(FauxSongList.get_as_text())
		SongList = fauxsonglist
	else:
		FauxSongList = FileAccess.open("res://Files/ChartFiles/SongList.txt", FileAccess.READ)
		fauxsonglist = JSON.parse_string(FauxSongList.get_as_text())
		SongList = fauxsonglist

func _savesongs():
	FauxSongList = FileAccess.open("res://Files/ChartFiles/SongList.txt", FileAccess.WRITE)
	fauxsonglist = JSON.stringify(SongList)
	FauxSongList.store_line(fauxsonglist)
