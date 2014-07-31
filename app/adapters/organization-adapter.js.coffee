`import LocalStorageHelper from 'appkit/helpers/local_storage'`

OrganizationAdapter = DS.RESTAdapter.extend({
  corsWithCredentials: true
  host: ENV.organization_api
  ajax: (url, type, hash) ->
    hash = hash || { data: {} }
    hash['data'] = data: {} unless hash['data'] ## had to add this because hash was defined but had no 'data' property defined
    hash.data['format'] = 'json'
    currentUser = LocalStorageHelper.get('current_user')
    if currentUser?
      headers = { 'X-AUTH-TOKEN': currentUser.token }
      hash.beforeSend = (xhr) ->
        Ember.keys(headers).forEach( (key) ->
          xhr.setRequestHeader(key, headers[key])
        )
    @._super(url, type, hash)
})

`export default OrganizationAdapter`
