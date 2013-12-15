content[5] =
    start:
        text: "You wake up refreshed and relaxed, almost as if you're most of the way to your destination you never cared about in the first place.  You know the drill."
        choices: [
            {
                text: "Run"
                icon: "fa-road"
                action: (player) ->
                    player.add "strength", -10
                    player.add "health", -5
                    player.add "sanity", -2
                    player.setPhase "r"
            }
            {
                text: "Sleep"
                icon: "fa-home"
                action: (player) ->
                    player.setPhase "s"
            }
        ]
    r:
        text: "You run for a bit.  You can see the banners waving from the fortress, as if you still care."
        choices: [
            {
                text: "Run"
                icon: "fa-road"
                action: (player) ->
                    player.add "strength", -50
                    player.add "health", -50
                    player.add "sanity", -10
                    player.setPhase "rr"
            }
            {
                text: "Sleep"
                icon: "fa-home"
                action: (player) ->
                    player.add "sanity", 5
                    player.add "strength", 1
                    player.add "health", 2
                    player.setPhase "rs"
            }
        ]
    rr:
        text: "You run more.  You're really tired now."
        choices: [
            {
                text: "Run"
                icon: "fa-road"
                action: (player) ->
                    player.add "strength", -500
                    player.add "health", -500
                    player.add "sanity", -100
                    player.setPhase "rr"
            }
            {
                text: "Sleep"
                icon: "fa-home"
                action: (player) ->
                    player.add "sanity", 10
                    player.add "strength", 2
                    player.add "health", 5
                    player.setPhase "rrs"
            }
        ]
    rs:
        text: "It's a bit early for sleeping, but you still manage to find a comfortable place and sleep.</p><p>You are awoken by a loud sound.  The sky is mostly dark, but you can tell it's just before sunrise.  The five creatures don't care.  They're attacking you anyways."
        choices: [
            {
                text: "Fight"
                icon: "fa-cutlery"
                action: (player) ->
                    player.takeDamageFromEnemyWithDifficulty(1)
                    player.takeDamageFromEnemyWithDifficulty(1)
                    player.takeDamageFromEnemyWithDifficulty(1)
                    player.setPhase "rsf"
            }
            {
                text: "Run"
                icon: "fa-rocket"
                action: (player) ->
                    player.add "strength", -5
                    player.setPhase "ranaway"
            }
        ]
    rsf:
        text: "You kill three of the creatures, and the other two run off.  One of the creatures that you killed conveniently dropped a first-aid kit, though God only knows why these things would be carrying first-aid kits.  You're hardly in a position to complain, though."
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
                    player.setPhase("rrs")
            }
        ]
    ranaway:
        text: "You run as fast as you can.  You don't see anything following you.  You fall asleep."
        choices: [
            {
                text: "Wake up"
                icon: "fa-hand-o-up"
                action: (player) ->
                    player.nextDay()
            }
        ]
    healed:
        text: "You patch yourself up a bit.  You cave in and sleep."
        choices: [
            {
                text: "Wake up"
                icon: "fa-hand-o-up"
                action: (player) ->
                    player.nextDay()
            }
        ]
    rrs:
        text: "You cave in and sleep."
        choices: [
            {
                text: "Wake up"
                icon: "fa-hand-o-up"
                action: (player) ->
                    player.nextDay()
            }
        ]
    s:
        text: "It's daytime.  You can't fall asleep.  No matter how hard you try."
        choices: [
            {
                text: "Run"
                icon: "fa-road"
                action: (player) ->
                    player.add "strength", -10
                    player.add "health", -5
                    player.add "sanity", -2
                    player.setPhase "r"
            }
            {
                text: "Sleep"
                icon: "fa-home"
                action: (player) ->
                    player.add "strength", -10
                    player.setPhase "ss"
            }
        ]
    ss:
        text: "Still daytime.  You try so hard to fall asleep that you pull a muscle.  Somehow."
        choices: [
            {
                text: "Run"
                icon: "fa-road"
                action: (player) ->
                    player.add "strength", -10
                    player.add "health", -5
                    player.add "sanity", -2
                    player.setPhase "r"
            }
            {
                text: "Sleep"
                icon: "fa-home"
                action: (player) ->
                    player.add "sanity", -1000
                    player.setPhase "ss"
            }
        ]