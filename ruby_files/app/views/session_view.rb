class SessionView
  def get(thing)
    puts "#{thing}?"
    gets.chomp
  end

  def wrong_creds
    puts "Incorrect Username or Password"
  end

  def right_creds(role)
    puts "Logged In as #{role}."
  end
end