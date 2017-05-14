(function (app) {
    app.controller('documentSignedByListController', documentSignedByListController);

    documentSignedByListController.$inject = ['$scope',
        'apiService',
        'notificationService',
        '$ngBootbox',
        '$stateParams',
        '$rootScope'];

    function documentSignedByListController($scope,
                                    apiService,
                                    notificationService,
                                    $ngBootbox,
                                    $stateParams,
                                    $rootScope) {
        $scope.listItem = [];
        $scope.page = 0;
        $scope.keyword = '';
        $scope.documentFormats = [
          { 'id': 0, 'value': 'Tất cả' },
          { 'id': 1, 'value': 'Văn bản đến' },
          { 'id': 2, 'value': 'Văn bản đi' },
        ];
        $scope.documentFormat = { 'id': 0, 'value': 'Tất cả' };

        $scope.pagesCount = 0;
        $scope.getListDocumentSignedBy = getListDocumentSignedBy;
        $scope.search = search;
        $scope.deleteDocmentSignedBy = deleteDocmentSignedBy;

        function deleteDocmentSignedBy(id) {
            $ngBootbox.confirm('Bạn có muốn xóa bản ghi này không')
                                .then(function () {
                                    apiService.put($rootScope.baseUrl + 'api/DocumentSignedBy/DeleteLogical/' + id, null, function (result) {
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
            getListDocumentSignedBy();
        }
        function pageChanged() {
            getListDocumentSignedBy();
        }
        function getListDocumentSignedBy(page) {
            page = page || 0;
            console.log($scope.documentFormat.id);
            var receivedDocument;
            if ($scope.documentFormat.id == '1') {
                receivedDocument = true;
            }
            else {
                if ($scope.documentFormat.id == '2') {
                    receivedDocument = false;
                }
                else {
                    receivedDocument = null;
                }
            }
            var config = {
                params: {
                    keyword: $scope.keyword,
                    receivedDocument: receivedDocument,
                    PageNumber: page,
                    PageSize: 10
                }
            }
            console.log(config);
            apiService.get($rootScope.baseUrl + 'api/DocumentSignedBy/Search', config, function (result) {
                if (result.data.isSuccess == false)
                    notificationService.displayError(result.message);
                if (result.data.totalItems == 0)
                    notificationService.displayError("không tìm thấy bản ghi nào");
                console.log(result.data.data);
                $scope.listItem = result.data.data;
                $scope.page = result.data.pageNumber;
                $scope.pagesCount = result.data.pagesCount;
                $scope.totalCount = result.data.totalItems;
                $scope.totalItems = result.data.totalItems;
                $scope.currentPage = result.data.pageNumber;
                $scope.recordsPerPage = config.params.PageSize;
            }, function () {
                console.log('Loading failure');
            });
        }
        $scope.getListDocumentSignedBy()
    }
})(angular.module('VOfficeApp.documentSignedBy'));