exports = {}

exports.displayFailureAlert = (error) =>
  @send('alert', {type: 'error', message: error.get('message')})

`export default exports`