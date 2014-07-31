`import OrganizationAdapter from 'appkit/adapters/organization-adapter'`
`import { test, moduleFor } from 'ember-qunit'`

moduleFor("adapter:organization-adapter", "{{adapter:organization-adapter}}", {})

test('sending an alert to the application controller will add it into the collection of alerts', ()->
  adapter = this.subject({})

  ok(adapter)
  ok(adapter instanceof DS.RESTAdapter)
  ok(adapter instanceof OrganizationAdapter)
  equal(adapter.get('host'), ENV.organization_api)
  ok(adapter.get('corsWithCredentials'))
)
