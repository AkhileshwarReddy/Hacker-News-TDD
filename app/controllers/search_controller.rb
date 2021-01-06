class SearchController < ApplicationController
    before_action :set_query_params, only: [:search]

    def search
        @search_items = Array.new
        if @type.values.first == "story"
            @search_items = get_submissions
        elsif @type.values.first == "comment"
            @search_items = get_comments
        else
            @search_items << get_submissions
            @search_items << get_comments
        end
        @search_items.flatten!
    end

    private
        def get_submissions
            Submission.search(@query, where: @where, order: @order).results
        end

        def get_comments
            Comment.search(@query, where: @where, order: @order).results
        end

        def set_query_params
            set_search_filters
            @query = params[:query]
            @search_items = Array.new
            @type = @types.select {|k, v| v == params[:type]}
            @sort = @sorts.select {|k, v| v == params[:sort]}
            @date_range = @date_ranges.select {|k, v| v == params[:dateRange]}
            order_options
            where_options
        end

        def order_options
            @order = {}
            if @sort.values.first == @sorts["Date"]
                @order[:created_at] = :asc
            elsif @sort.values.first == @sorts["Popularity"]
                @order[:upvotes] = :desc
            else
                @order = {}
            end
        end

        def where_options
            @where = @date_range.values.first == @date_range["All time"] ? {} 
            : {
                :created_at => {
                    :lte => Time.now,
                    :gte => case @date_range.values.first
                    when "last24h"
                            Time.now - 24.hours
                    when "pastWeek"
                            Time.now - 1.week
                    when "pastMonth"
                            Time.now - 1.month
                    when "pastYear"
                            Time.now - 1.year
                    end
                }
            }
        end

        def set_search_filters
            @types = {"All" => "all", "Stories" => "story", "Comments" => "comment"}
            @sorts = {"Popularity" => "byPopularity", "Date" => "byDate"}
            @date_ranges = {"All time" => "all", "Last 24h" => "last24h", "Past Week" => "pastWeek", "Past Month" => "pastMonth", "Past Year" => "pastYear"}
        end
end
