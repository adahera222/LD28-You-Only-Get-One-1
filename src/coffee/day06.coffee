content[6] =
    start:
        text: "You can tell that you're almost there.  You can read the title on the fortress.  Which isn't even relevant, as you no longer care about anything except being done with the game so you can give me my 0.0 on every single category, since the theme wasn't \"fourth wall?  What fourth wall?  What on Earth are you talking about?\""
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
    s:
        text: "Seriously, you're stupid.  Go die (in the game, I mean)."
        choices: [
            {
                text: "Okay, fine"
                icon: "fa-bolt"
                action: (player) ->
                    player.add "health", -1000
                    player.setPhase "s"
            }
            {
                text: "No"
                icon: "fa-paperclip"
                action: (player) ->
                    player.setPhase "resisting"
            }
        ]
    resisting:
        text: "Okay, fine then, if you want to survive then don't try to sleep during the day."
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
                    player.setPhase "f7u12"
            }
        ]
    f7u12:
        text: "That's not okay."
        choices: [
            {
                text: "Is too"
                icon: "fa-fire"
                action: (player) ->
                    player.setPhase("f7u12")
            }
            {
                text: "No, you're right, it isn't."
                icon: "fa-check"
                action: (player) ->
                    player.setPhase("resisting")
            }
        ]
    r:
        text: "You walk up to the gates of the fortress and search for a doorbell or something to alert them to your presence.  You're checking for secret buttons when the guards ask you why you're there."
        choices: [
            {
                text: "I live here"
                icon: "fa-home"
                action: (player) ->
                    player.setPhase("compliant")
            }
            {
                text: "The town leaders said to meet here"
                icon: "fa-users"
                action: (player) ->
                    player.setPhase("smart")
            }
            {
                text: "I am in need of shelter from these creatures"
                icon: "fa-shield"
                action: (player) ->
                    player.setPhase("compliant")
            }
        ]
    smart:
        text: "The guards are impressed that you remembered the plot.  They open the gates."
        choices: [
            {
                text: "Go inside"
                icon: "fa-sign-in"
                action: (player) ->
                    player.setPhase "inside"
            }
            {
                text: "Stay outside"
                icon: "fa-sign-out"
                action: (player) ->
                    player.setPhase "stupid"
            }
        ]
    compliant:
        text: "The two guards call you out on your crap.  They know as well as I do that the plot made no sense and was instantly forgettable, but unlike me, they don't care.  They run towards you."
        choices: [
            {
                text: "Fight"
                icon: "fa-cutlery"
                action: (player) ->
                    player.takeDamageFromEnemyWithDifficulty(2.5)
                    player.takeDamageFromEnemyWithDifficulty(2.5)
                    player.setPhase "ggn00b"
            }
            {
                text: "Run"
                icon: "fa-rocket"
                action: (player) ->
                    player.add "strength", -5
                    player.setPhase "ranaway"
            }
        ]
    ggn00b:
        text: "You valiantly and honorably kill the two guards who figured out you were lying to them, but you're stuck outside the gates.  Forever."
        choices: [
            {
                text: "Try to open the gates"
                icon: "fa-sort"
                action: (player) ->
                    if player.get("strength") > 60
                        player.add "strength", -40
                        player.setPhase("brokein")
                    else
                        player.add "health", -1000000
                        player.setPhase "ggn00b"
            }
        ]
    ranaway:
        text: "The guards take your departure as an admission of guilt and kill you.  Instantly."
        choices: [
            {
                text: "Okay?"
                icon: "fa-thumbs-up"
                action: (player) ->
                    player.add "health", -10000000
                    player.setPhase "ranaway"
            }
        ]
    brokein:
        text: "It took a lot of muscle, but you successfully broke open the gates."
        choices: [
            {
                text: "Go inside"
                icon: "fa-sign-in"
                action: (player) ->
                    player.setPhase "inside"
            }
            {
                text: "Stay outside"
                icon: "fa-sign-out"
                action: (player) ->
                    player.setPhase "stupid"
            }
        ]
    stupid:
        text: "That's stupid."
        choices: [
            {
                text: "Go inside"
                icon: "fa-sign-in"
                action: (player) ->
                    player.setPhase "inside"
            }
            {
                text: "Stay outside"
                icon: "fa-sign-out"
                action: (player) ->
                    player.setPhase "stupid"
            }
        ]
    inside:
        text: "Inside the fortress, you find a whole bunch of people who you recognize from your town.  Friends, family, bitter enemies, the whole deal.  In fact, you can't think of anyone who isn't there.  Congratulations, you win!"
        choices: [
            {
                text: "Accept your victory"
                icon: "fa-trophy"
                action: (player) ->
                    player.nextDay()
            }
        ]