/// <reference path="/assets/admin/libs/angular/angular.js" />
(function () {
    angular.module('VOfficeApp.documentType', ['VOfficeApp.common'])
            .config(config);

    config.$inject = ['$stateProvider', '$urlRouterProvider'];

    function config($stateProvider, $urlRouterProvider) {
        $stateProvider.state('documentType', {
            url: "/documentType",
            parent: 'base',
            templateUrl: "app/components/document/documentType/documentTypeListView.html",
            controller: "documentTypeListController",
            params: {
                currentPage: null,
                keyword: null
            }
        }).state('add_edit_documentType', {
            url: "/add_edit_documentType",
            parent: 'base',
            templateUrl: "app/components/document/documentType/documentTypeAddOrEditView.html",
            controller: "documentTypeAddOrEditController",
            params: {
                id:null,
                currentPage: null,
                keyword: null
            }
        });
    }
})();
