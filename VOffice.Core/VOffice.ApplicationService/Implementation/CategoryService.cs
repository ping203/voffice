using VOffice.Core.Messages;
using VOffice.Model;
using VOffice.Model.Validators;
using VOffice.Repository;
using VOffice.Repository.Queries;
using VOffice.ApplicationService.Implementation.Contract;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VOffice.ApplicationService
{
    public partial class CategoryService : BaseService, ICategoryService
    {
        protected readonly MeetingRoomRepository _meetingRoomRepository;
        protected readonly CustomerRepository _customerRepository;
        public CategoryService()
        {
            _customerRepository = new CustomerRepository();
            _meetingRoomRepository = new MeetingRoomRepository();
        }
        public BaseResponse<Customer> AddCustomer(Customer model)
        {
            var response = new BaseResponse<Customer>();
            var errors = Validate<Customer>(model, new CustomerValidator());
            if (errors.Count() > 0)
            {
                BaseResponse<Customer> errResponse = new BaseResponse<Customer>(model, errors);
                errResponse.IsSuccess = false;
                return errResponse;
            }
            try
            {
                response.Value = _customerRepository.Add(model);
            }
            catch (Exception ex)
            {
                response.IsSuccess = false;
                response.Message = "Error: " + ex.Message + " StackTrace: " + ex.StackTrace;
            }
            return response;
        }
        public BaseResponse<Customer> UpdateCustomer(Customer model)
        {
            BaseResponse<Customer> response = new BaseResponse<Customer>();
            var errors = Validate<Customer>(model, new CustomerValidator());
            if (errors.Count() > 0)
            {
                BaseResponse<Customer> errResponse = new BaseResponse<Customer>(model, errors);
                errResponse.IsSuccess = false;
                return errResponse;
            }
            try
            {
                response.Value = _customerRepository.Edit(model);
            }
            catch (Exception ex)
            {
                response.IsSuccess = false;
                response.Message = "Error: " + ex.Message + " StackTrace: " + ex.StackTrace;
            }
            return response;
        }
        public BaseResponse DeleteLogicalCustomer(int id)
        {
            BaseResponse response = new BaseResponse();
            Customer model = _customerRepository.GetById(id);
            try
            {
                model.Deleted = true;
                _customerRepository.Edit(model);
            }
            catch (Exception ex)
            {
                response.Message = ex.Message;
                response.IsSuccess = false;
            }
            return response;
        }
        #region MeetingRoom
        public BaseResponse<MeetingRoom> GetMeetingRoomById(int id)
        {
            var response = new BaseResponse<MeetingRoom>();
            try
            {
                response.Value = _meetingRoomRepository.GetById(id);
            }
            catch (Exception ex)
            {
                response.Message = "Error: " + ex.Message + " StackTrace: " + ex.StackTrace;
                response.IsSuccess = false;
            }
            return response;
        }

        public BaseListResponse<SPGetMeetingRoom_Result> FilterMeetingRoom(MeetingRoomQuery query)
        {
            var response = new BaseListResponse<SPGetMeetingRoom_Result>();
            int count = 0;
            try
            {
                response.Data = _meetingRoomRepository.Filter(query, out count);
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
        public BaseListResponse<MeetingRoom> GetAllMeetingRoom()
        {
            var response = new BaseListResponse<MeetingRoom>();
            try
            {
                var result = _meetingRoomRepository.GetAll().Where(x => x.Deleted == false && x.Active == true).ToList();
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
        public BaseResponse<MeetingRoom> AddMeetingRoom(MeetingRoom model)
        {
            var response = new BaseResponse<MeetingRoom>();
            var errors = Validate<MeetingRoom>(model, new MeetingRoomValidator());
            if (errors.Count() > 0)
            {
                BaseResponse<MeetingRoom> errResponse = new BaseResponse<MeetingRoom>(model, errors);
                errResponse.IsSuccess = false;
                return errResponse;
            }
            try
            {
                response.Value = _meetingRoomRepository.Add(model);
            }
            catch (Exception ex)
            {
                response.IsSuccess = false;
                response.Message = "Error: " + ex.Message + " StackTrace: " + ex.StackTrace;
            }
            return response;
        }
        public BaseResponse<MeetingRoom> UpdateMeetingRoom(MeetingRoom model)
        {
            BaseResponse<MeetingRoom> response = new BaseResponse<MeetingRoom>();
            var errors = Validate<MeetingRoom>(model, new MeetingRoomValidator());
            if (errors.Count() > 0)
            {
                BaseResponse<MeetingRoom> errResponse = new BaseResponse<MeetingRoom>(model, errors);
                errResponse.IsSuccess = false;
                return errResponse;
            }
            try
            {
                response.Value = _meetingRoomRepository.Edit(model);
            }
            catch (Exception ex)
            {
                response.IsSuccess = false;
                response.Message = "Error: " + ex.Message + " StackTrace: " + ex.StackTrace;
            }
            return response;
        }
        public BaseResponse DeleteLogicalMeetingRoom(int id)
        {
            BaseResponse response = new BaseResponse();
            MeetingRoom model = _meetingRoomRepository.GetById(id);
            try
            {
                model.Deleted = true;
                _meetingRoomRepository.Edit(model);
            }
            catch (Exception ex)
            {
                response.Message = ex.Message;
                response.IsSuccess = false;
            }
            return response;
        }
        #endregion MeetingRoom
        public BaseListResponse<Customer> GetAllCustomer()
        {
            var response = new BaseListResponse<Customer>();
            try
            {
                var result = _customerRepository.GetAll().Where(x => x.Deleted == false && x.Active == true).ToList();
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
        public BaseResponse<Customer> GetCustomerById(int id)
        {
            var response = new BaseResponse<Customer>();
            try
            {
                response.Value = _customerRepository.GetById(id);
            }
            catch (Exception ex)
            {
                response.Message = "Error: " + ex.Message + " StackTrace: " + ex.StackTrace;
                response.IsSuccess = false;
            }
            return response;
        }
        public BaseListResponse<SPGetCustomer_Result> FilterCustomer(CustomerQuery query)
        {
            var response = new BaseListResponse<SPGetCustomer_Result>();
            int count = 0;
            try
            {
                response.Data = _customerRepository.Filter(query, out count);
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
    }
}

