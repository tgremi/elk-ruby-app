# frozen_string_literal : true

class UsersSearch
  include ActiveModel::Model
  
  DEFAULT_PER_PAGE = 10
  DEFAULT_PAGE = 0

  attr_accessor :query, :page, :per

  def search 
    [query_string].compact.reduce(&:merge).page(page_num).per(per_page)
  end

  def query_string
    index.query(query_string: { fields: [:name, :email, :phone], query: query, default_operator: 'and'}) if query.present?
  end

  private 

  def index 
    UsersIndex
  end

  def page_num
    page || DEFAULT_PAGE
  end

  def per_page
    per || DEFAULT_PER_PAGE 
  end
  
end