extends Node2D

var world: ECSWorld

var entity

func _ready():
	world = ECSWorld.new()
	world.create()
	world.add_system(MovementSystem.new(world))
	entity = create_test_e()

func _physics_process(delta):
	world.execute(delta)

	$FPS.text = str(Engine.get_frames_per_second())
	$Count.text = str(world.entities.size())

func create_test_e() -> int:
	var entity: int = world.create_entity()
	world.add_component(entity, world.create_component(PositionComponent))

	return entity

func _on_Timer_timeout():
	create_test_e()
#	print(world.get_component(entity, PositionComponent).position)	

class PositionComponent:
	extends ECSComponent
	var position: Vector2 = Vector2()

class MoveComponent:
	extends ECSComponent
	var velocity: Vector2 = Vector2()

class MovementSystem:
	extends ECSSystem
	var family: ECSFamily
	var gath: ECSGatheringComponents

	func _init(world: ECSWorld):
		family = ECSFamily.new(world)
		family.include(PositionComponent)
		gath = world.create_gathering_components(family)

	func execute(delta: float):
		.execute(delta)
		for pc in gath.components[PositionComponent]:
			var pc_c: PositionComponent = pc
			pc_c.position += Vector2(1, 1)
