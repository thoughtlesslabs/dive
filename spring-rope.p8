pico-8 cartridge // http://www.pico-8.com
version 33
__lua__
-- dive rope and spring test
-- a thoughtlesslabs experiment

function _init()
	full_rope={}
	for i=1, 10 do
		rope_ep1 = 5*i
		add_rope_segment(rope_ep1)
	end
end

function _update60()
	if btnp(0) then
			full_rope[1].ep2 += 10
	end
	
	for i=1,#full_rope do
		rs = full_rope[i]
		
		spring_length = rs.ep2 - rs.ep1
		force = -rs.tightness*(spring_length-rs.spring_rest) - rs.dampen*(rs.velocity2-rs.velocity1)
		
		rs.accel1 = -force / rs.ep1_mass
		rs.accel2 = force / rs.ep2_mass
		
		rs.velocity1 += rs.accel1
		rs.velocity2 += rs.accel2
		
		rs.ep1 += rs.velocity1
		rs.ep2 += rs.velocity2
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
	rope.spring_rest = 5
	rope.tightness = 2
	rope.ep1_mass = 10
	rope.ep2_mass = 10
	rope.velocity1 = 0
	rope.velocity2 = 0
	rope.ep1 = x
	rope.ep2 = rope.ep1 + rope.spring_rest
	add(full_rope,rope)
end
