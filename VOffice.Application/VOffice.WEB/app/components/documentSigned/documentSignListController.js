(function (app) {
    app.controller('documentSignListController', documentSignListController);

    documentSignListController.$inject = ['$scope',
        'apiService',
        'notificationService',
        '$ngBootbox',
        '$stateParams',
        '$rootScope',
        'dateformatService',
        'AutoComplete'];

    function documentSignListController($scope,
                                    apiService,
                                    notificationService,
                                    $ngBootbox,
                                    $stateParams,
                                    $rootScope,
                                    dateformatService,
                                    AutoComplete) {

        $scope.documentsSigned = [];
        $scope.page = 1;
        $scope.keyword = '';
        $scope.pagesCount = 0;
        $scope.getListSignee = getListSignee;
        $scope.search = search;
        $scope.source = [];
        $scope.deletesignee = deletesignee;
        function deletesignee(id) {
            $ngBootbox.confirm('Bạn có muốn xóa bản ghi này không')
                                .then(function () {
                                    apiService.put($rootScope.baseUrl + 'api/AS_DOC_DocumentSignedApi/DeleteLogical/' + id, null, function (result) {
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

        function search() {
            getListSignee();
        }

        function getListSignee(page) {
            page = page || 1;
            var config = {
                params: {
                    keyword: $scope.keyword,
                    PageNumber: page,
                    PageSize: 10,
                    DepartmentId: 3,
                }
            }
            apiService.get($rootScope.baseUrl + 'api/DocumentSignedBy/GetAll', config, function (result) {
                if (result.data.isSuccess == false)
                    notificationService.displayError(result.message);
                if (result.data.totalItems == 0)
                    notificationService.displayError("không tìm thấy bản ghi nào");
                $scope.documentsSigned = result.data.data;
                $scope.source = result.data.data;
                $scope.page = result.data.pageNumber;
                $scope.customListFormatter = function (source) {
                    return '<b>(' + data.id + ')</b><i>' + data.fullName + '</i>';
                };
                $scope.pagesCount = result.data.pagesCount;
                $scope.totalCount = result.data.totalItems;
                $scope.totalItems = result.data.totalItems;
                $scope.currentPage = result.data.pageNumber;
                $scope.recordsPerPage = config.params.PageSize;

            }, function () {
                console.log('Load document Failed');
            });
        }
        $scope.getListSignee()
    }
})(angular.module('VOfficeApp.documentSigned'));