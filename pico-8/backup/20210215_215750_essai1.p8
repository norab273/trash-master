pico-8 cartridge // http://www.pico-8.com
version 29
__lua__
function _init()
		p={x=60,y=90,speed=4}
		bullets={}
		enemies={}
		explosions={}
		create_stars()
		
		
end

function _update60()
	if (btn(➡️)) p.x+=p.speed
	if (btn(⬅️)) p.x-=p.speed
	if (btn(⬆️)) p.y-=p.speed
	if (btn(⬇️)) p.y+=p.speed
	if (btnp(❎)) shoot()
	update_bullets()
	update_stars()
	if #enemies==0 then
	 spawn_enemies()
	end
	update_enemies()
	update_explosions()
end

function _draw()
	cls(0)
	--stars
	for s in all(stars) do
	pset(s.x,s.y,s.col)
end
	--vaisseau
	spr(1,p.x,p.y)
	--enemies
	for e in all(enemies) do
		spr(3,e.x,e.y) 
	end
	--explosions
	draw_explosions()
	--bullets
	for b in all(bullets) do
	 spr(2,b.x,b.y)
	end
	
	
end
-->8
--bullets

function shoot()
	new_bullet={
		x=p.x,
		y=p.y, 
		speed=4
	}
	add(bullets, new_bullet)
	sfx(0)
end

function update_bullets()
	for b in all(bullets) do
		b.y-=b.speed
		if b.y<-8 then
		del(bullets,b)
		end
	end
end
-->8
--stars
function create_stars()
	stars={}
	for i=1,9 do
	 new_star={
	 x=rnd(128),
	 y=rnd(128),
	 col=rnd({13,11}), 
	 speed=0.5+rnd(0.5)
	 }
	 add(stars,new_star)
  end
 for i=1,14 do
	 new_star={
	 x=rnd(128),
	 y=rnd(128),
	 col=rnd({7,2,8,}), 
	 speed=2+rnd(2)
	 }
	 add(stars,new_star)
  end
end

function update_stars()
 for s in all(stars) do
  s.y+=s.speed
  if s.y >128 then
   s.y=0
   s.x=rnd(128)
  end
  	
 end
 	
 end
-->8
--enemies

function spawn_enemies(amount)
 for i=1, amount do
  new_enemy={
   x=rnd(128), 
   y=rnd, 
   life=4
 }
 	
 end
 add(enemies, new_enemy)
 	
 end
 
function update_enemies()
 for e in all(enemies) do
 e.y+=0.3
  if e.y >128 then
   del(enemies,e)
  end
  --collision
  for b in all(bullets) do
   if collision(e,b) then
    
    create_explosion(b.x+4,b.y+2)
    del(bullets,b)
    e.life-=1
     if e.life==0 then
     del(enemies,e)
     end
   end
  end
 end
 	
 end
-->8
--collision
function collision(a,b)
 if a.x>b.x+8 
 or a.y>b.y+8
 or a.x+8<b.x
 or a.y+8<b.y then
  return false
 else
  return true
 end
end
-->8
--explosions

function create_explosion(_x,_y)
 add(explosions,{x=_x,
 																y=_y,
 																timer=0})
 sfx(1)
 	
 end
 
function update_explosions()
 for e in all(explosions) do
 e.timer+=1
  if e.timer==13 then
  del (explosions,e)
	 end
	end
end

function draw_explosions()
 circ(x,y,rayon,couleur)
 
	for e in all(explosions) do
	 circ(e.x,e.y,e.timer/3,
	      8+e.timer%3)
	      	
 end
end
__gfx__
0000000000a00a000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000d00d000090900000800800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
007007000d0770d000a0000090700709000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000770000c2222c000a0900009800890000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000cc2772cc0090a00088800888000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
007007000d0770d00090900088000088000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000dddddd00000a00008000080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000009dd90000a0000009888890000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
000100000000032050300502c050260502004019030110200e0100d0100c0100b0200a0200a010090100905009050090500605000000000000000000000000000000000000000000000000000000000000000000
0001000024650206500c6501d6500b6501764013640116400664007640086400b6400c6400e640116401164000000000000000000000000000000000000000000000000000000000000000000000000000000000
