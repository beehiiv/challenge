# frozen_string_literal: true

module PaginationMethods
  def pagination(total_records)
    {
      page: page,
      per_page: limit,
      total: total_records,
      total_pages: total_records.nil? ? 0 : (total_records / limit.to_f).ceil
    }
  end

  def page
    return 1 if params[:page].nil?

    params[:page].to_i&.positive? ? params[:page].to_i : 1
  end

  def limit
    return 15 if params[:per_page].nil?

    (params[:per_page].to_i > 15) ? 25 : params[:per_page].to_i
  end

  def offset
    (page === 1) ? 0 : ((page - 1) * limit)
  end
end
