class Tag < ApplicationRecord
  belongs_to :tag_map, class_name: "TagMap", foreign_key: "tag_id"
end
