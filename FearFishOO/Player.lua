module(..., package.seeall)

function new () 
	local player = {
					 Name='',
					 Pontos='',
					 Time=''
	}
					
	function player:setPlayerName(name)
		player.Name = name
		return player
	end
	
	function player:setPlayerPontos(pontos)
		player.Pontos = pontos
		return player
	end
	
	function player:setPlayerTime(time)
		player.Time = time
		return player
	end
	
	function player:getPlayerName()
		return player.Name
	end
	
	function player:getPlayerPontos()
		return player.Pontos
	end
	
	function player:getPlayerTime()
		return player.Time
	end		
	
	return player
end	
