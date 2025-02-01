require 'csv'

namespace :hexlet do
  desc "Imports users from csv fixture file"
  task :import_users, [:path] => :environment do |t, args|
    CSV.foreach(args[:path], headers: true) do |row|
      User.create!(
        first_name: row['first_name'],
        last_name: row['last_name'],
        birthday: Date.strptime(row['birthday'], '%m/%d/%Y'),
        email: row['email'])
    end
    print "Users created successfully from #{args[:path]}"
  end
end
