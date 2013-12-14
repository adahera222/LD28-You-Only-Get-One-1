$ ->

    Counter = Backbone.Model.extend
        defaults:
            value: 0
            maximum: 100

    HeadingLabel = Backbone.View.extend
        el: $("#button-press-count")
        template: _.template '<%= value %>'
        initialize: ->
            @listenTo @model, "change", @render
        render: ->
            @$el.html(@template(@model.attributes))

    HeadingButton = Backbone.View.extend
        el: $("#increment")
        events:
            click: "increment"
        increment: ->
            @model.set value: @model.get("value") + 1

    ProgressBar = Backbone.View.extend
        el: $("#click-progress")
        template: _.template """
            <div class="progress">
              <div class="progress-bar" role="progressbar" aria-valuenow="<%= value %>"
                aria-valuemin="0" aria-valuemax="<%= maximum %>" style="width: <%= 100 * value / maximum %>%;">
                <span class="sr-only"><%= 100 * value / maximum %>% Complete</span>
              </div>
            </div>"""
        initialize: ->
            @listenTo @model, "change", @render
        render: ->
            @$el.html(@template(@model.attributes))
    
    appCounter = new Counter
    
    label = new HeadingLabel
        model: appCounter
    label.render()
    
    button = new HeadingButton
        model: appCounter
    button.render()
    
    bar = new ProgressBar
        model: appCounter
    bar.render()

