require 'language_en'
require 'language_pt_br'


module(..., package.seeall)

function new (idioma) 
	local language = {}
	local game_translate = {
							   ENGLISH = language_en,
							   PORTUGUESE = language_pt_br
					       }
					
	function language:setLanguage(idioma)
		if (idioma == "PORTUGUESE") then
		     language = game_translate.PORTUGUESE
		end
		if (idioma == "ENGLISH") then
			 language = game_translate.ENGLISH
		end
		return language
	end
	
	
	function language:getLanguage()
		return language
	end
	
	return language
end	
