Key = class("Key")

KEY_WIDTH = 32
KEY_HEIGHT = 13
KEY_VERTICAL_OFFSET = 8

KEY_IMAGE = love.graphics.newImage("Asset/Graphic/Item/Key.png")

function Key:initialize(x, y)
	self.boundedBox = {
		x = x,
		y = y + KEY_VERTICAL_OFFSET,
		width = KEY_WIDTH,
		height = KEY_HEIGHT,
		parent = self
	}
	
	bump.addStatic(self.boundedBox)
	
	self.alive = true
end

function Key:onCollision(dt, other, dx, dy)
	
end

function Key:pickup()
	bump.remove(self.boundedBox)
	self.alive = false
end

function Key:draw()
	if self.alive then
		love.graphics.setColor(255, 255, 255)
		love.graphics.draw(KEY_IMAGE, self.boundedBox.x, self.boundedBox.y)
	end
end