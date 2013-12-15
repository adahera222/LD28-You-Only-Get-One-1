content[6] =
    start:
        text: "Now that you've \"won\" and accepted your victory, you have several options."
        choices: [
            {
                text: "Restart"
                icon: "fa-refresh"
                action: (player) ->
                    restart()
            }
            {
                text: "Quit"
                icon: "fa-power-off"
                action: (player) ->
                    location.href = "https://www.youtube.com/embed/oavMtUWDBTM?autoplay=1"
            }
        ]