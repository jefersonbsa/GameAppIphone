module (..., package.seeall)

function new()
	local localGroup = display.newGroup()
	local ui = require ( "ui" )
	
	local language =  director:getLanguage()
	local PlayerScreenBackground = display.newImage('capa.png')
	PlayerScreenBackground.x = display.contentWidth / 2
	PlayerScreenBackground.y = display.contentHeight / 2
	PlayerScreenBackground.xScale = 1.6
	PlayerScreenBackground.yScale = 1.6
	
	local labelPlayerScreenRoundedRect = display.newRoundedRect( display.contentWidth/3 - 40, 50, 210, 40, 8 )
	labelPlayerScreenRoundedRect:setFillColor( 0, 0, 0, 170 )
	local labelPlayerScreen = display.newText(language.createUserName..':',display.contentWidth / 3 - 30 ,55,'AmericanTypewriter-Bold',18)
	
	
	local voltar = function ( event )
		if event.phase == "release" then
			director:changeScene( "LanguageScreen", "moveFromLeft" )
		end
	end
	
	local enviar = function ( event )
		if event.phase == "release" then
			director:changeScene( "MenuScreen", "fade" )
		end
	end
	
   local function button( getObj )

       return function( event )
 
                
                if ( "began" == event.phase ) then
					-- This is the "keyboard has appeared" event
					-- In some cases you may want to adjust the interface when the keyboard appears.
                
                elseif ( "ended" == event.phase ) then
                        -- This event is called when the user stops editing a field:
                        -- for example, when they touch a different field or keyboard focus goes away
						-- This event is called when the user stops editing a field: for example, when they touch a different field					
						local PlayerClass = require('Player')
					    local playerSetup = PlayerClass.new()
						local player = playerSetup:setPlayerName(tostring( getObj().text ) )
						director:setPlayer(player)
                        
                elseif ( "submitted" == event.phase ) then
                        -- This event occurs when the user presses the "return" key
                        -- (if available) on the onscreen keyboard                    
                        -- Hide keyboard
                        native.setKeyboardFocus( nil )
                end 
        end     -- "return function()"

	end
	
	local listener = function( event )
		-- Hide keyboard
		native.setKeyboardFocus( nil )
	end
	

	local buttonVoltar = ui.newButton{
		default = "buttonArrow.png",
		over = "buttonArrowOver.png",
		onEvent = voltar,
		id = "arrow"
	}
	
	local buttonOK = ui.newButton{
					default = "buttonBlueSmall.png",
			        over = "buttonBlueSmallOver.png",
					onEvent = enviar,
					id = "buttonOK",
					text = "OK",
					font = "MarkerFelt-Thin",
					size = 14,
					emboss = true
	}
	
	buttonVoltar.x = 20; buttonVoltar.y = 450
	buttonOK.x = 160; buttonOK.y = 450
	
	local textInput = nil
	local labelPlayerName = nil
   
	
	localGroup:insert(PlayerScreenBackground)
	localGroup:insert(labelPlayerScreenRoundedRect)
	localGroup:insert(labelPlayerScreen)		
	localGroup:insert(buttonVoltar)	
	localGroup:insert(buttonOK)
	
	PlayerScreenBackground:addEventListener( "tap", listener )	
	
	if (system.getInfo('environment') == 'simulator') then
		textInput = 'Simulador'..math.random(1,50)
	    labelPlayerName = display.newText(textInput,display.contentWidth / 3,400,'AmericanTypewriter-Bold',18)
		local PlayerClass = require('Player')
		local playerSetup = PlayerClass.new()
		local player = playerSetup:setPlayerName(textInput)
		director:setPlayer(player)
		labelPlayerName:setTextColor( 0, 0, 0 )
		localGroup:insert(labelPlayerName)	

		
	else
		textInput = native.newTextField( 40, 160, 230, 25, button( function() return textInput end ) )
	end
		
	return localGroup
end