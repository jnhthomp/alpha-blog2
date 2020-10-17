class ArticleCategory < ApplicationRecord
  # Entries must have both an article_id and category_id associated with them
  # These two id's will be used to create the association between an article and it's categories
  belongs_to :article
  belongs_to :category
end