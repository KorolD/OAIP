//------------------------------------------------------------------------------
// <auto-generated>
//     Этот код создан по шаблону.
//
//     Изменения, вносимые в этот файл вручную, могут привести к непредвиденной работе приложения.
//     Изменения, вносимые в этот файл вручную, будут перезаписаны при повторном создании кода.
// </auto-generated>
//------------------------------------------------------------------------------

namespace EnrollmentCampaign
{
    using System;
    using System.Collections.Generic;
    
    public partial class oksk_specialities
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public oksk_specialities()
        {
            this.speciality_enum = new HashSet<speciality_enum>();
            this.oksk_qualifications = new HashSet<oksk_qualifications>();
        }
    
        public int ID { get; set; }
        public int name_ID { get; set; }
        public Nullable<int> name_additional_ID { get; set; }
        public string code { get; set; }
    
        public virtual oksk_names_additional oksk_names_additional { get; set; }
        public virtual oksk_names_main oksk_names_main { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<speciality_enum> speciality_enum { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<oksk_qualifications> oksk_qualifications { get; set; }
    }
}
