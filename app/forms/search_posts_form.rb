class SearchPostsForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :content, :string
end
