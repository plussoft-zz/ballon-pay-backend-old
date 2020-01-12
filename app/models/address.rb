class Address < ApplicationRecord
  belongs_to :person
  enum kind: [:others, :residential, :commercial]
end
