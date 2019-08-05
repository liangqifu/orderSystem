
$(function () {
    template.helper('obj2Str', function (val) {
        return JSON.stringify(val);
    });
    template.helper('convertOrderType', function (val) {
    	if(val && val !=''){
    		return $.i18n.prop('order-type-'+val);
    	}else{
    		return '';
    	}
        
    });
    template.helper('convertOrderStatus', function (val) {
    	if(val && val !=''){
    		return $.i18n.prop('order-status-'+val);
    	}else{
    		return '';
    	}
    });
    template.helper('convertOrderRound', function (val) {
    	if(val && val !=''){
    		return $.format($.i18n.prop('order-round'), val);
    	}else{
    		return '';
    	}
    });
    
    template.helper('convertOrderDrinks', function () {
    	return $.i18n.prop('order-drinks-detail');
    });
    
    template.helper('formatDateTime', function (val) {
    	if(val && val !=''){
    		return jQuery.formatDateTime('yy-mm-dd hh:ii', new Date(val))
    	}else{
    		return '';
    	}
    });
    
    template.helper('convertProductStatus', function (val) {
    	if(val && val !=''){
    		return $.i18n.prop('product-status-'+val);
    	}else{
    		return '';
    	}
    });
    
    template.helper('convertProductType', function (val) {
    	if(val && val !=''){
    		return $.i18n.prop('product-type-'+val);
    	}else{
    		return '';
    	}
    });
    
    
    template.helper('convertPrinterStatus', function (val) {
    	if(val && val !=''){
    		return $.i18n.prop('printerForm-status-'+val);
    	}else{
    		return '';
    	}
    });
    
    template.helper('convertPrinterOnLine', function (val) {
    	if(val && val !=''){
    		return $.i18n.prop('printerForm-onLine-'+val);
    	}else{
    		return '';
    	}
    });
    
    
    template.helper('convertCategoryPrintType', function (val) {
    	if(val && val !=''){
    		return $.i18n.prop('category-printType-'+val);
    	}else{
    		return '';
    	}
    });
    
    
    
    
});
$.format = function(source, params) {
	if (arguments.length == 1)
		return function() {
			var args = $.makeArray(arguments);
			args.unshift(source);
			return $.format.apply(this, args);
		};
	if (arguments.length > 2 && params.constructor != Array) {
		params = $.makeArray(arguments).slice(1);
	}
	if (params.constructor != Array) {
		params = [ params ];
	}
	$.each(params, function(i, n) {
		source = source.replace(new RegExp("\\{" + i + "\\}", "g"), n);
	});
	return source;
}; 