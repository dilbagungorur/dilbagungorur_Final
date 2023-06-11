using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace OtoparkSystem.Models.Entity
{
    public class OtoParkEntity
    {
        public string type { get; set; }
        public Geometry geometry { get; set; }
        public List<Properties> properties { get; set; }
    }

    public class Geometry
    {
        public string type { get; set; }
        public List<string> coordinates { get; set; }
    }

    public class Properties
    {
        public string PARK_NAME { get; set; }
        public string LOCATION_NAME { get; set; }
        public string PARK_TYPE_ID { get; set; }
        public string PARK_TYPE_DESC { get; set; }
        public string CAPACITY_OF_PARK { get; set; }
        public string WORKING_TIME { get; set; }
        public string COUNTY_NAME { get; set; }
        public string rank { get; set; }
    }

}