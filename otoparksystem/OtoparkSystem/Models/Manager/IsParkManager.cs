using OtoparkSystem.Models.Entity;
using RestSharp.Serialization.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace OtoparkSystem.Models.Manager
{
    public class IsParkManager
    {
        internal static string GetIsParks(int aracTurId)
        {
            Data.OTOPARKEntities db = new Data.OTOPARKEntities();

            var isparks = (from ato in db.AracTurleriOtoPark.AsNoTracking()
                           join op in db.OtoPark.AsNoTracking() on ato.OtoParkNumaraId equals op.NumaraId
                           where ato.AracTurleriNumaraId == aracTurId
                           && op.StatusTypeId == 1
                           select new { ato, op }).ToList();
            OtoParkEntity ope = new OtoParkEntity();
            ope.type = "Feature";
            ope.geometry = new Geometry();
            ope.geometry.type = "Point";
            ope.geometry.coordinates = new List<string>();
            ope.properties = new List<Properties>();
            foreach (var item in isparks)
            {
                ope.geometry.coordinates.Add( item.op.coordinatesx);
                ope.geometry.coordinates.Add(item.op.coordinatesy);
                Properties p = new Properties();
                p.PARK_NAME = item.op.PARK_NAME;
                p.LOCATION_NAME = item.op.LOCATION_NAME;
                p.PARK_TYPE_ID = item.op.PARK_TYPE_ID;
                p.PARK_TYPE_ID = item.op.PARK_TYPE_ID;
                p.PARK_TYPE_DESC = item.op.PARK_TYPE_DESC;
                p.CAPACITY_OF_PARK =item.op.CAPACITY_OF_PARK.ToString();
                p.WORKING_TIME = item.op.WORKING_TIME;
                p.COUNTY_NAME = item.op.COUNTY_NAME;
                p.rank = item.op.rank;
                ope.properties.Add(p);
            }
            JsonSerializer serial = new JsonSerializer();
            var json = serial.Serialize(ope);
            return json;
        }
    }
}