
(function (app) {
    app.controller('meetingRoomAddOrEditController', meetingRoomAddOrEditController);

    meetingRoomAddOrEditController.$inject = ['$scope',
                                      'apiService',
                                      'notificationService',
                                      'focus',
                                      'indexSvc',
                                      '$state',
                                      '$stateParams',
                                      '$rootScope',
    '$element']

    function meetingRoomAddOrEditController($scope,
                                    apiService,
                                    notificationService,
                                    focus,
                                    indexSvc,
                                    $state,
                                    $stateParams,
                                    $rootScope, $element) {

        $scope.skillsList = [
            { id: 1, name: "Công ty CPĐT&PT Công nghệ Văn Lang" },
            { id: 2, name: "NXBGD Hà Nội" },
            { id: 3, name: "NXBGD Đà Nẵng" },
            { id: 4, name: "NXBGD TP HCM" },
            { id: 5, name: "NXBGD Cần Thơ" },
            { id: 6, name: "Công ty CP ĐT sách & thiết bị dạy học Cửu Long" },
            { id: 7, name: "Công ty CP ĐT sách & thiết bị dạy học Quảng Ninh" },
            { id: 8, name: "Công ty CP ĐT sách & thiết bị dạy học Tây Bắc" },
            { id: 9, name: "Công ty CP ĐT sách & thiết bị trường học Hà Tây" },
            { id: 10, name: "Công ty CP ĐT sách & thiết bị dạy học Hà Nam" },
        ];

        $scope.selectItemCallback = function (item) {
            $scope.selectedItem = item;
        };

        $scope.removeItemCallback = function (item) {
            $scope.removedItem = item;
        };

        var fetchingRecords = false;
        var urlBase = "http://countrylistapi.apphb.com/api/country";
        $scope.vegetables = [{ "key": "Công ty CPĐT&PT Công nghệ Văn Lang", "value": "3" }, { "key": "NXBGD Hà Nội", "value": "2" }, { "key": "Cơ quan văn phòng", "value": "0" }];

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

        $scope.meetingRoom = {};
        $scope.save = save;
        function save() {

            if ($stateParams.id == 0) {
                $scope.meetingRoom.deleted = 0;
                $scope.meetingRoom.createdOn = new Date();
                $scope.meetingRoom.createdBy = "c8df8541-be47-4a62-b217-e4da7bf89f7a";
                $scope.meetingRoom.editedOn = new Date();
                $scope.meetingRoom.editedBy = "c8df8541-be47-4a62-b217-e4da7bf89f7a";
                $scope.meetingRoom.departmentId = $scope.selectedVegetables[0].Value;
                AddMeetingRoom();
            }
            else {
                $scope.meetingRoom.departmentId = $scope.selectedVegetables[0].Value;
                UpdateMeetingRoom();

            }
        }
        function UpdateMeetingRoom() {
            apiService.put($rootScope.baseUrl + 'api/meetingroom/Update', $scope.meetingRoom,
                function (result) {
                    if (!result.data.isValid) {
                        angular.forEach(result.data.brokenRules, function (value, key) {
                            notificationService.displayError(value.rule);
                        });
                        return;
                    }
                    notificationService.displaySuccess('Cập nhật thành công ');
                    $state.go('meetingRoom');
                }, function (error) {
                    notificationService.displayError('Cập nhật không thành công');
                });
        }
        function AddMeetingRoom() {
            apiService.post($rootScope.baseUrl + 'api/MeetingRoom/Add', $scope.meetingRoom,
                function (result) {
                    if (!result.data.isValid) {
                        angular.forEach(result.data.brokenRules, function (value, key) {
                            notificationService.displayError(value.rule);
                        });
                        return;
                    }
                    notificationService.displaySuccess('Thêm mới thành công');
                    $state.go('meetingRoom');
                }, function (error) {
                    notificationService.displayError('Thêm mới không thành công');
                });
        }

        function loadMeetingRoom() {
            apiService.get($rootScope.baseUrl + 'api/meetingroom/get/' + $stateParams.id, null,
                function (result) {
                    $scope.meetingRoom = result.data.value;
                },
                function (error) {
                    notificationService.displayError('Không có dữ liệu')
                })
        }
        if ($stateParams.id != 0) {
            loadMeetingRoom();
        }

    }
})(angular.module('VOfficeApp.meetingRoom'));