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
    public interface IDocumentService : IService
    {
        #region DocumentType
        BaseResponse<DocumentType> GetDocumentTypeById(int id);
        BaseListResponse<DocumentType> GetAllDocumentType();
        BaseListResponse<SPGetDocumentType_Result> FilterDocumentType(DocumentTypeQuery query);
        BaseResponse<DocumentType> AddDocumentType(DocumentType model);
        BaseResponse<DocumentType> UpdateDocumentType(DocumentType model);
        BaseResponse DeleteLogicalDocumentType(int id);
        #endregion DocumentType

        #region DocumentSignedBy
        BaseResponse<DocumentSignedBy> GetDocumentSignedByById(int id);
        BaseListResponse<DocumentSignedBy> GetAllDocumentSignedBy();
        BaseListResponse<SPGetDocumentSignedBy_Result> FilterDocumentSignedBy(DocumentSignedByQuery query);
        BaseResponse<DocumentSignedBy> AddDocumentSignedBy(DocumentSignedBy model);
        BaseResponse<DocumentSignedBy> UpdateDocumentSignedBy(DocumentSignedBy model);
        BaseResponse DeleteLogicalDocumentSignedBy(int id);
        #endregion DocumentSignedBy
    }
}
