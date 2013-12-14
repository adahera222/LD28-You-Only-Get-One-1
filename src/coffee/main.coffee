###

You have three statistics: health, strength, and sanity.  All of them are tracked by the game, but only one of them is
visible; you only get one that you can see.

###

$ ->
    
    Choice = Backbone.Model.extend {}
    
    ChoiceView = Backbone.View.extend
        tagName: "li"
        template: _.template $("#choice-template").html()
        events:
            "click button": "execute"
        render: ->
            @$el.html @template @model.attributes
        execute: ->
            @model.get("action")(currentPlayer)

    Player = Backbone.Model.extend
        takeDamageFromEnemyWithDifficulty: (enemyDifficulty) ->
            @add "health", -getDamageTakenBasedOnStrength @get("strength"), enemyDifficulty
        setPhase: (phase) ->
            @set phase: phase
        nextDay: ->
            @set day: @get("day") + 1, phase: "start"
        maxSelected: ->
            switch @get("selectedStat")
                when "health" then @get "maxHealth"
                when "strength" then @get "maxStrength"
                when "sanity" then @get "maxSanity"
                else console.error "AAAAAAAAAAAAAAAAAAAAAAA"
        currentSelected: ->
            switch @get("selectedStat")
                when "health" then @get "health"
                when "strength" then @get "strength"
                when "sanity" then @get "sanity"
                else console.error "AAAAAAAAAAAAAAAAAAAAAAA"
        add: (attr, modifier) ->
            modification = {}
            modification[attr] = @get(attr)+modifier
            @set modification
        defaults: ->
            maxHealth = randIntBetween(minInitialHealth, maxInitialHealth)
            maxStrength = randIntBetween(minInitialStrength, maxInitialStrength)
            maxSanity = randIntBetween(minInitialSanity, maxInitialSanity)
            maxHealth: maxHealth
            maxStrength: maxStrength
            maxSanity: maxSanity
            health: maxHealth
            strength: maxStrength
            sanity: maxSanity
            selectedStat: "health"
            gameStarted: yes
            day: 0
            phase: "start"
    
    currentPlayer = new Player
    
    currentPlayer.on "change:health change:strength change:sanity", ->
        if currentPlayer.get("health") < 0 or currentPlayer.get("strength") < 0 or currentPlayer.get("sanity") < 0
            alert "You lost!!!!!!!!!!111!!!!!!!!!1onehundredandeleven!!!"
        if currentPlayer.get("health") > currentPlayer.get "maxHealth"
            currentPlayer.set health: currentPlayer.get "maxHealth"
        if currentPlayer.get("strength") > currentPlayer.get "maxStrength"
            currentPlayer.set strength: currentPlayer.get "maxStrength"
        if currentPlayer.get("sanity") > currentPlayer.get "maxSanity"
            currentPlayer.set sanity: currentPlayer.get "maxSanity"

    Statistic = Backbone.View.extend
        el: $("#statistic")
        template: _.template $("#statistic").html()
        initialize: ->
            @listenTo @model, "change", @render
        render: ->
            @$el.html @template
                selected: @model.get("selectedStat")
                current: @model.currentSelected()
                maximum: @model.maxSelected()
                health: if leetHax0rMode then @model.get("health") else 0
                strength: if leetHax0rMode then @model.get("strength") else 0
                sanity: if leetHax0rMode then @model.get("sanity") else 0
                extraClass: getStatBarClass(@model.currentSelected())
            if @model.get("selectedStat") isnt "" then @$el.show() else @$el.hide()
            if leetHax0rMode
                @$(".hax-only").show()
    
    StatChooser = Backbone.View.extend
        el: $("#stat-chooser")
        events:
            "click .health": "health"
            "click .strength": "strength"
            "click .sanity": "sanity"
        initialize: ->
            @listenTo @model, "change", @render
        render: ->
            if @model.get("selectedStat") is "" and @model.get("gameStarted") then @$el.show() else @$el.hide()
        health: ->
            @model.set(selectedStat: "health")
        strength: ->
            @model.set(selectedStat: "strength")
        sanity: ->
            @model.set(selectedStat: "sanity")
    
    GameIntro = Backbone.View.extend
        el: $("#game-intro")
        events:
            "click #start-game": "begin"
        initialize: ->
            @listenTo @model, "change", @render
        render: ->
            if @model.get("gameStarted") then @$el.hide() else @$el.show()
        begin: ->
            @model.set gameStarted: yes
    
    GameAction = Backbone.View.extend
        el: $("#game-action")
        template: _.template $("#game-action").html()
        initialize: ->
            @listenTo @model, "change", @render
        render: ->
            currentContent = getContentFor @model.get("day"), @model.get("phase")
            @$el.html @template bodytext: currentContent.text
            for choice in currentContent.choices
                view = new ChoiceView(model: new Choice(choice))
                view.render()
                @$("#choices").append(view.el)
            if @model.get("selectedStat") isnt "" then @$el.show() else @$el.hide()
    
    stat = new Statistic
        model: currentPlayer
    stat.render()
    
    chooser = new StatChooser
        model: currentPlayer
    chooser.render()
    
    intro = new GameIntro
        model: currentPlayer
    intro.render()
    
    action = new GameAction
        model: currentPlayer
    action.render()
