<select name="uagence" id="uagence"
        class="form-control"
        ng-options="agence.nom for agence in agences | filter:shouldShowAgence track by agence.id"
        ng-model="form.agence">    

// initialisation des champs a cacher.
$scope.initializeChampCaches = function () {
    $scope.selAntVisible = true; // champ de selection d'une antenne
    if ($scope.form && 'CA' === $scope.form.role.nom) {
        $scope.selAntVisible = false;
    }
};

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
    
