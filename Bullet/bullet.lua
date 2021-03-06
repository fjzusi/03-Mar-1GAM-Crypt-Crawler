Bullet = class("Bullet")

BULLET_WIDTH = 16
BULLET_HEIGHT = 16

BULLET_SPEED = 400
BULLET_ROTATION_SPEED = 10
BULLET_IMAGE = love.graphics.newImage("Asset/Graphic/Bullet.png")

function Bullet:initialize(x, y, direction, hudObj)
	self.boundedBox = {
		x = x - BULLET_WIDTH / 2,
		y = y - BULLET_HEIGHT / 2,
		width = BULLET_WIDTH,
		height = BULLET_HEIGHT,
		parent = self
	}
	
	bump.add(self.boundedBox)
	self.alive = true
	
	self.direction = direction
	self.velocity = {
		x = math.cos(direction) * BULLET_SPEED,
		y = math.sin(direction) * BULLET_SPEED
	}
	self.rotation = 0
	
	self.hudObj = hudObj
end

function Bullet:onCollision(dt, other, dx, dy)
	if self.alive then
		local impact = false
		
		if instanceOf(Wall, other) then
			self.alive = false
			impact = true
		elseif instanceOf(Enemy, other) or instanceOf(EnemySpawner, other) then
			self.alive = false
			impact = true
		elseif instanceOf(HealthPickup, other) then
			self.alive = false
			other:pickup()
			impact = true
		end
		
		if impact then
			local px = self.boundedBox.x + BULLET_WIDTH / 2
			local py = self.boundedBox.y + BULLET_HEIGHT / 2
			
			px = px + math.cos(self.direction) * BULLET_WIDTH / 2
			py = py + math.sin(self.direction) * BULLET_HEIGHT / 2
			
			BULLET_SPARK_SYSTEM:setDirection(self.direction - math.pi)
			BULLET_SPARK_SYSTEM:setPosition(px, py)
			BULLET_SPARK_SYSTEM:start()
		end
	end
end

function Bullet:hitEnemyIncreaseScore()
	self.hudObj.curScore = self.hudObj.curScore + 10
end

function Bullet:update(dt, cameraBox)
	if self.alive then
		self.boundedBox.x = self.boundedBox.x + self.velocity.x * dt
		self.boundedBox.y = self.boundedBox.y + self.velocity.y * dt
		
		if not bump.doesCollide(self.boundedBox, cameraBox) then
			self.alive = false
		end
		
		self.rotation = self.rotation + BULLET_ROTATION_SPEED * dt
		if self.rotation > 360 then
			self.rotation = self.rotation - 360
		end
	end
end

function Bullet:draw()
	love.graphics.setColor(255, 255, 255)
	
	local rotation = math.rad(self.rotation)
	love.graphics.draw(
		BULLET_IMAGE,
		self.boundedBox.x + BULLET_WIDTH / 2,
		self.boundedBox.y + BULLET_HEIGHT / 2,
		self.rotation,
		1,
		1,
		BULLET_WIDTH / 2,
		BULLET_HEIGHT / 2
	)
end