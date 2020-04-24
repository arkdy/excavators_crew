describe Tickets::Persist do
  subject :command do
    described_class.call(attributes: ticket_attributes)
  end

  let(:ticket_attributes) do
    {
      additional_service_area_codes: %w[ZZL01 ZZL02 ZZL03],
      geo_polygon: '-81.13390268058475 32.07206917625161,-81.14660562247929 32.04064386441295',
      primary_service_area_code: 'ZZGL103',
      request_number: '09252012-00001',
      request_type: 'normal',
      response_due_at: Time.zone.local(2020, 7, 13, 23, 59, 59),
      sequence_number: '2421',
      excavator_attributes: {
        company_name: 'John Doe CONSTRUCTION',
        address: '555 Some RD, SOME PARK, ZZ, 55555',
        crew_onsite: true
      }
    }
  end

  it 'creates new ticket with correct data' do
    expect { command }.to change(Ticket, :count).by(1)
    expect(Ticket.last.attributes.except('id', 'created_at', 'updated_at')).to eq(
        'request_number' => '09252012-00001',
        'sequence_number' => '2421',
        'request_type' => 'normal',
        'response_due_at' => Time.zone.local(2020, 7, 13, 23, 59, 59),
        'primary_service_area_code' => 'ZZGL103',
        'additional_service_area_codes' => %w[ZZL01 ZZL02 ZZL03],
        'geo_polygon' => '-81.13390268058475 32.07206917625161,-81.14660562247929 32.04064386441295',
      )
  end

  it 'creates new excavator with correct data' do
    expect { command }.to change(Excavator, :count).by(1)
    expect(Excavator.last.attributes.except('id', 'created_at', 'updated_at')).to eq(
      'ticket_id' => Excavator.last.ticket_id,
      'company_name' => 'John Doe CONSTRUCTION',
      'address' => '555 Some RD, SOME PARK, ZZ, 55555',
      'crew_onsite' => true
    )
  end

  it 'returns ticket id' do
    expect(command.value).to eq({ ticket_id: Ticket.last.id })
  end
end
