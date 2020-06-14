class_name Main
extends Node2D

var world: ECSWorld = ECSWorld.new()

var texture = preload("res://icon.png")


func _ready():
	world.create()
	world.add_system(MovementSystem.new(world))
#	for i in range(5):
#		var entity: int = world.create_entity()
#		var sprite: Sprite = Sprite.new()
#		sprite.texture = texture
#		add_child(sprite)
#
#		var sc: SpriteComponent = world.create_component(SpriteComponent)
#		sc.sprite = sprite
#		world.add_component(entity, sc)
		
#	var bag: Bag = Bag.new(1)
#	print(bag._arr)
#	bag.set_o(4, null)
#	print(bag._arr)
#	bag.add_o(null)
#	print(bag._arr)
	

func _physics_process(delta):
	world.execute(delta)

	$FPS.text = str(Engine.get_frames_per_second())
	$Count.text = str(world.entities.size())

var count: int = 0

func _on_Timer_timeout():
	var entity: ECSEntity = world.create_entity()
	var sprite: Sprite = Sprite.new()
	sprite.texture = texture
	add_child(sprite)
	
	var sc: SpriteComponent = world.create_component(SpriteComponent)
	sc.sprite = sprite
	world.add_component(entity, sc)

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
	
	var gath: ECSGathering
	var sc_p: ComponentPuller
	
	func _init(world: ECSWorld):
		gath = world.create_gathering(ECSFamily.new(world).include(SpriteComponent))
		sc_p = ComponentPuller.new(world, SpriteComponent)
	
	func execute(delta):
		.execute(delta)
		for e in gath.entities:
			sc_p.get_component(e).sprite.position += Vector2(1, 1)
