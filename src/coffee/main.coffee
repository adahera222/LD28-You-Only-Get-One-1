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

getContentFor = (day, phase) ->
    currentDay = content[day]
    currentPhase = currentDay[phase]
    return currentPhase

$ ->
    
    randBetween = (min, max) -> Math.random() * (max - min) + min
    
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
        nextPhase: ->
            @set phase: @get("phase") + 1
        nextDay: ->
            @set day: @get("day") + 1
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
            day: 0
            phase: 0

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
        render: ->
            currentContent = getContentFor @model.get("day"), @model.get("phase")
            @$el.html @template bodytext: currentContent.text
            for choice in currentContent.choices
                view = new ChoiceView(model: new Choice(choice))
                view.render()
                @$("#choices").append(view.el)
            if @model.get("selectedStat") isnt "" then @$el.show() else @$el.hide()
    
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
