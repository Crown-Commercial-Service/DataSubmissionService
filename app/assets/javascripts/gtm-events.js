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
        })
    }
});