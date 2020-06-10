class_name ECSGatheringComponents

signal success(e)

var _world

var _family
var components: Dictionary = {}

func _init(world, family):
	self._world = world
	self._family = family
	for c in family._dict["include"]:
		components[c] = []

func check_entity(entity_id: int):
	if _family.matches(entity_id):
		emit_signal("success", entity_id)
		for c in _world.get_components(entity_id):
			components[c].append(_world.get_component(entity_id, c))
	else:
		pass
	
func remove_entity(entity_id: int):
	pass

func get_components(c_class):
	return components[c_class]
