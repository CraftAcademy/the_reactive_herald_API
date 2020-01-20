class Api::Admin::ArticlesController < ApplicationController
    before_action :authenticate_user!

  def create
    authorize(current_user)
    
    article = current_user.articles.create(article_params)
    
    if article.persisted? && attach_image(article)
      render head: :ok
    else
      article.destroy
      render json: { error: article.errors.full_messages }, status: 422
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :body)
  end

  def attach_image(article)
    params_image = params['article']['image']
    if params_image && params_image.present?
      DecodeService.attach_image(params_image, article.image)
    end
  end
end