class Event < ApplicationRecord

  acts_as_taggable # Alias for acts_as_taggable_on :tags

  PER_PAGE = 3

  scope :soon, -> {where("date >= '#{Date.today}'").order(date: :asc)}
  scope :archive, -> {where("date < '#{Date.today}'").order(date: :asc)}

  scope :recent_paginated, -> (page) { soon.paginate(page: page, per_page: PER_PAGE) }

  scope :with_tag, -> (tag) { tagged_with(tag) if tag.present? }
  scope :list_for, -> (page, tag) do
    recent_paginated(page).with_tag(tag)
  end

  scope :archive_paginated, -> (page) { archive.paginate(page: page, per_page: PER_PAGE) }
  scope :archive_for, -> (page, tag) do
    archive_paginated(page).with_tag(tag)
  end
end
