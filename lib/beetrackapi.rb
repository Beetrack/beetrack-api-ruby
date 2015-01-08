require 'curb'
require 'json'
require 'cgi'
require 'time'

module BeetrackAPI
    
    class Error < StandardError; end
    class AuthenticationError < Error; end

    class Client
        attr_accessor :key
        attr_reader :url 

        def initialize(options = {})
            @key = options[:key]
            @url = 'http://app.beetrack.cl/api/external/v1/'
        end

        def getroutes(options = {})
            date = options.empty? ? "#{Date.today.strftime("%d-%m-%Y")}" : options[:date]
            get('routes', :date => date)
        end

        def getroute(route_id)
            get("routes/#{route_id}")
        end

        def createroute(options = {})
            post("routes", options)
        end

        def getdispatchinfo(dispatch_id)
            get("dispatches/#{dispatch_id}")
        end

        def gettrucks
            get("trucks")
        end

        def updateroute(route_id, options ={})
            put("routes/#{route_id}", options)
        end

        private

        def get(path, params = {})
            res = Curl.get(@url + request_uri(path,params)) do |http|
                http.headers['X-AUTH-TOKEN'] = @key
                http.headers['Content-Type'] = 'application/json'
            end
            JSON.parse(res.body_str)
        end

        def post(path, params ={})
            res = Curl.post(@url + path, params.to_json) do |http|
                http.headers['X-AUTH-TOKEN'] = @key
                http.headers['Content-Type'] = 'application/json'
            end
            JSON.parse(res.body_str)
        end

        def put(path, params ={})
            res = Curl.put(@url + path, params.to_json) do |http|
                http.headers['X-AUTH-TOKEN'] = @key
                http.headers['Content-Type'] = 'application/json'
            end
            JSON.parse(res.body_str)
        end

        def parse(http_response)
            case http_response
            when Net::HTTPSuccess
                if http_response['Content-Type'].split(';').first == 'application/json'
                    JSON.parse(http_response.body)
                else
                    http_response.body
                end
            when Net::HTTPUnauthorized
                raise AuthenticationError
            else
                raise Error, "Unexpected HTTP response (code=#{http_response.code})"
            end
        end

        def request_uri(path, hash = {})
            if hash.empty?
                path
            else
                query_params = hash.map do |key, values|
                Array(values).map { |value| "#{key}=#{value}" }
            end
                path + '?' + query_params.flatten.join('&')
            end
        end

    end

end
