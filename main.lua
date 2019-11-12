N = 8
CenterX = 16;
CenterY = 65;
SizeBox = love.graphics.getWidth() / (N + N / 4);
Rad = SizeBox / 3
DB = {}
a = 0
--sx = 1
--sy = sx
aa = 250
bb = 350
cc = 450
aaa = 50
bbb = 150
ccc = 250
z = 2
b, q = 0, 0


function t(m)
	for i = 0, N - 1 do
		for j = 0, i do
			local tmp = m[(i + 1) * N + (j + 1)];
			m[(i + 1) * N + (j + 1)] = m[(j + 1) * N + (i + 1)];
			m[(j + 1) * N + (i + 1)] = tmp;
		end
	end
	return m
end

function love.load()
	--настройки игры
	local pressedbutton = love.window.showMessageBox('Menu', "Choose game mode\n\n", { "User vs AI", "User vs User", escapebutton = 0 })
	if pressedbutton == 1 then
		EzMode = true
		--[[local pressedbutton = love.window.showMessageBox('Difficulty', "Choose difficulty\n\n", { "Hard", "Normal", "Easy (random)", escapebutton = 0 })
		if pressedbutton == 3 then
			EzMode = true
		elseif pressedbutton == 2 then
			--fool
		elseif pressedbutton == 1 then
			--foil
		elseif pressedbutton == 0 then
			love.load()
		end]]
	elseif pressedbutton == 2 then
		EzMode = false
	elseif pressedbutton == 0 then
		love.event.quit()
	end
	love.graphics.setBackgroundColor(1 / 255 * 51, 1 / 255 * 153, 1 / 255 * 102);
	Step = -1
	Sum_Grab = 0
	Score_White, Score_Black, Score_Zero = 0, 0, 0
--[[	DB = {
		0, 0, 0, 0, 0, 0, 0, 0, --] so i couldn't make an algorithm without this useless line
		0, 0, 0, 0, 0, 0, 0, 0,
		0, 1, 0, 0, -1, 1, 0, 0,
		0, 0, 1, 0, 1, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 1, 0,
		0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 1, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0
	}
	for i = 0, N - 1 do
		for j = 0, N - 1 do
			if DB[(i + 1) * N + (j + 1)] == 1 then
				Score_White = Score_White + 1
			elseif DB[(i + 1) * N + (j + 1)] == -1 then
				Score_Black = Score_Black + 1
			elseif DB[(i + 1) * N + (j + 1)] == 0 then
				Score_Zero = Score_Zero + 1
			end
		end
	end]]

		for i = 0, N - 1 do
			for j = 0, N - 1 do
				if (i >= N / 2 - 1) and (i <= N / 2) and (j >= N / 2 - 1) and (j <= N / 2) then
					if (i == j) then
						DB[(i + 1) * N + (j + 1)] = 1
						Score_White = Score_White + 1
					else
						DB[(i + 1) * N + (j + 1)] = -1
						Score_Black = Score_Black + 1
					end
				else
					DB[(i + 1) * N + (j + 1)] = 0
					Score_Zero = Score_Zero + 1
				end
			end
		end
	DB = t(DB)
end

function love.keypressed(keyCode)
	if (keyCode == "escape") then
		local pressedbutton = love.window.showMessageBox("Exit or Restart", "What do you want?", { "Exit", "Restart", "Nothing" })
		if (pressedbutton == 1) then
			love.event.quit()
		elseif (pressedbutton == 2) then
			love.load()
		end
	end
end

function love.update(dt)
	if EzMode == true and Step == 1 then
		MousePosX, MousePosY = Rnd()
	else
		MousePosX, MousePosY = love.mouse.getPosition();
	end
	--MousePosX, MousePosY = TLfres.getMousePosition(W, H)
	--MousePosX = MousePosX
	--MousePosY = MousePosY
	love.keypressed()
end


function DrowCircle(x, y, col)
	if (col == 1) then
		love.graphics.setColor(1, 1, 1, 1);
	elseif (col == -1) then
		love.graphics.setColor(0, 0, 0, 1);
	end
	love.graphics.circle('fill', CenterX + SizeBox / 2 + (SizeBox * x), CenterY + SizeBox / 2 + (SizeBox * y), Rad);
end

function Rnd()
	local x = CenterX + SizeBox / 2 + (SizeBox * love.math.random(0, N - 1))
	local y = CenterY + SizeBox / 2 + (SizeBox * love.math.random(0, N - 1))
	return x, y
end

function DashBoard(x, y)
	love.graphics.setColor(0, 0, 0, 1);
	love.graphics.setLineWidth(1)
	love.graphics.rectangle("line", CenterX + (SizeBox * x), CenterY + (SizeBox * y), SizeBox, SizeBox);
end

function DrowStepCircle(x, y, z)
	love.graphics.setColor(0, 0, 0, 1); --черный
	love.graphics.circle('fill', CenterX + SizeBox / 2 + (SizeBox * x), CenterY + SizeBox / 2 + (SizeBox * y), Rad / z);
	love.graphics.setColor(1, 1, 1, 1); --белый
	love.graphics.circle('fill', CenterX + SizeBox / 2 + (SizeBox * x), CenterY + SizeBox / 2 + (SizeBox * y), Rad / z / 2);
end

function ScanStep(i, j)
	for ii = i - 1, i + 1 do
		for jj = j - 1, j + 1 do
			if (ii ~= i) or (jj ~= j) then
				if (DB[(ii + 1) * N + (jj + 1)] == -Step) then
					if (ii == i - 1) and (jj == j - 1) then
						UpLeft(i, j)
					end
					if (ii == i) and (jj == j - 1) then
						Up(i, j)
					end
					if (ii == i + 1) and (jj == j - 1) then
						UpRight(i, j)
					end
					if (ii == i - 1) and (jj == j) then
						Left(i, j)
					end
					if (ii == i + 1) and (jj == j) then
						Right(i, j)
					end
					if (ii == i - 1) and (jj == j + 1) then
						DownLeft(i, j)
					end
					if (ii == i) and (jj == j + 1) then
						Down(i, j)
					end
					if (ii == i + 1) and (jj == j + 1) then
						DownRight(i, j)
					end
				end
			end
		end
	end
	t1, t2, t3, t4, t5, t6, t7, t8 = 0, 0, 0, 0, 0, 0, 0, 0
end

function Recount(x1, y1, x2, y2)
	Sum_Grab = 0
	if (x2 < x1) and (y2 == y1) then
		--print('←')
		for i = (x2 + 1), (x1 - 1) do
			DB[(i + 1) * N + (y1 + 1)] = Step
			Sum_Grab = Sum_Grab + 1
		end
	end
	if (x2 > x1) and (y2 == y1) then
		--print('→')
		for i = (x1 + 1), (x2 - 1) do
			DB[(i + 1) * N + (y1 + 1)] = Step
			Sum_Grab = Sum_Grab + 1
		end
	end
	if (x2 == x1) and (y2 < y1) then
		--print('↑')
		for i = (y2 + 1), (y1 - 1) do
			DB[(x1 + 1) * N + (i + 1)] = Step
			Sum_Grab = Sum_Grab + 1
		end
	end
	if (x2 == x1) and (y2 > y1) then
		--print('↓')
		for i = (y1 + 1), (y2 - 1) do
			DB[(x1 + 1) * N + (i + 1)] = Step
			Sum_Grab = Sum_Grab + 1
		end
	end

	if (x2 < x1) and (y2 < y1) then
		--print('↖')
		for i = (y2 + 1), (y1 - 1) do
			for j = (x2 + 1), (x1 - 1) do
				if (j - x1) == (i - y1) then
					DB[(j + 1) * N + (i + 1)] = Step
					Sum_Grab = Sum_Grab + 1
				end
			end
		end
	end

	if (x2 > x1) and (y2 > y1) then
		--print('↘')
		for i = (y1 + 1), (y2 - 1) do
			for j = (x1 + 1), (x2 - 1) do
				if (j - x1) == (i - y1) then
					DB[(j + 1) * N + (i + 1)] = Step
					Sum_Grab = Sum_Grab + 1
				end
			end
		end
	end

	if (x2 > x1) and (y2 < y1) then
		--print('↗');
		for i = (y2 + 1), (y1 - 1) do
			for j = (x1 + 1), (x2 - 1) do
				if (i - x1) == (y1 - j) then
					DB[(j + 1) * N + (i + 1)] = Step
					Sum_Grab = Sum_Grab + 1
				end
			end
		end
	end

	if (x2 < x1) and (y2 > y1) then
		--print('↙');
		for i = (y1 + 1), (y2 - 1) do
			for j = (x2 + 1), (x1 - 1) do
				if (i - x1) == (y1 - j) then
					DB[(j + 1) * N + (i + 1)] = Step
					Sum_Grab = Sum_Grab + 1
				end
			end
		end
	end
	sum = t1 + t2 + t3 + t4 + t5 + t6 + t7 + t8
	ScanStep(x1, y1)
	DB[(x1 + 1) * N + (y1 + 1)] = Step
	a = a + 1
	Score_White = 0
	Score_Black = 0
	Score_Zero = 0
	if a == sum then
		b = 0
		Step = -Step
		a = 0
		for i = 0, N - 1 do
			for j = 0, N - 1 do
				if (DB[(j + 1) * N + (i + 1)] == -1) then
					Score_Black = Score_Black + 1
				elseif (DB[(j + 1) * N + (i + 1)] == 1) then
					Score_White = Score_White + 1
				elseif (DB[(j + 1) * N + (i + 1)] == 0) then
					Score_Zero = Score_Zero + 1
				end
			end
		end
	end
end

function UpLeft(i, j)
	local f = true
	for iii = i - 2, 0, -1 do
		for jjj = j - 2, 0, -1 do
			if (iii - i == jjj - j) and f == true then
				if (DB[(iii + 1) * N + (jjj + 1)] == Step) and (DB[(i + 1) * N + (j + 1)] == 0) then
					Skip = false
					DrowStepCircle(i, j, z)
					t1 = 1
					if (MousePosX > CenterX + (SizeBox * i)) and
							(MousePosX < CenterX + (SizeBox * (i + 1))) and
							(MousePosY > CenterY + (SizeBox * j)) and
							(MousePosY < CenterY + (SizeBox * (j + 1))) then
						if EzMode == true then
							if (love.mouse.isDown(1) and Step == -1) then
								Recount(i, j, iii, jjj)
							elseif Step == 1 then
								Recount(i, j, iii, jjj)
							else
								--love.graphics.print('DownR', ccc, cc, 0, 2);
							end
						else
							if (love.mouse.isDown(1)) then
								Recount(i, j, iii, jjj)
							else
								--love.graphics.print('DownR', ccc, cc, 0, 2);
							end
						end
					end
				elseif (DB[(iii + 1) * N + (jjj + 1)] == 0) then
					f = false
				end
			end
		end
	end
end

function Up(i, j)
	local f = true
	for jjj = j - 2, 0, -1 do
		if (f == true) then
			if (DB[(i + 1) * N + (jjj + 1)] == Step) and (DB[(i + 1) * N + (j + 1)] == 0) then
				DrowStepCircle(i, j, z)
				t2 = 1
				Skip = false
				if (MousePosX > CenterX + (SizeBox * i)) and
						(MousePosX < CenterX + (SizeBox * (i + 1))) and
						(MousePosY > CenterY + (SizeBox * j)) and
						(MousePosY < CenterY + (SizeBox * (j + 1))) then
					if EzMode == true then
						if (love.mouse.isDown(1) and Step == -1) then
							Recount(i, j, i, jjj)
						elseif Step == 1 then
							Recount(i, j, i, jjj)
						else
							--love.graphics.print('DownR', ccc, cc, 0, 2);
						end
					else
						if (love.mouse.isDown(1)) then
							Recount(i, j, i, jjj)
						else
							--love.graphics.print('DownR', ccc, cc, 0, 2);
						end
					end
				end
			elseif (DB[(i + 1) * N + (jjj + 1)] == 0) then
				f = false
			end
		end
	end
end

function UpRight(i, j)
	local f = true
	for iii = i + 2, N - 1 do
		for jjj = j - 2, 0, -1 do
			if (iii - i == j - jjj) and (f == true) then
				if (DB[(iii + 1) * N + (jjj + 1)] == Step) and (DB[(i + 1) * N + (j + 1)] == 0) then
					DrowStepCircle(i, j, z)
					t3 = 1
					Skip = false
					if (MousePosX > CenterX + (SizeBox * i)) and
							(MousePosX < CenterX + (SizeBox * (i + 1))) and
							(MousePosY > CenterY + (SizeBox * j)) and
							(MousePosY < CenterY + (SizeBox * (j + 1))) then
						if EzMode == true then
							if (love.mouse.isDown(1) and Step == -1) then
								Recount(i, j, iii, jjj)
							elseif Step == 1 then
								Recount(i, j, iii, jjj)
							else
								--love.graphics.print('DownR', ccc, cc, 0, 2);
							end
						else
							if (love.mouse.isDown(1)) then
								Recount(i, j, iii, jjj)
							else
								--love.graphics.print('DownR', ccc, cc, 0, 2);
							end
						end
					end
				elseif (DB[(iii + 1) * N + (jjj + 1)] == 0) then
					f = false
				end
			end
		end
	end
end

function Left(i, j)
	local f = true
	for iii = i - 2, 0, -1 do
		if (f == true) then
			if (DB[(iii + 1) * N + (j + 1)] == Step) and (DB[(i + 1) * N + (j + 1)] == 0) then
				DrowStepCircle(i, j, z)
				t4 = 1
				Skip = false
				if (MousePosX > CenterX + (SizeBox * i)) and
						(MousePosX < CenterX + (SizeBox * (i + 1))) and
						(MousePosY > CenterY + (SizeBox * j)) and
						(MousePosY < CenterY + (SizeBox * (j + 1))) then
					if EzMode == true then
						if (love.mouse.isDown(1) and Step == -1) then
							Recount(i, j, iii, j)
						elseif Step == 1 then
							Recount(i, j, iii, j)
						else
							--love.graphics.print('DownR', ccc, cc, 0, 2);
						end
					else
						if (love.mouse.isDown(1)) then
							Recount(i, j, iii, j)
						else
							--love.graphics.print('DownR', ccc, cc, 0, 2);
						end
					end
				end
			elseif (DB[(iii + 1) * N + (j + 1)] == 0) then
				f = false
			end
		end
	end
end

function Right(i, j)
	local f = true
	for iii = i + 2, N - 1 do
		if f == true then
			if (DB[(iii + 1) * N + (j + 1)] == Step) and (DB[(i + 1) * N + (j + 1)] == 0) then
				DrowStepCircle(i, j, z)
				t5 = 1
				Skip = false

				if (MousePosX > CenterX + (SizeBox * i)) and
						(MousePosX < CenterX + (SizeBox * (i + 1))) and
						(MousePosY > CenterY + (SizeBox * j)) and
						(MousePosY < CenterY + (SizeBox * (j + 1))) then
					if EzMode == true then
						if (love.mouse.isDown(1) and Step == -1) then
							Recount(i, j, iii, j)
						elseif Step == 1 then
							Recount(i, j, iii, j)
						else
							--love.graphics.print('DownR', ccc, cc, 0, 2);
						end
					else
						if (love.mouse.isDown(1)) then
							Recount(i, j, iii, j)
						else
							--love.graphics.print('DownR', ccc, cc, 0, 2);
						end
					end
				end
			elseif (DB[(iii + 1) * N + (j + 1)] == 0) then
				f = false
			end
		end
	end
end

function DownLeft(i, j)
	local f = true
	for iii = i - 2, 0, -1 do
		for jjj = j + 2, N - 1 do
			if (iii - i == j - jjj) and (f == true) then
				if (DB[(iii + 1) * N + (jjj + 1)] == Step) and (DB[(i + 1) * N + (j + 1)] == 0) then
					DrowStepCircle(i, j, z)
					t6 = 1
					Skip = false
					if (MousePosX > CenterX + (SizeBox * i)) and
							(MousePosX < CenterX + (SizeBox * (i + 1))) and
							(MousePosY > CenterY + (SizeBox * j)) and
							(MousePosY < CenterY + (SizeBox * (j + 1))) then
						if EzMode == true then
							if (love.mouse.isDown(1) and Step == -1) then
								Recount(i, j, iii, jjj)
							elseif Step == 1 then
								Recount(i, j, iii, jjj)
							else
								--love.graphics.print('DownR', ccc, cc, 0, 2);
							end
						else
							if (love.mouse.isDown(1)) then
								Recount(i, j, iii, jjj)
							else
								--love.graphics.print('DownR', ccc, cc, 0, 2);
							end
						end
					end
				elseif (DB[(iii + 1) * N + (jjj + 1)] == 0) then
					f = false
				end
			end
		end
	end
end

function Down(i, j)
	local f = true
	for jjj = j + 2, N - 1 do
		if (f == true) then
			if (DB[(i + 1) * N + (jjj + 1)] == Step) and (DB[(i + 1) * N + (j + 1)] == 0) then
				DrowStepCircle(i, j, z)
				t7 = 1
				Skip = false

				if (MousePosX > CenterX + (SizeBox * i)) and
						(MousePosX < CenterX + (SizeBox * (i + 1))) and
						(MousePosY > CenterY + (SizeBox * j)) and
						(MousePosY < CenterY + (SizeBox * (j + 1))) then

					if EzMode == true then
						if (love.mouse.isDown(1) and Step == -1) then
							Recount(i, j, i, jjj)
						elseif Step == 1 then
							Recount(i, j, i, jjj)
						else
							--love.graphics.print('DownR', ccc, cc, 0, 2);
						end
					else
						if (love.mouse.isDown(1)) then
							Recount(i, j, i, jjj)
						else
							--love.graphics.print('DownR', ccc, cc, 0, 2);
						end
					end
				end

			elseif (DB[(i + 1) * N + (jjj + 1)] == 0) then
				f = false
			end
		end
	end
end

function DownRight(i, j)
	local f = true
	for iii = i + 2, N - 1 do
		for jjj = j + 2, N - 1 do
			if (iii - i == jjj - j) and f == true then
				if (DB[(iii + 1) * N + (jjj + 1)] == Step) and (DB[(i + 1) * N + (j + 1)] == 0) then
					DrowStepCircle(i, j, z)
					t8 = 1
					Skip = false
					if (MousePosX > CenterX + (SizeBox * i)) and
							(MousePosX < CenterX + (SizeBox * (i + 1))) and
							(MousePosY > CenterY + (SizeBox * j)) and
							(MousePosY < CenterY + (SizeBox * (j + 1))) then
						if EzMode == true then
							if (love.mouse.isDown(1) and Step == -1) then
								Recount(i, j, iii, jjj)
							elseif Step == 1 then
								Recount(i, j, iii, jjj)
							else
								--love.graphics.print('DownR', ccc, cc, 0, 2);
							end
						else
							if (love.mouse.isDown(1)) then
								Recount(i, j, iii, jjj)
							else
								--love.graphics.print('DownR', ccc, cc, 0, 2);
							end
						end
					end
				elseif (DB[(iii + 1) * N + (jjj + 1)] == 0) then
					f = false
				end
			end
		end
	end
end

function love.draw()
	love.graphics.scale(scalex, scaley)

	Skip = true
	--TLfres.beginRendering(W, H)
	--love.graphics.scale(sx, sy)
	--TLfres.getScale(sx,sy)
	for i = 0, N - 1 do
		for j = 0, N - 1 do
			DashBoard(i, j);
			if (DB[(i + 1) * N + (j + 1)] == 1) then
				DrowCircle(i, j, 1)
			elseif (DB[(i + 1) * N + (j + 1)] == -1) then
				DrowCircle(i, j, -1)
			end
			----------------------------------------------------------
			--[[
			if (MousePosX > CenterX + (SizeBox * i)) and
								(MousePosX < CenterX + (SizeBox * (i + 1))) and
								(MousePosY > CenterY + (SizeBox * j)) and
								(MousePosY < CenterY + (SizeBox * (j + 1))) and
								(DB[(i + 1) * N + (j + 1)] == 0) and
								love.mouse.isDown(1) then
							DrowCircle(i, j, Step)
						end
						]]
			ScanStep(i, j)
		end
	end

	love.graphics.setColor(1, 1, 1, 1);
	love.graphics.print("Score: " .. Score_White, CenterX, CenterY - 32, 0, 2);
	love.graphics.setColor(0, 0, 0, 1);
	love.graphics.print(Score_Black, CenterX + 128, CenterY - 32, 0, 2);

	love.graphics.setColor(0, 0, 0, 1);
	if (Step == -1) then
		love.graphics.setColor(0, 0, 0, 1);
		love.graphics.print('Step # ' .. N * N - Score_Zero - 3 .. ': black', CenterX, CenterY - 64, 0, 2);
	else
		love.graphics.setColor(1, 1, 1, 1);
		love.graphics.print('Step # ' .. N * N - Score_Zero - 3 .. ': white', CenterX, CenterY - 64, 0, 2);
	end
	if love.mouse.isDown(2) then
		love.load()
	end
	if Score_Black > Score_White then
		S = 'Black win / You win'
		love.graphics.setColor(0, 0, 0, 1);
	elseif Score_Black < Score_White then
		S = 'White win / You lose'
		love.graphics.setColor(1, 1, 1, 1);
	else
		S = 'Dead heat'
		love.graphics.setColor(0.5, 0.5, 0.5, 1);
	end
	if Skip == true and Score_Zero ~= 0 and b < N then
		--love.graphics.print(b, 50, 300, 0, 3);
		--love.graphics.print(q, 50, 340, 0, 3);
		--love.graphics.print(Sum_Grab, 50, 400, 0, 3);
		if b == Sum_Grab then
			if q ~= 2 then
				if Step == -1 then
					ss = 'Black'
				elseif Step == 1 then
					ss = 'White'
				end
				local pressedbutton = love.window.showMessageBox('Skip step', "Skip " .. ss, { "Ok" })
				if pressedbutton == 1 then
					Step = -Step
					b = 0
				end
			else
				love.graphics.print(S, 50, 400, 0, 2);
				local pressedbutton = love.window.showMessageBox('Game over', "Skip Black and Skip White.\n\n" .. S, { "Exit", "Restart", "Ok" })
				if pressedbutton == 2 then
					love.load()
				elseif pressedbutton == 1 then
					love.event.quit()
				end
			end
			q = q + 1
		end
		b = b + 1
	elseif Skip == false and Score_Zero ~= 0 then
		q = 0
	elseif (Score_Zero == 0 and Score_White > 0 and Score_Black > 0) or (Skip == true and Score_Zero ~= 0 and (Score_White == 0 or Score_Black == 0)) then
		love.graphics.print(S, 50, 400, 0, 2);
		if b == Sum_Grab + 1 then
			local pressedbutton = love.window.showMessageBox('Game over', S, { "Exit", "Restart", "Ok" })
			if pressedbutton == 2 then
				love.load()
			elseif pressedbutton == 1 then
				love.event.quit()
			end
		end
		b = b + 1
	end
	--TLfres.endRendering()
end



print(math.pi)
print(-math.huge)