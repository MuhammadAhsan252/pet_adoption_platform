class Admins::QueriesController < ApplicationController
    before_action :authenticate_admin!
    def index
        @queries = Query.all
    end

    def destroy
        @query = Query.find(params[:id])
        @query.destroy
        redirect_to admins_queries_path, notice: "Query deleted!"
    end

end