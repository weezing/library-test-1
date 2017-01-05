class BookQuery
  attr_accessor :query_params

  def initialize(query_params = {})
    @query_params = query_params
  end

  def results
    prepare_query
    user_filter
    order_results
    paginate_results

    @results
  end

  private

  def prepare_query
    @results = Book.all
  end

  def user_filter
    return if @query_params[:user_id].blank?

    @results = @results.eager_load(:borrows).where("borrows.user_id = ?", @query_params[:user_id])
  end

  def order_results(default_sort = "title", default_direction = "asc")
    direction = query_params[:sort_direction].presence || default_direction
    sort = query_params[:sort_by].presence || default_sort

    @results = @results.order(sort => direction)
  end

  def paginate_results
    query_params[:per] ||= 10
    @results = @results.page(query_params[:page]).per(query_params[:per])
  end
end
