extends KinematicBody2D

var health = 1
var velocity = Vector2.ZERO
var score = 15

var Effects
onready var Explosion = load("res://Effects/Explosion.tscn")


func _physics_process(_delta):
	position += velocity
	position.x = wrapf(position.x,0,Global.VP.x)
	position.y = wrapf(position.y,0,Global.VP.y)

func damage(d):
	health -= d
	if health <= 0:
		Global.update_score(score)
	queue_free()
