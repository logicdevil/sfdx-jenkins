(
	{
		setStyleProperty : function (document, elementId, propertyName, propertyValue) {

			var element = document.getElementById(elementId);
			element.style.setProperty(propertyName, propertyValue);
		},

		removeClass : function (document, elementId, className) {

			var element = document.getElementById(elementId);
			element.classList.remove(className);
		},

		addClass : function (document, elementId, className) {

			var element = document.getElementById(elementId);
			element.classList.add(className);
		},

		hideSpinner : function (component) {
			component.set('v.showSpinner', false);
		},

		handleErrorResponse : function (component, errors) {

			var errorMessage;

			if (errors && errors[0] && errors[0].message) {
				errorMessage = errors[0].message;
			} else {
				errorMessage = $A.get('$Label.c.Unhandled_Error') + ' ' + $A.get('$Label.c.Contact_Administrator');
			}

			component.set('v.errorMessage', errorMessage);
		},

		serverAction : function (component, method, params) {

			var self = this;
			return new Promise(function (resolve, reject) {
				var action = component.get('c.' + method);

				if (params != null) {
					if (params.constructor === String) {
						action.setParams(JSON.parse(params));
					} else {
						action.setParams(params)
					}
				}

				action.setCallback(self, function (response) {
					var state = response.getState();

					if (state === 'SUCCESS') {
						resolve.call(this, response.getReturnValue());
					}
					else {
						reject.call(this, response.getError());
					}
				});

				$A.enqueueAction(action);
			});
		},
	}
)