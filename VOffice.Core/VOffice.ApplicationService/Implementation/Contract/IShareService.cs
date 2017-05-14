using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VOffice.Core.Messages;
using VOffice.Model;
using VOffice.Repository.Queries;

namespace VOffice.ApplicationService.Implementation.Contract
{
    public interface IShareService : IService
    {
        #region System Config
        BaseResponse<SystemConfig> GetSystemConfigById(int id);
        BaseListResponse<SystemConfig> GetAllSystemConfig();
        BaseListResponse<SPGetConfig_Result> FilterSystemConfig(SystemConfigQuery query);
        BaseResponse<SystemConfig> AddSystemConfig(SystemConfig model);
        BaseResponse<SystemConfig> UpdateSystemConfig(SystemConfig model);
        BaseResponse DeleteLogicalSystemConfig(int id);
        #endregion System Config
        #region System Config Department
        BaseListResponse<SystemConfigDepartment> GetAllSystemConfigDepartment();
        BaseListResponse<SPGetSystemConfigDepartment_Result> FilterSystemConfigDepartment(SystemConfigDepartmentQuery query);
        BaseResponse<SystemConfigDepartment> AddSystemConfigDepartment(SystemConfigDepartment model);
        BaseResponse<SystemConfigDepartment> UpdateSystemConfigDepartment(SystemConfigDepartment model);
        #endregion System Config Department
    }
}
