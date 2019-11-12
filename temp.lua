--
-- Created by IntelliJ IDEA.
-- User: Nikrodis
-- Date: 07.11.2019
-- Time: 0:49
-- To change this template use File | Settings | File Templates.

--AiEz_X = love.math.random(CenterX, CenterX + (SizeBox * N))
--AiEz_Y = love.math.random(CenterY, CenterY + (SizeBox * N))

--[[    if not((MousePosX > CenterX + (SizeBox * 0)) and
			(MousePosX < CenterX + (SizeBox * N)) and
			(MousePosY > CenterY + (SizeBox * 0)) and
			(MousePosY < CenterY + (SizeBox * N))) then
		if love.mouse.isDown(1) then
			love.graphics.setColor(0, 0, 0, 1);
			love.graphics.setLineWidth(64)
			love.graphics.arc("line", "open", MousePosX, MousePosY, Rad, 0, qwe())

			love.graphics.setColor(1, 1, 1, 1);
			love.graphics.setLineWidth(16)
			love.graphics.arc("line", "open", MousePosX, MousePosY, Rad * 2, 0, qwe())
		else
			angle = 0
			dtt = 0
		end


		if angle > 2.1 * math.pi then
			local pressedbutton = love.window.showMessageBox("Exit", "Exit?", { "Yes", "No" })
			if pressedbutton == 1 then
				love.event.quit()
			elseif pressedbutton == 2 then
				angle = 0
				dtt = 0
			end
		end
	else
		angle = 0
		dtt = 0
	end]]

--[[	love.graphics.print(MousePosX, 100, 300, 0, 2);
	love.graphics.print(MousePosY, 200, 300, 0, 2);
	love.graphics.print(CenterX + (SizeBox * N), 100, 400, 0, 2);
	love.graphics.print(CenterY + (SizeBox * N), 200, 400, 0, 2);]]
--[[if (Step == 1) then
	AiEz_X = love.math.random(CenterX, CenterX + (SizeBox * N))
	AiEz_Y = love.math.random(CenterY, CenterY + (SizeBox * N))
	--love.mouse.setPosition( AiEz_X, AiEz_Y )
print(AiEz_X)
	ScanStep(AiEz_X, AiEz_Y)
 end]]


--[[function qwe()
if (angle <= 2.1 * math.pi) then
dtt = dtt + love.timer.step() / 2
angle = angle + dtt * math.pi / 2
end
return (angle)
-- end]]

