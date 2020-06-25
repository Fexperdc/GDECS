class_name ECSGathering

var world
var family: ECSFamily
var entities: Array = []

var components: Dictionary = {}

func _init(world, family: ECSFamily):
	self.world = world
	self.family = family
	
	for c in family._dict["include"]:
		components[c] = []

func check_entity(entity: ECSEntity):
	if family.matches(entity) && !entities.has(entity):
		entities.append(entity)
		for c in components:
			components[c].append(world.get_component(entity, c))
		
	if !family.matches(entity):
		remove_entity(entity)
		print("NO")

func remove_entity(entity: ECSEntity):
	entities.erase(entity)
	print("lolololol")
	for a in components.values():
		for c in a:
			if c.entity == entity:
				components.values().erase(c)
