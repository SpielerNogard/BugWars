extends Node

var udp := PacketPeerUDP.new()
var connected = false
var ip = "192.168.2.116"
#var ip = "157.90.184.184"
var test = JSONParseResult.new()

func send_message(message):
	var new_message = JSON.print(message)
	udp.put_packet(new_message.to_utf8())	
		
func _connect_to_server():
	if !connected:
		var message = {
			"messagetype":"connect"
		}
		send_message(message)

func _disconnect_from_server():
	var message = {
			"messagetype":"stop"
		}	
	send_message(message)
		
func _set_card(card_nr, posx, posy, posz):
	var message = {
		"messagetype":"set_card",
		"number":card_nr,
		"posx":posx,
		"posy":posy,
		"posz":posz
	}
	send_message(message)
	
func _queue(my_cards):
	var message = {
		"messagetype":"queue",
		"cards":my_cards
	}
	send_message(message)

func _get_data():
	var data
	if udp.get_available_packet_count() > 0:
		data = udp.get_packet().get_string_from_utf8()
		if data == "success":
			connected = true
		else:
			data = parse_json(data)
			
			if data["messagetype"] == "game":
				return data


func _get_game_data():
	if connected == true:
		if udp.get_available_packet_count() > 0:
			print("Connected: %s" % udp.get_packet().get_string_from_utf8())
			var pkt = udp.get_packet().get_string_from_utf8()
			var me  = pkt["Player1"]
			var enemy = pkt["Player2"]	
			
			var my_towers = me["tower"]
			var enemy_tower = enemy["tower"]	
			
			var my_units = me["units"]
			var enemy_units = enemy["units"]
			
			var my_ressources = me["resources"]
			
			var my_cards = me["cards"]
			
func _ready():
	udp.connect_to_host(ip, 4242)
	_connect_to_server()

