###

You have three statistics: health, strength, and sanity.  All of them are tracked by the game, but only one of them is
visible; you only get one that you can see.

###

_.templateSettings =
  interpolate : /\{\{(.+?)\}\}/g

minInitialHealth = 90
maxInitialHealth = 110
minInitialStrength = 90
maxInitialStrength = 110
minInitialSanity = 90
maxInitialSanity = 110

$ ->
    
    randBetween = (min, max) -> Math.random() * (max - min) + min

    Player = Backbone.Model.extend
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
        defaults: ->
            maxHealth = Math.round(randBetween(minInitialHealth, maxInitialHealth))
            maxStrength = Math.round(randBetween(minInitialStrength, maxInitialStrength))
            maxSanity = Math.round(randBetween(minInitialSanity, maxInitialSanity))
            maxHealth: maxHealth
            maxStrength: maxStrength
            maxSanity: maxSanity
            minHealth: 0
            minStrength: 0
            minSanity: 0
            health: maxHealth
            strength: maxStrength
            sanity: maxSanity
            selectedStat: "health"
            gameStarted: yes

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
            if @model.get("selectedStat") isnt "" then @$el.show() else @$el.hide()
    
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
        events:
            "click #option-1 > button": "choice1"
            "click #option-2 > button": "choice2"
            "click #option-3 > button": "choice3"
        render: ->
            @$el.html @template
                bodytext: "Herp derp text"
                choice1text: "Choose me!"
                choice1icon: "fa-medkit"
                choice2text: "No, choose me!"
                choice2icon: "fa-pencil"
                choice3text: "I'm secretly the best!"
                choice3icon: "fa-tachometer"
            if @model.get("selectedStat") isnt "" then @$el.show() else @$el.hide()
        choice1: ->
            @model.set health: @model.get("health") - 5
        choice2: ->
            @model.set health: @model.get("health") - 5
        choice3: ->
            @model.set health: @model.get("health") - 5
    
    currentPlayer = new Player
    
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
