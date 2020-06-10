extends Node2D

func _ready():
	var world: ECSWorld = ECSWorld.new()
	var entity: int = world.create_entity()
#	world.add_component(entity, world.create_component(TestComponent))
	world.add_component(entity, world.create_component(TestComponent2))
	
	var family: ECSFamily = ECSFamily.new(world)
	family.include(TestComponent)
	family.include(TestComponent2)
	
	print(world.get_components(entity))
	print(family.matches(entity))

class TestComponent:
	extends ECSComponent

class TestComponent2:
	extends ECSComponent
