extends Node

var network = NetworkedMultiplayerENet.new()

#var ip = "127.0.0.1
var ip = "157.90.184.184"#
#var ip = "192.168.0.137"

var port = 50000

func _ready():
	connect_to_server()
	
func connect_to_server():
	var ip = "157.90.184.184"
	print("conneting to server")
	network.create_client(ip, port)
	get_tree().set_network_peer(network)
	
	network.connect("connection_failed", self, "_OnConnectionFailed")
	network.connect("connection_succeeded", self, "_OnConnectionSucceeded")
	
	
	
func _OnConnectionFailed():
	print("Failed to connect")

func _OnConnectionSucceeded():
	print("successfully connected")

