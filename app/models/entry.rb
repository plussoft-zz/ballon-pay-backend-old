class Entry < ApplicationRecord
  belongs_to :account
  enum kind: [:debit, :credit]
end
