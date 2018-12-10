(
	{
		getDataAndFillMap : function (component) {

			var self = this;
			self.clearErrorMessage(component);

			Promise.all([
				self.serverAction(component, 'getTomTomApiKey'),
				self.serverAction(component, 'getRecordCoordinates', '{ "recordId": "' + component.get('v.recordId') + '" }'),
				self.serverAction(component, 'getUserCoordinates'),
				self.serverAction(component, 'getRecordName', '{ "recordId": "' + component.get('v.recordId') + '" }')
			]).then(function (results) {
				if (component.isValid()) {
					self.hideSpinner(component);

					var map = component.get('v.map');
					if (!map) {
						map = self.initMap(component, self, results[0]);
						component.set('v.map', map);
					}

					var routeInformation = {};
					routeInformation.recordCoordinates = results[1];
					routeInformation.userCoordinates = results[2];
					routeInformation.recordName = results[3];
					component.set('v.routeInformation', routeInformation);

					self.fillMap(component, map, results[0], routeInformation.userCoordinates, routeInformation.recordCoordinates);
					component.set('v.directionInformation', self.getDirectionInformation(component));
				}
			}).catch(function (errors) {
				if (component.isValid()) {
					self.hideSpinner(component);
					self.handleErrorResponse(component, errors);
					console.log('Errors: ' + errors.toString());
				}
			});
		},

		reverseDirection : function (component) {

			var self = this;
			self.clearErrorMessage(component);

			Promise.all([
				self.serverAction(component, 'getTomTomApiKey')
			]).then(function (results) {
				if (component.isValid()) {

					var routeInformation = component.get('v.routeInformation');
					var map = component.get('v.map');
					if (!map) {
						map = self.initMap(component, self, results[0]);
						component.set('v.map', map);

					}

					if (component.get('v.isReversedDirection')) {		//draw a route for reversed direction
						self.fillMap(component, map, results[0], routeInformation.recordCoordinates, routeInformation.userCoordinates);
					} else {
						self.fillMap(component, map, results[0], routeInformation.userCoordinates, routeInformation.recordCoordinates);
					}

					component.set('v.directionInformation', self.getDirectionInformation(component));
					self.hideSpinner(component);
				}
			}).catch(function (errors) {
				if (component.isValid()) {
					self.handleErrorResponse(component, errors);
					console.log('Errors: ' + errors.toString());
					self.hideSpinner(component);
				}
			});
		},

		initMap : function (component, helper, apiKey) {

			tomtom.setProductInfo('DEMO APP', '0.1');
			var map = tomtom.L.map('TomTomMap', {
				key : apiKey	//'UtXjjBSIUvug0YMhA5yxybuc43NdB1iA'
			});
			return map;
		},

		processRouting : function (component, map, feature, self) {
			self.addMarkers(component, map, feature);
			self.fillRouteInformation(component, map, feature);
		},

		fillRouteInformation : function (component, map, feature) {

			if (component.isValid()) {

				var summary = feature.properties.summary;
				var routeInformation = component.get('v.routeInformation');

				routeInformation.distance = tomtom.unitFormatConverter.formatDistance(summary.lengthInMeters);
				routeInformation.estimatedTravelTime = tomtom.unitFormatConverter.formatTime(summary.travelTimeInSeconds);
				routeInformation.trafficDelay = tomtom.unitFormatConverter.formatTime(summary.trafficDelayInSeconds);

				component.set('v.routeInformation', routeInformation);
			}
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

			tomtom.L.marker(startPoint, {icon : endIcon}).addTo(map);
			tomtom.L.marker(endPoint, {icon : startIcon}).addTo(map);
		},

		fillMap : function (component, map, apiKey, startCoordinates, endCoordinates) {

			const self = this;
			tomtom.routingKey(apiKey);
			tomtom.routing({
				traffic : false
			}).locations(startCoordinates + ':' + endCoordinates)
				.go().then(function (routeJson) {
				var route = tomtom.L.geoJson(routeJson, {		//draw a route
					onEachFeature : function (feature) {
						self.processRouting.call(this, component, map, feature, self);
					},
					style : {color : 'red', opacity : 0.8}
				}).addTo(map);

				var lastRoute = component.get('v.lastRoute');		//if the route was drawn - remove it from the map and draw a new one
				if (lastRoute != null) {
					map.removeLayer(lastRoute);
				}
				component.set('v.lastRoute', route);

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

		getDirectionInformation : function (component) {

			if(component.get('v.isReversedDirection')){
				return 'The route from the address of ' + component.get('v.routeInformation').recordName + ' to your address.';
			} else {
				return 'The route from your address to the address of ' + component.get('v.routeInformation').recordName + '.';
			}
		},

		hideSpinner : function (component) {
			component.set('v.showSpinner', false);
		},

		showSpinner : function (component) {
			component.set('v.showSpinner', true);
		},
	}
)