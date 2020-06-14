class_name ECSGathering

var world
var family: ECSFamily
var entities: Array = []

func _init(world, family: ECSFamily):
	self.world = world
	self.family = family

func check_entity(entity_id: int):
	if family.matches(entity_id) && !entities.has(entity_id):
		entities.append(entity_id)
	else:
		remove_entity(entity_id)

func remove_entity(entity_id: int):
	entities.erase(entity_id)
