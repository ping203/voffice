﻿using VOffice.Core.Queries;
using VOffice.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VOffice.Repository.Queries
{
    public class DocumentSignedByQuery : BaseQuery<DocumentSignedBy>
    {
        public string Keyword { get; set; }
        public bool? ReceivedDocument { get; set; }
    }
}
