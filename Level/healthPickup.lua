HealthPickup = class("HealthPickup")

HEALTH_PICKUP_WIDTH = 32
HEALTH_PICKUP_HEIGHT = 32

HEALTH_PICKUP_HEALTH_VALUE = 15

HEALTH_PICKUP_IMAGES = {}
HEALTH_PICKUP_IMAGES[0] = love.graphics.newImage("Asset/Graphic/Item/HealthPickup1.png")
HEALTH_PICKUP_IMAGES[1] = love.graphics.newImage("Asset/Graphic/Item/HealthPickup2.png")
HEALTH_PICKUP_IMAGES[2] = love.graphics.newImage("Asset/Graphic/Item/HealthPickup3.png")

function HealthPickup:initialize(x, y, imageIndex)
	self.boundedBox = {
		x = x,
		y = y,
		width = HEALTH_PICKUP_WIDTH,
		height = HEALTH_PICKUP_HEIGHT,
		parent = self
	}
	bump.addStatic(self.boundedBox)
	
	self.image = HEALTH_PICKUP_IMAGES[imageIndex]
	self.alive = true
end

function HealthPickup:onCollision(dt, other, dx, dy)
	
end

function HealthPickup:pickup()
	bump.remove(self.boundedBox)
	self.alive = false
end

function HealthPickup:draw()
	if self.alive then
		love.graphics.setColor(255, 255, 255)
		love.graphics.draw(self.image, self.boundedBox.x, self.boundedBox.y)
	end
end