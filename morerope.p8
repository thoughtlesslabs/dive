pico-8 cartridge // http://www.pico-8.com
version 33
__lua__
function _init()
	rope={}
	col = 0
	gravity = 0.8
	seg_lng = 2
	for i=1,10 do
		x1 = 50
		y1 = i*seg_lng
		col += 1
		add_spring(x1,y1,col)
	end
end

function _update()
	local r
	for i=1,#rope-1 do
		i2 = i+1
		r = rope[i]
		r2 = rope[i2]
		if btnp(0) then
			rope[#rope-2].epx += 5
		end
		
		lng_x = r2.epx-r.epx
		lng_y = r2.epy-r.epy
		segment_lng = sqrt(lng_x*lng_x+lng_y*lng_y)
		
		norm_lng_x = lng_x/segment_lng
		norm_lng_y = lng_y/segment_lng
		
		velx = r2.epvelx-r.epvelx
		vely = r2.epvely-r.epvely
		
		force = -r.tight*(segment_lng-seg_lng)-r.damp*((lng_x*velx+lng_y*vely)/segment_lng)
		
		r.ep_force_x -= force*norm_lng_x
		r.ep_force_y -= force*norm_lng_y
		
		r2.ep_force_x += force*norm_lng_x
		r2.ep_force_y += force*norm_lng_y
	end
		
	for i=2, #rope do
		r = rope[i]
		
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

function _draw()
	cls()
	for i=1,#rope-1 do
		i2 = i+1
		r = rope[i]
		r2 = rope[i2]
		line(r.epx,r.epy,r2.epx,r2.epy,r.col)
	end
	print(#rope)
end

function add_spring(x,y,col)
	sp = {}	
	sp.col = col
	sp.epx = x
	sp.epy = y
	sp.epmass = 6
	sp.epvelx = 0
	sp.epvely = 0
	sp.epaccx = 0
	sp.epaccy = 0
	sp.ep_force_x = 0
	sp.ep_force_y = 0
	sp.tight = 2
	sp.damp = 2
	add(rope,sp)
end
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
