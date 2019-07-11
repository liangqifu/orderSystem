
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
    template.helper('formatDateTime', function (val) {
    	if(val && val !=''){
    		return jQuery.formatDateTime('yy-mm-dd hh:ii', new Date(val))
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