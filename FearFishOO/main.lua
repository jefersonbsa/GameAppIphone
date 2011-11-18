
require 'pubnub'
local director = require("director")

local mainGroup = display.newGroup()

multiplayer = pubnub.new({
    publish_key   = "demo",
    subscribe_key = "demo",
    secret_key    = "",
    ssl           = nil,
    origin        = "pubsub.pubnub.com"
})

multiplayer:subscribe({
    channel  = "fatec-corona",
    callback = function(jogador)	
				director:addPlayer(jogador.nomes,jogador.pontos,jogador.times)		
    end,
    errorback = function()
	    --labelScreenError = display.newText(language.MultiPlayerOffline..':',70,55,'AmericanTypewriter-Bold',18)
       -- print("Conexao Nao Encontrada!!! Ausente 3G Conection!")
        --localGroup:insert(labelScreenError)
    end
})

local main = function ()
	mainGroup:insert(director.directorView)		
	director:changeScene("LanguageScreen")
	return true
end

main()
--local translate = languageSetup.new()







