pico-8 cartridge // http://www.pico-8.com
version 33
__lua__
-- dive rope and spring test
-- a thoughtlesslabs experiment

function _init()
	full_rope={}
	spring_rest = 5
	for i=1, 10 do
		rope_ep1 = spring_rest*i
		add_rope_segment(rope_ep1)
	end
end

function _update60()
	if btnp(0) then
		for i=1,#full_rope do
			full_rope[#full_rope].ep2 += 1
	end
	end
	
	for i=1,#full_rope do
		rs = full_rope[i]
		
		spring_length = rs.ep2 - rs.ep1
		velx = rs.velocity2-rs.velocity1
		
		force = -rs.tightness*(spring_length-spring_rest) - rs.dampen*(rs.velocity2-rs.velocity1)
		
		accel = force / rs.ep2_mass
		
		accel += 1.5
		
		velx += accel
			
		rs.ep2 += velx

	end
end

function _draw()
	cls()
	for i=1,#full_rope do
		rs = full_rope[i]
		line(40,rs.ep1,40,rs.ep2)
	end
end

function add_rope_segment(x)
	rope = {}
	rope.dampen = 2
	rope.tightness = 0.5
	rope.ep1_mass = 100
	rope.ep2_mass = 5
	rope.velocity1 = 0
	rope.velocity2 = 0
	rope.ep1 = x
	rope.ep2 = rope.ep1 + spring_rest
	add(full_rope,rope)
end
