(function (app) {
    app.filter('statusFilter', function () {
        return function (input) {
            if (input) {
                return 'Kích hoạt'
            }
            else {
                return 'Khóa'
            }
        }
    });

    app.filter('statusReceivedFilter', function () {
        return function (input) {
            if (input) {
                return 'Đúng'
            }
            else {
                return 'Sai'
            }
        }
    });
})(angular.module('VOfficeApp.common'));


(function (app) {
    app.filter('documentTypeFilter', function () {
        return function (input) {
            if (input) {
                return 'Văn bản đến'
            }
            else {
                return 'Văn bản đi'
            }
        }
    });
})(angular.module('VOfficeApp.common'));

(function (app) {
    app.filter('listDepartmentFilter', function () {
        return function (input) {
            var listDepartment = [
                { "id": "3", "value": "Công ty cổ phần đầu tư & phát triển công nghệ Văn Lang" },
                { "id": "2", "value": "NXBGD Hà Nội" },
            ];
            var ret = "";
            for(var i = 0;i<listDepartment.length;i++)
            {
                if (input == listDepartment[i].id)
                {
                    ret = listDepartment[i].value;
                }
            }
            return ret;
        }
    });
})(angular.module('VOfficeApp.common'));

(function (app) {
    app.filter('activeFilter', function () {
        return function (input) {
            if (input) {
                return 'Kích hoạt'
            }
            else {
                return 'Chưa kích hoạt'
            }
        }
    });
})(angular.module('VOfficeApp.common'));

(function (app) {
    app.filter('systemConfigFilter', function () {
        return function (input) {
            if (input) {
                return 'password'
            }
            else {
                return 'Text'
            }
        }
    });
})(angular.module('VOfficeApp.common'));