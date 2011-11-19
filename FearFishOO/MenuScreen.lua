module (..., package.seeall)

function new()
	local localGroup = display.newGroup()
	local ui = require ( "ui" )
	
	local language =  director:getLanguage()
	
	local menuScreenBackground = display.newImage('capa.png')
	menuScreenBackground.x = display.contentWidth / 2
	menuScreenBackground.y = display.contentHeight / 2
	menuScreenBackground.xScale = 1.6
	menuScreenBackground.yScale = 1.6
	
	local voltar = function ( event )
		if event.phase == "release" then
			director:changeScene( "CreatePlayerScreen", "moveFromLeft" )
		end
	end
	
	local pause = function ( event )
		if event.phase == "release" then
			director:pause( )
		end
	end	
	
	local gameStart = function ( event )
		if event.phase == "release" then
			director:changeScene( "NivelScreen", "fade" )
		end
	end
	
	local aboutProject = function ( event )
		if event.phase == "release" then
			director:changeScene( "aboutScreen", "moveFromLeft" )
		end
	end
	
	local rankingList = function ( event )
		if event.phase == "release" then
			director:changeScene( "RankingScreen", 'moveFromRight' )
		end
	end
	
	local labelPlayerName = 
	display.newText(director.getPlayer().getPlayerName(),display.contentWidth/3,display.contentHeight / 2 + 120,'AmericanTypewriter-Bold',18)
	labelPlayerName:setTextColor( 0, 0, 0 )
	
	local buttonStart = ui.newButton{
		default = "buttonBlueSmall.png",
		over = "buttonBlueSmallOver.png",
		onEvent = gameStart,
		id = "buttonStart",
		text = language.buttonStart,
		size = 13,
		emboss=true
	}
	
	local buttonAbout = ui.newButton{
		default = "buttonBlueSmall.png",
		over = "buttonBlueSmallOver.png",
		onEvent = aboutProject,
		id = "buttonAbout",
		text = language.buttonAbout,
		size = 13,
		emboss=true
	}
	
	local buttonRanking = ui.newButton{
		default = "buttonBlueSmall.png",
		over = "buttonBlueSmallOver.png",
		onEvent = rankingList,
		id = "buttonRanking",
		text = language.ranking,
		size = 13,
		emboss=true
	}	
	
	local buttonPause = ui.newButton{
		default = "buttonBlueSmall.png",
		over = "buttonBlueSmallOver.png",
		text = language.buttonPause,
		size = 14,
		onEvent = pause,
		id = "arrow"
	}
	
	local buttonVoltar = ui.newButton{
		default = "buttonArrow.png",
		over = "buttonArrowOver.png",
		onEvent = voltar,
		id = "buttonVoltar"
	}	
	
	--print(director.getPLayer())

	buttonStart.x = 165; buttonStart.y = 395	
	buttonAbout.x = 100; buttonAbout.y = 430
	buttonRanking.x = 230; buttonRanking.y = 430
	buttonVoltar.x = 20; buttonVoltar.y = 450
	buttonPause.x = 270; buttonPause.y = 40	
	
	localGroup:insert(menuScreenBackground)
	--localGroup:insert(labelPlayerName)
	localGroup:insert(buttonAbout)
	localGroup:insert(buttonStart)
	localGroup:insert(buttonRanking)
	localGroup:insert(buttonVoltar)
	localGroup:insert(buttonPause)	
			
	return localGroup
end