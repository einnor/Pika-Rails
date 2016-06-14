# @Author: Ronnie Nyaga <Ronnie>
# @Date:   2016-06-11T20:28:57+03:00
# @Email:  ronnienyaga@gmail.com
# @Last modified by:   Ronnie
# @Last modified time: 2016-06-13T17:12:02+03:00



class Recipe < ActiveRecord::Base

  belongs_to :user
  has_many :recipe_ingredients
  has_many :recipe_steps
  has_many :serving_types

  accepts_nested_attributes_for   :recipe_ingredients,
                                  # reject_if: proc { |attributes| attributes['ingredient_id'].blank? },
                                  allow_destroy: true

  accepts_nested_attributes_for   :recipe_steps,
                                  reject_if: proc { |attributes| attributes['step'].blank? },
                                  allow_destroy: true

  validates :name, :preptime, :authorsTip, :servings, :price, :story, presence: true

  has_attached_file :cover, styles: { medium: "400x400#"}
  validates_attachment_content_type :cover, content_type: /\Aimage\/.*\Z/

end
