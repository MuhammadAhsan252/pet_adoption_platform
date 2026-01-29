class PetsForAdoptionController < ApplicationController
    require "net/http"

    def index
      uri = URI("https://api.petfinder.com/v2/animals")
      query_params = {}

      query_params[:type] = params[:type] if params[:type].present?
      query_params[:size] = params[:size] if params[:size].present?
      query_params[:gender] = params[:gender] if params[:gender].present?
      query_params[:age] = params[:age] if params[:age].present?
      query_params[:limit] = 100
      query_params[:organization] = "TX2382,OR402,FL1587,NJ946,CA2613,NY1521,NY1530,PA1124,UT222,CA2819,OH1289,MI1060,LA433,IA270,MO780,NY1511,WI530,NY1548,MA548,CA2631,CT577,FL1715,FL1627,VA798,AZ745,WI528,AZ753,UT223,FL1843,WI161,CA1904,CA1980,MO788,IL823,OH1143,CA2264,CA3066,MS192,TX2312,FL1591,TX2446,MD499,NM221,NC1070,IL908,CA2763,NY1424,FL1568,NY1456,NY1480,ID159,NJ927,ON594,WI525,MI1131,FL1651,TX2520,CA2860"
      query_params[:page] = params[:page] if params[:page].present?
      uri.query = URI.encode_www_form(query_params)

      response = fetch_data(uri)

      if response.code == "200"
        data = JSON.parse(response.body)
        @pets = data["animals"]
        @current_page = data["pagination"]["current_page"]
        @total_pages = data["pagination"]["total_pages"]
      else
        @pets = []  # If there's an error, set @pets to an empty array
        flash[:alert] = "Failed to fetch pets"
      end
    end

    def show
      uri = URI("https://api.petfinder.com/v2/animals/#{params[:id]}")

      response = fetch_data(uri)

      if response.code == "200"
        @pet = JSON.parse(response.body)["animal"]
      else
        @pet = {}  # If there's an error, set @pet to an empty hash
        flash[:alert] = "Failed to fetch pet"
      end
    end

    private
    def fetch_data(uri)
      request = Net::HTTP::Get.new(uri)
      request["Authorization"] = ENV["PETFINDER_API_KEY"]

      response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
        http.request(request)
      end
      response
    end
end
