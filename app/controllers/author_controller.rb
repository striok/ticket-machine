class AuthorController < ApplicationController

  before_action :authenticate_author!
  before_action :ensure_admin_user!

  def ensure_admin_user!
    if !current_author.admin? and (request.path.start_with?('/authors/posts') or request.path.start_with?('/authors/starts') or request.path.start_with?('/authors/events'))
      redirect_to root_path
    end
  end
end
