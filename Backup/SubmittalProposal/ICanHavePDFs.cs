using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SubmittalProposal {
    public interface ICanHavePDFs {
        bool HasPropertyAvailable { get; }
        void SetLaneLotForPDFs(string lanelot);
    }
}
