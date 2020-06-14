class_name ECSFamily

const INCLUDE: String = "include"
const EXCLUDE: String = "exclude"
const ONE_OF: String = "oneof"

var _world

var _dict: Dictionary = {
	"include": [],
	"exclude": [],
	"oneof": []
}

func _init(world):
	self._world = world

func include(c_class) -> ECSFamily:
	_dict[INCLUDE].append(c_class)
	
	return self
	
func exclude(c_class) -> ECSFamily:
	_dict[EXCLUDE].append(c_class)
	return self

func matches(entity: ECSEntity) -> bool:
	if _world.has_components(entity, _dict[INCLUDE]) || _dict[INCLUDE].size() == 0:
		if !_world.has_components(entity, _dict[EXCLUDE]) || _dict[EXCLUDE].size() == 0:
			if _world.has_one_component_of(entity, _dict[ONE_OF]) || _dict[ONE_OF].size() == 0:
				return true
				
	return false

