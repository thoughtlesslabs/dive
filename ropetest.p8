pico-8 cartridge // http://www.pico-8.com
version 32
__lua__
function _init()
	rope = {}
	start = {}
	ending = {}
	rope_length = 30
	create_rope()
end

function create_rope()
	for i=1,rope_length do
		if i == 1 then 
			startpoint = true
		elseif i == rope_length then
			endpoint = true
		else
			startpoint = false
			endpoint = false
		end
		addsegment(10+i,10,startpoint,endpoint,i)
	end
end

function _update60()
	if #rope < rope_length-1 then
		addsegment(ending[1].x,ending[1].y,false,false,ending[1].pos)
	end
	if #rope > rope_length-1 then
		del(rope,rope[#rope])
	end
	
	if btn(1) then
		ending[1].x += 1
		rope_length +=1
	end
	if btn(0) then
		ending[1].x -= 1
		rope_length -=1
	end
	
	for i=1,#rope do
		r = rope[i]
		r.dy = r.dy+0.2
		
		if r.pos - 1 == start[1].pos 
		or r.pos + 1 == ending[1].pos then
			r.dy = 0
		else
			r.dy /=5
		end
		r.y += r.dy
	end

	
end

function addsegment(x,y,sp,ep,pos)
	p ={}
	p.x = x
	p.y = y
	p.dx = 0
	p.dy = 0
	p.sp = sp
	p.ep = ep
	p.pos = pos
	if p.sp then
		add(start,p)
	elseif p.ep then
		add(ending,p)
	else
		add(rope,p)
	end
end

function _draw()
	cls()
	for i=1,#rope do
		pset(rope[i].x,rope[i].y,2)
	end
	pset(start[1].x,start[1].y,3)
	pset(ending[1].x,ending[1].y,3)
	print(#rope)
	print(rope_length)
end
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
