/// <reference path="/assets/admin/libs/angular/angular.js" />
(function (app) {
    app.controller('documentSignedAddController', documentSignedAddController);
    documentSignedAddController.$inject = ['$scope',
                                      'apiService',
                                      'notificationService',
                                      '$state',
                                      '$stateParams',
                                      '$rootScope', '$element']

    function documentSignedAddController($scope,
                                    apiService,
                                    notificationService,
                                    $state,
                                    $stateParams,
                                    $rootScope,
                                    $element) {
        $scope.docsignee = {};
        $scope.save = save;

        function save() {
            if ($stateParams.id == 0) {
                $scope.docsignee.deleted = false;
                $scope.docsignee.createdOn = new Date();
                $scope.docsignee.createdBy = "7251adb7-9b6b-4cbd-a21f-a6ecee7598b9";
                AddSignee();
            }
            else {
                UpdateSignee();
            }
        }
        function UpdateSignee() {
            apiService.put($rootScope.baseUrl + 'api/AS_DOC_DocumentSignedBy/Update', $scope.docsignee,
                function (result) {
                    if (!result.data.isValid) {
                        angular.forEach(result.data.brokenRules, function (value, key) {
                            notificationService.displayError(value.rule);
                        });
                        return;
                    }
                    notificationService.displaySuccess('Cập nhật thành công ' + result.data.value.name);
                    $state.go('documentSigned');
                }, function (error) {
                    notificationService.displayError('Cập nhật không thành công');
                });
        }

        function AddSignee() {
            apiService.post($rootScope.baseUrl + 'api/DocumentSignedBy/Add', $scope.docsignee,
                function (result) {
                    if (!result.data.isValid) {
                        angular.forEach(result.data.brokenRules, function (value, key) {
                            notificationService.displayError(value.rule); 
                        });
                        return;
                    }
                    notificationService.displaySuccess('Thêm mới thành công ' + result.data.value.name);
                    $state.go('documentSigned');
                }, function (error) {
                    notificationService.displayError('Thêm mới không thành công');
                });
        }

        function loadSignee() {
            apiService.get($rootScope.baseUrl + 'api/DocumentSignedBy/GetAll/' + $stateParams.id, null,
                function (result) {
                    console.log(result.data.value);
                    $scope.docsignee = result.data.value;
                    console.log(result.data.value.receiveddocument);
                },
                function (error) {
                    notificationService.displayError('Không có dữ liệu')
                })
        }
        if ($stateParams.id != 0) {
            loadSignee();
        }

    }
})(angular.module('VOfficeApp.documentSigned'));