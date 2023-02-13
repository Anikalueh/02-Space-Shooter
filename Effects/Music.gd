extends AudioStreamPlayer


func _ready():
	play()


func _on_Music_finished():
	play()
