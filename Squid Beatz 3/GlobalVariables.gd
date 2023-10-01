extends Node
## Originally made by PixelToad ('pixeltoad' on discord)
var CurrentSong
var CurrentDelay
var CurrentBPM
var CurrentWait
var CurrentLength
var CurrentAmount
var CurrentSongBeats
var CurrentSongLocation
var CurrentSongName

var Combo = 0
var Silvers = 0
var Golds = 0

var RatingSignal = ""
var Playing = false#Checks if the song is actually playing
var Note = 0#Value given to notes when made
var NoteDone = 0#Value checked upon other notes to see if hit
var SongSection = 0#Which part of the song has occurred
var EditorSection = 0#Where you are editing in the editor
var TotalTime = 0.00
var LastUpdate = 0.00


var InputsA = [0,0]#FACE SHOULDER
var InputsB = [0,0]#LEFT RIGHT
