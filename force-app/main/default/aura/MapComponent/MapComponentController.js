(
	{
		doInit : function (component, event, helper) {

			helper.showSpinner(component);
			helper.getDataAndFillMap(component);
		},

		handleIsReversedDirectionChange : function (component, event, helper) {

			helper.showSpinner(component);
			helper.reverseDirection(component);
		},
	}
)