require 'json'
require 'cgi'
require 'time'
require 'rest_client'

module BeetrackAPI

    class Error < StandardError; end
    class AuthenticationError < Error; end

    class Client
        attr_accessor :key
        attr_reader :url

        def initialize(options = {})
            @key = options[:key]
            @url = options[:url] || 'https://app.beetrack.cl/api/external/v1/'
            @url = @url + '/' if @url[-1] != '/'
        end

        def get_routes(options = {})
            date = options.empty? ? "#{Date.today.strftime("%d-%m-%Y")}" : options[:date]
            get('routes', :date => date)
        end

        alias_method :getroutes, :get_routes

        def get_route(route_id)
            get("routes/#{route_id}")
        end

        alias_method :getroute, :get_route

        def create_route(options = {})
            post("routes", options)
        end

        alias_method :createroute, :create_route

        def get_dispatch_info(dispatch_id)
            get("dispatches/#{dispatch_id}")
        end

        alias_method :getdispatchinfo, :get_dispatch_info

        def get_trucks
            get("trucks")
        end

        alias_method :gettrucks, :get_trucks

        def get_truck(identifier)
            get("trucks/#{identifier}")
        end

        alias_method :gettruck, :get_truck

        def update_route(route_id, options ={})
            put("routes/#{route_id}", options)
        end

        alias_method :updateroute, :update_route

        def upload_file(file, content_type)
          request = RestClient::Request.new(
              :method => :post,
              :url => "#{url}import",
              :headers => {
                'Content-Type' => content_type,
                'X-AUTH-TOKEN' => @key
                },
              :payload => {
                :multipart => true,
                :file => file
              },
              ssl_version: 'TLSv1_2')
          request.execute
        end

        def request_data_export(params = {})
          post('data_exports', params)
        end

        def get_data_export_status(id)
          get("data_exports/#{id}")
        end

        private

        def get(path, params = {})
          request = RestClient::Request.new(
            :method => :get,
            :url => @url + request_uri(path, params),
            :headers => {
              'Content-Type' => 'application/json',
              'X-AUTH-TOKEN' => @key
            },
            ssl_version: 'TLSv1_2')
          return JSON.parse(request.execute)
        end

        def post(path, params ={})
          JSON.parse(make_request(:post, path, params))
        end

        def put(path, params ={})
          JSON.parse(make_request(:put, path, params))
        end

        def make_request(method, path, params)
          request = RestClient::Request.new(
            :method => method,
            :url => @url + path,
            :payload => params.to_json,
            :headers => {
              'Content-Type' => 'application/json',
              'X-AUTH-TOKEN' => @key
            },
            ssl_version: 'TLSv1_2')
          return request.execute
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
