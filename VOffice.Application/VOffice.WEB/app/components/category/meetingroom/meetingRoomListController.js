(function (app) {
    app.controller('meetingRoomListController', meetingRoomListController);

    meetingRoomListController.$inject = ['$scope',
        'apiService',
        'notificationService',
        '$ngBootbox',
        '$stateParams',
        '$rootScope',
        '$element'];

    function meetingRoomListController($scope,
                                    apiService,
                                    notificationService,
                                    $ngBootbox,
                                    $stateParams,
                                    $rootScope,
                                    $element) {
        $scope.vegetables = [{ "Key": "Công ty CPĐT&PT Công nghệ Văn Lang", "Value": "3" }, { "Key": "NXBGD Hà Nội", "Value": "2" }, { "Key": "Cơ quan văn phòng", "Value": "0" }];

        $scope.searchTerm;
        $scope.selectedVegetables = [];
        $scope.clearSearchTerm = function () {
            $scope.searchTerm = '';
        };
        // The md-select directive eats keydown events for some quick select
        // logic. Since we have a search input here, we don't need that logic.
        $element.find('input').on('keydown', function (ev) {
            ev.stopPropagation();
        });
       
        $scope.page = 1;
        $scope.keyword = '';
        $scope.pagesCount = 0;
        $scope.getListMeetingRoom = getListMeetingRoom;
        $scope.search = search;
        $scope.deleteMeetingRoom = deleteMeetingRoom;
        $scope.callback = function (arg) {
            console.log('value selected by autocomplete: ', arg);
        };

        function deleteMeetingRoom(id) {
            $ngBootbox.confirm('Bạn có muốn xóa bản ghi này không')
                                .then(function () {
                                    apiService.put($rootScope.baseUrl + 'api/MeetingRoom/DeleteLogical/' + id, null, function (result) {
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
            getListMeetingRoom();
        }
        function pageChanged() {
            getListMeetingRoom();
        }
        function getListMeetingRoom(page) {
            var listDeparentID = "";
            for (var i = 0; i < $scope.selectedVegetables.length; i++)
            {
                listDeparentID += $scope.selectedVegetables[i].Value + ",";
            }
            console.log(listDeparentID);
            page = page || 0;
            var config = {
                params: {
                    keyword: $scope.keyword,
                    PageNumber: page,
                    PageSize: 10,
                    ListDepartmentId: listDeparentID,
                }
            }
            apiService.get($rootScope.baseUrl + 'api/meetingRoom/Search', config, function (result) {
                if (result.data.isSuccess == false)
                    notificationService.displayError(result.message);
                if (result.data.totalItems == 0)
                    notificationService.displayError("không tìm thấy bản ghi nào");
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
        $scope.getListMeetingRoom()
    }
})(angular.module('VOfficeApp.meetingRoom'));