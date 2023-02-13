extends Node

var VP = Vector2.ZERO
var score = 0
var lives = 5

var level = -1

var levels = [
	{
		"title":"Level 1",
		"subtitle":"Destroy the asteroids",
		"asteroids":[Vector2(100,100),Vector2(900,500)],
		"enemies":[],
		"timer":100,
		"asteroids_spawned":false,
		"enemies_spawned":false
	},
	{
		"title":"Level 2",
		"subtitle":"Destroy the asteroids and watch out of for the enemy",
		"asteroids":[Vector2(100,100),Vector2(900,500),Vector2(800,200)],
		"enemies":[Vector2(150,250)],
		"timer":80,
		"asteroids_spawned":false,
		"enemies_spawned":false
	}
]

func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS
	randomize()
	VP = get_viewport().size
	var _signal = get_tree().get_root().connect("size_changed", self, "_resize")
	update_score(0)
	update_lives(0)

func _physics_process(_delta):
	var A = get_node_or_null("/root/Game/Asteroid_Container")
	var E = get_node_or_null("/root/Game/Enemy_Container")
	if A != null and E != null:
		var L = levels[level]
		if L["asteroids_spawned"] and A.get_child_count() == 0 and L["enemies_spawned"] and E.get_child_count() == 0:
			next_level()

func reset():
	score = 0
	lives = 5
	level = -1
	for l in levels:
		l["asteroids_spawned"]=false
		l["enemies_spawned"]=false

func _unhandled_input(_event):
	if Input.is_action_pressed("quit"):
		get_tree().quit()
	if Input.is_action_pressed("pause"):
		var Pause_Menu = get_node_or_null("/root/Game/UI/Pause_Menu")
		if Pause_Menu == null:
			get_tree().quit()
		else:
			if Pause_Menu.visible:
				Pause_Menu.hide()
				get_tree().paused = false
			else:
				Pause_Menu.show()
				get_tree().paused = true



func _resize():
	VP = get_viewport().size
	

func update_score(s):
	score += s
	var Score = get_node_or_null("/root/Game/UI/HUD/Score")
	if Score != null:
		Score.text = "Score: " + str(score)

func update_lives(l):
	lives += l
	if lives <= 0:
		var _scene = get_tree().change_scene("res://UI/End_Game.tscn")
	var Lives = get_node_or_null("/root/Game/UI/HUD/Lives")
	if Lives != null:
		Lives.text = "Lives: " + str(lives)

func next_level():
	level += 1
	if level >= levels.size():
		var _scene = get_tree().change_scene("res://UI/End_Game.tscn")
	else:
		var Level_Label = get_node_or_null("/root/Game/UI/Level")
		if Level_Label != null:
			Level_Label.show_labels()
