class_name ECSWorld

signal entity_created(e)
signal entity_removed(e)
signal component_added(e, c)
signal component_removed(e, c)

var _current_id: int = -1
var _current_c_index: int = -1
	#	entities {
	#		entity_id : Bag(components)
	#	}
var entities: Dictionary = {}
var systems: Array = []
var gatherings: Array = []

var component_type: ComponentType

func create():
	connect("entity_created", self, "_entity_created")
	connect("entity_removed", self, "_entity_removed")
	connect("component_added", self, "_component_added")
	
	component_type = ComponentType.new(self)

func execute(delta: float):
	_execute_systems(delta)

func _execute_systems(delta: float):
	for s in systems:
		s.execute(delta)

func create_entity() -> int:
	_current_id += 1
	
	var _id: int = _current_id
	entities[_id] = Bag.new(16)
	
	emit_signal("entity_created", _id)
	
	return _id

func create_component(c_class):
	return c_class.new()

func add_component(entity_id: int, c) -> void:
	entities[entity_id].set_o(component_type.get_index_for(c.get_script()), c)
	emit_signal("component_added", entity_id, c)

func get_component(entity_id: int, c_class):
	return entities[entity_id].get_o(component_type.get_index_for(c_class))

func get_components(entity_id: int) -> Bag:
	return entities[entity_id]

func has_component(entity_id: int, c_class) -> bool:
	return entities[entity_id].get_o(component_type.get_index_for(c_class)) != null
	
func has_components(entity_id: int, c_classes: Array) -> bool:
	var result: bool = false
	for i in range(c_classes.size()):
		if has_component(entity_id, c_classes[i]):
			result = true
		else:
			result = false
			break
	
	return result

func remove_entity(entity_id: int):
	emit_signal("entity_removed", entity_id)
	entities.erase(entity_id)

func add_system(system):
	systems.append(system)

func create_gathering(family: ECSFamily) -> ECSGathering:
	var g: ECSGathering = ECSGathering.new(self, family)
	gatherings.append(g)
	return g

func _check_gatherings(entity_id: int):
	for g in gatherings:
		g.check_entity(entity_id)

func _remove_from_gatherings(entity_id: int):
	for g in gatherings:
		g.remove_entity(entity_id)

##################FOR SIGNALS############################

func _entity_created(e: int):
	_check_gatherings(e)
	
func _entity_removed(e: int):
	_remove_from_gatherings(e)
	
func _component_added(e: int, c):
	_check_gatherings(e)

func _component_removed(e: int, c):
	_check_gatherings(e)
