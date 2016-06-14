# @Author: Ronnie Nyaga <Ronnie>
# @Date:   2016-06-11T20:28:57+03:00
# @Email:  ronnienyaga@gmail.com
# @Last modified by:   Ronnie
# @Last modified time: 2016-06-11T21:27:27+03:00



class RecipeStep < ActiveRecord::Base
  belongs_to :recipe

end
