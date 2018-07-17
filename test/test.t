%Made by receneps. Yay.
%Some code taken from spacegame example (but i made it easier to understand :D)
%Use up, left and right to move. Esc to quit.

%All variable names are self explanatory :)
const maxframerate : int := 30
const numships :int := 36
var keys : array char of boolean
const up : char := chr (200)
const left : char := chr (203)
const right : char := chr (205)
const esc:char:=chr(27)
const shiprad : int := 19
const shipfrad : int := 23
var ship : array 0 .. 35 of int
var shipf : array 0 .. 35 of int
var angle : int
var x, y, dx, dy : real


procedure drawscreen
    cls
%draw the ship with the appropriate angle.
    Pic.Draw (ship (angle),
	round (x) - shiprad,
	round (y) - shiprad, picMerge)

    View.Update
end drawscreen

setscreen ("graphics:nooffscreenonly")
ship (0) := Pic.FileNew ("crappycar.bmp")
Pic.SetTransparentColour (ship (0), black)
for i : 1 .. numships-1%make all frames of the ship.(-1 because the 0 is already set.)
    ship (i) := Pic.Rotate (ship (0), i * (360 div numships), shiprad, shiprad)
end for
angle := 0
x := maxx div 2
y := maxy div 2
dx := 0
dy := 0
colourback (black)
loop%get key info
    Input.KeyDown (keys)
    if keys (up) then
	dx -= sind (angle * 10)%dont ask me, only gr 9 math (gr 10 next sem!)
	dy += cosd (angle * 10)%got from spacegame exmaple :D lol
    end if
    if keys (right) then%rotate if right
	angle := (angle - 1) mod numships
	delay(25)
    end if
    if keys (left) then%rotate if left
	angle := (angle + 1) mod numships
	delay(25)
    end if
    if keys (esc) then%exit when hit esc
    exit
    end if
    dx := min (max (dx, -20), 20)%Set "speed limit"
    dy := min (max (dy, -20), 20)
    x += dx
    y += dy
    if x > maxx then
	x:=maxx%keep car in bounds for x
    end if
    if x < 0 then
	x:=0
end if
    if y > maxy then
	y:=maxy %keep car in bounds for y
	end if
    if y < 0 then
	y:=0 
	end if
    drawscreen
    dx:=0
    dy:=0
end loop
