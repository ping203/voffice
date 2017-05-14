using VOffice.Core.Messages;
using VOffice.Model;
using VOffice.Repository.Queries;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VOffice.ApplicationService.Implementation.Contract
{
    public interface ICategoryService : IService
    {
        #region Customer
        BaseResponse<Customer> GetCustomerById(int id);
        BaseListResponse<Customer> GetAllCustomer();
        BaseListResponse<SPGetCustomer_Result> FilterCustomer(CustomerQuery query);
        BaseResponse<Customer> AddCustomer(Customer model);
        BaseResponse<Customer> UpdateCustomer(Customer model);
        BaseResponse DeleteLogicalCustomer(int id);
        #endregion Customer

        #region MeetingRoom
        BaseResponse<MeetingRoom> GetMeetingRoomById(int id);
        BaseListResponse<MeetingRoom> GetAllMeetingRoom();
        BaseListResponse<SPGetMeetingRoom_Result> FilterMeetingRoom(MeetingRoomQuery query);
        BaseResponse<MeetingRoom> AddMeetingRoom(MeetingRoom model);
        BaseResponse<MeetingRoom> UpdateMeetingRoom(MeetingRoom model);
        BaseResponse DeleteLogicalMeetingRoom(int id);
        #endregion MeetingRoom
    }
}
