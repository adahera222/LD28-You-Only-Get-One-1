content[2] =
    start:
        text: "You are getting visibly closer to the fortress; you can see the ridges and things on the tops of the walls.  You have a good feeling about this particular day; you don't think anything weird will happen."
        choices: [
            {
                text: "Run towards the fortress"
                icon: "fa-road"
                action: (player) ->
                    player.add "strength", -10
                    player.add "health", -5
                    player.add "sanity", -2
                    player.setPhase "awesomerunning"
            }
        ]
    awesomerunning:
        text: "You run towards the fortress for half an hour.  You stop when you notice on the side of the road an old first-aid kit."
        choices: [
            {
                text: "Use the first-aid kit"
                icon: "fa-medkit"
                action: (player) ->
                    sanity = player.get "sanity"
                    healPer = randBetween(minHealPerSanity, maxHealPerSanity)
                    player.add "health", Math.round(sanity * healPer)
                    player.setPhase("healed")
            }
            {
                text: "Ignore the first-aid kit"
                icon: "fa-ban"
                action: (player) ->
                    player.add "strength", -10
                    player.add "health", -5
                    player.add "sanity", -2
                    player.setPhase("stillrunning")
            }
        ]
    healed:
        text: "You worked hard to heal yourself."
        choices: [
            {
                text: "Start running"
                icon: "fa-road"
                action: (player) ->
                    player.add "strength", -10
                    player.add "health", -5
                    player.add "sanity", -2
                    player.setPhase("stillrunning")
            }
        ]
    stillrunning:
        text: "You started running.  After a while, it gets randomly ridiculously dark -- apparently whoever it is that decides how fast time moves hates you, or is just lazy.  You are approached by three creatures, one of which looks significantly larger and weirder than any you have seen before."
        choices: [
            {
                text: "Fight"
                icon: "fa-cutlery"
                action: (player) ->
                    player.takeDamageFromEnemyWithDifficulty(1)
                    player.takeDamageFromEnemyWithDifficulty(1)
                    player.setPhase "foughttwo"
            }
            {
                text: "Run"
                icon: "fa-rocket"
                action: (player) ->
                    player.add "strength", -5
                    player.setPhase "ranaway"
            }
        ]
    foughttwo:
        text: "You pull out your dagger as the creatures approach one by one, with the big one conveniently in the back.  You successfully dispatch the first two creatures and turn to face the third."
        choices: [
            {
                text: "Stand and fight"
                icon: "fa-cutlery"
                action: (player) ->
                    player.takeDamageFromEnemyWithDifficulty(2)
                    player.setPhase "foughtboss"
            }
            {
                text: "Turn and run"
                icon: "fa-rocket"
                action: (player) ->
                    player.add "strength", -5
                    player.setPhase "ranaway"
            }
        ]
    foughtboss:
        text: "You exert yourself more than you usually have and take care of the larger creature.  It's night, so you know that you should probably sleep."
        choices: [
            {
                text: "Sleep"
                icon: "fa-home"
                action: (player) ->
                    player.add "sanity", 20
                    player.add "strength", 4
                    player.add "health", 10
                    player.nextDay()
            }
            {
                text: "Don't sleep"
                icon: "fa-thumbs-o-down"
                action: (player) ->
                    player.add "sanity", -5
                    player.add "strength", -1
                    player.nextDay()
            }
        ]
    ranaway:
        text: "You sprint in the opposite direction as fast as possible.  You do not see anything following you.  It's getting late and you are tired."
        choices: [
            {
                text: "Sleep"
                icon: "fa-home"
                action: (player) ->
                    player.add "sanity", 15
                    player.add "strength", 3
                    player.add "health", 8
                    player.nextDay()
            }
            {
                text: "Don't sleep"
                icon: "fa-thumbs-o-down"
                action: (player) ->
                    player.add "sanity", -10
                    player.add "strength", -2
                    player.nextDay()
            }
        ]
    