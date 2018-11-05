(
	{
		doInit : function (component, event, helper) {

			helper.clearErrorMessage(component);
			console.log('test');

			Promise.all([
				helper.serverAction(component, 'getTomTomApiKey'),
				helper.serverAction(component, 'getRecordCoordinates', '{ "recordId": "' + component.get('v.recordId') + '" }'),
				helper.serverAction(component, 'getUserCoordinates')
			]).then(function (results) {
				if (component.isValid()) {
					helper.hideSpinner(component);
					var map = helper.initMap(component, helper, results[0]);
					helper.fillMap(component, map, results[0], results[2], results[1]);
				}
			}).catch(function (errors) {
				if (component.isValid()) {
					helper.hideSpinner(component);
					helper.handleErrorResponse(component, errors);
					console.log('Errors: ' + errors.toString());
				}
			});
		}
	}
)