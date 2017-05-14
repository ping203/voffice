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
    public partial class DocumentService : BaseService, IDocumentService
    {
        protected readonly DocumentTypeRepository _documentTypeRepository;
        protected readonly DocumentSignedByRepository _documentSignedByRepository;
        public DocumentService()
        {
            _documentTypeRepository = new DocumentTypeRepository();
            _documentSignedByRepository = new DocumentSignedByRepository();
        }

        #region DocumentType
        public BaseResponse<DocumentType> GetDocumentTypeById(int id)
        {
            var response = new BaseResponse<DocumentType>();
            try
            {
                response.Value = _documentTypeRepository.GetById(id);
            }
            catch (Exception ex)
            {
                response.Message = "Error: " + ex.Message + " StackTrace: " + ex.StackTrace;
                response.IsSuccess = false;
            }
            return response;
        }
        public BaseListResponse<SPGetDocumentType_Result> FilterDocumentType(DocumentTypeQuery query)
        {
            var response = new BaseListResponse<SPGetDocumentType_Result>();
            int count = 0;
            try
            {
                response.Data = _documentTypeRepository.Filter(query, out count);
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
        public BaseListResponse<DocumentType> GetAllDocumentType()
        {
            var response = new BaseListResponse<DocumentType>();
            try
            {
                var result = _documentTypeRepository.GetAll().Where(x => x.Deleted == false && x.Active == true).ToList();
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
        public BaseResponse<DocumentType> AddDocumentType(DocumentType model)
        {
            var response = new BaseResponse<DocumentType>();
            var errors = Validate<DocumentType>(model, new DocumentTypeValidator());
            if (errors.Count() > 0)
            {
                BaseResponse<DocumentType> errResponse = new BaseResponse<DocumentType>(model, errors);
                errResponse.IsSuccess = false;
                return errResponse;
            }
            try
            {
                response.Value = _documentTypeRepository.Add(model);
            }
            catch (Exception ex)
            {
                response.IsSuccess = false;
                response.Message = "Error: " + ex.Message + " StackTrace: " + ex.StackTrace;
            }
            return response;
        }
        public BaseResponse<DocumentType> UpdateDocumentType(DocumentType model)
        {
            BaseResponse<DocumentType> response = new BaseResponse<DocumentType>();
            var errors = Validate<DocumentType>(model, new DocumentTypeValidator());
            if (errors.Count() > 0)
            {
                BaseResponse<DocumentType> errResponse = new BaseResponse<DocumentType>(model, errors);
                errResponse.IsSuccess = false;
                return errResponse;
            }
            try
            {
                response.Value = _documentTypeRepository.Edit(model);
            }
            catch (Exception ex)
            {
                response.IsSuccess = false;
                response.Message = "Error: " + ex.Message + " StackTrace: " + ex.StackTrace;
            }
            return response;
        }
        public BaseResponse DeleteLogicalDocumentType(int id)
        {
            BaseResponse response = new BaseResponse();
            DocumentType model = _documentTypeRepository.GetById(id);
            try
            {
                model.Deleted = true;
                _documentTypeRepository.Edit(model);
            }
            catch (Exception ex)
            {
                response.Message = ex.Message;
                response.IsSuccess = false;
            }
            return response;
        }
        #endregion AS_DOC_Type

        #region DocumentSignedBy
        public BaseResponse<DocumentSignedBy> GetDocumentSignedByById(int id)
        {
            var response = new BaseResponse<DocumentSignedBy>();
            try
            {
                response.Value = _documentSignedByRepository.GetById(id);
            }
            catch (Exception ex)
            {
                response.Message = "Error: " + ex.Message + " StackTrace: " + ex.StackTrace;
                response.IsSuccess = false;
            }
            return response;
        }
        public BaseListResponse<SPGetDocumentSignedBy_Result> FilterDocumentSignedBy(DocumentSignedByQuery query)
        {
            var response = new BaseListResponse<SPGetDocumentSignedBy_Result>();
            int count = 0;
            try
            {
                response.Data = _documentSignedByRepository.Filter(query, out count);
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
        public BaseListResponse<DocumentSignedBy> GetAllDocumentSignedBy()
        {
            var response = new BaseListResponse<DocumentSignedBy>();
            try
            {
                var result = _documentSignedByRepository.GetAll().Where(x => x.Deleted == false && x.Active == true).ToList();
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
        public BaseResponse<DocumentSignedBy> AddDocumentSignedBy(DocumentSignedBy model)
        {
            var response = new BaseResponse<DocumentSignedBy>();
            var errors = Validate<DocumentSignedBy>(model, new DocumentSignedByValidator());
            if (errors.Count() > 0)
            {
                BaseResponse<DocumentSignedBy> errResponse = new BaseResponse<DocumentSignedBy>(model, errors);
                errResponse.IsSuccess = false;
                return errResponse;
            }
            try
            {
                response.Value = _documentSignedByRepository.Add(model);
            }
            catch (Exception ex)
            {
                response.IsSuccess = false;
                response.Message = "Error: " + ex.Message + " StackTrace: " + ex.StackTrace;
            }
            return response;
        }
        public BaseResponse<DocumentSignedBy> UpdateDocumentSignedBy(DocumentSignedBy model)
        {
            BaseResponse<DocumentSignedBy> response = new BaseResponse<DocumentSignedBy>();
            var errors = Validate<DocumentSignedBy>(model, new DocumentSignedByValidator());
            if (errors.Count() > 0)
            {
                BaseResponse<DocumentSignedBy> errResponse = new BaseResponse<DocumentSignedBy>(model, errors);
                errResponse.IsSuccess = false;
                return errResponse;
            }
            try
            {
                response.Value = _documentSignedByRepository.Edit(model);
            }
            catch (Exception ex)
            {
                response.IsSuccess = false;
                response.Message = "Error: " + ex.Message + " StackTrace: " + ex.StackTrace;
            }
            return response;
        }
        public BaseResponse DeleteLogicalDocumentSignedBy(int id)
        {
            BaseResponse response = new BaseResponse();
            DocumentSignedBy model = _documentSignedByRepository.GetById(id);
            try
            {
                model.Deleted = true;
                _documentSignedByRepository.Edit(model);
            }
            catch (Exception ex)
            {
                response.Message = ex.Message;
                response.IsSuccess = false;
            }
            return response;
        }
        #endregion DocumentSignedBy

    }
}
