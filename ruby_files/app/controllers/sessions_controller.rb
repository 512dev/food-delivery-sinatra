require_relative '../repositories/employee_repository.rb'
require_relative '../views/session_view.rb'


class SessionsController
  def initialize(repo)
    @employees = repo
    @view = SessionView.new
  end

  def sign_in
    username = @view.get(:username)
    password = @view.get(:password)
    user = @employees.find_by_username(username)
    if user && user.password == password
      @view.right_creds(user.role)
      user
    else
      @view.wrong_creds
      sign_in
    end
  end
end