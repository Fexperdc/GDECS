class_name ECSWorld

signal entity_created(e)
signal entity_removed(e)
signal component_added(e, c)
signal component_removed(e, c)

var _current_id: int = -1

var entities: Dictionary = {}
var systems: Array = []
var gath_components: Array = []

func _init():
	connect("entity_created", self, "entity_created")
	connect("entity_removed", self, "entity_removed")
	connect("component_added", self, "_component_added")
#	connect("entity_removed", self, "entity_removed")

func execute(delta: float):
	_execute_systems(delta)

func _check_gath_components(entity_id: int):
	for g in gath_components:
		g.check_entity(entity_id)

func _execute_systems(delta: float):
	for s in systems:
		s.execute(delta)

func create_entity() -> int:
	_current_id += 1
	
	var _id: int = _current_id
	entities[_id] = {}
	
	emit_signal("entity_created", _id)
	
	return _id

func create_component(c_class):
	var component: ECSComponent = c_class.new()
	return component

func add_component(entity_id: int, c) -> void:
#	entities[entity_id][c.get_script()] = c
	get_components(entity_id)[c.get_script()] = c
	emit_signal("component_added", entity_id, c)

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

func add_system(system):
	systems.append(system)

func create_gathering_components(family):
	var gath = ECSGatheringComponents.new(self, family)
	gath_components.append(gath)
	
	for e in entities:
		_check_gath_components(e)
	
	return gath

##################FOR SIGNALS############################

func _entity_created(e: int):
	_check_gath_components(e)
	
func _entity_removed(e: int):
	pass
	
func _component_added(e: int, c):
	_check_gath_components(e)

func _component_removed(e: int, c):
	pass
