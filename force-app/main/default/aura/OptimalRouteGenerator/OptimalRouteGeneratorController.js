(
	{
		doInit : function (component, event, helper) {


			component.set("v.recordsIds", ["qwe", "asd", "xcv"]);
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

			var droppedRecords = component.get("v.droppedRecords");
			var recordsByIds = component.get("v.recordsByIds");
			var recordId = component.get("v.pickedRecordId");
			droppedRecords.add(recordsByIds[recordId]);
			component.set("v.droppedRecords", droppedRecords);

			var dropZone = document.getElementById('drop_zone');
			dropZone.style.setProperty('border', 'none');
		},

		handleDragOver : function (component, event, helper) {

			event.preventDefault();

			var dropZone = document.getElementById('drop_zone');
			dropZone.style.setProperty('border', '2px solid red');
		},

		handleDragStart : function (component, event, helper) {

			component.set("v.pickedRecordId", event.target.id);
		},

		handleDragLeave : function (component, event, helper) {

			event.preventDefault();

			var dropZone = document.getElementById('drop_zone');
			dropZone.style.setProperty('border', 'none');
		},
	}
)