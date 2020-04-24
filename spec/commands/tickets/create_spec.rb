describe Tickets::Create do
  subject :command do
    described_class.call(json: json)
  end

  context 'with valid JSON argument' do
    let(:json) { file_fixture('ticket_with_excavator.json').read }

    it 'returns ticket ID and success status' do
      expect(command.value).to eq({ message: { ticket_id: Ticket.last.id }, status: :created })
    end
  end

  context 'with non-JSON argument' do
    let(:json) { 'just&parameters=123' }

    it 'returns error message and error status' do
      expect(command.value).to eq({ message: 'invalid JSON data', status: :bad_request })
    end
  end

  context 'with incorrect JSON argument' do
    let(:json) { '{"key" : "value"}' }

    it 'returns error message and error status' do
      expect(command.value).to include(:message, status: :bad_request)
    end
  end
end
