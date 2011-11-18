module (..., package.seeall)

function new()
	local localGroup = display.newGroup()
	local ui = require ( "ui" )

	
	local languageScreenBackground = display.newImage('fundo3.png')
	languageScreenBackground.x = display.contentWidth / 2
	languageScreenBackground.y = display.contentHeight / 2
	languageScreenBackground.xScale = 1.6
	languageScreenBackground.yScale = 1.6
	
	local labelLanguageScreenRoundedRect = display.newRoundedRect( 10, 50, 300, 40, 8 )
	labelLanguageScreenRoundedRect:setFillColor( 0, 0, 0, 170 )

	local labelLanguageScreen = display.newText('Select Your Language :',40,55,'AmericanTypewriter-Bold',18)
	
	local selectPortugues = function ( event )
		if event.phase == "release" then
			director:setLanguage( 'PORTUGUESE' )
			director:changeScene( "CreatePlayerScreen", "fade" )
		end
	end
	
	local selectEnglish = function ( event )
		if event.phase == "release" then
		    director:setLanguage( 'ENGLISH' )
			director:changeScene( "CreatePlayerScreen", "fade" )
		end
	end
	
	local buttonPortugues = ui.newButton{
					default = "buttonGray.png",
					over = "buttonBlue.png",
					onEvent = selectPortugues,
					id = "buttonPortugues",
					text = "Portugues",
					font = "MarkerFelt-Thin",
					size = 28,
					emboss = true
	}

	local buttonEnglish = ui.newButton{
					default = "buttonGray.png",
					over = "buttonBlue.png",
					onEvent = selectEnglish,
					id = "buttonEnglish",
					text = "English",
					font = "MarkerFelt-Thin",
					size = 28,
					emboss = true
	}

	buttonPortugues.x = 160; buttonPortugues.y = 220
	buttonEnglish.x = 160; buttonEnglish.y = 320

	localGroup:insert(languageScreenBackground)
	localGroup:insert(labelLanguageScreenRoundedRect)
	localGroup:insert(labelLanguageScreen)		
	localGroup:insert(buttonPortugues)	
	localGroup:insert(buttonEnglish)	
		
	return localGroup
end