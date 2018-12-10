(
	{
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