require_relative 'user'

class UserRepository
  def all
    users = []

    sql = 'SELECT * FROM users;'
    result_set = DatabaseConnection.exec_params(sql, [])    

    result_set.each do |record|

      user = User.new
      user.id = record['id'].to_i
      user.email = record['email']
      user.password = record['password']
      user.f_name = record['f_name']
      user.handle = record['handle']

      users << user
    end

    return users
  end
  
  # this #find method currently not required
  # but could be useful in future so replicated from PeepRepository
  def find(id)
    sql = 'SELECT * FROM users WHERE id = $1;'
    result_set = DatabaseConnection.exec_params(sql, [id])

    user = User.new
    user.id = result_set[0]['id'].to_i
    user.email = result_set[0]['email']
    user.password = result_set[0]['password']
    user.f_name = result_set[0]['f_name']
    user.handle = result_set[0]['handle']

    return user
  end

  def create(user)
    sql = 'INSERT INTO users (email, password, f_name, handle) VALUES ($1, $2, $3, $4);'
    result_set = DatabaseConnection.exec_params(sql, [user.email, user.password, user.f_name, user.handle])

    return user
  end
end