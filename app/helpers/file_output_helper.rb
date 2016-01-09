module FileOutputHelper

  def output_latest_taptaro_files
    set_current_timestamp
    create_root_dir
    output_categories
    output_category_items
    copy_audio_clips
  end

  def create_root_dir
    dir_name = create_root_dir_name
    dir_path = create_root_dir_path(dir_name)
    Dir.mkdir(dir_path, 0755) unless Dir.exist?(dir_path)
  end

  def copy_audio_clips
    src = get_audio_clips_dir_path
    dest = get_root_dir_path
    FileUtils.cp_r(src, dest)
  end

  def get_audio_clips_dir_path
    Rails.root.join('public', 'uploads', 'audio_clip')
  end

  def output_categories
    categories = Category.all.to_csv
    output_csv_records_to_filename(categories, "categories")
  end

  def output_category_items
    category_items = CategoryItem.all.to_csv
    output_csv_records_to_filename(category_items, "category_items")
  end

  def output_csv_records_to_filename(records, filename)
    parent_dir = get_root_dir_path
    file = File.open("#{parent_dir}/#{filename}.csv", 'w')
    file.write(records)
    file.close
  end

  def get_root_dir_path
    timestamp = get_current_timestamp
    Rails.root.join('tmp', "taptaro_export_#{timestamp}")
  end

  def create_root_dir_path(dir_name)
    tmp_dir_path = Rails.root.join('tmp')
    tmp_dir_path + dir_name
  end

  def create_root_dir_name
    timestamp = get_current_timestamp
    "taptaro_export_#{timestamp}"
  end

  @@current_timestamp
  TIMESTAMP_FORMAT='%Y%m%d%H%M%S'

  def set_current_timestamp
    @@current_timestamp = Time.now.strftime(TIMESTAMP_FORMAT)
  end

  def get_current_timestamp
    @@current_timestamp
  end

end