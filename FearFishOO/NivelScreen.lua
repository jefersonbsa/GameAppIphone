module (..., package.seeall)

function new()
	local localGroup = display.newGroup()
	local ui = require ( "ui" )

	local voltar = function ( event )
		if event.phase == "release" then
			director:changeScene( "MenuScreen", "moveFromLeft" )
		end
	end
	local facil = function ( event )
		if event.phase == "release" then
			director:setNivel(1,0,0)
			director:changeScene( "MultiPlayerScreen", "fade" )
		end
	end	
	
	local medium = function ( event )
		if event.phase == "release" then
			director:setNivel(0,1,0)
			director:changeScene( "MultiPlayerScreen", "fade" )
		end
	end	
	
	local dificil = function ( event )
		if event.phase == "release" then
			director:setNivel(0,0,1)
			director:changeScene( "MultiPlayerScreen", "fade" )
		end
	end
	
	local background = display.newImage('fundo3.png')
	background.x = display.contentWidth / 2
    background.y = display.contentHeight / 2
    background.xScale = 1.6
    background.yScale = 1.6	

	
	local buttonFacil= ui.newButton{
		default = "buttonGray.png",
		over = "buttonBlue.png",
		text = 'facil',
		onEvent = facil,
		id = "arrow"
	}
	buttonFacil.x = 160; buttonFacil.y = 150
	
	local buttonMedim= ui.newButton{
		default = "buttonGray.png",
		over = "buttonBlue.png",
		text = 'medium',
		onEvent = medium,
		id = "arrow"
	}
	buttonMedim.x = 160; buttonMedim.y = 250
	
	local buttonDificil= ui.newButton{
		default = "buttonGray.png",
		over = "buttonBlue.png",
		text = 'dificil',
		onEvent = dificil,
		id = "arrow"
	}
	buttonDificil.x = 160; buttonDificil.y = 350
	
	local buttonVoltar = ui.newButton{
		default = "buttonArrow.png",
		over = "buttonArrowOver.png",
		onEvent = voltar,
		id = "arrow"
	}
	buttonVoltar.x = 20; buttonVoltar.y = 450		


	localGroup:insert(background)
	localGroup:insert(buttonFacil)
	localGroup:insert(buttonMedim)
	localGroup:insert(buttonDificil)
	localGroup:insert(buttonVoltar)	
	


	return localGroup
end