extends Node3D

@export var player_scene: PackedScene
@export var cottage_scene: PackedScene
@export var cottage_scale := 3.5
@export var cottage_position := Vector3(0.0, 2.0, 14.0)

func _ready() -> void:
	_create_environment()
	_create_cottage()
	var player := player_scene.instantiate()
	player.position = Vector3(0.0, 0.8, -8.0)
	add_child(player)

func _create_cottage() -> void:
	var cottage := cottage_scene.instantiate()
	cottage.name = "Market Cottage"
	cottage.position = cottage_position
	cottage.scale = Vector3.ONE * cottage_scale
	add_child(cottage)

	var collision_body := StaticBody3D.new()
	collision_body.name = "Market Cottage Collision"
	collision_body.position = cottage_position
	add_child(collision_body)

	var cottage_size := Vector3(1.95, 1.15, 1.24) * cottage_scale
	var wall_thickness := 0.3
	var door_width := 1.25
	var door_height := 2.35
	var front_segment_width := (cottage_size.x - door_width) * 0.5
	var front_z := -cottage_size.z * 0.5 + wall_thickness * 0.5

	_create_collision_box(collision_body, Vector3(-(door_width + front_segment_width) * 0.5, 0.0, front_z), Vector3(front_segment_width, cottage_size.y, wall_thickness))
	_create_collision_box(collision_body, Vector3((door_width + front_segment_width) * 0.5, 0.0, front_z), Vector3(front_segment_width, cottage_size.y, wall_thickness))
	_create_collision_box(collision_body, Vector3(0.0, (cottage_size.y - door_height) * 0.5, front_z), Vector3(door_width, cottage_size.y - door_height, wall_thickness))
	_create_collision_box(collision_body, Vector3(-cottage_size.x * 0.5 + wall_thickness * 0.5, 0.0, 0.0), Vector3(wall_thickness, cottage_size.y, cottage_size.z))
	_create_collision_box(collision_body, Vector3(cottage_size.x * 0.5 - wall_thickness * 0.5, 0.0, 0.0), Vector3(wall_thickness, cottage_size.y, cottage_size.z))
	_create_collision_box(collision_body, Vector3(0.0, 0.0, cottage_size.z * 0.5 - wall_thickness * 0.5), Vector3(cottage_size.x, cottage_size.y, wall_thickness))

func _create_collision_box(parent: Node, position: Vector3, size: Vector3) -> void:
	var collision := CollisionShape3D.new()
	var shape := BoxShape3D.new()
	shape.size = size
	collision.position = position
	collision.shape = shape
	parent.add_child(collision)

func _create_environment() -> void:
	var environment := WorldEnvironment.new()
	environment.environment = Environment.new()
	environment.environment.background_mode = Environment.BG_COLOR
	environment.environment.background_color = Color(0.035, 0.055, 0.09)
	environment.environment.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	environment.environment.ambient_light_color = Color(0.3, 0.38, 0.55)
	environment.environment.ambient_light_energy = 0.7
	add_child(environment)

	var light := DirectionalLight3D.new()
	light.rotation_degrees = Vector3(-50.0, -30.0, 0.0)
	light.light_color = Color(1.0, 0.93, 0.8)
	light.light_energy = 1.2
	light.shadow_enabled = true
	add_child(light)

	_create_box("Ground", Vector3(0.0, -0.5, 10.0), Vector3(40.0, 1.0, 40.0), Color(0.12, 0.16, 0.2))
	_create_box("Cover", Vector3(0.0, 1.0, 7.0), Vector3(3.0, 2.0, 1.0), Color(0.3, 0.34, 0.4))
	_create_box("Cover", Vector3(-7.0, 1.0, 14.0), Vector3(1.0, 2.0, 4.0), Color(0.26, 0.3, 0.36))
	_create_box("Cover", Vector3(8.0, 1.0, 20.0), Vector3(4.0, 2.0, 1.0), Color(0.3, 0.34, 0.4))

func _create_box(box_name: String, position: Vector3, size: Vector3, color: Color) -> void:
	var body := StaticBody3D.new()
	body.name = box_name
	body.position = position
	add_child(body)

	var mesh_instance := MeshInstance3D.new()
	var mesh := BoxMesh.new()
	mesh.size = size
	var material := StandardMaterial3D.new()
	material.albedo_color = color
	mesh.material = material
	mesh_instance.mesh = mesh
	body.add_child(mesh_instance)

	var collision := CollisionShape3D.new()
	var shape := BoxShape3D.new()
	shape.size = size
	collision.shape = shape
	body.add_child(collision)
