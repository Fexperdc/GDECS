class_name Main
extends Node2D

var world: ECSWorld

var entity

var texture = preload("res://icon.png")

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
	world.add_component(entity, world.create_component(SpriteComponent))
	var sprite: Sprite = world.get_component(entity, SpriteComponent).sprite
	sprite.texture = texture
	add_child(sprite)

	return entity

func _on_Timer_timeout():
	create_test_e()
#	print(world.get_component(entity, PositionComponent).position)

class SpriteComponent:
	extends ECSComponent
	
	var sprite: Sprite = Sprite.new()

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
	var world: ECSWorld
	
	func _init(world: ECSWorld):
		self.world = world
		family = ECSFamily.new(world)
		family.include(SpriteComponent)
		gath = world.create_gathering_components(family)
	
	func execute(delta: float):
		.execute(delta)
		print(gath.components[SpriteComponent].size())
		
		for pc in gath.components[SpriteComponent]:
			var pc_c: SpriteComponent = pc
			pc_c.sprite.global_position += Vector2(1, 1)
			
	
