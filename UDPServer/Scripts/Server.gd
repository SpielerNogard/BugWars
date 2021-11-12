extends Node

var server := UDPServer.new()
var rng = RandomNumberGenerator.new()
var game_scene = load("res://Scenes/Game.tscn")
var peers = []
var queue = []
func _ready():
	server.listen(4242)

func check_data(data, ip, port, peer):
	var pkt = ""
	var player = [ip, port, peer]
	if data == "queue":
		queue.append(player)
		
	return pkt

func check_for_new_connections():
	if server.is_connection_available():
		var peer : PacketPeerUDP = server.take_connection()
		var pkt = peer.get_packet()
		print("Accepted peer: %s:%s" % [peer.get_packet_ip(), peer.get_packet_port()])
		print("Received data: %s" % [pkt.get_string_from_utf8()])
		peer.put_packet(pkt)
		peers.append(peer)

func check_for_new_data():
	for i in range(0, peers.size()):
		var peer = peers[i]
		var pkt = peer.get_packet()
		if len(pkt.get_string_from_utf8()) > 0:
			var ip = peer.get_packet_ip()
			var port = peer.get_packet_port()
			var data = pkt.get_string_from_utf8()
			var pkt_ret = check_data(data,ip,port, peer) 
			peer.put_packet(pkt)	

func create_game(player1, player2):
	var instance = game_scene.instance()
	instance.player1 = player1
	instance.player2 = player2
	add_child(instance)
					
func queue_players():
	if len(queue) >=2:
		var player1_pos = rng.randi_range (0, len(queue)-1)
		var player2_pos = rng.randi_range(0, len(queue)-1)
		
		var player1 = queue[player1_pos]
		var player2 = queue[player2_pos]	
		queue.erase(player1)
		queue.erase(player2)
		create_game(player1 ,player2)	
		
		
func _process(delta):
	server.poll() # Important!
	check_for_new_connections()
	check_for_new_data()
	
