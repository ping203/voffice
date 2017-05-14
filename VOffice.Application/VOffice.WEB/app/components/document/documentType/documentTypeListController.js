(function (app) {
    app.controller('documentTypeListController', documentTypeListController);

    documentTypeListController.$inject = ['$scope',
        'apiService',
        'notificationService',
        'authData',
        '$ngBootbox',
        '$stateParams',
        '$rootScope'];

    function documentTypeListController($scope,
                                    apiService,
                                    notificationService,
                                    authData,
                                    $ngBootbox,
                                    $stateParams,
                                    $rootScope) {        
        $scope.docFileds = [];
        $scope.page = 0;
        $scope.keyword = '';
        $scope.pagesCount = 0;
        $scope.getListDocumentTypes = getListDocumentTypes;
        $scope.search = search;
        $scope.deleteDocumentType = deleteDocumentType;

        function deleteDocumentType(id) {
            $ngBootbox.confirm('Bạn có muốn xóa bản ghi này không')
                                .then(function () {
                                    apiService.put($rootScope.baseUrl + 'api/DocumentType/DeleteLogical/' + id, null, function (result) {
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
            getListDocumentTypes(page);
        }
        function getListDocumentTypes(page) {
            var config = {
                params: {
                    Keyword: $scope.keyword,
                    PageSize: 10,
                    PageNumber: page
                }
            }
            if ($stateParams.currentPage != null) {
                console.log($stateParams.currentPage);
                config.params.PageNumber = $stateParams.currentPage;
                $stateParams.currentPage = null;
            }
            if ($stateParams.keyword != null) {
                console.log($stateParams.keyword);
                config.params.Keyword = $stateParams.keyword;
                $stateParams.keyword = null;
                $scope.keyword = config.params.Keyword;
            }
            apiService.get($rootScope.baseUrl + 'api/DocumentType/Search', config, function (result) {
                if (result.data.isSuccess == false)
                    notificationService.displayError(result.message);
                if (result.data.totalItems == 0)
                    notificationService.displayError("không tìm thấy bản ghi nào");
                $scope.docFileds = result.data.data;
                $scope.page = result.data.pageNumber;
                $scope.pagesCount = result.data.pagesCount;
                $scope.totalCount = result.data.totalItems;
                $scope.totalItems = result.data.totalItems;
                $scope.currentPage = result.data.pageNumber;
                $scope.recordsPerPage = config.params.PageSize;
            }, function () {
                console.log('Load document Failed');
            });
        }
        $scope.getListDocumentTypes()
    }
})(angular.module('VOfficeApp.documentType'));