
(function (app) {
    app.controller('customerAddOrEditController', customerAddOrEditController);
    customerAddOrEditController.$inject = ['$scope',
                                      'apiService',
                                      'notificationService',
                                      'focus',
                                      '$state',
                                      '$stateParams',
                                      '$rootScope']

    function customerAddOrEditController($scope,
                                    apiService,
                                    notificationService,
                                    focus,
                                    $state,
                                    $stateParams,
                                    $rootScope) {
        if ($stateParams.id == 0) {
            $scope.titleForm = "Thêm mới khách hàng";
        }
        else {
            $scope.titleForm = "Cập nhật khách hàng";
        }
        $scope.focusCode = function () {
            focus('code');
        }
        $scope.customer = {};
        $scope.save = save;
        $scope.BindList = BindList;
        function BindList() {
            console.log("edit:" + $stateParams.currentPage);
            $state.go('customer', { currentPage: $stateParams.currentPage, keyword: $stateParams.keyword });
        }
        function save() {
            if ($stateParams.id == 0) {
                $scope.customer.code = $scope.customer.code;
                $scope.customer.title = $scope.customer.title;
                $scope.customer.shortTitle = $scope.customer.shortTitle;
                $scope.customer.order = $scope.customer.order;
                $scope.customer.address = $scope.customer.address;
                $scope.customer.phoneNumber = $scope.customer.phoneNumber;
                $scope.customer.fax = $scope.customer.fax;
                $scope.customer.taxNumber = $scope.customer.taxNumber;
                $scope.customer.bankName = $scope.customer.bankName;
                $scope.customer.active = $scope.customer.active;
                $scope.customer.deleted = 0;
                $scope.customer.bankAccountNumber = $scope.customer.bankAccountNumber;
                $scope.customer.createdOn = new Date();
                $scope.customer.createdBy = "c8df8541-be47-4a62-b217-e4da7bf89f7a";
                $scope.customer.editedOn = new Date();
                $scope.customer.editedBy = "c8df8541-be47-4a62-b217-e4da7bf89f7a";
                AddCustomer();
            }
            else {
                UpdateCustomer();
            }
        }
        function UpdateCustomer() {
            apiService.put($rootScope.baseUrl + 'api/Customer/Update', $scope.customer,
                function (result) {
                    if (!result.data.isValid) {
                        angular.forEach(result.data.brokenRules, function (value, key) {
                            notificationService.displayError(value.rule);
                        });
                        return;
                    }
                    notificationService.displaySuccess('Cập nhật thành công ');
                    BindList();
                    //$state.go('customer', { currentPage: $stateParams.currentPage, keyword: $stateParams.keyword });
                }, function (error) {
                    notificationService.displayError('Cập nhật không thành công');
                });
        }

        function AddCustomer() {
            apiService.post($rootScope.baseUrl + 'api/Customer/Add', $scope.customer,
                function (result) {
                    if (!result.data.isValid) {
                        angular.forEach(result.data.brokenRules, function (value, key) {
                            notificationService.displayError(value.rule);
                        });
                        return;
                    }
                    else {
                        notificationService.displaySuccess('Thêm mới thành công ');
                        BindList();
                        // $state.go('customer', { currentPage: $stateParams.currentPage, keyword: $stateParams.keyword });
                    }
                    console.log(result.data.value);

                }, function (error) {
                    notificationService.displayError('Thêm mới không thành công');
                });
        }

        function loadCustomer() {
            apiService.get($rootScope.baseUrl + 'api/customer/get/' + $stateParams.id, null,
                function (result) {
                    console.log(result.data.value);
                    $scope.customer = result.data.value;
                },
                function (error) {
                    notificationService.displayError('Không có dữ liệu')
                })
        }
        if ($stateParams.id != 0 && $stateParams.id != null) {
            console.log("edit:" + $stateParams.currentPage);
            loadCustomer();
        }

    }
})(angular.module('VOfficeApp.customer'));