class Post < ActiveRecord::Base
  default_scope { order created_at: :desc }

  self.per_page = 3
end
