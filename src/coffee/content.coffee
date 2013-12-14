content = [
    [
        {
            text: "Oh hi, how are you doing today?"
            choices: [
                {
                    text: "Quite well, thank you."
                    icon: "fa-smile-o"
                    action: (player) ->
                        player.set health: 10
                        player.nextPhase()
                }
                {
                    text: "Rather average."
                    icon: "fa-meh-o"
                    action: (player) ->
                        player.set health: 5
                        player.nextPhase()
                }
                {
                    text: "Absolutely miserable.  Go away."
                    icon: "fa-frown-o"
                    action: (player) ->
                        player.set health: 2
                        player.nextPhase()
                }
            ]
        }
        {
            text: "That's nice.  I'd like to tell you about a thing that happened one time."
            choices: [
                {
                    text: "Ok..."
                    icon: "fa-arrow-right"
                    action: (player) ->
                        player.nextPhase()
                }
            ]
        }
    ]
]
