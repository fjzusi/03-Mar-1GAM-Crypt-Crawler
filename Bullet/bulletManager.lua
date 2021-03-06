require "Bullet/bullet"
require "soundLibrary"

BulletManager = class("BulletManager")

function initializeBulletParticleSystem()
	BULLET_SPARK_IMAGE = love.graphics.newImage("Asset/Particle/BulletSpark.png")
	local p = love.graphics.newParticleSystem(BULLET_SPARK_IMAGE, 10)
	
	p:setEmissionRate(2000)
	p:setLifetime(0.1)
	p:setParticleLife(0.1)
	p:setSpread(math.pi * 2 / 3)
	p:setRotation(0, math.pi * 2)
	p:setSpeed(200, 300)
	p:setSizes(0.2, 0.4)
	p:setColors(
		255, 255, 0, 255,
		255, 255, 0, 0
	)
	p:stop()
	
	BULLET_SPARK_SYSTEM = p
end

function BulletManager:initialize()
	self.bullets = {}
	
	initializeBulletParticleSystem()
end

function BulletManager:reset()
	self.bullets = {}
end

function BulletManager:fireBullet(x, y, direction, hudObj)
	if #self.bullets == 0 then
		SFX_BULLET_FIRE:rewind()
		SFX_BULLET_FIRE:play()
		table.insert(self.bullets, Bullet:new(x, y, math.rad(direction), hudObj))
	end
end

function BulletManager:update(dt, cameraBox)
	for index, bullet in ipairs(self.bullets) do
		bullet:update(dt, cameraBox)
		
		if not bullet.alive then
			table.remove(self.bullets, index)
			bump.remove(bullet.boundedBox)
		end
	end
end

function BulletManager:draw()
	for index, bullet in ipairs(self.bullets) do
		if bullet.alive then
			bullet:draw()
		end
	end
end