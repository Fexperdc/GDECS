class_name ECSWorld

signal entity_created(e)
signal entity_removed(e)
signal component_added(e, c)
signal component_removed(e, c)

var _current_c_index: int = -1
	#	entities {
	#		entity_id : Bag(components)
	#	}
var entities: Array = []
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

func create_entity() -> ECSEntity:
	var entity: ECSEntity = ECSEntity.new()
	entities.append(entity)
	emit_signal("entity_created", entity)
	
	return entity

func create_component(c_class):
	return c_class.new()

func add_component(entity: ECSEntity, c) -> void:
	entity.components.set_o(component_type.get_index_for(c.get_script()), c)
	emit_signal("component_added", entity, c)

func get_component(entity: ECSEntity, c_class):
	return entity.components.get_o(component_type.get_index_for(c_class))

func has_component(entity: ECSEntity, c_class) -> bool:
	return entity.components.get_o(component_type.get_index_for(c_class)) != null
	
func has_components(entity: ECSEntity, c_classes: Array) -> bool:
	var result: bool = false
	for i in range(c_classes.size()):
		if has_component(entity, c_classes[i]):
			result = true
		else:
			result = false
			break
	
	return result

func has_one_component_of(entity: ECSEntity, c_classes: Array) -> bool:
	var result: bool = false
	
	for i in range(c_classes.size()):
		if has_component(entity, c_classes[i]):
			result = true
			break
	
	return result

func remove_entity(entity: ECSEntity):
	emit_signal("entity_removed", entity)
	entities.erase(entity)

func add_system(system):
	systems.append(system)

func create_gathering(family: ECSFamily) -> ECSGathering:
	var g: ECSGathering = ECSGathering.new(self, family)
	gatherings.append(g)
	return g

func _check_gatherings(entity: ECSEntity):
	for g in gatherings:
		g.check_entity(entity)

func _remove_from_gatherings(entity: ECSEntity):
	for g in gatherings:
		g.remove_entity(entity)

##################FOR SIGNALS############################

func _entity_created(e: ECSEntity):
	_check_gatherings(e)
	
func _entity_removed(e: ECSEntity):
	_remove_from_gatherings(e)
	
func _component_added(e: ECSEntity, c):
	_check_gatherings(e)

func _component_removed(e: ECSEntity, c):
	_check_gatherings(e)
