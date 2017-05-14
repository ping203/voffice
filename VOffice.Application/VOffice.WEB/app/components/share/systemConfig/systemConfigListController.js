(function (app) {
    app.controller('systemConfigListController', systemConfigListController);
    app.controller('ModalInstanceCtrl', ModalInstanceCtrl)

    ModalInstanceCtrl.$inject = ['$uibModalInstance','$rootScope','apiService' ,'notificationService', 'systemConfig'];
    systemConfigListController.$inject = ['$scope',
        'apiService',
        'notificationService',
        'focus',
        '$ngBootbox',
        '$stateParams',
        '$uibModal',
        '$rootScope'];

    function ModalInstanceCtrl($uibModalInstance,$rootScope, apiService, notificationService, systemConfig) {
        var $ctrl = this;
        var accType = 1;
        if (accType == 1) {
            urlAPI = "SystemConfigDepartment";
            urlAPILoadItem = "";
        }
        else {
            urlAPI = "SystemConfig";
        }
        if (systemConfig != null) {
            $ctrl.systemConfig = systemConfig;
        } else {
            $ctrl.systemConfig = {};
        }
        

        function save() {
            $ctrl.systemConfig.DepartmentId = 3;
            $ctrl.systemConfig.ConfigId = 1002;
            $ctrl.systemConfig.deleted = false;
            $ctrl.systemConfig.createdOn = new Date();
            $ctrl.systemConfig.createdBy = "c8df8541-be47-4a62-b217-e4da7bf89f7a";
            $ctrl.systemConfig.editedOn = new Date();
            $ctrl.systemConfig.editedBy = "c8df8541-be47-4a62-b217-e4da7bf89f7a";            
            if ($ctrl.systemConfig.id == null) {
                AddSystemConfig();
            }
            else {
                UpdateSystemConfig();
            }
        }

        function UpdateSystemConfig() {
            
            apiService.put($rootScope.baseUrl + 'api/' + urlAPI + '/Update', $ctrl.systemConfig,
                function (result) {
                    if (!result.data.isValid) {
                        angular.forEach(result.data.brokenRules, function (value, key) {
                            notificationService.displayError(value.rule);
                        });
                        return;
                    }
                    notificationService.displaySuccess('Cập nhật thành công ');
                     
                }, function (error) {
                    notificationService.displayError('Cập nhật không thành công');
                });
        }

        function AddSystemConfig() {
            console.log($ctrl.systemConfig);
            apiService.post($rootScope.baseUrl + 'api/' + urlAPI + '/Add', $ctrl.systemConfig,
                function (result) {
                    if (!result.data.isValid) {
                        angular.forEach(result.data.brokenRules, function (value, key) {
                            notificationService.displayError(value.rule);
                            console.log(value.rule);
                        });
                        return;
                    }
                    notificationService.displaySuccess('Thêm mới thành công ' + result.data.value.title);
                     
                    
                }, function (error) {
                    notificationService.displayError('Thêm mới không thành công');
                });
        }

        $ctrl.arrTypes = [{ name: 'Text', value: 0 }, { name: 'PassWord', value: 1 }];
        $ctrl.ok = function () {
            save();
            $uibModalInstance.close({});
        };

        $ctrl.cancel = function () {
            $uibModalInstance.dismiss('cancel');
        };
    }


    function systemConfigListController($scope,
                                    apiService,
                                    notificationService,
                                    focus,
                                    $ngBootbox,
                                    $stateParams,
                                    $uibModal,
                                    $rootScope) {

        $scope.listItem = [];
        $scope.page = 0;
        $scope.keyword = '';
        $scope.pagesCount = 0;
        $scope.getListSystemConfig = getListSystemConfig;
        $scope.search = search;
        $scope.deleteSystemConfig = deleteSystemConfig;
        $scope.systemConfig = {};
        //$scope.save = save;
        var accType = 1;
        var urlAPI = "";
        var urlAPILoadItem = "";
        if (accType == 1) {
            urlAPI = "SystemConfigDepartment";
            urlAPILoadItem = "";
        }
        else {
            urlAPI = "SystemConfig";
        }
        $scope.open = function (systemConfig) {
            var modalInstance = $uibModal.open({
                ariaLabelledBy: 'modal-title',
                ariaDescribedBy: 'modal-body',
                templateUrl: 'systemConfigAddOrEdit.html',
                controller: 'ModalInstanceCtrl',
                controllerAs: '$ctrl',
                backdrop: 'static',
                keyboard: false,
                resolve: {
                    systemConfig: function () {
                        return systemConfig;
                    }
                }
            })
        }

        function deleteSystemConfig(id) {
            $ngBootbox.confirm('Bạn có muốn xóa bản ghi này không')
                                .then(function () {
                                    apiService.put($rootScope.baseUrl + 'api/SystemConfig/DeleteLogical/' + id, null, function (result) {
                                        if (result.data.isSuccess) {
                                            notificationService.displaySuccess('Xóa thành công');
                                            search();
                                        }
                                        else {
                                            notificationService.displayError(result.data.message);
                                        }
                                    },
                                     function () {
                                         notificationService.displayError('Xóa không thành công');
                                     })
                                });
        }

        function search(page) {
            getListSystemConfig(page);
        }

        function getListSystemConfig(page) {
            var config = {
                params: {
                    Keyword: $scope.keyword,
                    PageSize: 10,
                    PageNumber: page,
                    DepartmentID: 3
                }
            }

            apiService.get($rootScope.baseUrl + 'api/' + urlAPI + '/Search', config, function (result) {
                if (result.data.isSuccess == false)
                    notificationService.displayError(result.message);
                if (result.data.totalItems == 0)
                    notificationService.displayError("Không tìm thấy bản ghi nào");
                //console.log($scope.listItem);
                $scope.listItem = result.data.data;
                $scope.page = result.data.pageNumber;
                $scope.pagesCount = result.data.pagesCount;
                $scope.totalCount = result.data.totalItems;
                $scope.totalItems = result.data.totalItems;
                $scope.currentPage = result.data.pageNumber;
                $scope.recordsPerPage = config.params.PageSize;
            }, function () {
                console.log('Load systemconfig Failed');
            });
        }
        $scope.getListSystemConfig();

        $scope.resetForm = function () {
            $scope.systemConfig = {};
            $scope.systemConfig.type = { 'name': 'Text', 'value': 0 };
            $scope.systemConfig.active = true;
            $scope.systemConfig.allowClientEdit = true;
        }

        $scope.loadSystemConfig = function (item) {
            apiService.get($rootScope.baseUrl + 'api/' + urlAPI + '/GetAll', null,
                function (result) {
                    $scope.systemConfig = result.data.value;
                    $scope.systemConfig.type = { 'name': $scope.systemConfig.type == 0 ? 'Text' : "PassWord", 'value': $scope.systemConfig.type };
                    console.log("Type of item is: " + $scope.systemConfig.type);
                },
                function (error) {
                    notificationService.displayError('Không có dữ liệu');
                    console.log(error);
                })
        }
    }
})(angular.module('VOfficeApp.systemConfig'));




