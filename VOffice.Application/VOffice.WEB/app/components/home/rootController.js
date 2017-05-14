 

(function (app) {
    app.controller('rootController', rootController);

    rootController.$inject = ['$rootScope','$state', 'authData', 'loginService', '$scope', 'authenticationService'];

    function rootController($rootScope, $state, authData, loginService, $scope, authenticationService) {
        $rootScope.baseUrl = 'http://localhost:8888/';
        $scope.logOut = function () {
            loginService.logOut();
            $state.go('login');
        }
        $scope.authentication = authData.authenticationData;

        //authenticationService.validateRequest();
    }
})(angular.module('VOfficeApp'));