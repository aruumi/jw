var TuiGridUtility = new Object();

TuiGridUtility.getWhetherCreatedRows = function(gridInstance, rowKey) {
	var createRowList = gridInstance.getModifiedRows().createdRows;
	var isCreatedRow = false;
	$.each(createRowList, function(i, iv) {
		if(iv.rowKey == rowKey) {
			isCreatedRow = true;
		}
	});

	return isCreatedRow;
}


TuiGridUtility.selectOptionFormatter = function(selectOptions, props) {
	var result = "";
	$.each(selectOptions, function(i, iv) {
		if(props.value == iv.value) {
			result = iv.text;
		}
	});

	return result;
}

TuiGridUtility.getImageRenderer = function(props) {
	var el = document.createElement('img');
	el.className = 'datagrid_image'
	el.onerror = function(d) { el.src = replaceSrc; }

    this.getElement = function() {
    	return el;
	};

  	this.render = function(props) {
  		var imageSrc = props.columnInfo.renderer.options.getImageUrl(props);;
  		if(imageSrc != null) { el.src = imageSrc; }
	};
		
	this.render(props);
};