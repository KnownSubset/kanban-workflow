`import { test, moduleFor, moduleForComponent, moduleForModel } from 'ember-qunit'`
`import Index from 'appkit/routes/index'`

moduleFor('route:index', "Unit - IndexRoute")

test("it exists", () ->
  ok(this.subject() instanceof Index)
)

test("#model", () ->
  deepEqual(this.subject().model(), ['red', 'yellow', 'blue'])
)
