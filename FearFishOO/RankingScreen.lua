module (..., package.seeall)

function new()
	local localGroup = display.newGroup()
	local language =  director:getLanguage()
	local ui = require ( "ui" )

	local voltar = function ( event )
		if event.phase == "release" then
			director:changeScene( "MenuScreen", "moveFromLeft" )
		end
	end
	
	local zerar = function ( event )
		if event.phase == "release" then
			director:zerarRanking()
			director:changeScene( "RankingScreen", "fade" )
		end
	end	
	
	local background = display.newImage('fundo3.png')
	background.x = display.contentWidth / 2
    background.y = display.contentHeight / 2
    background.xScale = 1.6
    background.yScale = 1.6	

	local labelLanguageScreenRoundedRect = display.newRoundedRect( 10, 50, 130, 40, 8 )
	labelLanguageScreenRoundedRect:setFillColor( 0, 0, 0, 170 )
	local labelPlayerScreen = display.newText(language.RankingName,15,55,'AmericanTypewriter-Bold',18)

	local labelLanguageScreenRoundedRect2 = display.newRoundedRect( 145, 50, 80, 40, 8 )
	labelLanguageScreenRoundedRect2:setFillColor( 0, 0, 0, 170 )
	local labelPlayerScreen2 = display.newText(language.RankingScore,155,55,'AmericanTypewriter-Bold',18)	
	
	local labelLanguageScreenRoundedRect3 = display.newRoundedRect( 230, 50, 75, 40, 8 )
	labelLanguageScreenRoundedRect3:setFillColor( 0, 0, 0, 170 )
	local labelPlayerScreen3 = display.newText(language.RankingTime,235,55,'AmericanTypewriter-Bold',18)	
	
	local buttonZerar= ui.newButton{
		default = "buttonBlueSmall.png",
		over = "buttonBlueSmallOver.png",
		text = language.buttonReset,
		onEvent = zerar,
		size = 13,
		id = "arrow"
	}
	buttonZerar.x = 250; buttonZerar.y = 450

	
	local buttonVoltar = ui.newButton{
		default = "buttonArrow.png",
		over = "buttonArrowOver.png",
		onEvent = voltar,
		id = "arrow"
	}
	buttonVoltar.x = 20; buttonVoltar.y = 450
	
	localGroup:insert(background)
	localGroup:insert(labelLanguageScreenRoundedRect)
	localGroup:insert(labelPlayerScreen)

	
	localGroup:insert(labelLanguageScreenRoundedRect2)
	localGroup:insert(labelPlayerScreen2)
	
	localGroup:insert(labelLanguageScreenRoundedRect3)
	localGroup:insert(labelPlayerScreen3)

	localGroup:insert(buttonVoltar)
	localGroup:insert(buttonZerar)
	
	
	for indice1,jogador1 in ipairs(director:getRanking()) do
			local labelPlayerScreenRoundedRect1 = display.newRoundedRect( 10, 100 + indice1 * 32, 130,25,8 )
			labelPlayerScreenRoundedRect1:setFillColor( 0, 0, 0, 170 )
			
			local labelPlayerName1 = display.newText(jogador1.getPlayerName(),20,
			100 + indice1 * 33,'AmericanTypewriter-Bold',15)
			
			localGroup:insert(labelPlayerScreenRoundedRect1)
			localGroup:insert(labelPlayerName1)
			
			local labelPlayerScreenRoundedRect1 = display.newRoundedRect( 145, 100 + indice1 * 32, 80,25,8 )
			labelPlayerScreenRoundedRect1:setFillColor( 0, 0, 0, 170 )
			
			local labelPlayerName1 = display.newText(jogador1.getPlayerPontos(),165,
			100 + indice1 * 33,'AmericanTypewriter-Bold',15)
			
			localGroup:insert(labelPlayerScreenRoundedRect1)
			localGroup:insert(labelPlayerName1)
					
			local labelPlayerScreenRoundedRect1 = display.newRoundedRect( 230, 100 + indice1 * 32, 75,25,8 )
			labelPlayerScreenRoundedRect1:setFillColor( 0, 0, 0, 170 )
			
			local labelPlayerName1 = display.newText(jogador1.getPlayerTime(),255,
			100 + indice1 * 33,'AmericanTypewriter-Bold',15)
								
			localGroup:insert(labelPlayerScreenRoundedRect1)
			localGroup:insert(labelPlayerName1)
	end	

	return localGroup
end