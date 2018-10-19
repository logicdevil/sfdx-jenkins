(
	{
		initMap : function (component, helper) {

			tomtom.setProductInfo('DEMO APP', '0.1');
			var map = tomtom.L.map('TomTomMap', {
				key : 'UtXjjBSIUvug0YMhA5yxybuc43NdB1iA'
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

		fillMap : function (component, map) {
			const self = this;

			tomtom.routingKey('UtXjjBSIUvug0YMhA5yxybuc43NdB1iA');
			tomtom.routing({
				traffic : false
			}).locations('50.435795,30.500176:50.449885,30.490941')
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

		getTomTomApiKey : function (component) {

			var action = component.get('c.getTomTomApiKey');
			action.setCallback(this, function (response) {
				if (response.getState() === 'SUCCESS') {

				} else {
					this.handleErrorResponse(component, response);
				}
			})
		},

		handleErrorResponse : function (component, response) {

			var errorMessage;
			var errors = response.getError();

			if (errors && errors[0] && errors[0].message) {
				errorMessage = errors[0].message;
			} else {
				errorMessage = $A.get('$Label.c.Unhandled_Error') + ' ' + $A.get('$Label.c.Contact_Administrator');
			}

			component.set('v.errorMessage', errorMessage);
		},

		clearErrorMessage : function (component) {
			component.set('v.errorMessage', null);
		}
	}
)