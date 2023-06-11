using OtoparkSystem.Models.Entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace OtoparkSystem.Models.Manager
{
    public class AracTurleriManager
    {

        public static List<AracTurleriEntity> GetAracTurleri()
        {
            List<AracTurleriEntity> list = new List<AracTurleriEntity>();
            Data.OTOPARKEntities db = new Data.OTOPARKEntities();

            var aracturleri = db.AracTurleri.Where(t => t.StatusTypeId == 1);

            foreach(var at in aracturleri)
            {
                AracTurleriEntity ate = new AracTurleriEntity();
                ate.NumaraId = at.NumaraId;
                ate.Name = at.Name;
                ate.image = at.image;
                list.Add(ate);
            }
            return list;
        }

    }
}