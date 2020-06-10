class UsersController < ApplicationController
  def search
    user_search = UsersSearch.new(search_params)
    @users = UsersIndex.query(query_string: { fields: [:name, :email, :phone], query: search_params[:query], default_operator: 'and' })

    render json: @users, status: :ok
  end

  private

  def search_params
    params.permit(:query, :page, :per)
  end
end