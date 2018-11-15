class Micropost < ApplicationRecord
  belongs_to :user
  scope :order_desc, ->{order created_at: :desc}

  mount_uploader :picture, PictureUploader
  validates :user, presence: true
  validates :content, presence: true, length: {maximum: Settings.maximum}
  validate :picture_size

  private

  def picture_size
    return unless picture.size > Settings.max_size_image.megabytes
    errors.add :picture, t(".less_five_mb")
  end
end
