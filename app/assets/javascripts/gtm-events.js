$(() => {
    const $searchInput = $('#search');
    const $searchButton = $('#search-submit');

    if ($searchInput.length) {
        $searchButton.on('click', function() {
            const searchTerm = $searchInput.val().trim();
            if (searchTerm.length > 0) {
                window.dataLayer.push({
                    event: 'view_search_results',
                    search_term: searchTerm,
                    interaction_type: 'Customer URNs'
                });
            }
        });
    }

  // Track file downloads
  $('a[data-track="file_download"]').on('click', function(event) {
    event.preventDefault(); 

    const link = $(this);
    const url = link.attr('href');
    const linkText = link.text().trim();

    $.ajax({
      type: 'HEAD',
      url: url,
      success: function(data, status, xhr) {
        const contentDisposition = xhr.getResponseHeader('Content-Disposition');
        let fileName = '';

        if (contentDisposition) {
          const fileNameStarMatch = contentDisposition.match(/filename\*\=.+''(.+)/);
          if (fileNameStarMatch) {
            fileName = decodeURIComponent(fileNameStarMatch[1].replace(/['"]/g, ''));
          } else {
            const fileNameMatch = contentDisposition.match(/filename\=\"?(.+?)\"?(;|$)/);
            if (fileNameMatch) {
              fileName = fileNameMatch[1].replace(/['"]/g, '');
            }
          }
        }

        if (!fileName) {
          // Fallback
          fileName = url.substring(url.lastIndexOf('/') + 1);
        }

        const fileExtension = fileName.substring(fileName.lastIndexOf('.') + 1);
        const fileSize = formatFileSize(xhr.getResponseHeader('Content-Length'));

        window.dataLayer.push({
          event: 'file_download',
          link_text: linkText,
          link_url: url,
          file_extension: fileExtension,
          file_size: fileSize,
          file_name: fileName
        });

        window.location.href = url;
      },
      error: function() {
        console.error("Failed to fetch file metadata.");
      }
    });
  });

  let uploadStartTime;

  // Track the initiation of the document upload
  $('input[type="file"]').on('change', function() {
    const file = this.files[0];
    if (file) {
      const fileName = file.name;
      const fileExtension = fileName.substring(fileName.lastIndexOf('.') + 1);
      const fileSize = formatFileSize(file.size);
     
      uploadStartTime = Date.now();

      window.dataLayer.push({
        event: 'document_upload',
        file_extension: fileExtension,
        file_size: fileSize,
        file_name: fileName,
        interaction_type: 'initiate'
      });
    }
  });

  // Track the completion of the document upload
  $('#submission_upload').on('submit', function(event) {
    event.preventDefault();

    const fileInput = $('input[type="file"]')[0];
    if (fileInput && fileInput.files.length > 0) {
      const file = fileInput.files[0];
      const fileName = file.name;
      const fileExtension = fileName.substring(fileName.lastIndexOf('.') + 1);
      const fileSize = formatFileSize(file.size);
      const timeElapsed = ((Date.now() - uploadStartTime) / 1000).toFixed(2); // Time in seconds

      window.dataLayer.push({
        event: 'document_upload',
        file_extension: fileExtension,
        file_size: fileSize,
        file_name: fileName,
        interaction_type: 'complete',
        time_elapsed: timeElapsed
      });
    }

    this.submit();
  });

  // Track opening and closing of accordions
  $('.govuk-accordion__section-button').on('click', function() {
    const linkText = $(this).text().trim();
    const isExpanded = $(this).attr('aria-expanded') === 'true';
    const interactionType = isExpanded ? 'close' : 'open';

    window.dataLayer.push({
        event: 'accordion_use',
        interaction_type: interactionType,
        link_text: linkText
    });
  });

  // Track use of checkbox filters
  $('.govuk-checkboxes__input').on('click', function() {
    const checkbox = $(this);
    const label = checkbox.next('label').text().trim();
    const interactionType = checkbox.is(':checked') ? 'select' : 'remove'

    window.dataLayer.push({
        event: 'search_filter',
        interaction_type: interactionType,
        interaction_detail: label
    });
  });

  // Track use of date filter
  $('#month_from, #year_from, #month_to, #year_to').on('change', function() {
    let month, year;

    if ($(this).attr('id').includes('from')) {
      month = $('#month_from').val();
      year = $('#year_from').val();
    } else if ($(this).attr('id').includes('to')) {
      month = $('#month_to').val();
      year = $('#year_to').val();
    }

    if (month && year) {
      const interactionDetail = `${month}-${year}`;

      window.dataLayer.push({
        event: 'search_filter',
        interaction_type: 'select',
        interaction_detail: interactionDetail
      });
    }
  });

  // Track clearing of filters
  $('.ccs-clear-filters').on('click', function() {
    window.dataLayer.push({
        event: 'search_filter',
        interaction_type: 'clear',
        interaction_detail: 'Filter(s) cleared'
    });
  });

  function formatFileSize(bytes) { 
    if (bytes < 1024) return bytes + ' Bytes'; 
    else if (bytes < 1048576) return (bytes / 1024).toFixed(2) + ' KB'; 
    else if (bytes < 1073741824) return (bytes / 1048576).toFixed(2) + ' MB'; 
    else return (bytes / 1073741824).toFixed(2) + ' GB'; 
    }
});