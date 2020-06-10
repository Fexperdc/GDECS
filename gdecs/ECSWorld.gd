class_name ECSWorld

var _current_id: int = -1

var entities: Dictionary = {}

func create_entity() -> int:
	var _id: int = _current_id + 1
	entities[_id] = {}
	return _id

func create_component(c_class) -> ECSComponent:
	var component: ECSComponent = c_class.new()
	return component

func add_component(entity_id: int, c: ECSComponent) -> void:
	entities[entity_id][c.get_script()] = c

func get_component(entity_id: int, c_class):
	return entities[entity_id][c_class]

func get_components(entity_id: int) -> Dictionary:
	return entities[entity_id]

func has_component(entity_id: int, c_class) -> bool:
	return get_components(entity_id).has(c_class)
	
func has_components(entity_id: int, c_classes: Array) -> bool:
	return get_components(entity_id).has_all(c_classes)

func remove_entity(entity_id: int):
	entities.erase(entity_id)
