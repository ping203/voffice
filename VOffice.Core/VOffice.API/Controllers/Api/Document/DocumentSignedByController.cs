using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Http;
using VOffice.Core.Messages;
using VOffice.Model;
using VOffice.Repository.Queries;
using VOffice.ApplicationService.Implementation.Contract;

namespace VOffice.API.Controllers.Api.Document
{
    public class DocumentSignedByController : ApiController
    {
        IDocumentService documentService;
        public DocumentSignedByController(IDocumentService _documentService)
        {
            documentService = _documentService;
        }

        [HttpGet]
        public BaseResponse<DocumentSignedBy> Get(int id)
        {
            return documentService.GetDocumentSignedByById(id);
        }
        [HttpGet]
        public BaseListResponse<SPGetDocumentSignedBy_Result> Search([FromUri] DocumentSignedByQuery query)
        {
            return documentService.FilterDocumentSignedBy(query);
        }
        [HttpGet]
        public BaseListResponse<DocumentSignedBy> GetAll()
        {
            return documentService.GetAllDocumentSignedBy();
        }
        [HttpPost]
        public BaseResponse<DocumentSignedBy> Add(DocumentSignedBy model)
        {
            return documentService.AddDocumentSignedBy(model);
        }
        [HttpPut]
        public BaseResponse<DocumentSignedBy> Update(DocumentSignedBy model)
        {
            return documentService.UpdateDocumentSignedBy(model);
        }
        [HttpPut]
        public BaseResponse DeleteLogical(int id)
        {
            return documentService.DeleteLogicalDocumentSignedBy(id);
        }
    }
}
