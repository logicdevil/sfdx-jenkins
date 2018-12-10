(
	{
		highlightChangedData : function (component, document) {

				var elements = document.getElementsByClassName('need_to_be_highlighted');

				function changeOpacity(elements, oldOpacity, delta) {

					var newOpacity = oldOpacity + delta;
					if(newOpacity > 0.99) {
						setTimeout(changeOpacity, 4, elements, newOpacity, -delta);
						return;
					}
					if(newOpacity < 0.05) {
						setBackgroundOpacity(elements, 0);
						return;
					}
					setBackgroundOpacity(elements, newOpacity);
					setTimeout(changeOpacity, 4, elements, newOpacity, delta);
				}

				function setBackgroundOpacity(elements, opacity) {
					for(var i = 0; i < elements.length; i++) {
						elements[i].style.setProperty('background-color', 'rgba(80, 200, 80,' + opacity + ')');
					}
				}

				if(elements.length !== 0) {
					changeOpacity(elements, 0.06, 0.03);
				}
		},
	}
)