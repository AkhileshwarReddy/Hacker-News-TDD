module SubmissionsHelper
    def get_host(url)
        host = URI.parse(url).host
        host.start_with?("www.") ? host[4..-1] : host
    end
end
