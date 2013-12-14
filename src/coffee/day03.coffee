content[3] =
    start:
        text: "You are impressed with jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj jjjjjjjj jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj.  You may or may not be going certifiably insane.  I might be the insane one."
        choices: [
            {
                text: "Who are you?"
                icon: "fa-question"
                action: (player) ->
                    player.setPhase "whoareyou"
            }
        ]
    whoareyou:
        text: "I'm the developer.  Shouldn't that be obvious?"
        choices: [
            {
                text: "Oh, nice.  You're cool."
                icon: "fa-check"
                action: (player) ->
                    player.add "health", 9000
                    player.add "strength", 9000
                    player.add "sanity", 9000
                    player.setPhase "ohnice"
            }
            {
                text: "You're not a good person."
                icon: "fa-exclamation"
                action: (player) ->
                    player.setPhase "badperson"
            }
            {
                text: "I HATE YOU!"
                icon: "fa-cutlery"
                action: (player) ->
                    player.setPhase "hatersgonnahate"
            }
        ]
    ohnice:
        text: "It's nice to have some appreciation for once.  Here, feel refreshed."
        choices: [
            {
                text: "Thanks, but isn't there supposed to be a plot?"
                icon: "fa-question"
                action: (player) ->
                    player.setPhase "wherestheplot"
            }
        ]
    badperson:
        text: "And you're not a good person either.  Good people are nice to developers."
        choices: [
            {
                text: "And another thing.  Isn't there supposed to be a plot?"
                icon: "fa-question"
                action: (player) ->
                    player.setPhase "wherestheplot"
            }
        ]
    hatersgonnahate:
        text: "Oh yeah?  Well, how's this for hatred?  YOU'RE DEAD."
        choices: [
            {
                text: "Am not."
                icon: "fa-exclamation"
                action: (player) ->
                    player.setPhase "notdead"
            }
        ]
    notdead:
        text: "Are too."
        choices: [
            {
                text: "Am not."
                icon: "fa-exclamation"
                action: (player) ->
                    player.setPhase "notdead"
            }
            {
                text: "Okay, fine, I'm dead."
                icon: "fa-check"
                action: (player) ->
                    player.setPhase "dead"
            }
        ]
    dead:
        text: "Of course you are.  I'm the developer!  I should know!"
        choices: [
            {
                text: "Well, if you're so smart, what happened to the plot?"
                icon: "fa-question"
                action: (player) ->
                    player.setPhase "wherestheplot"
            }
        ]
    wherestheplot:
        text: "You actually noticed there was a plot?  I feel special now."
        choices: [
            {
                text: "But where did it go?"
                icon: "fa-question"
                action: (player) ->
                    player.setPhase "icanhazplot"
            }
            {
                text: "Actually, now that you mention it, \"plot\" is a bit generous."
                icon: "fa-exclamation"
                action: (player) ->
                    player.setPhase "notaplot"
            }
        ]
    icanhazplot:
        text: "I guess you can have your precious plot back if you're going to be so picky about it."
        choices: [
            {
                text: "Thanks."
                icon: "fa-magic"
                action: (player) ->
                    player.nextDay()
            }
        ]
    notaplot:
        text: "Well, if you want something done right, go do it yourself!"
        choices: [
            {
                text: "Okay then, I will."
                icon: "fa-github"
                action: (player) ->
                    window.location = "http://github.com/mathphreak/LD28"
            }
        ]