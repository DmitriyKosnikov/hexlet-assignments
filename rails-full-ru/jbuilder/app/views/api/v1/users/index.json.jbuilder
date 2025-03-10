# frozen_string_literal: true

json.array! @users do |user|
  json.extract! user, :id, :email, :address
  json.full_name "#{user.first_name} #{user.last_name}"
  json.posts do
    json.array! user.posts.each do |post|
      json.partial! 'post', post: post
    end
  end
end
