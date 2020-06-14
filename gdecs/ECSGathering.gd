class_name ECSGathering

var world
var family: ECSFamily
var entities: Array = []

func _init(world, family: ECSFamily):
	self.world = world
	self.family = family

func check_entity(entity: ECSEntity):
	if family.matches(entity) && !entities.has(entity):
		entities.append(entity)
	else:
		remove_entity(entity)

func remove_entity(entity: ECSEntity):
	entities.erase(entity)
