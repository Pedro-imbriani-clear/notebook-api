class Contact < ApplicationRecord
  def author
    "Pedro Imbriani"
  end
  def as_json(options={})
    super(methods: :author, root: true)
  end
end
