extends Node2D

onready var Enemy = load("res://Enemy/Enemy.tscn")

var y_positions = [100,150,200,250,300]
var initial_position = Vector2.ZERO

func _ready():
	initial_position.x = -100
	initial_position.y = y_positions[randi()%y_positions.size()]
	position = initial_position

func _physics_process(_delta):
	if get_child_count() == 0 and Global.level < Global.levels.size():
		var level = Global.levels[Global.level]
		if not level["enemies_spawned"]:
			for pos in level["enemies"]:
				var enemy = Enemy.instance()
				enemy.position = pos
				add_child(enemy)
			level["enemies_spawned"] = true
