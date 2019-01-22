(
	{
		doInit : function (component, event, helper) {

			component.set("v.droppedRecords", []);
			Promise.all([
				helper.serverAction(component, 'getRecordsMap', '{"sObjectName":"Account"}')
			]).then(function (results) {
				if (component.isValid()) {
					component.set('v.recordsByIds', results[0]);
					component.set('v.records', Object.values(results[0]));
					helper.hideSpinner(component);
				}
			}).catch(function (errors) {
				if (component.isValid()) {
					helper.handleErrorResponse(component, errors);
					console.log('Errors: ' + errors.toString());
					helper.hideSpinner(component);
				}
			});
		},

		handleDrop : function (component, event, helper) {

			event.preventDefault();

			var droppedRecords = component.get("v.droppedRecords");
			var recordsByIds = component.get("v.recordsByIds");
			var recordId = component.get("v.pickedRecordId");
			droppedRecords.push(recordsByIds[recordId]);
			component.set("v.droppedRecords", droppedRecords);
			helper.setStyleProperty(document, 'drop_zone', 'border', 'none');
		},

		handleDragOver : function (component, event, helper) {

			event.preventDefault();
			helper.setStyleProperty(document, 'drop_zone', 'border', '2px solid red');
		},

		handleDragStart : function (component, event, helper) {

			component.set("v.pickedRecordId", event.target.id);
			helper.setStyleProperty(document, event.target.id, 'background-color', 'rgba(0, 220, 0, 0.4)');
		},

		handleDragLeave : function (component, event, helper) {

			event.preventDefault();
			helper.setStyleProperty(document, 'drop_zone', 'border', 'none');
		},

		handleDragEnd : function (component, event, helper) {

			event.preventDefault();
			helper.setStyleProperty(document, event.target.id, 'background-color', 'unset');
		},
	}
)