using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

    public class Util
    {
        public static string DetecVowel(string keyword)
        {
        if(string.IsNullOrEmpty(keyword))
        {
            keyword = "";
        }
        keyword = keyword.ToLower();
            char[] charArr = keyword.ToCharArray();
        keyword = "";
            foreach (char c in charArr)
            {
                string tmp = "";
                tmp = c.ToString();

                if (c == 'a')
                {
                    tmp = "[aáàạảãâấầậẩẫăắằặẳẵ]";
                }
                if (c == 'e')
                {
                    tmp = "[eéèẹẻẽêếềệểễ]";
                }
                if (c == 'o')
                {
                    tmp = "[oóòọỏõôốồộổỗơớờợởỡ]";
                }
                if (c == 'i')
                {
                    tmp = "[iíìịỉĩ]";
                }
                if (c == 'u')
                {
                    tmp = "[uúùụủũưứừựửữ]";
                }
                if (c == 'd')
                {
                    tmp = "[dđ]";
                }
                if (c == 'y')
                {
                    tmp = "[ýyỳỷỹ]";
                }
            keyword += tmp;
            }
            return keyword;
        }
    }