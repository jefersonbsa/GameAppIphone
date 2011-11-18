module (..., package.seeall)

function new()
	local localGroup = display.newGroup()
	local ui = require ( "ui" )
    local language =  director:getLanguage()
	
	local aboutScreenBackground = display.newImage('fundo3.png')
	aboutScreenBackground.x = display.contentWidth / 2
	aboutScreenBackground.y = display.contentHeight / 2
	aboutScreenBackground.xScale = 1.6
	aboutScreenBackground.yScale = 1.6
	
	local logoFatec = display.newImage("logoFatec.jpg");
	logoFatec.x = display.contentWidth / 2
	logoFatec.y = display.contentHeight / 2 + 170
	
	local labelTextAboutScreen = display.newText( language.MessageAbout, display.contentWidth / 2 - 100, display.contentHeight/2 - 150, "Helvetica", 24 ) 
    labelTextAboutScreen:setTextColor( 0 )
	
	
	
	
    local voltar = function ( event )
		if event.phase == "release" then
			director:changeScene( "MenuScreen", "moveFromRight" )
		end
	end
	
    local buttonVoltar = ui.newButton{
		default = "buttonArrow.png",
		over = "buttonArrowOver.png",
		onEvent = voltar,
		id = "arrow"
	}
	
    buttonVoltar.x = 20; buttonVoltar.y = 450

	localGroup:insert(aboutScreenBackground)
	localGroup:insert(labelTextAboutScreen)		
	localGroup:insert(buttonVoltar)	
		
	return localGroup
end