(
	{
		doInit : function (component, event, helper) {

			/*Promise.all([
				self.serverAction(component, 'getRouteFor')
			]).then(function (results) {
				if (component.isValid()) {
					self.hideSpinner(component);
				}
			}).catch(function (errors) {
				if (component.isValid()) {
					self.handleErrorResponse(component, errors);
					console.log('Errors: ' + errors.toString());
					self.hideSpinner(component);
				}
			});*/
		},

		handleDrop : function (component, event, helper) {
			event.preventDefault();
			console.log('handleDrop');
			component.set('v.Test', 'ADASFASFSASDDASD');
		},

		handleDragOver : function (component, event, helper) {
			event.preventDefault();
			console.log('handleDragOver');
			var dropZone = document.getElementById('drop_zone');
			dropZone.style.setProperty('border', '2px solid red');
		},

		handleDragStart : function (component, event, helper) {
			console.log('handleDragExit');
		},
	}
)