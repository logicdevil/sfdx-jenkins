(
	{
		handleReverseDirection : function (component, event, helper) {
			var isReversedDirection = component.get('v.isReversedDirection');
			component.set('v.isReversedDirection', !isReversedDirection);
			helper.highlightChangedData(component, document);
		},
	}
)