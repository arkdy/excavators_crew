describe 'Requests to Tickets API', type: :request do
  it 'with correct JSON it should respond success' do
    post '/api/v1/tickets',
         params: file_fixture('ticket_with_excavator.json').read,
         headers: {'CONTENT_TYPE' => 'application/json'}
    expect(response).to have_http_status(:created)
  end

  it 'fails with incorrect JSON' do
    post '/api/v1/tickets',
         params: '{"some":"json"}',
         headers: {'CONTENT_TYPE' => 'application/json'}
    expect(response).to have_http_status(:bad_request)
  end

  it 'fails with non-JSON request' do
    post '/api/v1/tickets', params: 'just a string'
    expect(response).to have_http_status(:bad_request)
  end
end
