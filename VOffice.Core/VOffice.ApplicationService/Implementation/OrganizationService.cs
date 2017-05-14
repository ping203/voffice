using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VOffice.ApplicationService.Implementation.Contract;
using VOffice.Core.Messages;
using VOffice.Model;
using VOffice.Model.Validators;
using VOffice.Repository;
using VOffice.Repository.Queries;

namespace VOffice.ApplicationService
{

    public partial class OrganizationService : BaseService, IOrganizationService
    {
        protected readonly SystemConfigRepository _systemConfigRepository;
        protected readonly SystemConfigDepartmentRepository _systemConfigDepartmentRepository;
        protected readonly DepartmentRepository _departmentRepository;
        public OrganizationService()
        {
            _departmentRepository = new DepartmentRepository();
        }
        #region Department
        public BaseResponse<Department> GetDepartmentByID(int id)
        {
            var response = new BaseResponse<Department>();
            try
            {
                response.Value = _departmentRepository.GetById(id);
            }
            catch (Exception ex)
            {
                response.Message = "Error: " + ex.Message + " StackTrace: " + ex.StackTrace;
                response.IsSuccess = false;
            }
            return response;
        }
        public BaseListResponse<Department> GetAllDepartment()
        {
            var response = new BaseListResponse<Department>();
            try
            {
                var result = _departmentRepository.GetAll().Where(x => x.Deleted == false).ToList();
                response.Data = result;
                response.TotalItems = result.Count;
            }
            catch (Exception ex)
            {
                response.IsSuccess = false;
                response.Message = "Error: " + ex.Message + " StackTrace: " + ex.StackTrace;
            }
            return response;
        }
        //public BaseListResponse<SPGetConfig_Result> FilterDepartment(SystemConfigQuery query)
        //{
       
        //}
        public BaseResponse<Department> AddDepartment(Department model)
        {
            var response = new BaseResponse<Department>();
            var errors = Validate<Department>(model, new DepartmentValidator());
            if (errors.Count() > 0)
            {
                BaseResponse<Department> errResponse = new BaseResponse<Department>(model, errors);
                errResponse.IsSuccess = false;
                return errResponse;
            }
            try
            {
                response.Value = _departmentRepository.Add(model);
            }
            catch (Exception ex)
            {
                response.IsSuccess = false;
                response.Message = "Error: " + ex.Message + " StackTrace: " + ex.StackTrace;
            }
            return response;
        }
        public BaseResponse<Department> UpdateDepartment(Department model)
        {
            BaseResponse<Department> response = new BaseResponse<Department>();
            var errors = Validate<Department>(model, new DepartmentValidator());
            if (errors.Count() > 0)
            {
                BaseResponse<Department> errResponse = new BaseResponse<Department>(model, errors);
                errResponse.IsSuccess = false;
                return errResponse;
            }
            try
            {
                response.Value = _departmentRepository.Edit(model);
            }
            catch (Exception ex)
            {
                response.IsSuccess = false;
                response.Message = "Error: " + ex.Message + " StackTrace: " + ex.StackTrace;
            }
            return response;
        }
        public BaseResponse DeleteLogicalDepartment(int id)
        {
            BaseResponse response = new BaseResponse();
            Department model = _departmentRepository.GetById(id);
            try
            {
                model.Deleted = true;
                _departmentRepository.Edit(model);
            }
            catch (Exception ex)
            {
                response.Message = ex.Message;
                response.IsSuccess = false;
            }
            return response;
        }
        #endregion Department
    }
}
