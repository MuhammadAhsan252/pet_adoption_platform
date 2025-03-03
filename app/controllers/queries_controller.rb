class QueriesController < ApplicationController

    def create
        @query = Query.new(query_params)
        if @query.save
            # QueryMailer.with(query: @query).new_query.deliver_later
            redirect_to root_path, notice: "Query sent!"
        else
            redirect_to root_path, alert: "Query not sent!"
        end
    end

    private
    def query_params
        params.require(:query).permit(:full_name, :email, :message)
    end

end