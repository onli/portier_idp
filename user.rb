require 'bcrypt'

class User
    
    attr_accessor :name
    attr_accessor :password

    def initialize(name:)
        self.name = name
        self.password = Database.instance.getUserPassword(name: name)
        if self.password
            self.password = BCrypt::Password.new(self.password.to_s)
        end
    end

    def setPassword(password:)
        self.password = BCrypt::Password.create(password.to_s)
    end

    def remove()
        Database.instance.removeUser(name: self.name)
    end

    def save!()
        Database.instance.addUser(name: self.name, password: password)
    end

    def validPassword(password:)
        return password && self.password && self.password == password.to_s
    end
end