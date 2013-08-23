require_relative '../../db/config'

class Legislator < ActiveRecord::Base

  validates :email,
            :presence => true,
            :uniqueness => true,
            format: { with: /.[@]..+[\.]../}

  validates :phone,
            length: { minimum: 10 }

end
