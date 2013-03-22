if Meteor.isClient
  Template.projects.projects = () ->
    Projects.find {}

  Template.projects.events
    'click a': (event) ->
      event.preventDefault()
      Session.set 'project_id', this._id

  Template.project.show = () ->
    Session.get('project_id')?

  Template.project.project = () ->
    Projects.findOne _id: Session.get('project_id')

  Template.project.rendered = () ->
    project = Template.project.project()

    if Template.project.show() && project?
      graph = new Rickshaw.Graph
        element: this.find('#chart')
        width: 235
        height: 85
        renderer: 'bar'
        series: [
          data: [ { x: 0, y: project.hours }, { x: 1, y: 49 }, { x: 2, y: 38 }, { x: 3, y: 30 }, { x: 4, y: 32 } ],
          color: 'steelblue'
        ]

      graph.render()

if Meteor.isServer
  Meteor.startup () ->
    # code to run on server at startup

Projects = new Meteor.Collection "projects"
