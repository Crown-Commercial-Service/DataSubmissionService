module UrnHelper
  def urn_page_entries_info(collection, metadata, entry_name: nil)
    entry_name = entry_name.pluralize(collection.size)

    if metadata[:total_pages] < 2
      t('helpers.page_entries_info.one_page.display_entries', entry_name: entry_name, count: metadata[:total])
    else
      from = metadata[:offset_value] + 1
      to   = metadata[:offset_value] + (collection.respond_to?(:records) ? collection.records : collection.to_a).size

      t('helpers.page_entries_info.more_pages.display_entries', entry_name: entry_name, first: from, last: to,
                                                                total: metadata[:total])
    end.html_safe
  end
end
