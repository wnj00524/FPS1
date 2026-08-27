extends Node3D

@export var player_scene: PackedScene
@export var cottage_scene: PackedScene
@export var cottage_scale := 3.5
@export var cottage_position := Vector3(0.0, 2.0, 14.0)

func _ready() -> void:
	_create_environment()
	_create_cottage()
	var player := player_scene.instantiate()
	player.position = Vector3(0.0, 0.8, 20.0)
	player.rotation.y = 0.0
	add_child(player)

func _create_cottage() -> void:
	var cottage := cottage_scene.instantiate()
	cottage.name = "Market Cottage"
	cottage.position = cottage_position
	cottage.scale = Vector3.ONE * cottage_scale
	add_child(cottage)
	_create_cottage_collision()

func _create_cottage_collision() -> void:
	var dimensions := Vector3(1.9, 1.14, 1.23) * cottage_scale
	var width := dimensions.x
	var height := dimensions.y
	var depth := dimensions.z
	var wall_thickness := 0.24
	var doorway_width := 1.6
	var doorway_height := 2.15

	var shell := StaticBody3D.new()
	shell.name = "Cottage Collision"
	shell.position = cottage_position
	add_child(shell)

	# The asset's usable entrance is centered on the rear (+Z) wall.
	var side_width := (width - doorway_width) * 0.5
	_create_collision_box(shell, "Rear Wall Left", Vector3(-(doorway_width + side_width) * 0.5, 0.0, depth * 0.5), Vector3(side_width, height, wall_thickness))
	_create_collision_box(shell, "Rear Wall Right", Vector3((doorway_width + side_width) * 0.5, 0.0, depth * 0.5), Vector3(side_width, height, wall_thickness))
	_create_collision_box(shell, "Rear Wall Lintel", Vector3(0.0, doorway_height * 0.5, depth * 0.5), Vector3(doorway_width, height - doorway_height, wall_thickness))

	_create_collision_box(shell, "Front Wall", Vector3(0.0, 0.0, -depth * 0.5), Vector3(width, height, wall_thickness))
	_create_collision_box(shell, "Left Wall", Vector3(-width * 0.5, 0.0, 0.0), Vector3(wall_thickness, height, depth))
	_create_collision_box(shell, "Right Wall", Vector3(width * 0.5, 0.0, 0.0), Vector3(wall_thickness, height, depth))
	_create_collision_box(shell, "Roof Collision", Vector3(0.0, height * 0.5, 0.0), Vector3(width, wall_thickness, depth))

func _create_collision_box(parent: Node3D, box_name: String, local_position: Vector3, size: Vector3) -> void:
	var collision := CollisionShape3D.new()
	collision.name = box_name
	collision.position = local_position
	var shape := BoxShape3D.new()
	shape.size = size
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
