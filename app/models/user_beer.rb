class UserBeer < ApplicationRecord
  belongs_to :user
  belongs_to :beer

  def verbose_status
    new_status = ''
    if status
      new_status = "Tried"
    else
      new_status = "Want to try"
    end
    new_status
  end
end
