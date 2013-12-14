content[1] =
    start:
        text: "Morning arrives.  While your campfire was effective in keeping the creatures at bay before, you know that it will not last long; in fact, you can see it dwindling already.  You know that your only hope is to make for the mountain fortress and hope that someone else survived."
        choices: [
            {
                text: "Run towards the fortress"
                icon: "fa-road"
                action: (player) ->
                    player.add "strength", -10
                    player.add "health", -5
                    player.add "sanity", -2
                    player.setPhase "running1"
            }
            {
                text: "Search for supplies"
                icon: "fa-shopping-cart"
                action: (player) ->
                    player.add "strength", -1
                    player.setPhase "gathering"
            }
        ]
    gathering:
        text: "You find nothing in fifteen minutes of work.  There's probably a related medical condition, but you can't remember what it would be called."
        choices: [
            {
                text: "Run towards the fortress"
                icon: "fa-road"
                action: (player) ->
                    player.add "strength", -10
                    player.add "health", -5
                    player.add "sanity", -2
                    player.setPhase "running1"
            }
            {
                text: "Search for more supplies"
                icon: "fa-shopping-cart"
                action: (player) ->
                    player.add "strength", -1
                    player.setPhase "stillgathering"
            }
        ]
    stillgathering:
        text: "You still find nothing after another fifteen minutes.  You remembered the medical term: lazy-developer-itis." # it's the truth
        choices: [
            {
                text: "Run towards the fortress"
                icon: "fa-road"
                action: (player) ->
                    player.add "strength", -10
                    player.add "health", -5
                    player.add "sanity", -2
                    player.setPhase "running1"
            }
            {
                text: "Search for more supplies"
                icon: "fa-shopping-cart"
                action: (player) ->
                    player.add "strength", -1
                    player.setPhase "stillgathering"
            }
        ]
    running1:
        text: "You run for an hour towards the fortress.  You are impressed with your own stamina, but you know that the more you run, the weaker you will be.  Based on the approximate position of the sun, you guess that it is about noon."
        choices: [
            {
                text: "Keep running towards the fortress"
                icon: "fa-rocket"
                action: (player) ->
                    player.add "strength", -50
                    player.add "health", -50
                    player.add "sanity", -10
                    player.setPhase "running2"
            }
            {
                text: "Stop and take a break"
                icon: "fa-home"
                action: (player) ->
                    player.add "strength", 5
                    player.setPhase "break"
            }
        ]
    break:
        text: "You stop and rest for a while.  You feel as though you may be regaining some of your strength that you lost while running.  It's getting late; you might wish to set up camp for the night."
        choices: [
            {
                text: "Resume running towards the fortress"
                icon: "fa-road"
                action: (player) ->
                    player.add "strength", -25
                    player.add "health", -20
                    player.add "sanity", -5
                    player.setPhase "running2"
            }
            {
                text: "Set up camp and sleep"
                icon: "fa-home"
                action: (player) ->
                    player.add "sanity", 5
                    player.add "strength", 1
                    player.add "health", 2
                    player.setPhase "camp"
            }
        ]
    camp:
        text: "You don't have very much with which to make a camp; all you've got is some brush from the ground.  You start a tiny fire to keep the creatures at bay, and then sleep.</p><p>You hear a loud noise which wakes you up.  It is very dark outside, and you can see four creatures coming towards you."
        choices: [
            {
                text: "Stand and fight the creatures"
                icon: "fa-cutlery"
                action: (player) ->
                    player.takeDamageFromEnemyWithDifficulty(1)
                    player.takeDamageFromEnemyWithDifficulty(1)
                    player.setPhase "donerunning"
            }
        ]
    running2:
        text: "You run for another hour towards the fortress; you are so exhausted that you lose consciousness.</p><p>When you wake up, it is pitch black, and you can just barely see four creatures coming towards you."
        choices: [
            {
                text: "Stand and fight the creatures"
                icon: "fa-cutlery"
                action: (player) ->
                    player.takeDamageFromEnemyWithDifficulty(1.25)
                    player.takeDamageFromEnemyWithDifficulty(1.25)
                    player.add "sanity", -15
                    player.setPhase "donerunning"
            }
        ]
    donerunning:
        text: "You successfully kill two of the creatures; the other two back off.  The effort has taken a significant toll on your nerves and strength; you go to sleep for a bit."
        choices: [
            {
                text: "Pass out"
                icon: "fa-hand-o-down"
                action: (player) ->
                    player.add "sanity", 3
                    player.add "strength", 1
                    player.add "health", 1
                    player.nextDay()
            }
        ]