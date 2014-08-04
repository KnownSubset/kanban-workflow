SelectComponent = Ember.Component.extend({
  classNames:         'ember-select'
  classNameBindings: ['showDropdown:open', 'isButton:btn', 'isButton:btn-default']
  prompt:             'Select a Value'
  filteredContent: []
  content:    []
  multiple: false
  model: []
  selections: Em.A([])
  query:      ''
  isButton: false
  isSelect: true
  showDropdown: false
  dropdownHeight: 50

  selection: ( ->
    if @get('multiple') then @get('selections') else @get('selections.firstObject')
  ).observes('selections')

  init: ->
    @_super()
    optionTemplate = @get('optionTemplate')
    selectedOptionTemplate = @get('selectedOptionTemplate')
    template = """<div class='ember-select-container input-group '>
                    <div class="select-choice form-control">
                      {{#each selections}}
                        {{#{selectedOptionTemplate} model=this}}
                      {{else}}
                        <span class='text-muted'>{{prompt}}</span>
                      {{/each}}
                    </div>
                    <span class="input-group-addon dropdown-toggle" {{action 'toggleDropdown'}}>
                      <i class="fa fa-caret-square-o-down fa-fw"></i>
                    </span>
                  </div>
                  {{#if showDropdown}}
                    <div class='dropdown-menu'>
                      {{input type='text' value=query class='select-search' placeholder='Search for ...' }}
                      <div class='select-elements'>
                        {{#each filteredContent}}
                          <div class='select-item select-element' {{action 'selected' this}} > {{#{optionTemplate} model=this}}</div>
                        {{else}}
                          <span>No results match '{{query}}'</span>
                        {{/each}}
                      </div>
                    </div>
                  {{/if}}
                """
    @set('layout', Ember.Handlebars.compile(template))
    Em.run.later( => @set('query', null))

  dropDownStyle: Ember.computed( ->
    height = Math.min @get('height'), @get('totalHeight')
    "height: #{height}px"
  ).property('height', 'totalHeight')

  setFilteredContent: ( ->
    query = @get('query') || ''
    selection = @get('selections') || []
    Ember.RSVP.Promise.resolve(@get('model')).then (content) =>
      content = if Ember.isArray(content) then content else []
      filteredContent = content.filter((item) => @matcher(query, item)).reject( (item) -> selection.contains(item))
      @set('filteredContent', filteredContent)
  ).observes('query', 'model', 'selections.@each')

  matcher: (searchText, item) ->
    return true unless searchText?
    escapedSearchText = searchText.trim().replace(/[-[\]{}()*+?.,\\^$|#\s]/g, "\\$&")
    searchField = Ember.get(this, 'searchField')
    searchText = if Ember.isBlank(searchField) then item.toString() else Ember.get(item, searchField)
    new RegExp(escapedSearchText, 'i').test(searchText)

  actions: {
    toggleDropdown: ->
      @toggleProperty('showDropdown')
      false

    removeSelectedOption: (option) ->
      @get('selection').removeObject(option)
      false

    selected: (selection) ->
      selections = this.get('selections')
      if (not selections?)
        selections = @set('selections', []).get('selections')
      unless @get('multiple') or Ember.isBlank(selections)
        selections.replace(0, 1, [selection])
      else
        selections.addObject(selection)
      @set('showDropdown', false)
  }
})

`export default SelectComponent`