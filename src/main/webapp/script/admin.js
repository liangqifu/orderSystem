
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
    
    template.helper('convertOrderService', function () {
    	return $.i18n.prop('order-service-detail');
    });
    
    
    
    template.helper('formatDateTime', function (val) {
    	if(val && val !=''){
    		return jQuery.formatDateTime('dd.mm.yy hh:ii', new Date(val))
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
    
    template.helper('convertProductType', function (val1,val2) {
    	if(val1 =='1' && val2 == '1'){
    		return $.i18n.prop('product-type-1')+','+$.i18n.prop('product-type-2');
    	} else if(val1 =='1' && (val2 == '0' || val2 == '')){
    		return $.i18n.prop('product-type-1');
    	} else if(val2 =='1' && (val1 == '0' || val1 == '')){
    		return $.i18n.prop('product-type-2');
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
    
    template.helper('convertOrderPinterType', function (val) {
    	if(val && val !=''){
    		return $.i18n.prop('order-printType-'+val);
    	}else{
    		return '';
    	}
    });
    
    template.helper('convertOrderPinterStatus', function (val) {
    	if(val && val !=''){
    		return $.i18n.prop('order-print-status-'+val);
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