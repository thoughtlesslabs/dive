pico-8 cartridge // http://www.pico-8.com
version 33
__lua__
function _init()
	rope = {}
	rope_segments = 10
	rope_length = 1.5
	mass = 2
	damping = 3
	tightness = 5
	gravity = 0
	rest_length = rope_length/rope_segments
	for i=1,rope_segments do
		x = 10 + rest_length*i
		create_segment(x)
	end
end

function _update60()
	if btnp(0) then
		rope[#rope-1].x += 5
	end
	
	for i=1, #rope-1 do
		r1 = rope[i]
		r2 = rope[i+1]
		dx = r2.x-r1.x
		dy = r2.y-r1.y
		spring_length = sqrt(dx*dx-dy*dy)
		normx = dx/spring_length
		normy = dy/spring_length
		
		velx = r2.vx-r1.vx
		vely = r2.vy-r1.vy
		
		force = -tightness*(spring_length-rest_length)
		force -= damping*((dx*velx+dy*vely)/spring_length)
	
		r1.forcex -= force*normx
		r1.forcey -= force*normy
		r2.forcex += force*normx
		r2.forcey += force*normy

	end
	for i=1,#rope do
		rx = rope[i]
		accx = rx.forcex/rx.mass
		accy = rx.forcey/rx.mass
		
		accy += gravity
		
		velx += accx
		vely += accy
		
		rx.x += velx
		rx.y += vely
		
		rx.forcex = 0
		rx.forcey = 0
	end
end

function _draw()
	cls()
	local rs1,rs2
	for i=1,#rope-1 do
		rs1 = rope[i]
		rs2 = rope[i+1]
		line(rs1.x,rs1.y,rs2.x,rs2.y)
	end
end

function create_segment(x)
	r = {}
	r.mass = mass
	r.x = x
	r.y = 10
	r.vx = 0
	r.vy = 0
	r.forcex =0
	r.forcey =0
	add(rope,r)
end
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
