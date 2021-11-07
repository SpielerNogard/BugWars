extends Node

var network = NetworkedMultiplayerENet.new()
var port = 50000
var max_players = 100

func _ready():
	start_server()
	

func start_server():
	network.create_server(port, max_players)
	get_tree().set_network_peer(network)
	print("Server started")
	#network.set_bind_ip("157.90.184.184")
	network.connect("peer_connected", self, "_Peer_Connect")
	network.connect("peer_disconnected", self, "_Peer_Disconnect")
	
func _Peer_Connect(player_id):
	print("User "+str(player_id)+" connected")

func _Peer_Disconnect(player_id):
	print("User "+str(player_id)+" disconnected")
