class TagMap < ApplicationRecord
  belongs_to :clothes, class_name: "Clothe", foreign_key: "clothe_id"
  belongs_to :tag, class_name: "Tag", foreign_key: "tag_id"
end
