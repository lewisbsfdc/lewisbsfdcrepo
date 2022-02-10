({
	removeClass : function(cmp, str, cls) {
		console.log('removeClass str->', str);
		var lc = cmp.find(str);
		$A.util.removeClass(lc, cls);
		
	},

	addClass : function(cmp, str, cls) {
		console.log('addClass str->', str);
		var lc = cmp.find(str);
		$A.util.addClass(lc, cls);
		
	}


})