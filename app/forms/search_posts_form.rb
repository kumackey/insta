class SearchPostsForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :content, :string

  def search
    scope = Post.all
    scope = scope.content_contain(content) if content.present?
    scope
  end
end
