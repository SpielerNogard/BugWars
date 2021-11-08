extends Spatial

var udp := PacketPeerUDP.new()
var connected = false

func _ready():
	udp.connect_to_host("157.90.184.184", 4242)

func _process(delta):
	if !connected:
		# Try to contact server
		udp.put_packet("The answer is... 42!".to_utf8())
	if udp.get_available_packet_count() > 0:
		print("Connected: %s" % udp.get_packet().get_string_from_utf8())
		connected = true
		
	udp.put_packet("The answer is... 42!".to_utf8())