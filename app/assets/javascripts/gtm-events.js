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

  function formatFileSize(bytes) { 
    if (bytes < 1024) return bytes + ' Bytes'; 
    else if (bytes < 1048576) return (bytes / 1024).toFixed(2) + ' KB'; 
    else if (bytes < 1073741824) return (bytes / 1048576).toFixed(2) + ' MB'; 
    else return (bytes / 1073741824).toFixed(2) + ' GB'; 
    }
});