`import ApplicationAdapter from 'appkit/adapters/application'`
`import OrganizationAdapter from 'appkit/adapters/organization-adapter'`

adapter = if Ember.testing then  ApplicationAdapter else OrganizationAdapter.extend({})

`export default adapter`
