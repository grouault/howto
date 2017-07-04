    
    module.filter("shouldShowAgence", function(){
        return function(agences) {
            var filtered = [];
            console.log('test out');
            angular.forEach(agences, function (agence) {
                console.log('test');
                if (agence.nom !== 'CCE') {
                    filtered.push(agence);
                }
            });
            return filtered;
        };
    })
    
