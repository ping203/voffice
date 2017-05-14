/// <reference path="/assets/admin/libs/angular/angular.js" />
(function () {
    angular.module('VOfficeApp.meetingRoom', ['VOfficeApp.common', 'angular-search-and-select', 'ngMaterial'])
            .config(config);

    config.$inject = ['$stateProvider', '$urlRouterProvider'];
   

    function config($stateProvider, $urlRouterProvider) {
        $stateProvider
            .state('meetingRoom', {
                url: "/meetingroom",
                parent: 'base',
                templateUrl: "app/components/category/meetingroom/meetingRoomListView.html",
                controller: "meetingRoomListController"
            }).state('add_edit_meetingroom', {
                url: "/add_edit_meetingroom/:id",
                parent: 'base',
                templateUrl: "app/components/category/meetingroom/meetingRoomAddOrEditView.html",
                controller: "meetingRoomAddOrEditController"
            });
    }
})()