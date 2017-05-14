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

    public partial class ShareService : BaseService, IShareService
    {
        protected readonly SystemConfigRepository _systemConfigRepository;
        protected readonly SystemConfigDepartmentRepository _systemConfigDepartmentRepository;
        protected readonly DepartmentRepository _departmentRepository;
        public ShareService()
        {
            _systemConfigRepository = new SystemConfigRepository();
            _systemConfigDepartmentRepository = new SystemConfigDepartmentRepository();
            _departmentRepository = new DepartmentRepository();
        }

        #region SystemConfig
        public BaseResponse<SystemConfig> GetSystemConfigById(int id)
        {
            var response = new BaseResponse<SystemConfig>();
            try
            {
                response.Value = _systemConfigRepository.GetById(id);
            }
            catch (Exception ex)
            {
                response.Message = "Error: " + ex.Message + " StackTrace: " + ex.StackTrace;
                response.IsSuccess = false;
            }
            return response;
        }
        public BaseListResponse<SystemConfig> GetAllSystemConfig()
        {
            var response = new BaseListResponse<SystemConfig>();
            try
            {
                var result = _systemConfigRepository.GetAll().Where(x => x.Deleted == false).ToList();
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
        public BaseListResponse<SPGetConfig_Result> FilterSystemConfig(SystemConfigQuery query)
        {
            var response = new BaseListResponse<SPGetConfig_Result>();
            int count = 0;
            try
            {
                response.Data = _systemConfigRepository.Filter(query, out count);
                response.TotalItems = count;
                response.PageNumber = query.PageNumber != 0 ? query.PageNumber : 1;
                response.PageSize = query.PageSize;

            }
            catch (Exception ex)
            {
                response.Message = "Error: " + ex.Message + " StackTrace: " + ex.StackTrace;
            }
            return response;
        }
        public BaseResponse<SystemConfig> AddSystemConfig(SystemConfig model)
        {
            var response = new BaseResponse<SystemConfig>();
            var errors = Validate<SystemConfig>(model, new SystemConfigValidator());
            if (errors.Count() > 0)
            {
                BaseResponse<SystemConfig> errResponse = new BaseResponse<SystemConfig>(model, errors);
                errResponse.IsSuccess = false;
                return errResponse;
            }
            try
            {
                response.Value = _systemConfigRepository.Add(model);
            }
            catch (Exception ex)
            {
                response.IsSuccess = false;
                response.Message = "Error: " + ex.Message + " StackTrace: " + ex.StackTrace;
            }
            return response;
        }
        public BaseResponse<SystemConfig> UpdateSystemConfig(SystemConfig model)
        {
            BaseResponse<SystemConfig> response = new BaseResponse<SystemConfig>();
            var errors = Validate<SystemConfig>(model, new SystemConfigValidator());
            if (errors.Count() > 0)
            {
                BaseResponse<SystemConfig> errResponse = new BaseResponse<SystemConfig>(model, errors);
                errResponse.IsSuccess = false;
                return errResponse;
            }
            try
            {
                response.Value = _systemConfigRepository.Edit(model);
            }
            catch (Exception ex)
            {
                response.IsSuccess = false;
                response.Message = "Error: " + ex.Message + " StackTrace: " + ex.StackTrace;
            }
            return response;
        }
        public BaseResponse DeleteLogicalSystemConfig(int id)
        {
            BaseResponse response = new BaseResponse();
            SystemConfig model = _systemConfigRepository.GetById(id);
            try
            {
                model.Deleted = true;
                _systemConfigRepository.Edit(model);
            }
            catch (Exception ex)
            {
                response.Message = ex.Message;
                response.IsSuccess = false;
            }
            return response;
        }
        #endregion SystemConfig
        #region System Config Department

        public BaseListResponse<SystemConfigDepartment> GetAllSystemConfigDepartment()
        {
            var response = new BaseListResponse<SystemConfigDepartment>();
            try
            {
                var result = _systemConfigDepartmentRepository.GetAll().ToList();
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
        public BaseListResponse<SPGetSystemConfigDepartment_Result> FilterSystemConfigDepartment(SystemConfigDepartmentQuery query)
        {
            var response = new BaseListResponse<SPGetSystemConfigDepartment_Result>();
            int count = 0;
            try
            {
                response.Data = _systemConfigDepartmentRepository.Filter(query, out count);
                response.TotalItems = count;
                response.PageNumber = query.PageNumber != 0 ? query.PageNumber : 1;
                response.PageSize = query.PageSize;

            }
            catch (Exception ex)
            {
                response.Message = "Error: " + ex.Message + " StackTrace: " + ex.StackTrace;
            }
            return response;
        }
        public BaseResponse<SystemConfigDepartment> AddSystemConfigDepartment(SystemConfigDepartment model)
        {
            var response = new BaseResponse<SystemConfigDepartment>();
            var errors = Validate<SystemConfigDepartment>(model, new SystemConfigDepartmentValidator());
            if (errors.Count() > 0)
            {
                BaseResponse<SystemConfigDepartment> errResponse = new BaseResponse<SystemConfigDepartment>(model, errors);
                errResponse.IsSuccess = false;
                return errResponse;
            }
            try
            {
                response.Value = _systemConfigDepartmentRepository.Add(model);
            }
            catch (Exception ex)
           
            {
                response.IsSuccess = false;
                response.Message = "Error: " + ex.Message + " StackTrace: " + ex.StackTrace;
            }            
            return response;
        }
        public BaseResponse<SystemConfigDepartment> UpdateSystemConfigDepartment(SystemConfigDepartment model)
        {
            BaseResponse<SystemConfigDepartment> response = new BaseResponse<SystemConfigDepartment>();
            var errors = Validate<SystemConfigDepartment>(model, new SystemConfigDepartmentValidator());
            if (errors.Count() > 0)
            {
                BaseResponse<SystemConfigDepartment> errResponse = new BaseResponse<SystemConfigDepartment>(model, errors);
                errResponse.IsSuccess = false;
                return errResponse;
            }
            try
            {
                response.Value = _systemConfigDepartmentRepository.Edit(model);
            }
            catch (Exception ex)
            {
                response.IsSuccess = false;
                response.Message = "Error: " + ex.Message + " StackTrace: " + ex.StackTrace;
            }
            return response;
        }
        #endregion System config department
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
