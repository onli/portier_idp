require 'sqlite3'
require 'singleton'


class Database
    include Singleton

    def initialize
        self.setupDB
    end

    def setupDB
        @db = SQLite3::Database.new "database.db"

        begin
            @db.execute 'CREATE TABLE IF NOT EXISTS users(
                            name TEXT PRIMARY KEY,
                            password TEXT
            );'
            
        rescue => error
            warn "Error creating database: #{error}"
        end

        @db.execute 'ANALYZE;'
        @db.results_as_hash = true
    end


    def addUser(name:, password:)
        begin
            @db.execute('INSERT INTO users(name, password) VALUES(?, ?)', name, password)
        rescue => e
            warn "error adding user: #{e}"
        end
    end

    def removeUser(name:)
        begin
            @db.execute('DELETE FROM users WHERE name = ?', name)
        rescue => e
            warn "error removing user: #{e}"
        end
    end

    def getUserPassword(name:)
        begin
            return @db.execute('SELECT password FROM users WHERE name = ?', name)[0]['password']
        rescue => e
            warn "error getting user password: #{e}"
        end
    end

    def getUsers()
        begin
            return @db.execute('SELECT name FROM users')
        rescue => e
            warn "error getting user: #{e}"
        end
    end
end