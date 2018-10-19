(
	{
		doInit : function (component, event, helper) {

			//todo add promises to handle logic

			helper.clearErrorMessage(component);
			helper.getTomTomApiKey(component);
			var map = helper.initMap(component);
			helper.fillMap(component, map);
		}
	}
)