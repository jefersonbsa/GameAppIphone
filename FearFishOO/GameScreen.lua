require 'scores'

module (..., package.seeall)

display.setStatusBar(display.HiddenStatusBar)


function new()
	
	local localGroup = display.newGroup()
	local ui = require ( "ui" )
    local language =  director:getLanguage()
	countExibe = 0
	local background = display.newImage('fundo.png')
	background.x = display.contentWidth / 2
    background.y = display.contentHeight / 2
    background.xScale = 1.6
    background.yScale = 1.6	
	
	BRICK_W = 38
	BRICK_H = 31
	OFFSET = 13
	TABLE_SIZE = 8
	SCORE_CONST = 100
	score = 0
	bricks = display.newGroup()
	xSpeed = 5 
	ySpeed = -5
	xDir = 1
	yDir = 1
	gameEvent = ''
	currentLevel = 1
	ddGameScreen = {}
	buildLevel = {}
	movePaddle = {}
	gameListeners = {}
	startGame = {}
	update = {}
	bounce = {}
	removeBrick = {}
	alert = {}
	restart = {}
	changeLevel = {}
	
	 
 	facil,medium,dificil = director:getNivel()		
	
	-- Levels
	levels = {}

	levels[1] = {{dificil,dificil,medium,0,0,medium,dificil,dificil},
			 	 {dificil,dificil,medium,0,0,medium,dificil,dificil},
			 	 {0,medium,0,0,0,0,0,0},
			 	 {0,0,0,0,0,0,0,0},
			 	 {0,0,0,facil,dificil,facil,0,0},
			 	 {0,0,0,0,0,0,0,0},
			 	 {0,0,0,facil,0,facil,0,0},
			 	 {dificil,dificil,0,0,0,0,dificil,dificil},
			 	 {dificil,0,0,0,0,0,0,dificil},}

	levels[2] = {{0,0,0,0,0,0,0,0},
				 {0,0,0,0,0,0,0,0},
				 {0,0,0,0,0,0,0,0},
				 {0,0,0,0,0,0,0,0},
				 {0,0,0,0,1,0,0,0},
				 {0,0,0,0,0,0,0,0},
				 {0,0,0,0,0,0,0,0},
				 {0,0,0,0,0,0,0,0},}

	levels[3] = {{0,0,0,0,0,0,0,0},
	 			 {0,0,0,0,0,0,0,0},
			 	 {0,0,0,0,0,0,0,0},
			 	 {0,0,0,0,0,0,0,0},
			 	 {0,0,0,0,1,0,0,0},
			 	 {0,0,0,0,0,0,0,0},
			 	 {0,0,0,0,0,0,0,0},
			 	 {0,0,0,0,0,0,0,0},
			 	 {0,0,0,0,0,0,0,0},}

	levels[4] = {{0,0,0,0,0,0,0,0},
	 			 {0,0,0,0,0,0,0,0},
			 	 {0,0,0,0,0,0,0,0},
			 	 {0,0,0,0,0,0,0,0},
			 	 {0,0,0,0,1,0,0,0},
			 	 {0,0,0,0,0,0,0,0},
			 	 {0,0,0,0,0,0,0,0},
			 	 {0,0,0,0,0,0,0,0},
			 	 {0,0,0,0,0,0,0,0},}
			
	local physics = require("physics")
	physics.start()

	physics.setGravity(0,0)


	function gameListeners(action)
		if(action == 'add') then
			Runtime:addEventListener('accelerometer', movePaddle)
			Runtime:addEventListener('enterFrame', update)
			paddle:addEventListener('collision', bounce)
			ball:addEventListener('collision', removeBrick)
			-- usar touch no simulador
			if (system.getInfo('environment') == 'simulator') then
				paddle:addEventListener('touch', dragPaddle)
			end
			--
		else
			Runtime:removeEventListener('accelerometer', movePaddle)
			Runtime:removeEventListener('enterFrame', update)
			paddle:removeEventListener('collision', bounce)
			ball:removeEventListener('collision', removeBrick)
			-- usar touch no simulador
			if (system.getInfo('environment') == 'simulator') then
				paddle:removeEventListener('touch', dragPaddle)
			end
			--
		end
	end

	-- Used to drag the paddle on the simulator
	function dragPaddle(e)
		if(e.phase == 'began') then
			lastX = e.x - paddle.x
		elseif(e.phase == 'moved') then
			paddle.x = e.x - lastX
		end
	end

	--

	function bounce(e)
		ySpeed = -5

		-- Paddle Collision, check the which side of the paddle the ball hits, left, right 
		if((ball.x + ball.width/2) < paddle.x) then
			xSpeed = -5
		elseif((ball.x + ball.width/2) >= paddle.x) then
			xSpeed = 5
		end
	end

	function removeBrick(e)

		-- Check the which side of the brick the ball hits, left, right  
	          if(e.other.name == 'brick' and (ball.x + ball.width /2) < (e.other.x + e.other.width /2)) then
	              xSpeed = -5
	          elseif(e.other.name == 'brick' and (ball.x + ball.width * 0.5) >= (e.other.x + e.other.width * 0.5)) then
	              xSpeed = 5
	          end
		-- Bounce, Remove
		if(e.other.name == 'brick') then
			ySpeed = ySpeed * -1
			e.other:removeSelf()
			e.other = nil
			bricks.numChildren = bricks.numChildren - 1
			-- Score
			score = score + 1
			scoreNum.text = score * SCORE_CONST
			scoreNum:setReferencePoint(display.CenterLeftReferencePoint)
			scoreNum.x = 54 
		end

		-- Check if all bricks are destroyed
		if(bricks.numChildren < 0) then
			enviaMensagem(director.getPlayer().getPlayerName(),score * SCORE_CONST,time)		
			alert('  Voce Ganhou!', '  Proximo Level ›')
			gameEvent = 'win'
		end
	end

	function update(e)

		-- Ball Movement 
		ball.x = ball.x + xSpeed
		ball.y = ball.y + ySpeed
		countExibe = countExibe + 1
		if (countExibe > 16) then
			time = time + 1
			clockNum.text = time 
		end
		
		if (countExibe >= 17) then
			countExibe = 0
		end

		-- Wall Collision 
		if(ball.x - ball.width/2 < 0) then 
			ball.x = ball.x + 3 
			xSpeed = -xSpeed 
		end--Left
		
		if((ball.x + ball.width/2) > display.contentWidth) then 
			ball.x = ball.x - 3 
			xSpeed = -xSpeed 
		end--Right
		
		if((ball.y - ball.height/2)< 0) then 
			ySpeed = -ySpeed 
		end--Up
		
		if((ball.y + ball.height/2) > paddle.y + paddle.height/2) then 
			--enviaMensagem("Jeferson",score)		
			alert('  Você Perdeu', '  Tente Novamente ›') gameEvent = 'lose'
		end--down/lose
	end



	function movePaddle:accelerometer(e)
		-- Accelerometer Movement
		paddle.x = display.contentCenterX + (display.contentCenterX * (e.xGravity*2))
		-- Borders 
		if((paddle.x - paddle.width * 0.5) < 0) then
			paddle.x = paddle.width * 0.5
		elseif((paddle.x + paddle.width * 0.5) > display.contentWidth) then
			paddle.x = display.contentWidth - paddle.width * 0.5
		end
	end
	
	function alert(t, m)
		gameListeners('remove')

		alertBg = display.newImage('alertBg.png')
		box = display.newImage('alertBox.png', 90, 202)

		transition.from(box, {time = 300, xScale = 0.5, yScale = 0.5, transition = easing.outExpo})

		titleTF = display.newText(t, 0, 0, native.systemFont, 19)
		titleTF:setTextColor(0,0,0)
		titleTF:setReferencePoint(display.CenterReferencePoint)
		titleTF.x = display.contentCenterX
		titleTF.y = display.contentCenterY - 15

		msgTF = display.newText(m, 0, 0, native.systemFont, 12)
		msgTF:setTextColor(0,0,0)
		msgTF:setReferencePoint(display.CenterReferencePoint)
		msgTF.x = display.contentCenterX
		msgTF.y = display.contentCenterY + 15

		box:addEventListener('tap', restart)

		alertScreen = display.newGroup()
		alertScreen:insert(alertBg)
		alertScreen:insert(box)
		alertScreen:insert(titleTF)
		alertScreen:insert(msgTF)
	end
	
	function restart(e)
		if(gameEvent == 'win' and table.maxn(levels) > currentLevel) then
			currentLevel = currentLevel + 1
			changeLevel(levels[currentLevel])--next level
			levelNum.text = tostring(currentLevel)
		elseif(gameEvent == 'win' and table.maxn(levels) <= currentLevel) then
			box:removeEventListener('tap', restart)
			alertScreen:removeSelf()
			alertScreen = nil	
			alert('  Fim do Jogo', '  Parabens! ')
			gameEvent = 'finished'
		elseif(gameEvent == 'lose') then
			changeLevel(levels[currentLevel])--same level
		elseif(gameEvent == 'finished') then
			--addMenuScreen()

			director:changeScene( "MenuScreen", "moveFromLeft" )
			--transition.from(menuScreen, {time = 300, y = -menuScreen.height, transition = easing.outExpo})

			box:removeEventListener('tap', restart)
			alertScreen:removeSelf()
			alertScreen = nil

			currentLevel = 1

			scoreText:removeSelf()
			scoreText = nil
			scoreNum:removeSelf()
			scoreNum = nil
			clockText:removeSelf()
			clockText = nil
			clockNum:removeSelf()
			clockNum = nil
			levelText:removeSelf()
			levelText = nil
			levelNum:removeSelf()
			levelNum = nil
			ball:removeSelf()
			ball = nil
			paddle:removeSelf()
			paddle = nil

			score = 0
		end
	end		

	function changeLevel(level)

		-- Clear Level Bricks 
		bricks:removeSelf()

		bricks.numChildren = 0
		bricks = display.newGroup()

		-- Remove Alert 
		box:removeEventListener('tap', restart)
		alertScreen:removeSelf()
		alertScreen = nil

		-- Reset Ball and Paddle position 
		ball.x = (display.contentWidth / 2 ) - (ball.width / 2 )
		ball.y = (paddle.y - paddle.height/2) - (ball.height * 0.5) 

		paddle.x = display.contentWidth / 2

		-- Redraw Bricks 
		buildLevel(level)

		-- Start
		background:addEventListener('tap', startGame)
	end
	
	function addGameScreen()


		-- Add Game Screen (Inicio do Jogo)
		paddle = display.newImage('paddle.png')
		ball = display.newImage('peixe.png')

		paddle.x = (display.contentWidth / 2 )
		paddle.y = (display.contentHeight - 20 )
		ball.x = (paddle.x ) 
		ball.y =  (paddle.y - paddle.height/2) - ball.height/2

		paddle.name = 'paddle'
		ball.name = 'ball'

		-- Build Level Bricks 
		buildLevel(levels[1])

		-- Text (Texto no top para Score)
		scoreText = display.newText(language.Score..':', 5, 2, native.systemFont, 14)
		scoreText:setTextColor(0, 0, 0)
		scoreNum = display.newText('0', 54, 2, native.systemFont, 14)
		scoreNum:setTextColor(0,0,0)
		

		-- Text (Texto no top para Time)
		time = 0;
		clockText = display.newText('Time:', 120, 2, native.systemFont, 14)
		clockText:setTextColor(0, 0, 0)
		clockNum = display.newText(time, 180, 2, native.systemFont, 14)
		clockNum:setTextColor(0,0,0)

		-- Level (Adiciona o Level da Tela)
		levelText = display.newText(language.Level..':', 260, 2, native.systemFont, 14)
		levelText:setTextColor(0, 0, 0)
		levelNum = display.newText('1', 307, 2, native.systemFont, 14)
		levelNum:setTextColor(0,0,0)

		-- Start Listener 
		background:addEventListener('tap', startGame)
	end
	
	function buildLevel(level)

		-- Level length, height 
		local len = table.maxn(level)
		bricks:toFront()

		for i = 1, len do
			for j = 1, TABLE_SIZE do
				if(level[i][j] == 1) then
					local brick = display.newImage('brick.png')
					brick.name = 'brick'
					brick.x = BRICK_W * j - OFFSET
					brick.y = BRICK_H * i
					physics.addBody(brick, {density = 1, friction = 0, bounce = 0})
					brick.bodyType = 'static'
					bricks.insert(bricks, brick)
				end
			end
		end
	end
	
	function startGame:tap(e)
		background:removeEventListener('tap', startGame)
		gameListeners('add')
		-- Physics
		physics.addBody(paddle, {density = 1, friction = 0, bounce = 0})
		physics.addBody(ball, {density = 1, friction = 0, bounce = 0})
		paddle.bodyType = 'static'
	end
	
	addGameScreen()

	
	localGroup:insert(background)
	
	return localGroup
end