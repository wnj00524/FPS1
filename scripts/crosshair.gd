extends Control

@export var crosshair_size := 8.0
@export var thickness := 2.0
@export var color := Color.WHITE

func _ready() -> void:
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	queue_redraw()

func _draw() -> void:
	var center := crosshair_size * 0.5
	var viewport_center := get_viewport_rect().size * 0.5
	draw_rect(Rect2(Vector2(viewport_center.x - center, viewport_center.y - thickness * 0.5), Vector2(crosshair_size, thickness)), color)
	draw_rect(Rect2(Vector2(viewport_center.x - thickness * 0.5, viewport_center.y - center), Vector2(thickness, crosshair_size)), color)
