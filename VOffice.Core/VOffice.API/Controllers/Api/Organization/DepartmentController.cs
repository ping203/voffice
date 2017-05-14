using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Http;
using VOffice.Core.Messages;
using VOffice.Model;
using VOffice.Repository.Queries;
using VOffice.ApplicationService.Implementation.Contract;

namespace VOffice.API.Controllers.Api.Organization
{
    /// <summary>
    /// Department API. An element of SystemConfig Deparment Service
    /// </summary>
    public class DepartmentController : ApiController
    {
        IOrganizationService organizationService;
        /// <summary>
        /// Contructor
        /// </summary>
        /// <param name="_organizationService"></param>
        public DepartmentController(IOrganizationService _organizationService)
        {
            organizationService = _organizationService;

        }
        ///// <summary>
        ///// Get a list of Deparment via SQL Store
        ///// </summary>
        ///// <param name="query"></param>
        ///// <returns></returns>
        ////[HttpGet]
        ////public BaseListResponse<SPGetSystemConfigDepartment_Result> Search([FromUri] SystemConfigDepartmentQuery query)
        ////{
        ////    return shareService.FilterSystemConfigDepartment(query);
        ////}
        /// <summary>
        /// Get All Deparment
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public BaseListResponse<Department> GetAll()
        {
            BaseListResponse<Department> result = organizationService.GetAllDepartment();
            return result;
        }
        /// <summary>
        /// Insert a Deparment to Database
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [HttpPost]
        public BaseResponse<Department> Add(Department model)
        {
            return organizationService.AddDepartment(model);
        }
        /// <summary>
        /// Update a Deparment
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [HttpPut]
        public BaseResponse<Department> Update(Department model)
        {
            return organizationService.UpdateDepartment(model);
        }

    }

}