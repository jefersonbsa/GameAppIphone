module (..., package.seeall)


function new()
	local localGroup = display.newGroup()
	local ui = require ( "ui" )
    local mensagens = 0;
    local players = {}
	
	local language =  director:getLanguage()
	
	local background = display.newImage('fundo3.png')
	background.x = display.contentWidth / 2
    background.y = display.contentHeight / 2
    background.xScale = 1.6
    background.yScale = 1.6	

	local voltar = function ( event )
		if event.phase == "release" then
			director:changeScene( "MenuScreen", "moveFromRight" )
		end
	end

	local gameStart = function ( event )
		if event.phase == "release" then
			director:changeScene( "GameScreen", "fade" )
		end
	end
	
	local labelScreenRoundedRect = display.newRoundedRect( display.contentWidth/3, 50, 180, 40, 8 )
	labelScreenRoundedRect:setFillColor( 0, 0, 0, 170 )

	local labelScreen = display.newText(language.MultiPlayerOnline..':',display.contentWidth/3 - 30,55,'AmericanTypewriter-Bold',18)
	
	local buttonStart = ui.newButton{
		default = "buttonBlueSmall.png",
		over = "buttonBlueSmallOver.png",
		onEvent = gameStart,
		id = "buttonStart",
		text = language.buttonStart,
		size = 12,
		emboss=true
	}
	buttonStart.x = 165; buttonStart.y = 450
	
	local buttonVoltar = ui.newButton{
		default = "buttonArrow.png",
		over = "buttonArrowOver.png",
		onEvent = voltar,
		id = "arrow"
	}
	buttonVoltar.x = 20; buttonVoltar.y = 450	

	localGroup:insert(background)
	localGroup:insert(labelScreenRoundedRect)
	localGroup:insert(labelScreen)
	localGroup:insert(buttonStart)	
	localGroup:insert(buttonVoltar)	
	
	
	--local clock = os.clock
	--function sleep(n)  -- seconds
	--  local t0 = clock()
	--  while clock() - t0 <= n do end
	--end
	--sleep(2)
	
	if (#director:getPlayersOnline() == 0) then
		local labelPlayerScreenRoundedRect = display.newRoundedRect( 50, 100 , 250,30,8 )
		labelPlayerScreenRoundedRect:setFillColor( 0, 0, 0, 170 )
		local labelPlayerName = display.newText(language.InfoPlayerOnline,60,100,'AmericanTypewriter-Bold',18)		
		
		labelPlayerName:setTextColor( 100, 255, 255 )
		localGroup:insert(labelPlayerScreenRoundedRect)	
		localGroup:insert(labelPlayerName)
	else
		for indice,jogador in ipairs(director:getPlayersOnline()) do
			local labelPlayerScreenRoundedRect = display.newRoundedRect( 30, 100 + indice * 45, 270,30,8 )
			labelPlayerScreenRoundedRect:setFillColor( 0, 0, 0, 170 )
			local labelPlayerName = display.newText('Jogador : ' .. jogador.getPlayerName(),50,
			100 + indice * 45,'AmericanTypewriter-Bold',15)		
			localGroup:insert(labelPlayerScreenRoundedRect)
			localGroup:insert(labelPlayerName)
		end

	end
	
--[[	for indice1,jogador1 in ipairs(director:getRanking()) do
		local labelPlayerScreenRoundedRect1 = display.newRoundedRect( 30, 100 + indice1 * 60, 270,30,8 )
		labelPlayerScreenRoundedRect1:setFillColor( 0, 0, 0, 170 )
		local labelPlayerName1 = display.newText('Jogador : ' .. jogador1.getPlayerName(),50,
		100 + indice1 * 60,'AmericanTypewriter-Bold',15)		
		localGroup:insert(labelPlayerScreenRoundedRect1)
		localGroup:insert(labelPlayerName1)
	end]]

				
		
	return localGroup
end