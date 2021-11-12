extends Node

var player1 = null
var player1_ip = null
var player1_port = null
var player1_peer = null 

var player2 = null
var player2_ip = null
var player2_port = null
var player2_peer = null

func check_data(peer, data):
	if peer == player1_peer or peer == player2_peer:
		pass

func set_player1(player):
	player1 = player
	player1_ip = player[0]
	player1_port = player[1]
	player1_peer = player[2]

func set_player2(player):
	player2 = player
	player2_ip = player[0]
	player2_ip = player[1]
	player2_peer = player[2]

func _ready():
	pass # Replace with function body.

