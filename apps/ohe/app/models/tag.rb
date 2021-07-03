class Tag < ApplicationRecord
  belongs_to :clothe, class_name: "Clothe", foreign_key: "clothe_id"
end
