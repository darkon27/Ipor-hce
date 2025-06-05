using System;
using System.Collections.Generic;
using System.Data.Entity.Validation;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Repository.Repository
{
    public class LogValidationErrors
    {
        public static string LogError(DbEntityValidationException ex)
        {
            foreach (DbEntityValidationResult validation
                in ex.EntityValidationErrors)
            {
                Debug.WriteLine(
                    "Error in entity {0}",
                    validation.Entry.Entity);

                foreach (DbValidationError propertyError
                    in validation.ValidationErrors)
                {
                    Debug.WriteLine(
                        "Error in property {0}: {1}",
                        propertyError.PropertyName,
                        propertyError.ErrorMessage);
                }
            }
            return "";
        }
    }
}
