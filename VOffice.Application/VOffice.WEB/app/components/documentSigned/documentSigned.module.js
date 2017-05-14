/// <reference path="/assets/admin/libs/angular/angular.js" />
(function () {
    angular.module('VOfficeApp.documentSigned', ['VOfficeApp.common'])
            .config(config);

	config.$inject = ['$stateProvider', '$urlRouterProvider'];

	function config($stateProvider, $urlRouterProvider) {
		$stateProvider.state('documentSigned', {
		    url: "/documentSigned",
            parent:"base",
			templateUrl: "app/components/documentSigned/documentSignedListView.html",
			controller: "documentSignListController"
		})
        .state('add_documentSigned', {
            url: "/add_documentSigned/:id",
            parent: "base",
            templateUrl: "app/components/documentSigned/documentSignedAddView.html",
            controller: "documentSignedAddController"
        });
	}
})();
