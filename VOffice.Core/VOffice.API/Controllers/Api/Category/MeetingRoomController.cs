using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Http;
using VOffice.Core.Messages;
using VOffice.Model;
using VOffice.Repository.Queries;
using VOffice.ApplicationService.Implementation.Contract;

namespace VOffice.API.Controllers.Api.Category
{
    /// <summary>
    /// Customer API. An element of CategoryService
    /// </summary>
    public class MeetingRoomController : ApiController
    {
        ICategoryService categoryService;
        /// <summary>
        /// Contructor
        /// </summary>
        /// <param name="_categoryService"></param>
        public MeetingRoomController(ICategoryService _categoryService)
        {
            categoryService = _categoryService;

        }
        /// <summary>
        /// Get a Customer by Id
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [HttpGet]
        public BaseResponse<MeetingRoom> Get(int id)
        {
            return categoryService.GetMeetingRoomById(id);
        }
        /// <summary>
        /// Get a list of Customer via SQL Store
        /// </summary>
        /// <param name="query"></param>
        /// <returns></returns>
        [HttpGet]
        public BaseListResponse<SPGetMeetingRoom_Result> Search([FromUri] MeetingRoomQuery query)
        {
            return categoryService.FilterMeetingRoom(query);
        }
        /// <summary>
        /// Get All Customer
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public BaseListResponse<Customer> GetAll()
        {
            var a = "aaaa";
            return categoryService.GetAllCustomer();
        }
        /// <summary>
        /// Insert a Customer to Database
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [HttpPost]
        public BaseResponse<MeetingRoom> Add(MeetingRoom model)
        {
            return categoryService.AddMeetingRoom(model);
        }
        /// <summary>
        /// Update a Customer
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [HttpPut]
        public BaseResponse<MeetingRoom> Update(MeetingRoom model)
        {
            return categoryService.UpdateMeetingRoom(model);
        }
        /// <summary>
        /// Mark a Customer as Deleted
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [HttpPut]
        public BaseResponse DeleteLogical(int id)
        {
            return categoryService.DeleteLogicalMeetingRoom(id);
        }
    }
}