(
	{
		initMap : function (component, helper, apiKey) {

			tomtom.setProductInfo('DEMO APP', '0.1');
			var map = tomtom.L.map('TomTomMap', {
				key : apiKey	//'UtXjjBSIUvug0YMhA5yxybuc43NdB1iA'
			});
			return map;
		},

		addMarkers : function (component, map, feature) {

			var endIcon = tomtom.L.icon({
				iconUrl : component.get('v.startIcon'),
				iconSize : [30, 30],
				iconAnchor : [15, 15]
			});
			var startIcon = tomtom.L.icon({
				iconUrl : component.get('v.endIcon'),
				iconSize : [30, 30],
				iconAnchor : [15, 15]
			});
			var startPoint, endPoint;

			if (feature.geometry.type === 'MultiLineString') {
				startPoint = feature.geometry.coordinates[0][0].reverse(); //get first point from first line
				endPoint = feature.geometry.coordinates.slice(-1)[0].slice(-1)[0].reverse(); //get last point from last line
			} else {
				startPoint = feature.geometry.coordinates[0].reverse();
				endPoint = feature.geometry.coordinates.slice(-1)[0].reverse();
			}
			tomtom.L.marker(startPoint, {icon : startIcon}).addTo(map);
			tomtom.L.marker(endPoint, {icon : endIcon}).addTo(map);
		},

		fillMap : function (component, map, apiKey, startCoordinates, endCoordinates) {

			const self = this;
			tomtom.routingKey(apiKey);
			tomtom.routing({
				traffic : false
			}).locations(startCoordinates + ':' + endCoordinates)
				.go().then(function (routeJson) {
				var route = tomtom.L.geoJson(routeJson, {
					onEachFeature : function (feature) {
						self.addMarkers.call(this, component, map, feature);
					},
					style : {color : 'red', opacity : 0.8}
				}).addTo(map);
				map.fitBounds(route.getBounds(), {padding : [5, 5]});
			});
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

		clearErrorMessage : function (component) {
			component.set('v.errorMessage', '');
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

		hideSpinner : function (component) {
			component.set('v.showSpinner', false);
		}
	}
)