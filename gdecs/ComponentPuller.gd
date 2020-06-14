class_name ComponentPuller

var world: ECSWorld

var component_type: ComponentType

func _init(world: ECSWorld, c_class):
	self.world = world
	component_type = world.component_type.get_for(c_class)

func get_component(entity_id: int) -> ECSComponent:
	return world.get_components(entity_id).get_o(component_type.index)
