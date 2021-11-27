extends Spatial

var queued = false

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _process(delta):
	var data = Client._get_data()
	
	if data:
		print(data)
	if !queued:
		Client._queue([])
		queued = true
	pass
