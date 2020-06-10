class_name ECSFamily

var _world

var _dict: Dictionary = {
	"include": []
}

func _init(world):
	self._world = world

func include(c_class):
	_dict["include"].append(c_class)

func matches(entity_id: int) -> bool:
	var result: bool = _world.has_components(entity_id, _dict["include"])
	return result
