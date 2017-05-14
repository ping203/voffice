/// <reference path="/assets/admin/libs/angular/angular.js" />
(function () {
    angular.module('VOfficeApp.documentSignedBy', ['VOfficeApp.common'])
            .config(config);

    config.$inject = ['$stateProvider', '$urlRouterProvider'];

    function config($stateProvider, $urlRouterProvider) {
        $stateProvider           
            .state('documentSignedBy', {
                url: "/documentsignedby",
                parent:'base',
                templateUrl: "app/components/document/documentsignedby/documentSignedByListView.html",
                controller: "documentSignedByListController"
            }).state('add_edit_documentSignedBy', {
                url: "/add_edit_documentSignedBy/:id",
                parent: 'base',
                templateUrl: "app/components/document/documentsignedby/documentSignedByAddOrEditView.html",
                controller: "documentSignedByAddOrEditController"
            });
    }
})();
