class BookQuery
  attr_accessor :query_params

  def initialize(query_params = {})
    @query_params = query_params
  end

  def results
    prepare_query
    order_results
    paginate_results

    @results
  end

  private

  def prepare_query
    @results = Book.all.order("title asc")
  end

  def order_results(default_sort = "title", default_direction = "asc")
    direction = query_params[:direction].presence || default_direction
    sort = query_params[:sort].presence || default_sort

    @results = @results.order(sort => direction)
  end

  def paginate_results
    query_params[:per] ||= 10
    @results = @results.page(query_params[:page]).per(query_params[:per])
  end
end
