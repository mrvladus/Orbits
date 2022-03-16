extends Node2D

onready var rocket: PackedScene = preload("res://Scenes/Rocket.tscn")

func _ready():
	$Line.add_point($Earth.global_position, 0)
	$Line.add_point(get_global_mouse_position(), 1)

func pull_slingshot():
	if !Global.launched and Input.is_action_pressed("launch"):
		var distance = get_global_mouse_position()
		$Line.visible = true
		if distance.distance_to($Earth.position) > 200:
			distance = (distance - $Earth.position).normalized() * 200 + $Earth.position
		$Line.points[1] = distance
	if !Global.launched and Input.is_action_just_released("launch"): 
		$Rocket.launch($Line.points[0] - $Line.points[1], 5)
		$Line.visible = false

func _physics_process(delta):
	pull_slingshot()

