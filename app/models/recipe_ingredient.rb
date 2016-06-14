# @Author: Ronnie Nyaga <Ronnie>
# @Date:   2016-06-11T20:28:57+03:00
# @Email:  ronnienyaga@gmail.com
# @Last modified by:   Ronnie
# @Last modified time: 2016-06-12T00:58:19+03:00



class RecipeIngredient < ActiveRecord::Base
  belongs_to :recipe
end
