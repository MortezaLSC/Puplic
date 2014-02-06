description = [[
http-reverse-ip does a reverse ip lookup using Bing's search engine ip operator.
By default, five result pages are requested from bing, which amounts to 50 results at Bing's default 10 results per page. To increase the number of requested pages use the http-reverse-ip.pages argument.
* To learn more about Bing's ip operator:
http://msdn.microsoft.com/en-us/library/ff795671.aspx
]]

---
-- @usage
-- nmap -p80 --script http-reverse-ip <host>
--
-- @output
-- PORT   STATE SERVICE
-- 80/tcp open  http
-- | http-reverse-ip: 
-- | nmap.org
-- | insecure.org
-- | secwiki.org
-- |_images.insecure.org
--
-- @args http-reverse-ip.host Host to check. 
-- @args http-reverse-ip.pages The number of results pages to be requested from bing. Default is 5.
---

author = "Shinnok"
license = "Same as Nmap--See http://nmap.org/book/man-legal.html"
categories = {"discovery", "safe", "external"}

require "http"
require "shortport"

portrule = shortport.http

--Builds the Bing search query
-- () param host 
-- () param page
-- () return Url 
local function bing_search_query(host, page)
  return string.format("http://www.bing.com/search?q=ip:%s&first=%s&FORM=PERE", host, page)
end

---
--MAIN
---
action = function(host, port)
  local pages = 50
  local target
  local domains = {}

  if((stdnse.get_script_args("http-reverse-ip.pages"))) then
    pages = stdnse.get_script_args("http-reverse-ip.pages")*10
  end

  if(stdnse.get_script_args("http-reverse-ip.host")) then
    target = stdnse.get_script_args("http-reverse-ip.host")
  else
    target = host.ip
  end

  stdnse.print_debug(1, "%s: Checking host %s", SCRIPT_NAME, target) 

  -- Bing search

  for page=0, pages, 10 do
    local qry = bing_search_query(target, page)
    local req = http.get_url(qry)

    stdnse.print_debug(2, "%s", qry)
    stdnse.print_debug(2, "%s", req.body)

    if req.body then
      local found = false
      for domain in req.body:gmatch('<h3><a href=\"http[s]?://([A-Za-z0-9%.%%%+%-]+%.%w%w%w?%w?)/')  do
        for _, value in pairs(domains) do
          if value == domain then
            found = true
          end
        end
        if not found then 
          domains[#domains+1] = domain
        end
      end
    end
  end

  if #domains > 0 then
    return "\n" .. stdnse.strjoin("\n", domains)
  end
end
