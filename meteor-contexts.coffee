if Meteor.isClient
  ### Data Contexts ###
  Template.body.helpers
    parentContext: ->
      name: "Parent context"

  Template.parentTemplate.helpers
    enclosingTemplateContext: ->
      name: "Enclosing template context"

  Template.childTemplate.helpers
    nestedContext: ->
      name: "Nested context"

    doubleNestedContext: ->
      name: "Double nested context"

  ### Template methods ###
  Template.parentTemplate.created = ->
    @name = "Parent template instance"

  Template.childTemplate.created = ->
    @name = "Child template instance"

  Template.childTemplate.rendered = ->
    $('ul').click()
    
  ### Template helpers ###
  Template.childTemplate.helpers
    currentData: ->
      Template.currentData().name

    instanceData: ->
      Template.instance().data.name

    parentData0: ->
      Template.parentData(0).name

    parentData1: ->
      Template.parentData().name

    parentData2: ->
      Template.parentData(2)?.name

    instance: ->
      Template.instance().name

    parentInstance: ->
      Template.instance().view.parentView.parentView.templateInstance?().name

  ### Event handlers ###
  Template.childTemplate.events
    'click ul': (event, template) ->
      $ul = $(event.target)

      $ul.find('.this span').text(@name)
      $ul.find('.template-data span').text(template.data.name)
      $ul.find('.instance-data span').text(Template.instance().data.name)
      $ul.find('.current-data span').text(Template.currentData().name)
      $ul.find('.parent-data-0 span').text(Template.parentData(0).name)
      $ul.find('.parent-data-1 span').text(Template.parentData().name)
      $ul.find('.parent-data-2 span').text(Template.parentData(2)?.name)
      $ul.find('.template span').text(template.name)
      $ul.find('.instance span').text(Template.instance().name)
      $ul.find('.parent-instance span').text(Template.instance().view.parentView.parentView.templateInstance?().name)
