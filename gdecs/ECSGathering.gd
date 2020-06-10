class_name ECSGathering

var _family: ECSFamily

func _init(family: ECSFamily):
	self._family = family

func check_entity(entity_id: int):
	if _family.matches(entity_id):
		pass

func remove_entity(entity_id: int):
	pass
