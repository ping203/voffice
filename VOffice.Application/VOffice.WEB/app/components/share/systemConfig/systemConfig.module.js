/// <reference path="/assets/admin/libs/angular/angular.js" />
(function () {
    angular.module('VOfficeApp.systemConfig', ['VOfficeApp.common'])
            .config(config);

    config.$inject = ['$stateProvider', '$urlRouterProvider'];

    function config($stateProvider, $urlRouterProvider) {
        $stateProvider
            .state('systemConfig', {
                url: "/systemConfig/",
                parent: 'base',
                templateUrl: "app/components/share/sysTemConfig/systemConfigListView.html",
                controller: "systemConfigListController",
                params: {
                    currentPage: null,
                    keyword: null
                }
            });
    }
})();
