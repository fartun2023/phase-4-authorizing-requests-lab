class MembersOnlyArticlesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def index
    articles = Article.where(is_member_only: true)
    render json: articles
  end

  def show
    if current_user
      article = Article.find(params[:id])
      render json: article
    else
      render json: { error: 'Unauthorized - Sign in required' }, status: :unauthorized
    end
  end

  private

  def current_user
    current_user # Assuming you have Devise configured and the user model is called User
  end
end