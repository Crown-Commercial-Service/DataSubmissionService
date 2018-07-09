module ApiHelpers
  def mock_tasks_endpoint!
    body = {
      data: [],
      jsonapi: {
        version: '1.0'
      }
    }

    stub_request(:get, 'https://ccs.api/v1/tasks')
      .with(query: hash_including({}))
      .to_return(
        headers: { 'Content-Type': 'application/vnd.api+json; charset=utf-8' },
        body: body.to_json
      )
  end
end
