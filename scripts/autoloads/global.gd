extends Node

var ppt : int = 32; #Pixels per Tile

signal player_died

func playerDied():
	player_died.emit();
	
