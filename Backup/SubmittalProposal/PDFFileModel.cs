using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SubmittalProposal {
    public class PDFFileModel {
        public PDFFileModel(string filespec, string lot, string lane) {
            mfilespec = filespec;
            mlot = lot;
            mlane = lane;
        }
        public string mfilespec;
        public string mlot;
        public string mlane;
    }
}