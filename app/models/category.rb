class Category < ActiveRecord::Base
	has_many :category_items

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      all.each do |category|
        csv << category.attributes.values_at(*column_names)
      end
    end
  end

end
