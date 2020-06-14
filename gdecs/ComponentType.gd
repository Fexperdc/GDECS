class_name ComponentType

const registered_types: Dictionary = {}
var index: int = -1

var world

func _init(world):
	self.world = world

func get_for(c_class) -> ComponentType:
	var component_type
	
	if registered_types.has(c_class):
		component_type = registered_types[c_class]
	else:
		component_type = self.get_script().new(world)
		world._current_c_index += 1
		component_type.index = world._current_c_index
		registered_types[c_class] = component_type
	
	return component_type

func get_index_for(c_class) -> int:
	return get_for(c_class).index
