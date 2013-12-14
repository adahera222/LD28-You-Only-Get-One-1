content[0] =
    start:
        text: "You are sitting in an open field.  There is a campfire in front of you.  It burns slowly and is quite comforting.  The fire illuminates a rather large area; you can see that nothing is trying to eat you. Fortunately for you, it's daytime, so the fire is rather pointless for lighting.  You can see in the distance the gate of a mountain fortress; you remember that your town leaders decreed that this fortress would be the place of refuge for everyone in case of an emergency like this one.  But the night is fast approaching and you have little time before nightfall.  You are in pristine condition; you've never felt better despite the rather bizarre turn of events that has preceded this moment."
        choices: [
            {
                text: "Next"
                icon: "fa-arrow-right"
                action: (player) ->
                    player.setPhase("nightfall")
            }
        ]
    nightfall:
        text: "As night falls, you see some vague shapes; they seem to be avoiding the light from your campfire. Although you can't tell for certain, you would guess that there are three of them present.  They seem rather weak and somewhat vulnerable.  You reach for your trusted dagger and find it reassuringly attached to your belt.  You weigh your options and come to the conclusion that it would be feasible to attempt to drive the creatures off now."
        choices: [
            {
                text: "Attack the creatures"
                icon: "fa-cutlery"
                action: (player) ->
                    player.takeDamageFromEnemyWithDifficulty(1)
                    player.setPhase("aggressive")
            }
            {
                text: "Leave them alone"
                icon: "fa-home"
                action: (player) ->
                    player.setPhase("nonaggressive")
            }
        ]
    nonaggressive:
        text: "You sit by the fire and the creatures do not move towards you.  You are growing tired.  They might be peaceful, or they might be waiting for a chance to attack you."
        choices: [
            {
                text: "Sleep for the rest of the night"
                icon: "fa-moon-o"
                action: (player) ->
                    player.add "sanity", 10
                    player.add "strength", 2
                    player.add "health", 5
                    player.nextDay()
            }
            {
                text: "Stay awake and on guard"
                icon: "fa-shield"
                action: (player) ->
                    player.add "sanity", -5
                    player.add "strength", -1
                    player.nextDay()
            }
        ]
    aggressive:
        text: "As you move to attack the creatures, most of them disperse.  You are close enough now to see them in detail; their appearance is truly hideous and startles you momentarily.  One of them does not move, and as you close in, you notice in your peripheral vision that they are watching you, perhaps in an attempt to determine your strength.  You stab the creature; it bites at you.  You kill it easily; you have been a bit scratched up, but nothing too severe has happened to you.  You return to the fire, and you can see the creatures returning to where they were.</p><p>You are growing tired, but you know that they may or may not attempt to kill you in your sleep."
        choices: [
            {
                text: "Sleep for the rest of the night"
                icon: "fa-moon-o"
                action: (player) ->
                    player.add "sanity", 10
                    player.add "strength", 2
                    player.add "health", 5
                    player.nextDay()
            }
            {
                text: "Stay awake and on guard"
                icon: "fa-shield"
                action: (player) ->
                    player.add "sanity", -5
                    player.add "strength", -1
                    player.nextDay()
            }
        ]