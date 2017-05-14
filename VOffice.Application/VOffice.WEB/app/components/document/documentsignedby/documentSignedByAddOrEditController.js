
(function (app) {
    app.controller('documentSignedByAddOrEditController', documentSignedByAddOrEditController);

    documentSignedByAddOrEditController.$inject = ['$scope',
                                      'apiService',
                                      'focus',
                                      'notificationService',
                                      '$state',
                                      '$stateParams',
                                      '$rootScope']

    function documentSignedByAddOrEditController($scope,
                                    apiService,
                                    focus,
                                    notificationService,
                                    $state,
                                    $stateParams,
                                    $rootScope) {
        $scope.documentSignedBy = {};
        $scope.save = save;
        $scope.focusFullName = function () {
            focus('fullName');
        }
        function save() {
            if ($stateParams.id == 0) {
                $scope.documentSignedBy.deleted = false;
                $scope.documentSignedBy.active = true;
                $scope.documentSignedBy.departmentId = 1;
                $scope.documentSignedBy.createdOn = new Date();
                $scope.documentSignedBy.createdBy = "c8df8541-be47-4a62-b217-e4da7bf89f7a";
                $scope.documentSignedBy.editedOn = new Date();
                $scope.documentSignedBy.editedBy = "c8df8541-be47-4a62-b217-e4da7bf89f7a";
                AddDocumentSignedBy();
            }
            else {
                UpdateDocumentSignedBy();
            }
        }
        function UpdateDocumentSignedBy() {
            apiService.put($rootScope.baseUrl + 'api/DocumentSignedBy/Update', $scope.documentSignedBy,
                function (result) {
                    if (!result.data.isValid) {
                        angular.forEach(result.data.brokenRules, function (value, key) {
                            notificationService.displayError(value.rule);
                        });
                        return;
                    }
                    notificationService.displaySuccess('Cập nhật thành công ' + result.data.value.fullName);
                    $state.go('documentSignedBy');
                }, function (error) {
                    notificationService.displayError('Cập nhật không thành công');
                });
        }

        function AddDocumentSignedBy() {
            apiService.post($rootScope.baseUrl + 'api/DocumentSignedBy/Add', $scope.documentSignedBy,
                function (result) {
                    if (!result.data.isValid) {
                        angular.forEach(result.data.brokenRules, function (value, key) {
                            notificationService.displayError(value.rule);
                        });
                        return;
                    }
                    console.log(result.data.value);
                    notificationService.displaySuccess('Thêm mới thành công ' + result.data.value.fullName);
                    $state.go('documentSignedBy');
                }, function (error) {
                    notificationService.displayError('Thêm mới không thành công');
                });
        }

        function loadDocumentSignedBy() {
            apiService.get($rootScope.baseUrl + 'api/DocumentSignedBy/get/' + $stateParams.id, null,
                function (result) {
                    console.log(result.data.value);
                    $scope.documentSignedBy = result.data.value;
                },
                function (error) {
                    notificationService.displayError('Không có dữ liệu')
                })
        }
        if ($stateParams.id != 0) {
            loadDocumentSignedBy();
        }
        
    }
})(angular.module('VOfficeApp.documentSignedBy'));