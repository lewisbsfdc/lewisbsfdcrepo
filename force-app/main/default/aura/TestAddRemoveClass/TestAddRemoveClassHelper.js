({
	navigateTo : function(ret) {
        console.log('navigate to ret->', ret);
		var loc = '/lightning/r/Fuzzy_Lead__c/' + ret + '/view';
        window.open(loc,'_blank');
	}
})