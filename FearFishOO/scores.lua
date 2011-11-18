require 'pubnub'

local mensagens = 0;
players = {}

jogadores = { nome="",pontos=0 }

multiplayer = pubnub.new({
    publish_key   = "demo",
    subscribe_key = "demo",
    secret_key    = "",
    ssl           = nil,
    origin        = "pubsub.pubnub.com"
})

function send_a_message(nome1,ponto1,time1)
    multiplayer:publish({
        channel = "fatec-corona",
        message = { nomes = nome1,pontos=ponto1, times = time1}
    })
end

function enviaMensagem(player1,score1,time1)
    send_a_message(player1,score1,time1)
end