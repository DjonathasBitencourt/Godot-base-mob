extends KinematicBody2D
var life = 150
var SPEED = 30
var velocity = Vector2()
const gravity = 40
var Diretion = 1
var OppositeDirection = -1
func _ready():
	$Control/TextureProgress.visible = false	

	
	
func _physics_process(delta):
		velocity.y += gravity
		
		if is_on_wall( ) or $RayCast2D.is_colliding() == false:
			Diretion = Diretion * OppositeDirection
			$RayCast2D.position.x *= -1
			$PresenceSensorD/CollisionShape2D.position.x *= -1
		if Diretion == 1:
			$AnimatedSprite.flip_h = false
		elif Diretion == -1:
			$AnimatedSprite.flip_h = true	
			$RayCast2D.position.x *= -1
			$PresenceSensorD/CollisionShape2D.position.x *= -1
		velocity.x = Diretion * SPEED	
		velocity = move_and_slide(velocity , Vector2(0, -1))	
		
		if life <= 0:
			SPEED = 0
			$BodyDano.collision_mask = 0
			$BodyDano.collision_mask = 0
			$AnimatedSprite.visible = false
			$Control/TextureProgress.visible = false
			$Animations.play("dead")
			$ChaosExplosion/Explosion.play()
			$ChaosExplosion/Animation.play("Big")
			yield($ChaosExplosion/Animation, "animation_finished")
			queue_free()
func Movi(delta):
	pass
func Visible(delta):
	pass
func _on_BodyDano_body_entered(body):
	body.dano()

func _on_Body_area_entered(area):
	life-=50
	$Control/TextureProgress.value -= 33
	$Control/TextureProgress.visible = true
	$Animations.play("dano")
	$Body/CollisionShape2D.disabled = true
	yield($Animations, "animation_finished")
	
	$Body/CollisionShape2D.disabled = false
	$Control/TextureProgress.visible = false	



func _on_PresenceSensorD_body_entered(body):
	#SPEED = SPEED*2
	pass

func _on_PresenceSensorD_body_exited(body):
	#SPEED = 30
	pass
