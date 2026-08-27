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
