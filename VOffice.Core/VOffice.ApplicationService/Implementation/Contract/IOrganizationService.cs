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
    public interface IOrganizationService : IService
    {
        #region Department
        BaseResponse<Department> GetDepartmentByID(int id);
        BaseListResponse<Department> GetAllDepartment();
        BaseResponse<Department> AddDepartment(Department model);
        BaseResponse<Department> UpdateDepartment(Department model);
        BaseResponse DeleteLogicalDepartment(int id);
        #endregion Department
    }
}
