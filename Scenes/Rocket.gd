extends RigidBody2D

onready var Earth = get_node('../Earth')
onready var Line = get_node('../Line')

var prev_pos: Vector2

func _physics_process(delta):
	launch_position()
	rotate_rocket()

func launch_position():
	if Global.launched: return
	$Camera.zoom = Vector2(2, 2)
	var point = Earth.position
	var angle = global_position.angle_to_point(Line.get_point_position(1))
	var distance = 70
	position = point + Vector2(cos(angle), sin(angle)) * distance
	rotation = global_position.angle_to_point(point)

func launch(vector, speed = 1):
	Global.launched = true
	$Trail.visible = true
	$Camera.zoom = Vector2(2, 2)
	linear_velocity = vector * speed
	prev_pos = global_position
	$Timer.start()
	$RotationTimer.start()

func rotate_rocket():
	if !Global.launched: return
	rotation = global_position.angle_to_point(prev_pos)

func _on_Timer_timeout():
	Global.launched = false
	launch_position()

func _on_RotationTimer_timeout():
	prev_pos = global_position
	$RotationTimer.start()
