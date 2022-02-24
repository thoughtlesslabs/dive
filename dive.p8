pico-8 cartridge // http://www.pico-8.com
version 33
__lua__
-- deep sea diver
-- a thoughtless labs experiment

function _init()
	rope={}
	move = true
	make_player()
	friction = 1.01
	debug = ""
	col = 9
	gravity = 0.01
	seg_lng = 1
	tight = 200
	damp =400
	for i=1,p.rsegments do
		x1 = 10
		y1 = i*seg_lng
--		col += 1
		add_hose_segment(x1,y1,col)
	end
end

function _update60()
	if move then
	move_player()
	end
	adjust_hose()
end

function _draw()
	cls()
	spr(1,p.x,p.y)
	for i=1,#rope-1 do
		i2 = i+1
		r = rope[i]
		r2 = rope[i2]
		line(r.epx,r.epy,r2.epx,r2.epy,r.col)
	end
end

function make_player()
	p = {}
	p.x = 10
	p.y = 20
	p.dx = 0
	p.dy = 0
	p.mass = 100
	p.rsegments = 20
end
-->8
-- updatefunctions

function move_player()
	if btn(0) then	p.dx = -0.5 end
	if btn(1) then	p.dx = 0.5 end
	if btn(2) then	p.dy = -5 end
	if btn(3) then	p.dy = 5	end
	
	p.dy = p.dy+gravity
	p.dx = p.dx/friction

	p.x += p.dx
	p.y += p.dy
	
--	p.x = mid(5,p.x,100)
 p.y = mid(5,p.y,100)
	debug = p.dx
end


function adjust_hose()
	rope[#rope].epx = p.x
	rope[#rope].epy = p.y
	for i=1,#rope-1 do
		i2 = i+1
		r = rope[i]
		r2 = rope[i2]	
		lng_x = r2.epx-r.epx
		lng_y = r2.epy-r.epy
		
		segment_lng = sqrt(lng_x*lng_x+lng_y*lng_y)
		
		norm_lng_x = lng_x/segment_lng
		norm_lng_y = lng_y/segment_lng
		
		velx = r2.epvelx-r.epvelx
		vely = r2.epvely-r.epvely
		
		force = -tight*(segment_lng-seg_lng)-damp*((lng_x*velx+lng_y*vely)/segment_lng)
		
		r.ep_force_x -= force*norm_lng_x
		r.ep_force_y -= force*norm_lng_y
		
		r2.ep_force_x += force*norm_lng_x
		r2.ep_force_y += force*norm_lng_y
	end
	
	for i=2, #rope-1 do
		i2 = i+1
		r = rope[i]
		r2 = rope[i2]
		
		r.epaccx = r.ep_force_x/r.epmass
		r.epaccy = r.ep_force_y/r.epmass
		
		r.epaccy += gravity
		
		r.epvelx += r.epaccx
		r.epvely += r.epaccy
		
 	r.epx += r.epvelx
		r.epy += r.epvely

		r.ep_force_x = 0
		r.ep_force_y = 0
	end
end

function add_hose_segment(x,y)
	sp = {}	
	sp.col = col
	sp.epx = x
	sp.epy = y
	sp.epmass = 1000
	sp.epvelx = 0
	sp.epvely = 0
	sp.epaccx = 0
	sp.epaccy = 0
	sp.ep_force_x = 0
	sp.ep_force_y = 0
	add(rope,sp)
end

function check_collision(epx,epy,epvx,epvy)
	nextepy = epy + epvy
	nextepx = epx + epvx
		
	if pget(epx,nextepy)==8 then
		return false
	end
	if pget(nextepx,epy)==8 then
		return false
	end
	return true
end
__gfx__
00000000200660000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000209696000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700229696000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000022660000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000440000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700009499400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000440000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000004004000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
