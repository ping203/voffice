
(function (app) {
    app.controller('documentTypeAddOrEditController', documentTypeAddOrEditController);

    documentTypeAddOrEditController.$inject = ['$scope',
                                      'apiService',
                                      'notificationService',
                                      'focus',
                                      '$state',
                                      '$stateParams',
                                      '$rootScope']

    function documentTypeAddOrEditController($scope,
                                    apiService,
                                    notificationService,
                                    focus,
                                    $state,
                                    $stateParams,
                                    $rootScope) {

        console.log($stateParams);
        if ($stateParams.id == 0) {
            $scope.titleForm = "Thêm mới loại văn bản";
        }
        else {
            $scope.titleForm = "Cập nhật loại văn bản";
        }
        $scope.focusCode=function()
        {
            focus('code');
        }
        $scope.documentType = {};
        $scope.save = save;
        $scope.BindList = BindList;
        function BindList() {
            $state.go('documentType', { currentPage: $stateParams.currentPage, keyword: $stateParams.keyword });
        }
        function save() {
            if ($stateParams.id == 0) {
                $scope.documentType.code = $scope.documentType.code;
                $scope.documentType.title = $scope.documentType.title;
                $scope.documentType.active = $scope.documentType.active;
                $scope.documentType.deleted = 0;
                $scope.documentType.createdOn = new Date();
                $scope.documentType.createdBy = "c8df8541-be47-4a62-b217-e4da7bf89f7a";
                $scope.documentType.editedOn = new Date();
                $scope.documentType.editedBy = "c8df8541-be47-4a62-b217-e4da7bf89f7a";
                console.log($scope.documentType)
                AddDocType();
            }
            else {
                UpdateDocumentType();
            }
        }
        function UpdateDocumentType() {
            apiService.put($rootScope.baseUrl + 'api/DocumentType/Update', $scope.documentType,
                function (result) {
                    if (!result.data.isValid) {
                        angular.forEach(result.data.brokenRules, function (value, key) {
                            notificationService.displayError(value.rule);
                        });
                        return;
                    }
                    notificationService.displaySuccess('Cập nhật thành công ' + result.data.value.title);
                    BindList();
                }, function (error) {
                    notificationService.displayError('Cập nhật không thành công');
                });
        }

        function AddDocType() {
            apiService.post($rootScope.baseUrl + 'api/DocumentType/Add', $scope.documentType,
                function (result) {
                    if (!result.data.isValid) {
                        angular.forEach(result.data.brokenRules, function (value, key) {
                            notificationService.displayError(value.rule);
                        });
                        return;
                    }
                    notificationService.displaySuccess('Thêm mới thành công ' + result.data.value.title);
                    BindList();
                }, function (error) {
                    notificationService.displayError('Thêm mới không thành công');
                });
        }

        function loadDocumentType() {
            apiService.get($rootScope.baseUrl + 'api/DocumentType/Get/' + $stateParams.id, null,
                function (result) {
                    $scope.documentType = result.data.value;
                },
                function (error) {
                    notificationService.displayError('Không có dữ liệu')
                })
        }
        if ($stateParams.id != 0 && $stateParams.id != null) {
            loadDocumentType();
        }

    }
})(angular.module('VOfficeApp.documentType'));